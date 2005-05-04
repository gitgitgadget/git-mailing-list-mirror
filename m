From: Junio C Hamano <junkio@cox.net>
Subject: Re: Howto update a 'dirty' entry in the cache from the object
 database
Date: Wed, 04 May 2005 10:37:40 -0700
Message-ID: <7vll6uopsr.fsf@assigned-by-dhcp.cox.net>
References: <20050504142351.GL18380@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505041014510.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 19:33:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTNja-00081H-69
	for gcvg-git@gmane.org; Wed, 04 May 2005 19:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVEDRiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 13:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEDRiX
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 13:38:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42703 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261285AbVEDRhq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 13:37:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050504173740.SXIX16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 4 May 2005 13:37:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505041014510.2328@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 4 May 2005 10:23:01 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Wed, 4 May 2005, Thomas Glanzmann wrote:
>> 
>> I edited a bunch of files and notice that I want to revert back one of
>> the files to the original one (the one that comes with HEAD). But I
>> already updated the cache. Is there a way to 'patch' the cache with the
>> original file.

LT> Absolutely.

LT> You can do it several ways. The easiest one is

LT> 	git-read-tree -m HEAD
LT> 	git-checkout-cache -f filename

LT> but this means that you revert your entire index file to the old HEAD 
LT> information, so you'll need to do git-update-cache on the files that you 
LT> changed.

I think the easiest one that does not lose the cache for other
files is:

    git-diff-cache -z HEAD |
    GIT_EXTERNAL_DIFF=git-apply-patch-script \
        git-diff-tree-helper -z -R filename

This means: find diff from HEAD to the cache, and apply the diff
in the reverse, only to the filename.

