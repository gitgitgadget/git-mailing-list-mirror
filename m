From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Sun, 15 Jun 2008 08:59:38 +0900
Message-ID: <200806142359.m5ENxsBI028758@mi0.bluebottle.com>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
	<OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	<20080611213648.GA13362@glandium.org>
	<alpine.DEB.1.00.0806112242370.1783@racer>
	<20080611230344.GD19474@sigill.intra.peff.net>
	<alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	<loom.20080612T042942-698@post.gmane.org>
	<6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	<7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
	<279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
	<7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
	<279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com>
	<alpine.DEB.1.00.0806130551200.6439@racer>
	<0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
	<alpine.DEB.1.00.0806132239490.6439@racer>
	<612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 02:00:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7fft-0007Bw-Tx
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 02:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbYFNX7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 19:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755789AbYFNX7z
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 19:59:55 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:56532 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784AbYFNX7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 19:59:54 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5ENxsBI028758
	for <git@vger.kernel.org>; Sat, 14 Jun 2008 16:59:54 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:date:to:cc:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=dSEpQ6b3QzIArbiZNCQ4PPaOjtF0nWsZWPs7In9ErG0nhThILApHt3knBCbvM+Ig1
	dPe3p253EF9VPTX72P80Ot4bf5SY/8bNg+QMIIdKISfYPK71+v4ioa01iyPpn+v
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5ENxd2q001863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Jun 2008 16:59:44 -0700
In-Reply-To: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
X-Trusted-Delivery: <55076bf889212f0d8decb9f00d6dfbc2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85055>

Wincent Colaiuta <win@wincent.com> writes:

> (2) The people largely responsible for the implementation of "git
> stash" never envisaged its use for long term storage (either
> intentional abuse of "stash", or inadvertent misuse) and architected
> it in such a way that it can "forget" stashes after a period of time

I apologize for my lack of perfect foresight as the original
author of the command.  As I already said, I think expiration
period of reflogs that is configurable for each ref as suggested
earlier by Junio makes sense.

But changing the default expiration "never" for stash has its
own problem and I think we need to modify the way a stash entry
is created to solve it.

You will find in the DISCUSSION section of git-stash manual page
that a stash entry is represented as a commit that is a merge
between the commit the stash was made on (H), and a fake commit
whose tree records the contents of the index (I).  The merge
commit itself records the state of the files in the working
directory as its tree (W):

           .----W
          /    /
    -----H----I

If you do not expire stash forever, you will keep the history
behind the commit H.  This is unnecessary and is problematic
particularly if you rebase your branches frequently.

In order to apply a stash, all you need is the tree of the three
commits contained in this structure.  You do not need the
history behind commit H.

The following is a trial patch to change how a stash is recorded.
With this patch I do not think we will keep unnecessary commits
behind H in the repository even when a stash is kept forever.

diff --git a/git-stash.sh b/git-stash.sh
index 4938ade..f4c4236 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -54,6 +54,9 @@ create_stash () {
 	fi
 	msg=$(printf '%s: %s' "$branch" "$head")
 
+	# create the base commit that is parentless
+	b_commit=$(printf 'base of %s\n' "$msg" | git commit-tree "HEAD:")
+
 	# state of the index
 	i_tree=$(git write-tree) &&
 	i_commit=$(printf 'index on %s\n' "$msg" |


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
