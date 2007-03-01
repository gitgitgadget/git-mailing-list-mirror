From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Thu, 1 Mar 2007 09:23:47 -0600
Message-ID: <17894.61443.113876.53670@lisa.zopyra.com>
References: <17893.42063.186763.291346@lisa.zopyra.com>
	<20070228155412.GC5479@spearce.org>
	<17893.43522.511785.121778@lisa.zopyra.com>
	<17893.44181.129918.669187@lisa.zopyra.com>
	<20070228163256.GD5479@spearce.org>
	<118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
	<20070228164922.GB5924@spearce.org>
	<17893.46083.869042.467318@lisa.zopyra.com>
	<20070228170641.GC5924@spearce.org>
	<17893.47007.136145.112498@lisa.zopyra.com>
	<20070228174339.GE5924@spearce.org>
	<17893.54640.150106.294218@lisa.zopyra.com>
	<17893.54980.672279.633902@lisa.zopyra.com>
	<alpine.LRH.0.82.0702281439410.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 16:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMn8h-0007nB-Fs
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 16:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbXCAPYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 10:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbXCAPYN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 10:24:13 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61981 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965271AbXCAPYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 10:24:12 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l21FNqV01968;
	Thu, 1 Mar 2007 09:23:52 -0600
In-Reply-To: <alpine.LRH.0.82.0702281439410.29426@xanadu.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41099>

On Wednesday, February 28, 2007 at 14:40:25 (-0500) Nicolas Pitre writes:
>On Wed, 28 Feb 2007, Bill Lear wrote:
>
>> On Wednesday, February 28, 2007 at 13:18:08 (-0600) Bill Lear writes:
>> >
>> >% ls -l objects
>> >total 88088
>> >drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 info/
>> >drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 pack/
>> >-rw-------  1 rael  software 90099505 Feb 28 13:06 pack_eZwOnG
>> 
>> I should have added:
>> 
>> % ls -l ~/devel/fusion/.git/objects/pack/pack-fe532a54e5d549f1cfc70a4ab2c5f4eaac8897a5.pack
>> -r--r--r--  1 rael software 90099525 Feb 27 21:36 /home/rael/devel/project/.git/objects/pack/pack-fe532a54e5d549f1cfc70a4ab2c5f4eaac8897a5.pack
>> 
>> That's 20 bytes of difference.
>
>That is actually OK.  This is the temporary pack file the fetch received 
>but which final SHA1 has not been written yet.  Normally, after the 
>delta resolution has finished (the part that requires the pread() calls) 
>then the final SHA1 is written and the pack is moved to its final 
>location under an appropriate name.  But in your case index-pack bailed 
>out on the failing pread() and left its incomplete temporary pack there.

As follow-up: I installed git 1.5.0.1 on a box with a newer version of
Linux, tried the same operations and it worked fine.

% uname -a
Linux xiho.zopyra.com 2.6.15-1.2054_FC5smp #1 SMP Tue Mar 14 16:05:46 EST 2006 i686 i686 i386 GNU/Linux

% git clone --bare ~/project
Initialized empty Git repository in /austin/users/rael/repos/git/project/
remote: Generating pack...
remote: Done counting 4304 objects.
remote: Deltifying 4304 objects.
remote:  100% (4304/4304) done
Indexing 4304 objects.
remote: Total 4304 (delta 2031), reused 4293 (delta 2026)
 100% (4304/4304) done
Resolving 2031 deltas.
 100% (2031/2031) done

So, I guess we'll just have to upgrade our Linux boxes to get the
newer NFS client code that appears to be the cause of this...


Bill
