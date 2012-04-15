From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sun, 15 Apr 2012 21:32:42 +0200
Message-ID: <20120415193242.GA1960@ecki>
References: <20120414182907.GA3915@ecki>
 <4F89D1C6.8090705@kdbg.org>
 <20120414220606.GA18137@ecki>
 <4F8B0158.4040407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:52:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVUz-00089c-QW
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab2DOTwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 15:52:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42790 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab2DOTwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 15:52:33 -0400
Received: from [127.0.0.1] (p5B22C962.dip.t-dialin.net [91.34.201.98])
	by bsmtp.bon.at (Postfix) with ESMTP id 14240130045;
	Sun, 15 Apr 2012 21:52:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4F8B0158.4040407@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195583>

On Sun, Apr 15, 2012 at 07:11:52PM +0200, Johannes Sixt wrote:
> 
> But reading the first line in this way needs a few assumptions to be true:
> 
> - git-daemon does not write an incomplete line and then waits.

Yes. One way to avoid that assumption would be a timeout.

> - git-daemon does not write more than one line, because xread() happily
> reads everything it can get. Your implementation differs from the old
> version because the shell's 'read' is required to read no more than one
> line, i.e., to read byte-wise from the pipe until it sees the LF.

The strbuf_getwholeline_fd implementation calls xread(fd, buf, 1),
reading only one byte at a time. It does not try to read beyond the
newline.
