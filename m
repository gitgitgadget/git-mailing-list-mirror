From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make clients ask for "git program" over ssh and local transport
Date: Wed, 25 Jun 2008 19:13:43 -0400
Message-ID: <20080625231343.GS11793@spearce.org>
References: <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org> <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org> <20080625053848.GJ11793@spearce.org> <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org> <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:14:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeCV-0004h4-JT
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbYFYXN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbYFYXN7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:13:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56693 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbYFYXN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:13:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBeBD-00064V-6g; Wed, 25 Jun 2008 19:13:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C72320FBAE; Wed, 25 Jun 2008 19:13:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86367>

Junio C Hamano <gitster@pobox.com> wrote:
> This will allow server side programs such as upload-pack to be installed
> outside $PATH.  Connections to git-daemon still ask for "git-program" to
> retain backward compatibility for daemons before 1.5.6.1 and 1.6.0.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This is essentially your patch.  This can be in 1.6.0 clients and it
>    should also be in 1.5.6.1 as people might keep ancient clients to talk
>    to new servers that won't have anything but "git" on $PATH.

Ack.  Thanks for cleaning up the code in connect.c to not segfault
or send garbage.

I think you want to squash this in as well:

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d76260c..f693a6d 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -12,7 +12,7 @@ static const char send_pack_usage[] =
 "  --all and explicit <ref> specification are mutually exclusive.";
 
 static struct send_pack_args args = {
-	/* .receivepack = */ "git-receive-pack",
+	/* .receivepack = */ "git receive-pack",
 };
 
 /*
 

-- 
Shawn.
