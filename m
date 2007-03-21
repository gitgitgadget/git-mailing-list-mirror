From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: GIT v1.5.1-rc1
Date: Wed, 21 Mar 2007 16:07:18 +0000
Message-ID: <200703211607.20361.andyparkins@gmail.com>
References: <20070306063501.GA24355@spearce.org> <20070320025539.GA28922@spearce.org> <7v648v5goy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 17:07:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU3LW-0006x5-K7
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 17:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbXCUQH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 12:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbXCUQH1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 12:07:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:56127 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbXCUQHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 12:07:25 -0400
Received: by wx-out-0506.google.com with SMTP id h31so389311wxd
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 09:07:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oVliwzb/5ByOYphdgDzHekiX+6je3MuFvC7Z/tjqSWghODPPXXgaSCIBmpFt2+A6YeNm0C9tNYYFGYycqBgwjBufVwHVz1uMECWv8Iixffniixnoz/xQxwdbB/xHoQmYEiJtl8cYhiYh6DGFLGMDUKGGbaNgQSFC5NuYw6FbCQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PC0lq97QstaggpdLbXfNi4uEnDIQL+ALwVntLXGhwlirlSyEIlf5hN74eg5QLpF2zrMSk6PnqikS9EsjPXJFw/NWIk8vHJh11h8QxOybidq+D853h9FODW/1sZZdp9ERfmkPqJlC2WswFPU34Be0+7CaukRwEb9nDNSaOVbBxe0=
Received: by 10.90.78.9 with SMTP id a9mr2377021agb.1174493245279;
        Wed, 21 Mar 2007 09:07:25 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id m15sm5969469nfc.2007.03.21.09.07.23;
        Wed, 21 Mar 2007 09:07:24 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7v648v5goy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42800>

On Wednesday 2007 March 21 05:06, Junio C Hamano wrote:

> But I do not think "new to this repository" is the right thing
> to compute in the first place.  In a heavily topic-oriented
> development style, you may do something like this:

Unfortunately, I think it's the only thing that can sensibly be done.

Assume that we want every commit to appear on one, and only one email.  It's 
got to be done by only showing the new commits.

> However, after the topic cooks in 'next' and proves to be fine,
> the next push would go like this:
>
> 	$ git checkout master
>         $ git merge topic
>         $ git push $URL master
>
> There is no new commit that appeared in the repository with this
> push, and there will be no notification sent out, if you do "new
> to this repository".

Yes there is; the notification says that ref master was updated.  It wouldn't 
show any new commits - which is exactly right.  This to my mind is the same 
reason that fast-forward merges are better than all-merges-the-same.

The truth is that there were no new commits, so the email generator should 
show no new commits; however there was a ref change so it should show that.  
That's exactly what the current hook does.

The only fault in it, that I've yet to fix, is that it shows an empty log 
section; I eventually want the zero-new-commits case to be caught and a 
little description of why there are no new commits output instead.

> The latter is, however, far more significant event than the
> former, from the point of view of overall project history, both
> for a casual user who tracks only the primary integration branch
> and for a developer who is expected to fork his new work off of
> the primary integration branch.  Showing only new commits that
> appeared in the repository is absolutely the wrong thing to do.

I don't think so; either the merge generated a new commit, in which case that 
merge commit will be shown, or the merge didn't generate a new commit in 
which case the report of the branch change is all that is needed.

Note: none of your examples describe a case where an email of some sort is not 
generated.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
