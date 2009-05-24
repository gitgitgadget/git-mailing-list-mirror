From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: y.a. static code analysis
Date: Sun, 24 May 2009 15:04:06 +0200
Message-ID: <81b0412b0905240604q3c8c798bi6ad64d8916b4cd9e@mail.gmail.com>
References: <927245250905231200ifbda2f6t1c54628e314d63e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2VyaGF0IMWeZXZraSBEaW7Dp2Vy?= <jfcgauss@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 15:04:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8DND-0001CD-04
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 15:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbZEXNEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 09:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755288AbZEXNEH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 09:04:07 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:43896 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbZEXNEF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 09:04:05 -0400
Received: by fxm12 with SMTP id 12so769887fxm.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n7QQuYd6rJwU+op0HJycDLjYd6a8UgsJ32J4ipYVmHE=;
        b=cUlE/R8nlp/Le5yj2ye0R5INfDWKPn30NjJdA7oyWoOdM3hxF7Jq7dBh8byVo1tBLK
         2jD8LqubNunyhKKkLRXZcSGxyPHcGHFW7fmtiP5FkZK/YKbxQBqcYld5Cl2WpETsweqx
         VS5BpGMMjEkYtcxD332Y6CJLNIMV0jQpx+wYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cF5I/UCplpuJspHmGWPMNyNtyhWk0Pr+66RS6MJZ8Ad84CPu7MH5eDs/BdsilssZ+m
         vjJkhPhv3/9igj02D1vQFHZCsxiU84xd2O9Mq9JsVCRRQD0ersjwium1v9/Lh8i/BmrI
         yQSjJS4AudxfHJKie3twJ4tY9xUUe7SYk5+8k=
Received: by 10.204.58.9 with SMTP id e9mr5784684bkh.15.1243170246139; Sun, 24 
	May 2009 06:04:06 -0700 (PDT)
In-Reply-To: <927245250905231200ifbda2f6t1c54628e314d63e6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119818>

2009/5/23 Serhat =C5=9Eevki Din=C3=A7er <jfcgauss@gmail.com>:
> i think only the ones about date.c (below note) are real defects
> (first chars are not checked).
>
> and also how about http://scan.coverity.com? i see it was mentined
> before (http://article.gmane.org/gmane.comp.version-control.git/11156=
2)
> with apparently no responses or arguments (there has been a suggestio=
n
> of bad license terms in that message, but if the scan is suitable for
> so many FOSS (see all rungs) including the kernel, why would it be no=
t
> good for git?). i think it could be a good free (as in beer) code
> check for git.

There is a reason why the static checking tools are not popular:
too many false positives.

> [./builtin-apply.c:482]: (error) Using 'name' after it is deallocated=
 / released

Just wrong.

> [./compat/mingw.c:273]: (style) Found 'mktemp'. You should use 'mkste=
mp' instead
> [./compat/mkdtemp.c:5]: (style) Found 'mktemp'. You should use 'mkste=
mp' instead

Assuming the platform (see "compat"?) has mkstemp(3).

> [./date.c:268]: (style) Redundant code: Found a statement that begins
> with numeric constant
> [./date.c:483]: (style) Redundant code: Found a statement that begins
> with numeric constant

There is no numeric constant in the line, and while you're right (almos=
t)
regarding skipping the first character, the message itself is confusing=
=2E

You're not completely right, because looking at the code, the character
you think is skipped is already tested for existence in other places.
Yes, the code could be clearer at this point. Could be just a sign of
refactoring passes, though.

> [./http-push.c:1419]: (error) Using 'lock' after it is deallocated / =
released

This is the only real bug.

> [./read-cache.c:938] -> [./read-cache.c:759] -> [./read-cache.c:729]:
> (all) Array index out of bounds
> [./read-cache.c:938] -> [./read-cache.c:759] -> [./read-cache.c:731]:
> (all) Array index out of bounds
> [./read-cache.c:938] -> [./read-cache.c:759] -> [./read-cache.c:736]:
> (all) Array index out of bounds

Definitely not. It is just a flexarray, worked around  with array[1]
for some compilers.

> [./test-sha1.c:16]: (error) Memory leak: buffer

The program ends and there is no point deallocating the buffer.
