From: Geert Bosch <bosch@gnat.com>
Subject: Re: [PATCH] Fix renaming branch without config file
Date: Thu, 5 Apr 2007 12:00:58 -0400
Message-ID: <B0C79D8E-07A8-4178-B0A6-698EB2BB5A2A@gnat.com>
References: <20070405144359.4B8832A7C67@potomac.gnat.com> <Pine.LNX.4.63.0704051728400.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZUOi-0003Dr-Qj
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 18:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767121AbXDEQBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 12:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767116AbXDEQBF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 12:01:05 -0400
Received: from nile.gnat.com ([205.232.38.5]:55429 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767121AbXDEQBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 12:01:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id E1B2448CDA0;
	Thu,  5 Apr 2007 12:00:59 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 11271-01-10; Thu,  5 Apr 2007 12:00:59 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id A62D948CDF1;
	Thu,  5 Apr 2007 12:00:59 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.63.0704051728400.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43839>


On Apr 5, 2007, at 11:30, Johannes Schindelin wrote:
> I don't think this is correct. git_config_rename_section() _should_  
> return
> an error.
>
>> Otherwise, renaming a branch would abort, leaving the repository  
>> in an
>> inconsistent state.
>
> This should take the hint from --rename-section, and print a  
> warning (or
> not).

Looking at the code, I deduced that git_config_rename_section()
returns a positive count of sections renamed, 0 if no matching
section exists and negative for another error condition.

The proposed patch makes the behavior of an absent config file the
same as the behavior of an empty one, which seems sane to me.
There should be no warning, as it is perfectly fine to have no
config file. Could you elaborate on why you believe my patch
is not correct?

Currently, a repository without "config" file will be messed up by
trying to rename a branch, as the rename will mostly succeed but
leaves the HEAD dangling, requiring manual file editing to recover.

   -Geert
