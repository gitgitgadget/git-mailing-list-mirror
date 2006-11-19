X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 15:26:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611191522580.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> 
 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com> 
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>  <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
  <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org> 
 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com> 
 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org> 
 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com> 
 <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com> 
 <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
 <e5bfff550611191425g30d02b98l71cfdc6439d2e09f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 23:26:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611191425g30d02b98l71cfdc6439d2e09f@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31872>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glw3L-0002aD-7S for gcvg-git@gmane.org; Mon, 20 Nov
 2006 00:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933737AbWKSX0S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 18:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933739AbWKSX0S
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 18:26:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52879 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S933737AbWKSX0R (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 18:26:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJNQDix016119
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 19
 Nov 2006 15:26:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJNQCDI021112; Sun, 19 Nov
 2006 15:26:12 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Marco Costalba wrote:
> 
> Excuse me for my ignorance, but isn' it the job of OS disk schedulers?

The OS disk scheduler does exactly that but

	ONLY IF IT'S GIVEN DATA TO WORK ON IN PARALLEL

If an application gives it read requests one by one, the OS has no choice 
but to just do the accesses one by one.

Writes are easier, since you can just buffer them. But you can't "buffer" 
a read. When the user asks for a readdir(), you'd better give it to the 
user, and there's not anything you can do about it.

So disk schedulers only work for 
 - parallel workloads
 - writes

(where "parallel workloads" can be asynchronous reads - where the user 
says "I will _start_ this read, notify me when it's done" and then gives 
multiple independent reads to do in parallel).

So the OS cannot add parallelism - it can only take advantage of what 
parallelism the application gives it.

