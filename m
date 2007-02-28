From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 13:18:08 -0600
Message-ID: <17893.54640.150106.294218@lisa.zopyra.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUJn-0007Nm-BJ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbXB1TSZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbXB1TSZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:18:25 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60904 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbXB1TSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:18:24 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SJILt07520;
	Wed, 28 Feb 2007 13:18:21 -0600
In-Reply-To: <20070228174339.GE5924@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40991>

On Wednesday, February 28, 2007 at 12:43:39 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> Yes: 1.4.x worked fine.  This was actually my attempt to re-do the 1.4
>> clone I had laying around, as I wanted my backup done with 1.5.  I
>> still have the 1.4 cloned repo, just moved it out of the way...
>
>OK, is ~/devel/project fully packed?  If it isn't can you repack
>it (or a clone of it) so that it is?

I did a git gc on this before starting, so I assume it is fully packed.

I tried copying my backup 1.4 repo to my local drive and then cloning
it with 1.5 onto my nfs-mounted drive.  This failed like this:

% cp -rp project-/ ~/project-1.4
% git clone --bare ~/project-1.4
[...]
Resolving 1286 deltas.
fatal: cannot pread pack file: Success from=37269, packfile size=0
fatal: index-pack died with error code 128

Just to see what 1.4 will now do, I tried with 1.4, and it is now
failing also:

[Reset PATH]
% git --version
git version 1.4.4.1
% git clone --bare ~/project-1.4
[...]
Resolving 1286 deltas.
remote: Total 3165, written 3165 (delta 1286), reused 1840 (delta 488)
fatal: index-pack died of signal 7

>Then take the packfile and try to feed it right into index-pack:
>
>	mkdir /austin/users/rael/repos/git/project-test
>	cd /austin/users/rael/repos/git/project-test
>	git --bare init
>	git --bare index-pack --stdin --fix-thin \
>	  <~/devel/project/.git/objects/pack/pack-*.pack
>
>Now while that is running it should be creating pack_XXXXXX as a
>temporary file (where XXXXXX is replaced with the temp string).
>Its this file that we are seeing magically truncate to 0 in the
>middle of running.

Did that.  Still fails:

% git --bare index-pack --stdin --fix-thin < ~/devel/project/.git/objects/pack/pack-fe532a54e5d549f1cfc70a4ab2c5f4eaac8897a5.pack
fatal: cannot pread pack file: Success from=39215, packfile size=0

I do see this:

% ls -l objects
total 88088
drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 info/
drwxr-xr-x  2 rael  software     4096 Feb 28 13:05 pack/
-rw-------  1 rael  software 90099505 Feb 28 13:06 pack_eZwOnG


Bill
