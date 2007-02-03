From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t9200 still failing...
Date: Sat, 3 Feb 2007 14:41:45 -0500
Message-ID: <E7A51B21-ECE4-4B0A-8CA2-538727AA6BFF@silverinsanity.com>
References: <DBACB5AE-7C40-4D44-85BB-76F30BE96E36@silverinsanity.com> <13848C22-6C0B-46F0-ABC5-1A94D0DB6B06@wf227.com> <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <82643737-7D5F-4A73-83BA-EB5AD9BBA5EA@wf227.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Wolfgang Fischer <wf@wf227.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 20:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDQlj-0003Pj-45
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 20:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXBCTlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 14:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbXBCTlt
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 14:41:49 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:37901 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbXBCTls (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 14:41:48 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id D0A141FFD0EE;
	Sat,  3 Feb 2007 19:41:47 +0000 (UTC)
In-Reply-To: <82643737-7D5F-4A73-83BA-EB5AD9BBA5EA@wf227.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38587>


On Feb 3, 2007, at 2:06 PM, Wolfgang Fischer wrote:

> A simple test would be to create a UFS image, mount it somewhere,  
> and run the tests inside the mounted UFS image. If the test  
> succeeds, there is a getdirent() somewhere in the codepath, where  
> you are not expecting it. OTOH we can assume already, that there is  
> a getdirents() somewhere, so you might just start with a debugger   
> with an appropriate breakpoint.

The true solution was to read the code more completely.  The way git  
tests for things that are ignored is to read the directory and  
compare it to the pathspecs from the command line.  If we don't find  
a match, it's obviously because the file was in an ignore file.   
Unfortunately, in OS X it's not obvious because of the mismatch  
between NFC and NFD on different file systems.

The solution, as I see it, is to use a Unicode-aware comparison in  
dir.c:match_one().  ICU appears to both be available on OS X  
(although without headers) and have the needed functions.  I'm  
unfamiliar with both ICU and this chunk of the git internals, but  
I'll work on a proof of concept patch.

~~ Brian
