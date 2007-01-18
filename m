From: Timur Tabi <timur@freescale.com>
Subject: git-send-email --suppress-from option doesn't work.
Date: Thu, 18 Jan 2007 15:07:24 -0600
Organization: Freescale
Message-ID: <45AFE18C.2020303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 18 22:07:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7eTp-00076Y-D3
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 22:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbXARVH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 16:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXARVH0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 16:07:26 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:44404 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbXARVH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 16:07:26 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l0IL7PHi013724
	for <git@vger.kernel.org>; Thu, 18 Jan 2007 14:07:25 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0IL7OTE023191
	for <git@vger.kernel.org>; Thu, 18 Jan 2007 15:07:24 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37140>

The --suppress-from option doesn't work for me because the comparison is too strict.

Here's an example usage of git-send-email:

git-send-email --suppress-from --from timur@freescale.com --to timur@tabi.org 
--smtp-server remotesmtp.freescale.net 0001-Add-support-for-the-MPC8349E-mITX-GP.txt

I need to specify the --from option, because otherwise git-send-email will 
prompt me for a From address, and I don't want it to prompt me for anything.

The problem is that the patchfile contains this line:

From: Timur Tabi <timur@freescale.com>

That means that the patchfile contains the string "Timur Tabi 
<timur@freescale.com>", but the --from specifies the string 
"timur@freescale.com".  The code which checks the suppress-from option is here:

                         } elsif (/^(Cc|From):\s+(.*)$/) {
                                 if ($2 eq $from) {
                                         next if ($suppress_from);
                                 }

I don't know Perl, but I'm guess the The "$2 eq $from" is a strict comparison 
that fails in my case.

Some of you might say at this point, "Why don't you  just specify --from "Timur 
Tabi <timur@freescale.com>"?  I tried that, and it still doesn't work.

Basically, what I want is to prevent git-send-email from CC'ing me on my own 
patches.  No matter what I do, I can't prevent it from adding "Cc: Timur Tabi 
<timur@freescale.com>" to the email header.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
