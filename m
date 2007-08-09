From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 14:46:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu Aug 09 23:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJFqo-0007e2-2R
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 23:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbXHIVrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXHIVrW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 17:47:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32861 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751410AbXHIVrV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 17:47:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79Lkl3u027965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 14:46:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79LkfPw021174;
	Thu, 9 Aug 2007 14:46:41 -0700
In-Reply-To: <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55479>



On Thu, 9 Aug 2007, Linus Torvalds wrote:
> 
> So "builtin-read-tree.c" (or rather unpack-trees.c) would need the same 
> kind of logic.

The path seems to be:

  cmd_read_tree ->
    unpack_trees ->
      unpack_trees_rec ->
        [ recursive .. unpack_trees_rec ] ->
	  oneway_merge ->
	    keep_entry ->
	      add_index_entry()

and here again we end up having the same insertion sort issue.

		Linus
