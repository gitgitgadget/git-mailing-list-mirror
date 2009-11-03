From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH resend] gitk: Fix "git gui blame" invocation when called from topdir
Date: Tue, 3 Nov 2009 21:39:47 +1100
Message-ID: <19184.2163.760155.285153@cargo.ozlabs.ibm.com>
References: <1256990974-32671-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 11:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Gny-0001yT-Qk
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 11:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbZKCKju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 05:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbZKCKju
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 05:39:50 -0500
Received: from ozlabs.org ([203.10.76.45]:41922 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbZKCKju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 05:39:50 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0A07DB7BD8; Tue,  3 Nov 2009 21:39:54 +1100 (EST)
In-Reply-To: <1256990974-32671-1-git-send-email-markus.heidelberg@web.de>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131962>

Markus Heidelberg writes:

> In this case "git rev-parse --git-dir" doesn't return an absolute path,
> but merely ".git", so the selected file has a relative path.
> The function make_relative then tries to make the already relative path
> relative, which results in a path like "../../../../Makefile" with as
> much ".." as the number of parts [pwd] consists of.
> 
> This regression was introduced by commit 9712b81 (gitk: Fix bugs in
> blaming code, 2008-12-06), which fixed "git gui blame" when called from
> subdirs.
> 
> This also fixes it for bare repositories.

Thanks for the patch, but I'd prefer to just add:

    if {[file pathtype $f] ne "relative"} {
	return $f
    }

at the start of the function.  I think that's easier to read than
having a big if statement.  Would you like to do a new patch or will I
just make that change to your patch?

Paul.
