From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/3] t3700: avoid racy git situation
Date: Thu, 08 Nov 2007 16:45:59 +0100
Message-ID: <47332F37.5090402@viscovery.net>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site> <Pine.LNX.4.64.0711081414160.4362@racer.site> <47331E65.9010209@viscovery.net> <Pine.LNX.4.64.0711081511440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9bH-0002sT-7x
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761258AbXKHPqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761237AbXKHPqG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:46:06 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22944 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761243AbXKHPqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:46:05 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq9ZT-0004F4-LI; Thu, 08 Nov 2007 16:45:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 874516B7; Thu,  8 Nov 2007 16:45:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711081511440.4362@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64046>

Johannes Schindelin schrieb:
> The problem is that the index has the same timestamp as the file "foo".
> 
> Therefore, git cannot tell if "foo" is up-to-date in the index, since it 
> could have been modified (and indeed is) just a fraction of a second later 
> than the index was last updated.

The test goes like this:

         >foo && git add foo && git commit -a -m "commit all" &&
         test -z "`git diff-index HEAD -- foo`" &&
         git read-tree HEAD &&
         case "`git diff-index HEAD -- foo`" in
         :100644" "*"M   foo") echo ok;;
         *) echo fail; (exit 1);;
         esac &&
         git add --refresh -- foo &&
         test -z "`git diff-index HEAD -- foo`"

I'm pretty sure that this test completed within one second even before 
git-commit was a builtin. (I assume that timestamps don't have sub-second 
resolution.) Why then didn't this racy-git problem occur with the scripted 
git-commit?

-- Hannes
