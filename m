From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 11:56:01 +0100
Organization: At home
Message-ID: <eppshi$1l4$1@sea.gmane.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <20070130165548.GF25950@spearce.org> <20070131015555.GA1944@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 11:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCD7R-0003NK-Sm
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 11:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbXAaKzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 05:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933006AbXAaKzJ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 05:55:09 -0500
Received: from main.gmane.org ([80.91.229.2]:37495 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998AbXAaKzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 05:55:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCD79-0008Nw-ML
	for git@vger.kernel.org; Wed, 31 Jan 2007 11:54:55 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 11:54:55 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 11:54:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git,gmane.comp.version-control.mercurial.general
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38239>

Theodore Tso wrote:

> On Tue, Jan 30, 2007 at 11:55:48AM -0500, Shawn O. Pearce wrote:
>> I think hg modifies files as it goes, which could cause some issues
>> when a writer is aborted.  I'm sure they have thought about the
>> problem and tried to make it safe, but there isn't anything safer
>> than just leaving the damn thing alone.  :)
> 
> To be fair hg modifies files using O_APPEND only.  That isn't quite as
> safe as "only creating new files", but it is relatively safe.

>From (libc.info):

 -- Macro: int O_APPEND
     The bit that enables append mode for the file.  If set, then all
     `write' operations write the data at the end of the file, extending
     it, regardless of the current file position.  This is the only
     reliable way to append to a file.  In append mode, you are
     guaranteed that the data you write will always go to the current
     end of the file, regardless of other processes writing to the
     file.  Conversely, if you simply set the file position to the end
     of file and write, then another process can extend the file after
     you set the file position but before you write, resulting in your
     data appearing someplace before the real end of file.

I don't quote understand how that would help hg (Mercurial) to have
operations like commit, pull/fetch or push atomic, i.e. all or nothing.
In hg you have to update individual files (blobs buckets) storing delta
and perhaps full version, update manifest file (flat tree) and update
changelog (commit): what happens if for example there are two concurrent
operations trying to update repository, e.g. two push operations in parallel
(from two different developers), or fetch from cron and commit? What
happens if operation is interrupted (e.g. lost connection to network during
fetch)?

In git both situations result in some prune-able and fsck-visible crud in
repository, but repository stays uncorrupted, and all operations are atomic
(all or nothing).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
