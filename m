From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Fri, 14 Mar 2008 11:18:30 +1300
Message-ID: <47D9A836.9010601@catalyst.net.nz>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZvlk-0007JJ-Rp
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 23:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYCMWSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 18:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbYCMWSe
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 18:18:34 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:51775 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbYCMWSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 18:18:33 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.113])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JZvks-0005NE-Qq; Fri, 14 Mar 2008 11:18:30 +1300
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77142>

Marc-Andre Lureau wrote:
> git-symbolic-ref HEAD returns master reference, even if the file does
> not exists. That prevents the initial checkout and fails in
> git-rev-parse.

But you are patching the block that gets triggered on subsequent
imports, this code does not deal with "initial checkout" unless
something else is wrong. The line right above the open() is an else that
has the block that matters.

> The patch checks the existence of the reference file
> before assuming an original branch exists. There might be better
> solutions than checking file existence.

There are indeed. If we need this patch -- then you can call git
ref-parse right to see if you get a sha1.

> -	unless ($last_branch) {
> +	if (-f "$git_dir/$last_branch") {

Note that the file won't exist there in any modern git. It will be in
$git_dir/refs/heads/$last_branch. Did you test this patch?

What's your workflow with cvsimport? Perhaps you are doing something
strange with it... :-)

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
