From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Be more careful with objects directory permissions on
 clone
Date: Tue, 06 May 2008 10:08:58 +0200
Message-ID: <4820121A.9090606@viscovery.net>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz> <481ECCF0.6080308@viscovery.net> <alpine.BSO.1.10.0805051047260.7723@zrgural.vwaro.pbz> <481EDC4B.2010105@viscovery.net> <alpine.BSO.1.10.0805051121090.32248@zrgural.vwaro.pbz> <481EE478.9000704@viscovery.net> <alpine.BSO.1.10.0805051742020.10940@zrgural.vwaro.pbz> <fvp14f$8v0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 10:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtIFG-0007xF-Lc
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 10:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbYEFIJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 04:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbYEFIJG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 04:09:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31802 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYEFIJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 04:09:01 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JtIEN-0005jC-Cd; Tue, 06 May 2008 10:08:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1050C6B7; Tue,  6 May 2008 10:08:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <fvp14f$8v0$1@ger.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81343>

Jakub Narebski schrieb:
> Mark Hills wrote:
> 
>> -               find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
>> +               # Create dirs using umask and permissions and destination
>> +               find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir -p) &&
>> +               # Copy existing 0444 permissions on content
>> +               find objects ! -type d -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
> 
> By the way, it is important that previous version had -depth, and
> proposed one doesn't? Was it about creating directories before files?

-depth means that directory names are listed *after* their content.
Consequently, it was about setting modification times and permissions on
directories *after* all of their content is created at the destination.

The intent of the new version is to not copy permissions of directories;
and since the modification times don't matter, the absence of -depth is ok.

-- Hannes
