X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Corrupt pack file using older versions of git on a newer repo..
Date: Wed, 20 Dec 2006 10:30:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612201024370.18171@xanadu.home>
References: <BAYC1-PASMTP11ADF6C984028A9DED853FAECF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 15:31:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <BAYC1-PASMTP11ADF6C984028A9DED853FAECF0@CEZ.ICE>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34938>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx3PW-0006zt-Hr for gcvg-git@gmane.org; Wed, 20 Dec
 2006 16:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964870AbWLTPbL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 10:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWLTPbL
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 10:31:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41658 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964870AbWLTPbK (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 10:31:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAK006AMWFGEKL0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Wed,
 20 Dec 2006 10:30:52 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Wed, 20 Dec 2006, Sean wrote:

> 
> This is probably expected behavior, but when bisecting another Git
> issue[1], i found that after a fresh clone of the git repository using
> 1.4.4.2 I got the following corrupt pack file when accessing that repo
> with an old version of git:
> 
> $ git --version
> git version 1.4.2
> 
> $ git log
> fatal: corrupted pack file .git/objects/pack/pack-d75f6a8307f8d8ce9727fe27107486839c54aef6.pack

To make that repository accessible with older git versions simply run 
git-repack -a -d using version 1.4.4.2.

The clone with version 1.4.4.2 added OBJ_OFS_DELTA objects to the pack 
which older git versions don't know about.  Those objects are used for 
pack transport when both ends know about them as they take less space.  
But the repack doesn't use them by default so a full repack will get rid 
of them automatically.


