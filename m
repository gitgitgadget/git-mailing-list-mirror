X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Thoughts about memory requirements in traversals [Was: Re: [RFC] Submodules in GIT]
Date: Sun, 3 Dec 2006 12:47:12 +0100
Message-ID: <200612031247.12957.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612030421.18662.Josef.Weidendorfer@gmx.de> <ekubag$6km$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 11:47:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <ekubag$6km$2@sea.gmane.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33106>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqpof-0008Ip-Lb for gcvg-git@gmane.org; Sun, 03 Dec
 2006 12:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936690AbWLCLrR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 06:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936695AbWLCLrR
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 06:47:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:5309 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936690AbWLCLrQ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 06:47:16 -0500
Received: (qmail invoked by alias); 03 Dec 2006 11:47:14 -0000
Received: from p5496A934.dip0.t-ipconnect.de (EHLO noname) [84.150.169.52] by
 mail.gmx.net (mp044) with SMTP; 03 Dec 2006 12:47:14 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sunday 03 December 2006 12:10, Jakub Narebski wrote:
> > You simply sequentially renumber any object SHA, starting from 0
> > in the order you see them. You can do two renumberings, one for
> > the objects contained in the original pack (1), and one for the
> > external ones (2). Put these new numbers (with a bit distinguishing
> > (1) and (2)) as replacement into commit/tree objects.
> > At the end, you have the new offsets for objects in (1). Put
> > redirection tables for (1) [new number -> new offset]
> > and (2) [other new number->SHA1 of external object] at the end
> > of the new pack.
> 
> Doesn't this idea clash with the object and delta reusing for repack?

In general, yes: you modify object content by encoding, and if you want
to reuse the objects without decompression, and need to keep the info
to be able to decode, ie. the redirection table.

This gets problematic if you want to join multiple packs, or fetch objects
and want to reuse the compressed representation, as the object renumbering
is only local to one pack, and numbers can be reused between packs.

So this idea is probably for archival packs only.

