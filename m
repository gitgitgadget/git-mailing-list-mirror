From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 22:39:22 +0200
Message-ID: <20090718203922.GG16708@vidovic>
References: <20090718134551.GC16708@vidovic> <20090718135649.GA6759@sigill.intra.peff.net> <20090718141658.GE16708@vidovic> <20090718153148.GA9367@sigill.intra.peff.net> <7veisd3k31.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 22:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSGgx-00042J-C3
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 22:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbZGRUj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbZGRUj1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 16:39:27 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:37728 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbZGRUj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 16:39:27 -0400
Received: by ewy26 with SMTP id 26so1561514ewy.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RPFW1sUcnM38jePALFuTUsX27zBl5Jb9n3GXX1Ez/3s=;
        b=DkUWlU22ggBdsQ1mNF2woq4yuIioAytMyMkPRyIFHewcKeBOrDilxH2de4UyZO7iJW
         wwEFs+7NXMo/1+L3VnQIp1To7WscneZtMfyHYkWtAjcgZ/VpeW4+G7GDEI8N/97Yq+VQ
         U9pzVR6ZFYK4vpWScdpH/v7sdU7DHMdElIP/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E7HS9NvIMRCsa1lwZLwHjqGvFBo7HRnqSWA56cTi2IsrkdAwqbItB4GgbPGrVDSt6k
         jn/UaHto6srl3st0BbbriAq/FGAnoeFM11j4Dh9t0ZHuN0wKsjfmHRwyWsMeS/rnn6Vq
         kQPZ2YynPLfWvH6v/e/dljfJybbDNOY/k2dns=
Received: by 10.210.129.20 with SMTP id b20mr1477972ebd.83.1247949566006;
        Sat, 18 Jul 2009 13:39:26 -0700 (PDT)
Received: from @ (91-164-151-27.rev.libertysurf.net [91.164.151.27])
        by mx.google.com with ESMTPS id 5sm2221478eyh.56.2009.07.18.13.39.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 13:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7veisd3k31.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123536>

The 18/07/09, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Are you compiling with any special options?

Normally, no (cf. my mail to Johannes Sixt).

> >                                             I usually compile with just
> > "-g -Wall -Werror", but I also tried with "-O2" and couldn't reproduce.

The Makefile have

  215:CFLAGS = -g -O2 -Wall
  217:ALL_CFLAGS = $(CFLAGS)

and it should be OK. I know that -Werror will fail on

  libgit.a(mkdtemp.o): In function `gitmkdtemp':
    /home/nicolas/dev/official_packages/git/compat/mkdtemp.c:5: warning: the
    use of `mktemp' is dangerous, better use `mkstemp'

but I think this is an unrelated problem.

$ gcc --version
gcc (GCC) 4.1.2 (Gentoo 4.1.2 p1.3)

> Me neither, but I found an unrelated anomaly in the output from the test
> nearby.
> 
>     Switched to branch 'foo-baz-renamed-from-foo'
>     *   ok 3: file renamed from foo/baz to foo
> 
>     * expecting success:
>             git checkout -f foo-becomes-a-directory &&
>             git diff-tree -p HEAD initial > patch &&
>             git apply --index < patch
> 
>     error: Invalid path ''
>     Switched to branch 'foo-becomes-a-directory'
>     *   ok 4: directory becomes file
> 
> Notice the "error"?

I couldn't reproduce this error here with

  sh t4114-apply-typechange.sh --verbose
and
  sh t4114-apply-typechange.sh --verbose --debug

on the current next.

With this patch, I still fail on the test.

-- 
Nicolas Sebrecht
