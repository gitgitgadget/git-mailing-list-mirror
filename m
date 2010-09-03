From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 06:37:12 -0400
Message-ID: <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com> <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 12:38:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrTfI-0005Vu-JE
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 12:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267Ab0ICKhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 06:37:21 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:54416 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932301Ab0ICKhQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 06:37:16 -0400
X-AuditID: 12074422-b7bbfae000005e9b-44-4c80cfd8b0e7
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id A5.28.24219.8DFC08C4; Fri,  3 Sep 2010 06:37:12 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o83AbF8b019655;
	Fri, 3 Sep 2010 06:37:15 -0400
Received: from [10.0.42.101] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o83AbDgt026801
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Sep 2010 06:37:14 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155241>


On Sep 2, 2010, at 7:09 PM, Nicolas Pitre wrote:

> The BitTorrent model is simply unappropriate for Git.  It doesn't fit to 
> the Git model at all as BitTorrent works on stable and static data, and 
> requires a lot of people wanting that same data.

I wonder if this would work.   Assume for the moment that once every N days (where N might be one month), the "Gittorrent master" generates a "canonical pack construction file" that contains information about the objects, their delta pairing, the version of diff and zlib required, etc., and the SHA1 of the expected resulting encoding of this pack file.   This would contain the canonical pack for the entire repository, and for the Linux kernel, it might be released on www.kernel.org, and contain all of the objects from the beginning of time to the latest commit in Linus Torvalds' repository.

Although everybody's git repository will have different packs that they use and store natively, by following the "canonical pack construction file" they will be able to build up a canonical encoding for the pack that can then be used to more quickly allow newbie developers who are pulling the full clone of Linus's tree for the first time to download using a peer2peer Bittorrent style download.   So people who are willing to participate as part of the peer2peer network can download the instructions for how to make the canonical pack once a month, and use it to create the canonical pack.  If the "Gittorrent master" has spent a lot of time to carefully compute the most efficient set of delta pairings, they will get the slight benefit of a more efficient pack which they could use instead of th
 eir local one without having to use large values of --window and --depth to "git repack". 

This allows the peer2peer download to be used where it most matters --- for the bulk download for people who are cloning from the "canonical repository" for the first time.  After that, they will no doubt find it far more efficient to download incremental uploads using the git protocol. 

-- Ted
