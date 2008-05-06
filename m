From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Make rebase save ORIG_HEAD if using current branch
Date: Tue, 6 May 2008 13:45:04 -0400
Message-ID: <54536F65-3A06-482E-9806-2E4F643C1024@silverinsanity.com>
References: <20080506051920.GA9165@Hermes.local> <481FFB62.9090804@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 06 19:46:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtRF0-0001WH-He
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 19:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763777AbYEFRpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 13:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbYEFRpO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 13:45:14 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54132 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbYEFRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 13:45:09 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C303C1FFC250;
	Tue,  6 May 2008 17:45:01 +0000 (UTC)
In-Reply-To: <481FFB62.9090804@viscovery.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81372>


On May 6, 2008, at 2:32 AM, Johannes Sixt wrote:

> Brian Gernhardt schrieb:
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 9b13b83..8d54d9f 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -342,6 +342,7 @@ case "$#" in
>> 		branch_name=HEAD ;# detached
>> 	fi
>> 	branch=$(git rev-parse --verify "${branch_name}^0") || exit
>> +	echo "$branch" > "$GIT_DIR/ORIG_HEAD"
>
> 1. You should be using 'git update-ref' here, I think.
> 2. You should detect errors.

This is exactly how git-merge.sh does it.  While that's not a good  
argument for adding this, perhaps merge should be updated as well.   
And presumably update-ref will make detecting errors easy.  But is  
being unable to set ORIG_HEAD an error that should stop the entire  
process?

> 3. Should ORIG_HEAD better be set at the end of the rebase, not at the
> beginning? Because if the rebase stops for some reason, and then you  
> do a
> 'git reset', you'll have overwritten the ORIG_HEAD that you have set  
> here.

I put it where I did because I thought it would only make sense when  
rebasing the current HEAD (instead of the two argument version that  
switches first).  Duplicating the logic to determine that later seemed  
wasteful.  Also, might you want to access the original HEAD during a  
rebase conflict?  (Although that would argue that ORIG_HEAD should be  
set for all rebases, to $upstream.)

~~ Brian
