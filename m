From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Tue, 25 Nov 2008 18:31:41 +0100
Message-ID: <492C367D.3030209@drmicha.warpmail.net>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Tue Nov 25 18:33:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L51mb-0001Fd-91
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 18:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYKYRbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 12:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYKYRbs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 12:31:48 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42062 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752317AbYKYRbr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 12:31:47 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 555D31C8AF3;
	Tue, 25 Nov 2008 12:31:46 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 25 Nov 2008 12:31:46 -0500
X-Sasl-enc: vUIelm4+2FZm7lwwlC1FgMobdyHlecl55HFhPOIr1sf1 1227634305
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4221CABD9;
	Tue, 25 Nov 2008 12:31:45 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101671>

Ondrej Certik venit, vidit, dixit 25.11.2008 17:44:
> Hi,
> 
> I would like to export our whole git repository to patches, and then
> reconstruct it again from scratch. Following the man page of "git
> fast-export":
> 
> $ git clone git://git.sympy.org/sympy-full-history-20081023.git
> $ cd sympy-full-history-20081023
> $ git fast-export --all --export-marks=marks > patches
> $ cd ..
> $ mkdir sympy-new
> $ cd sympy-new
> $ git init
> $ git fast-import --export-marks=marks < ../sympy-full-history-20081023/patches
> git-fast-import statistics:
> ---------------------------------------------------------------------
> Alloc'd objects:      25000
> Total objects:        21355 (       144 duplicates                  )
>       blobs  :         8009 (         0 duplicates       4529 deltas)
>       trees  :        10627 (       144 duplicates       9189 deltas)
>       commits:         2719 (         0 duplicates          0 deltas)
>       tags   :            0 (         0 duplicates          0 deltas)
> Total branches:          21 (        26 loads     )
>       marks:        1048576 (     10728 unique    )
>       atoms:            726
> Memory total:          2880 KiB
>        pools:          2098 KiB
>      objects:           781 KiB
> ---------------------------------------------------------------------
> pack_report: getpagesize()            =       4096
> pack_report: core.packedGitWindowSize =   33554432
> pack_report: core.packedGitLimit      =  268435456
> pack_report: pack_used_ctr            =      40706
> pack_report: pack_mmap_calls          =       2791
> pack_report: pack_open_windows        =          1 /          2
> pack_report: pack_mapped              =   26177739 /   35513414
> ---------------------------------------------------------------------
> 
> 
> 
> However, the repository is very different to the original one. It
> contains only 191 patches:
> 
> $ git log --pretty=oneline | wc -l
> 191
> 
> and it only contains couple files. Compare this with the original repository:
> 
> $ git log --pretty=oneline | wc -l
> 2719

I get the same stats (with the dups) but a perfect rev count, when I use
git log --all. The reason is that the history in the imported repo is
disconnected at various places (at tagging commits)! Your command counts
only the revs backwards to the first "disconnection".

So, the real issue is: Why has the result these cuts in the history?
I don't know, I just noticed that turning on rename and copy detection
makes git-fast-import crash, which shouldn't happen either. Something's
not right here. CC'ing the authors of im- and export.

BTW: Maybe you can accomplish what you want with different means? Why
export|import directly to git?

Michael
--
git 1.6.0.4.608.ga9645
