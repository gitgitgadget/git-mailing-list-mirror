X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] make =?iso-8859-1?Q?index-p=E2ck?= able to complete
 thin packs
Date: Fri, 27 Oct 2006 20:41:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610272032110.11384@xanadu.home>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home>
 <7vmz7hcs0o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 28 Oct 2006 00:47:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vmz7hcs0o.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30353>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdcGD-0001rG-BN for gcvg-git@gmane.org; Sat, 28 Oct
 2006 02:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750980AbWJ1AlE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 20:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWJ1AlE
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 20:41:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:584 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1750980AbWJ1AlC
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 20:41:02 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7T001UHLWCM800@VL-MO-MR001.ip.videotron.ca> for git@vger.kernel.org; Fri,
 27 Oct 2006 20:41:01 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 27 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > +static void fix_unresolved_deltas(int nr_unresolved)
> > +{
[...]
> > +		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
> > +			continue;
> 
> Just for the sake of my own sanity checking,...
> 
> Is it because base objects of OFS_DELTA _must_ exist in the same
> pack (even when --thin) that we do not have to worry about them
> in this function?

Indeed.  Otherwise it would be impossible to determine the offset to the 
base object if that base object is not in the pack.

That doesn't mean there isn't any OFS_DELTA left to resolve though.  
But this function is only about adding missing objects to the pack and 
the deltas that need them must be REF_DELTA objects.

Once a REF_DELTA has been resolved with an external object, it then 
constitute a possible new base for remaining OFS_DELTA or 
REF_DELTA objects, and that is found recursively in resolve_delta().


