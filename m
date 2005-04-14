From: "Barry Silverman" <barry@disus.com>
Subject: Live Merging from remote repositories
Date: Thu, 14 Apr 2005 16:01:32 -0400
Message-ID: <IGEMLBGAECDFPIKMIMLCCEELCHAA.barry@disus.com>
References: <20050414193507.GA22699@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:56:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMAQo-0003wr-Gg
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDNT6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVDNT6e
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:58:34 -0400
Received: from borg.disus.com ([199.243.199.210]:15121 "EHLO borg.disus.com")
	by vger.kernel.org with ESMTP id S261378AbVDNT61 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 15:58:27 -0400
Received: from ARNOLD (dhcpaj.secdisus.com [199.246.34.144])
	by borg.disus.com (8.11.6/8.11.6) with SMTP id j3EIwAf13090;
	Thu, 14 Apr 2005 14:58:10 -0400
To: "Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <junkio@cox.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20050414193507.GA22699@pasky.ji.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If you are merging from many distributed developers, than you would need to
replicate every one of their repositories into your own. Is this necessary?

I have been looking at Junio's code for merging, and it looks like it would
be (relatively) easy change to make it run live across two remote
repositories - assuming "future" science to develop remote common ancestor
lookup...

IE, merge.pl $COMMON-BASE $LOCAL-CHANGESET remote::$REMOTE-CHANGESET

To make this work, only a couple of things need to happen:
1) be able to remotely run "remote::diff-tree $BASE $REMOTE-CHANGESET", and
copy the results over the net to the place in the script where it is done
locally. This is not a LOT of data, and is bounded by the number of total
number of blobs in the resulting tree.

2) When a remote blob is required (for merging, or copying), then copy it
from the remote .git/objects to the local one. You only copy the blobs that
will end up in the merged result (or be used for file merge).

The way Junio has done it, no intermediate trees or commits are used...

You don't copy remote's tree of commits between $BASE and $REMOTE-CHANGESET,
or any of their associated trees and blobs (unless used to merge).

Is this a bug or a feature?


Barry Silverman

