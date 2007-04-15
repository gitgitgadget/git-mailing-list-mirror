From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Expose subprojects as special files to "git diff" machinery
Date: Sun, 15 Apr 2007 21:16:23 +0100
Message-ID: <200704152116.26773.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 22:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdB9Q-0001pq-N2
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbXDOUQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbXDOUQl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:16:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:47624 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbXDOUQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:16:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so953394uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 13:16:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JDwLQXqNS7k/OEXXmwkblrWxMU1rEKx9MRyEmYSLYb3kv8msaJf+LPqvHv1dNzlYroEQ/nbzkhBr4ZuayMM50FHUohIZSwxkjKPh+T2xVfOPHtqdBDcm4yURWVCcNnspb3ptmqsmyOTP7BjzWiZBHHLOojPHIedijVQzM0r5Mp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PbJ7ofW3dxs02M1VSJgXOYoUlFJN6pPyRYVZPOvkkAArh38lpoB/b5Jr74JBsFM5peVwgb78mWYlDXUOI8vEfco2QxJayZO6/yVC2Vlv26CtIeZwtcOWFz6OQsKIgT48oi9GUfnf/ccqzBpYQSeh3+Wv6le7/PbV7/0Y95eTItQ=
Received: by 10.67.19.17 with SMTP id w17mr3770270ugi.1176668199214;
        Sun, 15 Apr 2007 13:16:39 -0700 (PDT)
Received: from grissom.local ( [82.0.29.64])
        by mx.google.com with ESMTP id b36sm10732340ika.2007.04.15.13.16.38;
        Sun, 15 Apr 2007 13:16:38 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44514>

On Sunday 2007, April 15, Linus Torvalds wrote:

> 	diff --git a/sub-A b/sub-A
> 	index 2de597b..e8f11a4 160000
> 	--- a/sub-A
> 	+++ b/sub-A
> 	@@ -1 +1 @@
> 	-Subproject commit 2de597b5ad348b7db04bd10cdd38cd81cbc93ab5
> 	+Subproject commit e8f11a45c5c6b9e2fec6d136d3fb5aff75393d42

Isn't this dangerous because it looks just like a normal diff with a 
file being rewritten, when in truth it is a tree entry record being 
rewritten.  Possibly this is in the same category as the enhancements 
needed for rename support

cf.

diff --git a/file1 b/file2
similarity index 100%
rename from file1
rename to file2

There's no need to have a line marker, as there is only one "line" in 
the subproject "file", and no need for the index line because that 
information is contained in the change itself.  So something like:

diff --git a/sub-A b/sub-B
subproject from commit 2de597b5ad348b7db04bd10cdd38cd81cbc93ab5
subproject to commit e8f11a45c5c6b9e2fec6d136d3fb5aff75393d42

Regardless of the format, I'm sure this should be treated as part of 
git's extended diff syntax, so that if a diff like this ever got into 
the wild it wouldn't be a disaster if someone tried to apply it.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
