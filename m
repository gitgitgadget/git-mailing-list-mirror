From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Thu, 26 Nov 2009 11:14:49 -0700
Message-ID: <885649360911261014w4f3a6150w31fe435c25065a2f@mail.gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
	 <20091125203922.GA18487@coredump.intra.peff.net>
	 <7viqcytjic.fsf@alter.siamese.dyndns.org>
	 <20091125210034.GC18487@coredump.intra.peff.net>
	 <7vmy2as319.fsf@alter.siamese.dyndns.org>
	 <20091125214949.GA31473@coredump.intra.peff.net>
	 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
	 <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com>
	 <7vd436p339.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 19:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDirn-0000YD-Ls
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 19:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbZKZSOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 13:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbZKZSOn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 13:14:43 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:52316 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZKZSOn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 13:14:43 -0500
Received: by iwn1 with SMTP id 1so572489iwn.33
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=CFasurUiNdFeZ2ji/W9VCNBk6Yonx+vrhzse+5nu7oU=;
        b=UJjHq6GG4B81lc4Big4naRGJLU6hcfh+BgjbH2dLm2XjL/o7jQPsp4NizP9AE11qvG
         yiguVpRHLGp1hfN85cQZp9FxiB6eZfmY2tUwOTNg2fPiLKUlyOhM4Yc7Vpeh57clb6tP
         CfcAyfizddymyw3o0Ld3uk9AFhn1Z0DWxCzmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=m/GRAzW//wXvOWlL8vOhME9sprK2+TUfreHp5Z1AdGjjAwahVH9CTn66ONh2nxle2Y
         7i4Ubw+np9slsXE22z4dL8eeIhm/SEtUvIb+1ylO3dth4a/mQyrkUTP2BghfmVa6emVJ
         IflDPswkCQlKh6Y3eKTAnx8Zi+tu939afcxwI=
Received: by 10.231.25.199 with SMTP id a7mr36786ibc.51.1259259289385; Thu, 26 
	Nov 2009 10:14:49 -0800 (PST)
In-Reply-To: <7vd436p339.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133817>

On Wed, Nov 25, 2009 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  - git does not accept paths (it lets you specify patterns that match,
>   e.g. t/ to name ptahs under t/ directory).

That's not entirely true, unfortunately:

$ echo >> unpack-trees.c
$ git diff --name-status unpack-trees.c
M       unpack-trees.c
$ git diff --name-status $PWD/unpack-trees.c
M       unpack-trees.c
$ git diff --name-status $PWD/../git/unpack-trees.c
M       unpack-trees.c
$ git diff --name-status ../git/unpack-trees.c
fatal: '../git/unpack-trees.c' is outside repository

So it seems that 'git diff' accepts absolute paths as long as they end up
in the repository, but oddly enough, doesn't do so for relative paths.
It's possible that some users have scripts that use absolute paths, and
changing the interpretation would break those scripts.  Such scripts
*should* be rare, so maybe it's ok to break them, but it needs to be
considered.

James
