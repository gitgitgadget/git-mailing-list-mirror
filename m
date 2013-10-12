From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [BAD PATCH 0/9] v4-aware tree walker API
Date: Sat, 12 Oct 2013 10:42:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310121001000.3023@syhkavp.arg>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1310091137310.3023@syhkavp.arg> <20131011122259.GA7776@lanh>
 <20131011130528.GA10014@lanh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 16:42:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV0OS-0001mY-Q9
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 16:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab3JLOmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 10:42:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab3JLOmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 10:42:07 -0400
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUK00KPO8U6PR00@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 12 Oct 2013 10:42:06 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 1CD912DA0669; Sat, 12 Oct 2013 10:42:06 -0400 (EDT)
In-reply-to: <20131011130528.GA10014@lanh>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236049>

On Fri, 11 Oct 2013, Duy Nguyen wrote:

> On Fri, Oct 11, 2013 at 07:22:59PM +0700, Duy Nguyen wrote:
> > > > Maybe we could make an exception and allow the tree walker to pass
> > > > pv4_tree_cache* directly to decode_entries so it does not need to do
> > > > the first lookup every time..
> > > > 
> > > > Suggestions?
> 
> Looking at decode_entries() traces I think the "one decode_entries()
> for one tree_entry()" just amplifies the delta chain effect. If you
> hide 3 entries behind 5 layers of copy sequences
> (i.e. tree1->tree2->..->tree5->real-tree-entry), then every
> decode_entries(count=1) will have to go through 5 layers.

Calling decode_entries() for every tree entry is a bad approach.  We 
should really implement this as a state machine preserving the entire 
state between entries so that moving to the next entry is just a matter 
of advancing a pointer in most cases.


Nicolas
