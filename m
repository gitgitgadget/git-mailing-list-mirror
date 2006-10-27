X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 10:27:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610271022240.11384@xanadu.home>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
 <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home>
 <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home>
 <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org>
 <20061027030054.GB28407@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 27 Oct 2006 14:28:19 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061027030054.GB28407@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30328>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdSgJ-0006Fd-KU for gcvg-git@gmane.org; Fri, 27 Oct
 2006 16:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752212AbWJ0O1J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 10:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbWJ0O1I
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 10:27:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27627 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752212AbWJ0O1H
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 10:27:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7S00ANCTH5WD00@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Fri,
 27 Oct 2006 10:27:06 -0400 (EDT)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, Shawn Pearce wrote:

> Unfortunately it does not completely work.
> 
> What happens when the incoming pack (steps #2 and #3) takes 15
> minutes to upload (slow ADSL modem, lots of objects) and the
> background repack process sees those temporary refs and starts
> trying to include those objects?  It can't walk the DAG that those
> refs point at because the objects aren't in the current repository.
> 
> From what I know of that code the pack-objects process will fail to
> find the object pointed at by the ref, rescan the packs directory,
> find no new packs, look for the object again, and abort over the
> "corruption".
> 
> OK so the repository won't get corrupted but the repack would be
> forced to abort.

Maybe this is the best way out?  Abort git-repack with "a fetch is in 
progress -- retry later".  No one will really suffer if the repack has 
to wait for the next scheduled cron job, especially if the fetch doesn't 
explode packs into loose objects anymore.

> Another issue I just thought about tonight is we may need a
> count-packs utility that like count-objects lists the number
> of active packs and their total size.  If we start hanging onto
> every pack we receive over the wire the pack directory is going to
> grow pretty fast and we'll need a way to tell us when its time to
> `repack -a -d`.

Sure.  Although the pack count is going to grow much less rapidly.  
Think of one pack per fetch instead of many many objects per fetch.


