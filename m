X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 09:07:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612110905180.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com> 
 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org> 
 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com> 
 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org> 
 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com> 
 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org> 
 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com> 
 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
 <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
 <Pine.LNX.4.64.0612110855550.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 17:08:22 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612110855550.12500@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34017>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtodY-0002ee-TT for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762954AbWLKRIB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762949AbWLKRHy
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:07:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44715 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762950AbWLKRHx
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 12:07:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBH7jID021890
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 09:07:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBH7hrK032219; Mon, 11 Dec
 2006 09:07:44 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Linus Torvalds wrote:
> 
> That's not timing what I asked. That's just timing the "git-rev-list". You 
> need to time the "cat" part too. Either use a script, or do something like 
> 
> 	time sh -c "git-rev-list ... | cat > /dev/null".

Btw, if you do this, you'll actually see one of the _real_ advantages of 
pipes.

On an SMP system, you'll easily get output like "110%CPU", since now the 
git-rev-list and the user can run in parallel. Of course, they can do so 
with temp-files too, but then you have all the "is it a true EOF, or is it 
just the fact that the writer hasn't written everything yet" problem (and 
the _normal_ solution for that is to simply not allow any overlapping 
work).

