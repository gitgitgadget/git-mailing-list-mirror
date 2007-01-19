From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-email --suppress-from option doesn't work.
Date: Fri, 19 Jan 2007 02:24:36 +0100
Message-ID: <45B01DD4.7000204@op5.se>
References: <45AFE18C.2020303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 02:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7iVB-0008CG-7t
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 02:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbXASBZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 20:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932839AbXASBZG
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 20:25:06 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:50923 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838AbXASBZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 20:25:05 -0500
Received: from [172.27.78.30] (unknown [172.27.76.254])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3DF4F6BCBC; Fri, 19 Jan 2007 02:25:03 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45AFE18C.2020303@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37146>



Timur Tabi wrote:
> The --suppress-from option doesn't work for me because the comparison is
> too strict.
> 
> Here's an example usage of git-send-email:
> 
> git-send-email --suppress-from --from timur@freescale.com --to
> timur@tabi.org --smtp-server remotesmtp.freescale.net
> 0001-Add-support-for-the-MPC8349E-mITX-GP.txt
> 
> I need to specify the --from option, because otherwise git-send-email
> will prompt me for a From address, and I don't want it to prompt me for
> anything.
> 
> The problem is that the patchfile contains this line:
> 
> From: Timur Tabi <timur@freescale.com>
> 
> That means that the patchfile contains the string "Timur Tabi
> <timur@freescale.com>", but the --from specifies the string
> "timur@freescale.com".  The code which checks the suppress-from option
> is here:
> 
>                         } elsif (/^(Cc|From):\s+(.*)$/) {

I believe

	(/^(Cc|From):[^<]+<([^>])+>.*$/)

would do the trick for your case. It would however fail when specifying a proper
--from address in the 'git commit --author="Foo Barson <foo@barson.com>"' style.

Are you sure you need to specify --from for those patches though?

>                                 if ($2 eq $from) {
>                                         next if ($suppress_from);
>                                 }
> 
> I don't know Perl, but I'm guess the The "$2 eq $from" is a strict
> comparison that fails in my case.
> 
> Some of you might say at this point, "Why don't you  just specify --from
> "Timur Tabi <timur@freescale.com>"?  I tried that, and it still doesn't
> work.
> 

That sounds extremely odd indeed. Could this have to do with character
conversion?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
