From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 20:48:57 +0100
Message-ID: <201101112048.57326.j6t@kdbg.org>
References: <4D262D68.2050804@cfl.rr.com> <4D2C7611.6060204@cfl.rr.com> <20110111173922.GB1833@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Phillip Susi <psusi@cfl.rr.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:49:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PckDN-0000C5-LY
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577Ab1AKTtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:49:04 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:61346 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932319Ab1AKTtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:49:03 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C49CDCDF86;
	Tue, 11 Jan 2011 20:48:56 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AD2C019F5F2;
	Tue, 11 Jan 2011 20:48:57 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20110111173922.GB1833@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164982>

On Dienstag, 11. Januar 2011, Jeff King wrote:
> On Tue, Jan 11, 2011 at 10:24:01AM -0500, Phillip Susi wrote:
> > Yes, either a new branch or separate historical repository could be
> > published to pull the original history from, or git would need to pass
> > the --no-replace-objects flag to git-upload-pack on the server, causing
> > it to ignore the replace and send the original history.
>
> AFAIK, git can't pass --no-replace-objects to the server over git:// (or
> smart http). You would need a protocol extension.

Why would you have to? git-upload-pack never looks at replacement objects.

> And here's another corner case I thought of:
>
> Suppose you have some server S1 with this history:
>
>   A--B--C--D
>
> and a replace object truncating history to look like:
>
>   B'--C--D
>
> You clone from S1 and have only commits B', C, and D (or maybe even B,
> depending on the implementation). But definitely not A, nor its
> associated tree and blobs.

Why so? Cloning transfers the database using git-upload-pack, 
git-pack-objects, git-index-pack, and git-unpack-objects. All of them have 
object replacements disabled. (And AFAICS, there is no possibility to 
*enable* it.)

Therefore, after cloning you get

 A--B--C--D

and perhaps also the replacement object B'.

Hint: git grep read_replace_refs

-- Hannes
