From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a certain blob
Date: Sat, 17 Feb 2007 10:30:50 -0800
Message-ID: <7vire0tz51.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:30:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUKl-0005kB-Eo
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbXBQSaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbXBQSaw
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:30:52 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43942 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030247AbXBQSav (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:30:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217183052.UMZY1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 13:30:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QiWq1W00R1kojtg0000000; Sat, 17 Feb 2007 13:30:51 -0500
In-Reply-To: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 17 Feb 2007 18:39:50 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40006>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +static struct object_hash file_trees = { 0, 0, NULL };
> +static struct object_array file_commits = { 0, 0, NULL };

These don't look good for two reasons: (1) you could leave BSS
to do the 0 initialization; (2) you need to change this if you
need to change the shape of "struct object_hash" later.

> +#define CONTAINS_FILE (1u<<10)

I am partly at fault, but I think we should have a consolidated
bit assignment policy in place before introducing new users of
object flags.  Some older code says in their comments that
revision.h reserves lower 8 bits while others say 16.  I offhand
know who is correct X-<.
