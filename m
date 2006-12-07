X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 7 Dec 2006 15:33:48 -0800
Message-ID: <f2b55d220612071533l332d107t5852121eab53e5d8@mail.gmail.com>
References: <45744FA3.7020908@zytor.com>
	 <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
	 <4577A84C.3010601@zytor.com>
	 <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
	 <45785697.1060001@zytor.com>
	 <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
	 <457868AA.2030605@zytor.com>
	 <Pine.LNX.4.64.0612071121410.3615@woody.osdl.org>
	 <20061207193903.GE12143@spearce.org>
	 <Pine.LNX.4.64.0612071152410.3615@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 23:34:02 +0000 (UTC)
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IieQ2l8z/NORXP9bOv/btR8DoW9BWUt+PGVRXtrFqh4abmwAi+vOuMODkMAlLuAW6wllIeMs5R1oM8tsHDsJAtqzMcG8y8DT2s+b/2/BEsGyS7h35yeph79mGjKiKk6ONqeMW/q6XwoeTY46Q2NBbJdJcHY0doXA7jBAakHrS64=
In-Reply-To: <Pine.LNX.4.64.0612071152410.3615@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33648>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsSkT-0000bA-Qs for gcvg-git@gmane.org; Fri, 08 Dec
 2006 00:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163998AbWLGXdv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 18:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163636AbWLGXdu
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 18:33:50 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:22193 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1163998AbWLGXdt (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 18:33:49 -0500
Received: by wx-out-0506.google.com with SMTP id h27so657620wxd for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 15:33:49 -0800 (PST)
Received: by 10.90.89.5 with SMTP id m5mr3414357agb.1165534428957; Thu, 07
 Dec 2006 15:33:48 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Thu, 7 Dec 2006 15:33:48 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/7/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Does anybody who is web-server clueful know if there is some simple
> front-end (squid?) that is easy to set up and can just act as a caching
> proxy in front of such an incompetent server?

Squid in "transparent reverse proxy" mode isn't a bad choice, although
I don't know offhand whether it queues/clusters concurrent requests
for the same URL in the way you want.  I suggest the "transparent"
deployment (netfilter/netlink integration) because you can slap it in
with no changes to the origin server and yank it out again if you have
a problem.  The challenge is in getting conntrack to scale to a
zillion concurrent sessions, but you could probably find someone in
your crowd who knows something about that.  :-)

Ignore any documentation that talks about httpd_accel_*.  Configuring
transparent mode is a great deal simpler and saner in squid 2.6 than
it used to be; you just add a "transparent" parameter to the http_port
tag.  With or without this tag, you set up what used to be called
"accelerator mode" using some parameters to http_port and cache_peer,
as described in
http://www.squid-cache.org/mail-archive/squid-users/200607/0162.html.

If transparent mode looks like the right thing for kernel.org, you
might be interested in some netfilter hackery to offload part of the
conntrack session lookup load to a front-end box that blocks DDoS and
acts more or less as an L4 switch plus session context cache.  I've
been banging on a proof of concept implementation for a while, and am
currently working on integrating against 2.6.19 by splitting
nf_conntrack into front and back halves that interact via a sort of
Layer 2+ header.  I have no idea yet whether it will have any
scalability benefit on dual-x86_64 class hardware (it was originally
conceived for rigid cache architectures where the random access
patterns of session lookups have drastic cache effects).

Cheers,
