From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: git-am doesn't apply the rest of the email after a partial patch fail?
Date: Sun, 7 Apr 2013 14:23:44 -0700
Message-ID: <CAPKkNb4MKZjo+OfqApL+pc4uhoTfTfxcM1h1YCAF8=Eq4H5ctg@mail.gmail.com>
References: <CAPKkNb43bWupbOaAntF8VJQ8ZJjt8SG-mZa3GohxZEAZQm-evQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:46:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pl-0000sy-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762293Ab3DGVXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 17:23:46 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:57837 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762040Ab3DGVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 17:23:45 -0400
Received: by mail-la0-f42.google.com with SMTP id fe20so4844296lab.15
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=LAL0zL4uHUzCFOJSD9Owxh8IskRy25AykMPPfWE9yAY=;
        b=LnRbSSvRtp8QL7OCjLKisnV1dqV4vSjwYL9BlupjmJoP7dv6imuLVToLfT+O46Q6Hu
         75M6fYiPrY1G9d1mB7WBsP8RCPT1SrDkVVB4nb03nDyk2iphiSOY8c4FcI5r4wDWEKY6
         uVHGkhINYDXq3tlpnwY6qQoeFCogirNqM0ojFC0pQqbBtMTm+e4+vwSLCoylqGU4TfFk
         Aaq55y3B4rptAoh6FIylX1s28S/LdI6dMSIThsRZzBHAokc4MTw++SUGaO8X1cZ8ROwE
         6+msCJgcm8L4LSnL3S/p3I0RSG5iWBOLgTzp49Bay/IPHPwCk0uZ/WrYMSzuYiV4ydyv
         iyMw==
X-Received: by 10.112.76.39 with SMTP id h7mr8924394lbw.118.1365369824411;
 Sun, 07 Apr 2013 14:23:44 -0700 (PDT)
Received: by 10.114.92.105 with HTTP; Sun, 7 Apr 2013 14:23:44 -0700 (PDT)
In-Reply-To: <CAPKkNb43bWupbOaAntF8VJQ8ZJjt8SG-mZa3GohxZEAZQm-evQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220375>

So, it turns out, `--reject` is not default for git-am / git-apply,
and has to be explicitly specified for the desired behaviour.  Makes
no sense, if you ask me, and especially the below error message, which
tells you nothing about having to use `--reject`:

% git am ../grok-old-hg-git.git/00{27,28,29,30,31}*
...
error: patch failed: build.xml:178
error: build.xml: patch does not apply
error: patch failed: src/org/opensolaris/opengrok/analysis/AnalyzerGuru.java:64
error: src/org/opensolaris/opengrok/analysis/AnalyzerGuru.java: patch
does not apply
Patch failed at 0001 src/.../uue/Uuencode*{lex,java}: introducing
uuencode(5) support
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
%

Correcting the specified failures and running `git am --resolved`
won't get you anywhere.  Have to abort, and run `git am --reject` to
get anywhere.

C.

On 7 April 2013 11:00, Constantine A. Murenin <mureninc@gmail.com> wrote:
> Hi,
>
> I'm trying to convert/rebase about 40 local patches from an old
> mercurial fork of OpenGrok (upstream used to use hg), to the new git
> repository (upstream has recently switched to github).
>
> What I decided to do is convert my old mercurial repo to git (by
> pushing with py-hg-git to a git repository, and then checking out with
> git), and use `git format-patch` from an old .hg-git.git repository,
> and then use `git am` on the new (upstream git) repository of the
> `format-patch` mails from an old one.
>
> However, what I've faced with, is that when a conflict happens, and I
> resolve, and do `git add`, and `git am --resolved`, then the rest of
> the `format-patch` email where the conflict has occurred is discarded,
> and the subsequent patch/email now doesn't want to apply either, since
> all of the previous patch/email is missing, other than the manually
> added changes.
>
> What gives?  Does `git am --resolve` discard the rest of the mail, if
> any patching errors occur?  Is one supposed to apply the whole
> `format-patch` email manually when `git am` does encounter some
> problem with only some minor parts of that email?
>
> % git --version; uname -rms
> git version 1.7.6
> OpenBSD 5.2 amd64
>
> C.
