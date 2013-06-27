From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v6 2/5] git-remote-mediawiki: new git bin-wrapper for developement
Date: Thu, 27 Jun 2013 20:53:16 +0200
Message-ID: <CAETqRCjZdv-_V3jmhjxZj+_XU7AKRvMZ3ojo7=yW3m846F4E1w@mail.gmail.com>
References: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
	<1372354652-4147-3-git-send-email-benoit.person@ensimag.fr>
	<7vr4fnsafy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 20:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsHJp-00055e-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 20:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab3F0SxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 14:53:18 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:34160 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab3F0SxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 14:53:17 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so876788wes.34
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=fjDRvRkSP7Yl0Qzy+t+CBonqXoXif4xyXU9jNo+O2ME=;
        b=sejmGJJJdtCTw0Y0aL8goUHPrpfVQwKkhrIP32k2wkMI/Mk5CxKguhj340QpFb1NlZ
         1w96ZXPE6KUUefyitAsKet66Gd9ZdGWtayW8hWQjpn2xTj57DoXPtQWqAfY5RxSRdVjU
         OEoflMzZFzdpDGrjNZSwiH28UtdsgVRHHuV9xkmNSx/hqzWVqoY4+SbJFczH6Oj2AJum
         QFtToQE1AeVe6iU4Zh0aalFbdm+w61HUFwpxj0YMxx1UiANKg6pRosoWAs8Ju7UePRL8
         3e8im2W+aPdrNe9FB3NRt+N7nNr7SZyguGOVEQU5gviuPjl3LX+an9BqLMK+t2aPmpDv
         479Q==
X-Received: by 10.194.24.40 with SMTP id r8mr7193450wjf.7.1372359196104; Thu,
 27 Jun 2013 11:53:16 -0700 (PDT)
Received: by 10.216.245.196 with HTTP; Thu, 27 Jun 2013 11:53:16 -0700 (PDT)
In-Reply-To: <7vr4fnsafy.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: LJmBED0E3l_3B60cAK_TgKh1XqI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229145>

> As far as I can tell, the only real reason why you need this and
> cannot use ../../bin-wrappers/git directly is because the GITPERLLIB
> it gives you only points at ../../perl/blib/lib and not this
> directory.
Plus (forgot to mention it in the other mail :/ ) it enables us to not
"copy" git-mw and git-remote-mediawiki at each "make" and stop us from
polluting the toplevel directory with those two scripts during
development.

> Two possible alternatives:
>
>  - Is there a reason you would not want to "install" whatever Perl
>    modules you want to "use" via GITPERLLIB mechanism to
>    ../../perl/blib/lib?
If we are making modifications to Git/Mediawiki.pm or even git-mw.perl
/ git-remote-mediawiki.perl, installing them without proper testing
beforehand seems wrong.

>    Perhaps it will interfere with the real
>    installation step in ../../perl/Makefile?
I don't think so, but I am not an expert on what's going on in
../../perl/Makefile.

>    If that is the case,
>    then it is not a good idea, but otherwise, that would let you use
>    ../../bin-wrappers/git as-is.
>
>  - Perhaps we could do:
>
>         GITPERLLIB="${GPLEXTRA+$GPLEXTRA:}@@BUILD_DIR@@/perl/blib/lib"
>
>    in wrap-for-bin.sh, so that your instruction can become
>
>         GPLEXTRA=$(pwd) ../../bin-wrappers/git whatever-mw-thing
>
>    and you do not have to have this file?  We would also need to
>    "unset GPLEXTRA" at the beginning of test-lib.sh if we were to do
>    this.


> How does a developer (or user) use this script?  From your Makefile
> (e.g. "make test")?  Manually following some written instruction?
> In either case, the latter option feels a lot more sensible
> alternative without having to maintain this extra copy of wrap-for-bin
> that can easily go out of sync.
A developer uses it like any bin-wrapper : bin-wrapper/git mw preview
for instance. He can add it to its path while working on the scripts
etc ...

The best way to do it would be to factorise those new use cases
(adding new elements in $GITPERLLIB and $PATH) in the code that
generate bin-wrappers from wrap-for-bin.sh I think.

But it was weird to work on that in this serie which initial goal was
to add a preview tool for git-remote-mediawiki and ended up adding a
new perl package, a new 'git mw' command which handles subcommands,
...

In the end, this patch could be removed from the serie since it is
self-contained : it is not used by 3/5, 4/5, and 5/5.

Benoit
