From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why are ref_lists sorted?
Date: Sun, 18 Mar 2007 22:42:27 -0700
Message-ID: <7vd535lrgc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
	<Pine.LNX.4.64.0703190520150.24247@beast.quantumfyre.co.uk>
	<20070319053331.GA22534@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 06:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTAda-0004Xd-Jc
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 06:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965553AbXCSFm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 01:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965560AbXCSFm3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 01:42:29 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46335 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965553AbXCSFm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 01:42:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319054229.LKNA748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 01:42:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cViT1W00j1kojtg0000000; Mon, 19 Mar 2007 01:42:28 -0400
In-Reply-To: <20070319053331.GA22534@spearce.org> (Shawn O. Pearce's message
	of "Mon, 19 Mar 2007 01:33:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42592>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We already have the ISPACKED flag in the flags field to tell us if
> the ref is loose or not.  When inserting a ref into the hash table
> you keep the loose version (either if its in the table, or the one
> being inserted).

As long as you are careful enough not to break the unwrapped
entries, repacking and re-reading of refs (I think these three
are the reasons we have separate lists), I am fine with that
change.  I also think some callers of do_for_each_refs (this
includes the userland that use git-for-each-ref and/or
git-show-ref) expect the traversal to be sorted, so I would like
to keep that sorted output behaviour.

An additional hash to speed up look-up operation is probably a
good thing to have.
