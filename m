From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 18:27:07 +0200
Message-ID: <200706131827.08163.Josef.Weidendorfer@gmx.de>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org> <e5bfff550706130708k601514c9o1ba2747582027699@mail.gmail.com> <Pine.LNX.4.64.0706131553390.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:27:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVgl-0003JQ-Km
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099AbXFMQ1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758198AbXFMQ1S
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:27:18 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:43705 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757958AbXFMQ1R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 12:27:17 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id B9FAD277B;
	Wed, 13 Jun 2007 18:27:15 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0706131553390.4059@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50090>

On Wednesday 13 June 2007, Johannes Schindelin wrote:
> ~1.4s	log _with_ --pretty=raw
> ~3.5s	log _with_ --pretty=raw _and_ -z (!)

That happens on linux, too.

I am not really familiar with that code, but comparision
of the call graphs of "git log" vs. "git log -z", as
produced by callgrind (shameless plug) and visualized
by kcachegrind (again, another shameless plug) shows
that the difference happens in log_tree_diff, called
from log_tree_commit.

While without "-z", log_tree_diff immediatly returns
because "opt->diff" is 0, in the case of "-z",
the tree differences are fully done even not used at all ?!

The result is that "log_tree_commit" executes (inclusive
callees) 340 million instructions without "-z", while
it runs 2300 million instructions in the "-z" case.

Josef
