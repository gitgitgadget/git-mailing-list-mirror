X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Wed, 06 Dec 2006 02:13:31 -0800
Message-ID: <7vlkll72no.fsf@assigned-by-dhcp.cox.net>
References: <456FD461.4080002@saville.com>
	<Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
	<456FDF24.1070001@saville.com>
	<Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
	<7vejri20mf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4575B32F.5060108@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
	<Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac22glzz.fsf@assigned-by-dhcp.cox.net>
	<7vwt5573sy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612061058360.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 10:13:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612061058360.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 6 Dec 2006 11:02:10 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33422>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtmR-00019J-OD for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760428AbWLFKNd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760431AbWLFKNc
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:13:32 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50446 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759302AbWLFKNc (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 05:13:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206101331.KVI15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 6
 Dec 2006 05:13:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vNCv1V0091kojtg0000000; Wed, 06 Dec 2006
 05:12:56 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Originally, I thought that building in git-merge-one-file, and enhancing 
> it to recognize by the parameters if it should act as a merge replacement, 
> would be the way to go. Should I do this, or rather add 
> builtin-merge-file?

All in-tree users of git-merge-one-file is of this pattern:

	git merge-index -o git-merge-one-file -a

so I was hoping we can capture this whole thing as a single
command (merge-index would fork+exec a merge-one-file per
unmerged path), instead of doing merge-one-file as a built-in.

In any case, the way your xdl-merge engine is done, it should be
almost trivial to write a pure 'RCS merge replacement' as a
totally separate program -- the bulk of the new code would be
parsing parameters, opening the three input files, populating
mmfile structures and writing the result out, and there would be
almost no "smart" in that part of the code you would want to
share with the git-aware version.



