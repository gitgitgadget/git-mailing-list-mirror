From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Tue, 10 Oct 2006 21:46:59 +0200
Message-ID: <452BF8B3.5090305@tromer.org>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz> <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 10 21:54:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXNfm-0007VD-03
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 21:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWJJTxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWJJTxu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 15:53:50 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:32720 "EHLO
	lucian.tromer.org") by vger.kernel.org with ESMTP id S1030237AbWJJTxu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 15:53:50 -0400
Received: from [192.168.4.6] ([192.168.4.6])
	by lucian.tromer.org (8.13.7/8.12.11) with ESMTP id k9AJrWin010111;
	Tue, 10 Oct 2006 21:53:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28659>

On 2006-10-10 17:03, Linus Torvalds wrote:
> On Tue, 10 Oct 2006, Sam Vilain wrote:
>> If using git-repack -a, unreferenced objects are kept behind in the
>> pack.  This might be the best default, but there are no good ways
>> to clean up the packfiles if a lot of rebasing is happening, or
>> branches have been deleted.
> 
> Don't do this.

Too late: "git repack -a -d" already does it, in contradiction to its
manpage. It creates a new pack by following .git/refs, and then deletes
all old pack files.

> I understand why you want to do it, but the fact is, it's dangerous.
> 
> Right now, "git repack" is actually safe to run even on a repository which 
> is being modified! And that's actually important, if you have something 
> like a shared repo that gets re-packed every once in a while from a 
> cron-job!

Don't run it on a shared repo, then. And grab a coffee while it runs.
But why force leaf repositories to accumulate garbage?

This functionality is just as racy, and just as necessary, as
"git-prune". It merely garbage-collects the packs as well. Git seems to
collect unreferenced objects faster than the space between the cushions
in my sofa, and there ought to be a way to tidy up things.

Linus, I see why you neither need nor want this functionality in your
typical workflow, but things look different for a downstream developer
who engages in a variety of garbage-generating activities like tracking
wild trees, rebasing patches and using stgit. I really don't need that
unreferenced copy of 2.6.15-rc2-mm1 in my packs anymore.

  Eran
