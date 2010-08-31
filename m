From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Large pack causes git clone failures ... what to do?
Date: Tue, 31 Aug 2010 11:02:47 -0700
Message-ID: <20100831180247.GF32601@spearce.org>
References: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:02:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVAe-0003Vy-5K
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab0HaSCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:02:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35631 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0HaSCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:02:50 -0400
Received: by pvg2 with SMTP id 2so2568676pvg.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 11:02:50 -0700 (PDT)
Received: by 10.114.52.1 with SMTP id z1mr7412939waz.64.1283277770342;
        Tue, 31 Aug 2010 11:02:50 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 33sm16844173wad.6.2010.08.31.11.02.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 11:02:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154949>

Geoff Russell <geoffrey.russell@gmail.com> wrote:
> I did a "git gc" on a repository and ended up with a 4GB pack ... now I
> can't clone the repository and get the following:
> 
> remote: fatal: Out of memory? mmap failed: Cannot allocate memory
> remote: aborting due to possible repository corruption on the remote side.
> fatal: early EOF
> error: git upload-pack: git-pack-objects died with error.
> fatal: git upload-pack: aborting due to possible repository corruption
> on the remote side.
> fatal: index-pack failed
> 
> How do I deal with this?   I'm running git version 1.6.2.3

Are you on a 32 bit Linux system?  Or 64 bit?  Git should be auto
selecting a unit that would allow it to mmap slices of that 4GB pack.

> I've looked at "git repack --max-pack-size", but which that
> created new packs it didn't delete the old monster.

You really needed to run:

  git repack --max-pack-size=.. -a -d

The -d flag tells it to remove the old packs once the new packs
are ready, and the -a flag tells it to reconsider every object
in the repository, rather than just those that are loose.

But if you can't clone it, you probably can't repack it.  Clone works
by creating a pack file on the server, just like repack does.
Except it sends the pack out to the network stream instead of to
local disk.

-- 
Shawn.
