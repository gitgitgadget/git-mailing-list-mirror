From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] filter-branch: provide the convenience functions also for commit filters
Date: Wed, 18 Jul 2007 17:19:55 -0700
Message-ID: <7vfy3l5jo4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707181650080.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 02:20:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBJkW-0003Tl-1n
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 02:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761993AbXGSAUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 20:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762037AbXGSAUE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 20:20:04 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45985 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761652AbXGSAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 20:20:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070719002001.NPE1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Jul 2007 20:20:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RCL01X00C1kojtg0000000; Wed, 18 Jul 2007 20:20:00 -0400
In-Reply-To: <Pine.LNX.4.64.0707181650080.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 18 Jul 2007 16:52:00 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52915>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +this_script="$(cd "$(dirname "$0")"; pwd)"/$(basename "$0")
> ...
> +		filter_commit="SOURCE_FUNCTIONS=1 . \"$this_script\"; $OPTARG"

Hmmmmmm.

Care to enlighten why this is not just:

	filter_commit="SOURCE_FUNCTIONS=1 . \"$0\"; $OPTARG"

Is it because you cd(1) around in the script, and it can be
relative to where you started?

In either case, are you quoting potential funnies (such as '"'
or '\\') in "$0" sufficiently?  Exporting this_script variable,
and changing the above to

	filter_commit='SOURCE_FUNCTIONS=1 . "$this_script";'" $OPTARG"

to arrange the shell that is invoked with 'sh -c' to expand its
value would make it smaller problem, I suspect.
