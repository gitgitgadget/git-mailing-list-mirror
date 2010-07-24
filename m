From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/6] Makefile: Include subdirectories in "make cover" 
	reports
Date: Sat, 24 Jul 2010 23:28:02 +0000
Message-ID: <AANLkTim8UIiplPxUdcEWnDpevOUUZARgObhIFCkfO3zl@mail.gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
	<1280004663-4887-3-git-send-email-avarab@gmail.com>
	<201007250037.57086.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oco8l-0007Ed-LK
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0GXX2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:28:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41552 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0GXX2H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 19:28:07 -0400
Received: by iwn7 with SMTP id 7so1529774iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 16:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dR9OG0/OWUghutjfKloMeONVimZI2uX3FOeZOUcGiZM=;
        b=KAon3RR5Y5UHNfqJtnFPqLlwiz2LuZH0CGyY52A6qu683bfiRh0/tEec3Uny25bWHd
         4dHPedGLjoLnOZojHogHq00rQcISvfq0FFuI+Jf+6f99iuSv3nzwrNJt2G/wrXBoXp1N
         nhR8AK2IcmY6L4owKXLuqaJRFuM0CiXl/+UD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HJ76XQ1URpCOFiT03RxkUu72Ingu3jnB2fa5tV6oBmq0/M0c23jfQvWBvOnmRqOaWS
         vGXGKZSZFYe9ysZzuBg7PvIZRsOnsO+2AuXEjse/ikb/UgLw1WkHah0S+3nEvWO6+HnJ
         oT9HLFiEwtGKkelGLmszpsLTnZKGG+8sOracw=
Received: by 10.231.145.1 with SMTP id b1mr6261677ibv.69.1280014082887; Sat, 
	24 Jul 2010 16:28:02 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 24 Jul 2010 16:28:02 -0700 (PDT)
In-Reply-To: <201007250037.57086.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151686>

On Sat, Jul 24, 2010 at 22:37, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The buildin/, xdiff/ and compat/ subdirectories weren't being includ=
ed
>> in the gcov aggregation, nor were the files there being cleaned up.
> [...]
>> =C2=A0coverage-clean:
>> - =C2=A0 =C2=A0 rm -f *.gcda *.gcno
>> + =C2=A0 =C2=A0 $(RM) *.gcov *.gcda *.gcno
>> + =C2=A0 =C2=A0 $(RM) builtin/*.gcov
>> + =C2=A0 =C2=A0 $(RM) builtin/*.gcda
>> + =C2=A0 =C2=A0 $(RM) builtin/*.gcno
>
> By the same logic, the xdiff and compat directories should also be
> included here. =C2=A0Maybe also block-sha1?

Yeah, actually now that I think about it any C code we compile could
spew those *.gcda *.gcno files, which means:

    $ find . -type f -name '*.c'| ack '^(.*/.*)/[^/]+$' --output '$1'|s=
ort|uniq
    ./block-sha1
    ./builtin
    ./compat
    ./compat/fnmatch
    ./compat/nedmalloc
    ./compat/regex
    ./compat/win32
    ./contrib/convert-objects
    ./contrib/examples
    ./contrib/svn-fe
    ./ppc
    ./xdiff

Maybe it would be better to just put:

    *.gcda
    *.gcno

Into .gitignore, and leave it to the user to clean these with git
clean -dxf or something.
