From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 13:16:06 -0800
Message-ID: <7vljscd695.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
 <20090210121833.GC15491@coredump.intra.peff.net>
 <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de>
 <20090210131029.GC17305@coredump.intra.peff.net>
 <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <7vprhqnv0c.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de>
 <20090210165610.GP30949@spearce.org>
 <7vocxam96s.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
 <20090211200227.GA27961@coredump.intra.peff.net>
 <alpine.DEB.1.00.0902112152270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:17:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMSw-0008T1-Oi
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945AbZBKVQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbZBKVQS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:16:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286AbZBKVQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:16:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C1C69811E;
	Wed, 11 Feb 2009 16:16:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CFDB99811D; Wed,
 11 Feb 2009 16:16:08 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902112152270.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 11 Feb 2009 21:57:23 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 36CCA3C8-F881-11DD-9187-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109531>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Even the merging should not pose any problem at all; we need a custom 
> merge driver anyway, and there is no reason whatsoever why we should not 
> just teach the merge driver to remove the slashes before comparing the 
> filie names.

Once you start talking about "remove the slashes", you are assuming that
the custom merge algorithm must look at *all the paths* in the two trees
being merged, and it is a sign that your thinking is so trapped in the
inefficient way the current merge-recursive and unpack-trees based merge
works, and cannot think about the possibility that there could be more
efficient way to do merges.  Not very good.

If you have a fixed boundary and if most subtrees are the same between two
notes during a merge, we can do the same optimization as we do for two
input "diff-tree" codepath.  If the top of a subtree matches, we do not
even have to look at their subtree.  But that is true only if you do not
remove the slashes and allow a random hierarchy.
