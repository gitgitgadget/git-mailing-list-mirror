From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: how do you review auto-resolved files
Date: Tue, 21 Feb 2012 17:22:09 -0600
Message-ID: <4F442721.4080107@gmail.com>
References: <ji0vik$e48$1@dough.gmane.org> <7vhayjga0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 00:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzz2G-0002X9-Fr
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 00:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494Ab2BUXWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 18:22:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41300 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2BUXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 18:22:09 -0500
Received: by ghrr11 with SMTP id r11so3194847ghr.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 15:22:09 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.153.70 as permitted sender) client-ip=10.236.153.70;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.153.70 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.153.70])
        by 10.236.153.70 with SMTP id e46mr37760302yhk.29.1329866529199 (num_hops = 1);
        Tue, 21 Feb 2012 15:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AXg1OBOok+N+6muJvMMf5ekatJ+V5NjShTElN2ED8Fc=;
        b=SJTLNWAf0y0V3zA6/C843eYajf8xu5eUug9g5dqk203mUo3cHXHR+TdSfXWU257JBx
         bZfoVABaCkwAMkhB3AT6QZQXD501aNlj/RwHbW83GbFuQijHb4/X51SB5+OpdArdnac2
         l2pl1kzi5irJ9sTlvEbqXV1zBCQv+UQ9yWkQA=
Received: by 10.236.153.70 with SMTP id e46mr29426874yhk.29.1329866529135;
        Tue, 21 Feb 2012 15:22:09 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id n72sm57760002yhh.21.2012.02.21.15.22.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 15:22:08 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vhayjga0a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191196>

On 2/21/2012 3:19 PM, Junio C Hamano wrote:
> "Neal Kreitzinger"<neal@rsss.com>  writes:
>
>> When git does a merges (merge/rebase/cherry-pick) it auto-resolves same-file
>> changes that do not conflict on the same line(s).
>>
>> Technical Question:  What are the recommended commands for reviewing the
>> files that auto-resolved after a "merge"?
>
> Imagine that you are the maintainer of the mainline and are reviewing the
> work made on a side branch that you just merged, but pretend that the
> contribution came as a patch instead.  How would you assess the damage to
> your mainline?
>
> You would use "git show --first-parent $commit" for that.
>
> And then look at what the sideline wanted to do to the old baseline:
>
> 	git log -p $commit^..$commit
>
> which would, unless the person who worked on the side branch did a shoddy
> job describing his work, explain what the side branch wanted to achieve
> and also _how_ it wanted to achieve it.
>
> And then re-read the first "git show" output with that knowledge, together
> with the knowledge you have on your mainline codebase, and decide if the
> solution used by the side branch is still valid.  If it makes sense, you
> are done.  If the advance in your mainline since the side branch forked
> invalidated some assumption the side branch made (e.g. a helper function
> the side branch used has changed its meaning, a helper function the side
> branch changed its meaning gained more callsite on the mainline, etc.),
> you have a semantic conflict that you would need to address.
>
> It is unclear what exactly you consider "auto-resolve" in your message, so
> I'd refrain from commenting on the "Philosophical" part, at least for now.

Context: (git-merge manpage definition of merge-conflict) "During a 
merge, the working tree files are updated to reflect the result of the 
merge... When both sides made changes to the same area, however, git 
cannot randomly pick one side over the other, and asks you to resolve it 
by leaving what both sides did to that area."

My definition for "auto-resolve": "During a merge, the working tree 
files are updated to reflect the result of the merge... When both sides 
made changes to different areas of the same file, git picks both sides 
automatically, and leaves its up to you to make sure you review those 
merge results for correctness after git has made the merge commit."

IOW, an "auto-resolve" specifically means that both sides (ours and 
theirs) made changes to file(a) since the common-ancestor version of 
fila(a), and git picked both sides without raising a merge-conflict. 
(The reason I came up with the term "auto-resolve" is because in the 
git-merge output the term "Auto-merging" can also indicate that only one 
side (theirs) changed file(a) since the common-ancestor and that git is 
just "fast-forwarding" theirs file(a) on top of common-ancestor file(a).)

v/r,
neal
