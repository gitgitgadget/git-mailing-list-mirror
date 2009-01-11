From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 18:31:47 +0200
Message-ID: <496A1EF3.20204@panasas.com>
References: <200901111602.53082.borntraeger@de.ibm.com> <200901111607.59054.borntraeger@de.ibm.com> <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de> <200901111620.03345.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 17:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM3FV-0000DV-5f
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 17:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbZAKQb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 11:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbZAKQb4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 11:31:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:26901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbZAKQbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 11:31:55 -0500
Received: by ug-out-1314.google.com with SMTP id 39so150193ugf.37
        for <multiple recipients>; Sun, 11 Jan 2009 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=bxPs0hM4s4FTJC15wCyXlHINZrgBlnM+DMPcRsxts/k=;
        b=rCdhDPOs72/QAwtGTuTtzNVtjTo6CHgKCWzcARR5RKtq8d6k2hUIqCUquv/fp/Kr0d
         QhPr5UzPTxaYB7qz8vPRqYKkwShkiYY7KN3M8Nj5La07yc/bvt0e++hIBNm7kBz6//Xc
         GAO269K4DoeQGUFbDYN2on2a4RBtLjCo/5XfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Fb2G8JocXPI9NDEMFMBT6hUTRgJTTHQoTE7RHmLgEY0egcjdQAZ1KHgHmmRcCk6Gzn
         0QPpcEL3XeaQPSuaHOUyNehCJesssuLRe9Re021/qHfdItbdcOjB1fxdSMEX7UekhxPo
         YZS2AZsYbc3N2pCzB6aijViT+eSDpNwVHvCCo=
Received: by 10.67.92.10 with SMTP id u10mr739829ugl.21.1231691513470;
        Sun, 11 Jan 2009 08:31:53 -0800 (PST)
Received: from bh-buildlin2.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id x37sm32929292ugc.41.2009.01.11.08.31.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 08:31:52 -0800 (PST)
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <200901111620.03345.borntraeger@de.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105193>

Christian Borntraeger wrote:
> Am Sonntag 11 Januar 2009 schrieben Sie:
>> Hi,
>>
>> On Sun, 11 Jan 2009, Christian Borntraeger wrote:
>>
>>> Am Sonntag 11 Januar 2009 schrieb Christian Borntraeger:
>>>> doing a 
>>>> git bisect start
>>>> git bisect good a3a798c
>>>> git bisect bad v2.6.29-rc1
>>>>
>>>> results in a repository without several files, e.g Makefile!
>>>> git describe also fails.
>>> In fact, retesting with a clean repository shows, that there are only 
> btrfs 
>>> files - nothing else.
>>>
>>> Linus did you pull a broken btrfs repository?
>> I guess it is a subtree merge.  So no, nothing went wrong
>>
>> Use "git bisect skip" to skip over those.
> 
> I think we should really avoid merging subtrees to the linux kernel. It makes 
> bisecting a real PITA. 

Should is too soft, we cannot. What if it changes mainline files, they will
not have common ancestry. And also the sub-tree checkout un-checkout will take
ages. Chris must have merged with his subtree with a rebase not a merge. I suspect
Linus git tree will have to rebase. This is the first time I've seen such a merge.
for example see be0e5c097f it has no parent, and so on.

> Furthermore, It is unlikely, but what if the problem is part of the 581 
> changesets from btrfs?
> 

Exactly

> Christian
> --

Boaz
