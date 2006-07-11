From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-base: update the clean-up postprocessing
Date: Tue, 11 Jul 2006 01:13:57 -0700
Message-ID: <7vpsgc4kze.fsf@assigned-by-dhcp.cox.net>
References: <44AB0948.9070606@gmail.com>
	<7vy7v8dctz.fsf@assigned-by-dhcp.cox.net>
	<7vejx0cwwj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 11 10:14:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0DNb-0002pE-61
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 10:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGKIN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 04:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGKIN7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 04:13:59 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6802 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750735AbWGKIN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 04:13:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711081358.USTF985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 04:13:58 -0400
To: git@vger.kernel.org
In-Reply-To: <7vejx0cwwj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 05 Jul 2006 00:51:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23694>

Junio C Hamano <junkio@cox.net> writes:

> A fixed up version of this patch, along with your updated test,
> is at the tip of "pu".
>
> It does affect the processing time for cases where there are
> more than one merge bases negatively.  To compute all merge-base
> for the 23 merges in the kernel reporitory, the old code with
> the "contaminate the well a bit more" clean-up phase takes 2.5
> seconds, while the new code takes 3.9 seconds.
>
> Processing all 2215 merges in the kernel repository (the other
> 2192 merges have one merge-base between the parents) takes 160
> seconds either way.  In other words, multi merge-base merges are
> relatively rare and a bit more time spent to clean-up with the
> new code is lost in the noise.
>
> The numbers are taken from /usr/bin/time on an Athron 64X2 3800.

I did a similar test on git.git repository.  Numbers are
interesting.

 * I have 941 two-head merges.  89 of them are multi-base
   merges.  This is unproportionally higher compared to the
   kernel repository.

 * Both the version in "master" (i.e. the one with the horizon
   effect) and this version with updated clean-up code produces
   identical set of merge bases for all 941 two-head merges.

 * The difference in processing time for 941 two-head merges
   with both versions is lost within margin of error.
