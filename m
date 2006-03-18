From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] 3% tighter packs for free
Date: Fri, 17 Mar 2006 23:21:33 -0800
Message-ID: <7vwtesxloi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603172205490.4889@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 08:21:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKVkp-0002Yk-0s
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 08:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbWCRHVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 02:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbWCRHVf
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 02:21:35 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44254 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1752181AbWCRHVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 02:21:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318071953.NDYM20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 02:19:53 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0603172205490.4889@localhost.localdomain> (Nicolas
	Pitre's message of "Fri, 17 Mar 2006 22:45:07 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17688>

Nicolas Pitre <nico@cam.org> writes:

>  			if (inscnt) {
> +				while (moff && ref_data[moff-1] == data[-1]) {
> +					if (msize == 0x10000)
> +						break;
> +					/* we can match one byte back */
> ...
> +					break;
> +				}
>  				out[outpos - inscnt - 1] = inscnt;

Once you make it into a patch form, it is plainly obvious that
this is a good optimization.  Since our BLK_SIZE is 16 bytes,
you are grabbing up to 15 more bytes (on average 8 more bytes or
so) for every match after a partially modified block.

Very nice.  I wonder if a larger BLK_SIZE (say 32 bytes) would
give us faster packing without losing much compression if we use
this idea.
