From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Status of conflicted files resolved with rerere
Date: Thu, 12 Aug 2010 17:36:53 -0400
Message-ID: <AANLkTi=tVV5gL2b2LfXALXahzabJXzVjB5z9-OSztOMJ@mail.gmail.com>
References: <20100812212828.GA17825@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 23:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjfSi-0003PF-NF
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760816Ab0HLVhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 17:37:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57311 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760756Ab0HLVhO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 17:37:14 -0400
Received: by wyb32 with SMTP id 32so1876388wyb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=l4HR6IbI9zQZamUHG2QG7hSUEu3JEhNMkrklqxfsa3w=;
        b=DzrSOChYaXpuQ7bd/D75hyK/CKVoh8WiTuPwNlnnIq7z06HbXzd/R5bka+Ycpxto3K
         NRnN6VDRJ6R0sbHMf3YrgeYcuMaBvPRQglEG4GGi2dTBVri11tUw4xPBfMj313Mg5KAA
         IL/DgDUdQ/YKP4VxwqGFNajSosgpKSA9lKBQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LYX6z2BJ+z6Ubnt3pznW1Hs56Rz7k9u50ipICcyr8jULzFK5IA4tdds8CDi0FT0oUo
         FhqWWdkfnAQGXIQBbSjjx600CtsJTWFCzwp0+7iR5gGPKCNdSkGMJ2F0o0rabvdJMYg0
         Nq2oeF/fYbfIRlZHxBbPerznim02aLtnCbIDo=
Received: by 10.216.10.77 with SMTP id 55mr509449weu.17.1281649033099; Thu, 12
 Aug 2010 14:37:13 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 12 Aug 2010 14:36:53 -0700 (PDT)
In-Reply-To: <20100812212828.GA17825@jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153423>

On Thu, Aug 12, 2010 at 5:28 PM, Magnus B=E4ck
<magnus.back@sonyericsson.com> wrote:
> I played around with git rerere today and was surprised by the result=
s.
> When a conflict has been resolved automatically by rerere, the file
> isn't added to the index like other files are where Git just used one=
 of
> the regular merge resolution algorithms. What's worse, if git mergeto=
ol
> is invoked -- which is what I normally do when git merge needs help -=
-
> it has no idea that the file actually has been merged already, and
> launches the merge tool with the three files involved in the merge. I=
f
> the user hasn't been paying attention to each line of the git merge
> output (stating the files who were automatically resolved) it's easy =
to
> trash rerere's work.

The motivation behind the current behaviour, as I understand it, is
that rerere speeds things up, but you don't necessarily want to trust
that it has resolved your merge conflicts correctly.  After all, they
were unarguably *conflicts*, not just normal merge results, so you
can't quite trust them.

That said, I've never had a problem where rerere did the wrong thing
for me.  Maybe there could be an option to override it.

Anyway, I never use a mergetool, so like you suspected, this has never
been a major problem for me.

It sounds like the real problem here though it the mergetool stuff.
Why is it disregarding all the automated merging that git has done and
starting over from scratch?  If git, in its infinite cleverness, has
resolved *some* parts of the file but not others, wouldn't we want it
to keep those resolutions?  It sounds like mergetool is actually
making things *more* work instead of less.

Is there some way to teach the mergetool stuff to be smarter?  At the
very least, having it auto-skip files that have no *remaining*
conflicts might be a good idea.

Have fun,

Avery
