From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
Date: Mon, 11 Apr 2011 00:43:52 +0200
Message-ID: <BANLkTimjkuvOc4mS4hfC7PiGWrRAb_2uog@mail.gmail.com>
References: <1301848953-31525-1-git-send-email-avarab@gmail.com>
	<1301848953-31525-2-git-send-email-avarab@gmail.com>
	<7voc4ncg0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 00:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q93MZ-0003xv-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 00:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab1DJWny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 18:43:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45289 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab1DJWnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 18:43:53 -0400
Received: by fxm17 with SMTP id 17so3232481fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=J0Lchvt5B63QzOUm8M9qvw6ZiwnrMwncnfe+ycE3o9Q=;
        b=uLXVLx4FDFJncJogzgDmBB8FM4zhiC5Dl4pTEfvMs7tHISoaahsJ3cU1Zizr4YTF6H
         aZsparK5WDGIWTLdgyrJbv/b1yZLi8u+31aGw+mEZccHCRm8mBDqxVQFNfDfKxksxdSX
         8bRc+1Ndi9XYabVKqw9omcf0allYCST9Zw2Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=k0r3MpkCFSyFw54O9gvL9yQt2pNPUJLyzH49oc1H5aCDhCO9Fgs/R31vvPjctL1RTe
         rsinBpLEUlPq+9tPXJuj8vf5TONHyn8NuZGiiC3Iry1BN1xt2nXFgvQXXQx0ldLLEmq4
         ydrKGqIsoaBTG5zUkcudY/DxOmhLBX1htGGQg=
Received: by 10.223.127.210 with SMTP id h18mr320555fas.67.1302475432312; Sun,
 10 Apr 2011 15:43:52 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Sun, 10 Apr 2011 15:43:52 -0700 (PDT)
In-Reply-To: <7voc4ncg0l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171292>

On Sun, Apr 3, 2011 at 21:05, Junio C Hamano <gitster@pobox.com> wrote:

> Perhaps it is not an issue in real life; after all eval_gettext interface
> is not something you invented in 5 minutes without thinking deeply, but is
> what you plan to use from outside codebase that presumably has seen a wide
> use in the field, and it may be just that I am worried too much about an
> implausible corner case, but I thought I should bring it up.

It's a corner case, but if we run into it we can easily solve it like
this:

    #!/bin/sh
    . gettext.sh

    HOME=/home/junio
    path='$HOME/.gitconfig'
    var=core.i18n
    (
        export HOME var ;# no need for HOME, but just an illustration
        # TRANSLATORS: $path will be "$HOME/.gitconfig"
        eval_gettext 'Look at $path and find definition of $var variable.'; echo
    )

Which results in:

    $ sh /tmp/foo.sh
    Look at $HOME/.gitconfig and find definition of core.i18n variable.
