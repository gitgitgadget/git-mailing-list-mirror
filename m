X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Add a test for git-rerere
Date: Wed, 20 Dec 2006 10:37:47 -0800
Message-ID: <7v4prqfm6c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612201737190.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 18:38:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612201737190.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 20 Dec 2006 17:37:45 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34954>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx6KT-00052Y-5T for gcvg-git@gmane.org; Wed, 20 Dec
 2006 19:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030276AbWLTSht (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 13:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWLTSht
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 13:37:49 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40414 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030276AbWLTShs (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 13:37:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220183747.HVZY20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 13:37:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 16d51W00j1kojtg0000000; Wed, 20 Dec 2006
 13:37:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +cat > a1 << EOF
> +Whether 'tis nobler in the mind to suffer
> +The slings and arrows of outrageous fortune,
> +Or to take arms against a sea of troubles,
> +And by opposing end them? To die: to sleep;
> +No more; and by a sleep to say we end
> +The heart-ache and the thousand natural shocks
> +That flesh is heir to, 'tis a consummation
> +Devoutly to be wish'd.
> +EOF

This is out of copyright protection long time ago, so it would
be fine to use in example ;-).

> +sha1=4f58849a60b4f969a2848966b6d02893b783e8fb
> +rr=.git/rr-cache/$sha1
> +test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
> +
> +test_expect_success 'no postimage or thisimage yet' \
> +	"test ! -f $rr/postimage -a ! -f $rr/thisimage"

I am worried that this test specifies the behaviour a bit too
precisely.  It is not t0000 basic where we want bit-for-bit
match with the expected result.  Wouldn't this test break when
you further improve xdl_merge, for example?

> +rm $rr/postimage
> +echo -ne "$sha1\ta1\0" > .git/rr-cache/MERGE_RR

Hmmmmmm.  I've stayed away from "echo -e" so far...

> +sha2=4000000000000000000000000000000000000000
> +rr2=.git/rr-cache/$sha2
> +mkdir $rr2
> +echo Hello > $rr2/preimage

Collisions are not so likely and perhaps we do not care.

> +case "$(date -d @11111111 +%s 2>/dev/null)" in
> +[1-9]*)
> +	# it is a recent GNU date. good.
> +	now=$(date +%s)
> +	let almost_15_days_ago=$now+60-15*86400
> +	let just_over_15_days_ago=$now-1-15*86400
> +	let almost_60_days_ago=$now+60-60*86400
> +	let just_over_60_days_ago=$now-1-60*86400

Hmmmmm.  I've stayed away from "let" so far as well...
