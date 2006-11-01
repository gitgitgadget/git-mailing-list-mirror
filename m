X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Wed, 01 Nov 2006 08:15:53 -0800
Message-ID: <7vodrr2ldy.fsf@assigned-by-dhcp.cox.net>
References: <20060925044641.GB15757@spearce.org>
	<20061031174225.3c7c1e77.vsu@altlinux.ru>
	<7vac3covlf.fsf@assigned-by-dhcp.cox.net> <ei8s19$e04$1@sea.gmane.org>
	<20061101151859.0e984d3f.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 16:16:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061101151859.0e984d3f.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Wed, 1 Nov 2006 15:18:59 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30646>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfIkw-000706-9x for gcvg-git@gmane.org; Wed, 01 Nov
 2006 17:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946919AbWKAQPz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 11:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946920AbWKAQPz
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 11:15:55 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:42135 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1946919AbWKAQPy
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 11:15:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101161554.TVYI18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 11:15:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hUFy1V00B1kojtg0000000 Wed, 01 Nov 2006
 11:15:58 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> writes:

> What name format should be used for such saved refs?  refs/old/`date -I`
> is not unique enough; probably `date --utc +%Y.%m.%d-%H.%M.%S`?  And it
> would be good if multiple refs which were deleted or modified in a
> non-fast-forward way during a single operation (like git-mirror) would
> be saved together - which may be tricky if they are saved at the lower
> level (in update-ref).
>
> Adding the fast-forward check into update-ref also does not look nice,
> but this check is required for full safety.

I wasn't going to suggest doing the check or even naming at such
a low level.  From the usability point of view, the caller
should decide if the discarded refs are even saved at all, and
if so in which namespace.  That way commit_lock_file() can just
notice the old version of the locked file (it is always sitting
next to it) and hardlink the discarded one to the purgatory
before renaming the newly created .lock file there.



