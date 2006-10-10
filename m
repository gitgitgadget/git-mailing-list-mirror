From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Wed, 11 Oct 2006 00:09:00 +0200
Message-ID: <452C19FC.7030001@tromer.org>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz> <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org> <452BF8B3.5090305@tromer.org> <Pine.LNX.4.64.0610101423561.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:15:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXPt5-0006oK-2Y
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030583AbWJJWPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 18:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030588AbWJJWPn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:15:43 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:12266 "EHLO
	lucian.tromer.org") by vger.kernel.org with ESMTP id S1030583AbWJJWPn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 18:15:43 -0400
Received: from [192.168.4.6] ([192.168.4.6])
	by lucian.tromer.org (8.13.7/8.12.11) with ESMTP id k9AMFX6e011287;
	Wed, 11 Oct 2006 00:15:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610101423561.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28677>

On 2006-10-10 23:25, Linus Torvalds wrote:
> On Tue, 10 Oct 2006, Eran Tromer wrote:
>> Too late: "git repack -a -d" already does it, in contradiction to its 
>> manpage. It creates a new pack by following .git/refs, and then deletes 
>> all old pack files.
> 
> That's very different.
> 
> That just means that you should not try to do two _concurrent_ repacks. 

How so? This process loses the unreferenced objects from the old packs,
where "referenced" is determined in a racy way. Same problem.

> 
>> Don't run it on a shared repo, then. And grab a coffee while it runs.
>> But why force leaf repositories to accumulate garbage?
> 
> Nobody forces that.
> 
> You can run "git prune" if you want to. But at least we know that "git 
> prune" is unsafe.

But "git prune" does not GC packs, only loose objects.

Anyway, I think the right thing to do is to make "git repack -a -d"
operate safely (not drop any objects), and add a new --prune option
so that "git repack -a -d --prune" does what "git repack -a -d" used to do.

  Eran
