From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Wed, 18 Jan 2012 18:32:57 -0600
Message-ID: <4F1764B9.90907@gmail.com>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com> <4F1714AD.4090706@gmail.com> <7vwr8oljq7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:33:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnfwD-00064u-3l
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 01:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab2ASAdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 19:33:03 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47477 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab2ASAdB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 19:33:01 -0500
Received: by yhoo21 with SMTP id o21so1080083yho.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 16:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lRHAf1YGpRXqdWuV7ngV09+dTHPMbf3pxQ0WC/4L1QQ=;
        b=hmrBhr1ChA/gArUpE/F2sKrKILDGf4+WRr65V1Bqst5TV2axEdyrz116YO94KRR1bl
         fw2rmBuTQ/OG/83vZr9McYMNJuhNvzBS8WXIZdgE+h8cx4uXSYsu9/uiaLevBaEszxiA
         d4d6f0j/HGQ9X+s4LoX1aYoDkxxR1ev/qdCq4=
Received: by 10.236.80.4 with SMTP id j4mr35047310yhe.65.1326933181207;
        Wed, 18 Jan 2012 16:33:01 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id i50sm45760077yhk.11.2012.01.18.16.33.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 16:33:00 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vwr8oljq7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188783>

On 1/18/2012 4:38 PM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>> hooks/post-update is:
>>
>> git stash save
>> echo "worktree+index of non-bare remote current branch stashed for safety"
>> git reset --hard
>> echo "git-reset --hard on current remote branch to ensure clean state"
>>
>> message is echoed, but git-reset --hard does not appear to have really
>> worked. (git 1.7.1)
>
> Have you checked where in the filesystem hierarchy that script is run
> (hint: pwd)?
>
echo pwd in post-update echoes /path/WORKTREE/.git in git-push stdout.

> Also it is unclear why you keep saying "stash". What kind of changes are
> you expecting to be saved to the stash? Will they be changes that are not
> source controlled that you would rather not to see? In other words, after
> running "stash" every time somebody pushes and having accumulated many
> stash entries, when do you plan to pop these stashed changes?
>
good point. rejection of dirty worktree is a cleaner safety.

> I would have expect that such a repository to reject a push if the working
> tree is dirty, and run checkout in post-update, though.
>
'git-checkout -f' works manually, but in post-update hook it leaves 
behind dirty worktree, ie. index and HEAD match, but worktree still 
matches HEAD@{1}.  This is the same undesired result git-stash and 
git-reset --hard leave behind when executed in post-update hook.

v/r,
neal
