X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 14:28:28 +0100
Message-ID: <200612111428.29390.Josef.Weidendorfer@gmx.de>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> <200612111026.23656.Josef.Weidendorfer@gmx.de> <e5bfff550612110452t5bb18517yc0cf8278d4d9948c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 13:28:57 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550612110452t5bb18517yc0cf8278d4d9948c@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34001>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtlD3-0002eN-UE for gcvg-git@gmane.org; Mon, 11 Dec
 2006 14:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762903AbWLKN2m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 08:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762905AbWLKN2m
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 08:28:42 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:56235 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1762903AbWLKN2m (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 08:28:42 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 78A2A2138; Mon, 11
 Dec 2006 14:28:40 +0100 (MET)
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On Monday 11 December 2006 13:52, Marco Costalba wrote:
> On 12/11/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > On Monday 11 December 2006 01:15, Marco Costalba wrote:
> > >               guiUpdateTimer.start(100, true);
> >
> > What is the result with "guiUpdateTimer.start(0, true);" ?
> ...
> IOW you suggest to use a brute force polling of the pipe.

Ah, yes. That is probably not what you want.

Why did you introduce the timer at all? What was the problem
with QProcess and handling its signal "data available" ?

If you do

	git-rev-list | cat > /dev/null

the consuming "cat" will do a blocking read, and this should have
the same property "handle data as fast as possible when they
come available" as QProcess with handling the data in
the handler of QProcess' signal "data available".

If it is about postprocessing the small data chunks you get (and the
double copy in memory), I do not think this is a problem: a machine
noadays usually should handle 1 GB/s bandwidth to memory. You probably
are loosing more with your 100ms timer.

Or am I missing something?

