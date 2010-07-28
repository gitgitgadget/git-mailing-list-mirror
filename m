From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 17:00:09 -0700
Message-ID: <20100728000009.GE25268@spearce.org>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Juran <jjuran@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 02:00:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odu4I-0001bD-Td
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 02:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab0G1AAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 20:00:14 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36377 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0G1AAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 20:00:12 -0400
Received: by pxi14 with SMTP id 14so677390pxi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 17:00:12 -0700 (PDT)
Received: by 10.114.92.20 with SMTP id p20mr5135462wab.65.1280275212047;
        Tue, 27 Jul 2010 17:00:12 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id x9sm9854728waj.3.2010.07.27.17.00.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 17:00:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152019>

Avery Pennarun <apenwarr@gmail.com> wrote:
> 
> While we're here, it's probably worth mentioning that git's index file
> format (which stores a sequential list of full paths in alphabetical
> order, instead of an actual hierarchy) does become a bottleneck when
> you actually have a huge number of files in your repo (like literally
> a million).  You can't actually binary search through the index!  The
> current implementation of submodules allows you to dodge that
> scalability problem since you end up with multiple smaller index
> files.  Anyway, that's fixable too.

Yes.

More than once I've been tempted to rewrite the on-disk (and I guess
in-memory) format of the index.  And then I remember how painful that
stuff is in either C git.git or JGit, and I back away slowly.  :-)

Ideally the index is organized the same way the trees are, but
you still can't do a really good binary search because of the
ass-backwards name sorting rule for trees.  But for performance
reasons you still want to keep the entire index in a single file,
an index per directory (aka SVN/CVS) is too slow for the common
case of <30k files.

-- 
Shawn.
