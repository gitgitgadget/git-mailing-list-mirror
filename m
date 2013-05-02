From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 5/6] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 21:44:56 -0500
Message-ID: <CAMP44s0yd8EFWCkdFpHzUbdB-www=R6e1Yk-nPwiJDFPaAfYHQ@mail.gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-6-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_-S_BvQAa5b2+XpfM2-fJcEQ5EJa4RRtV1vQPEe1emA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 04:45:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXjWd-0001MJ-97
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 04:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759770Ab3EBCpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 22:45:35 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36819 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab3EBCo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 22:44:57 -0400
Received: by mail-wi0-f169.google.com with SMTP id h11so117623wiv.2
        for <git@vger.kernel.org>; Wed, 01 May 2013 19:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EQcOzrXfe1avYFYzaF90TAOo6WTF3vl1c959jj/pFg4=;
        b=jNj5N4N0v9KNf43vNbubq+3qTA64avlAzIMYImjktVfRRNYj19HuDOC+p+nu11CMlr
         Da3T2oo2Hq96mcl5SkOUzxvmTGU9Ap653pEG5tQ0ZwxYA2VldUVVMSFtPWLO64jDCf7i
         GLE+ZJIALBrOl0Y4ZpGvvlruhp+XNZH7kK/s8/p6VNjc8Xa31rww9fUiZ8W+PfOJd5Aw
         wDFou/VcUAayQNUK6Jjkcm21wf4VhfuK2aZb4fEC50ntx/N5LcsekThvrShqk2das0Vi
         dHbvYujC6iphjXCQ5CycYS4/zC64ApawMwXrybyDgtnRHKV7WbX8+vJoNYJeIFPiiZq+
         dqKA==
X-Received: by 10.194.248.200 with SMTP id yo8mr5283748wjc.36.1367462696426;
 Wed, 01 May 2013 19:44:56 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Wed, 1 May 2013 19:44:56 -0700 (PDT)
In-Reply-To: <CACsJy8D_-S_BvQAa5b2+XpfM2-fJcEQ5EJa4RRtV1vQPEe1emA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223175>

On Tue, Apr 30, 2013 at 9:03 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 1, 2013 at 4:49 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
>> can't remove '{0}'?
>>
>> This patch allows '@' to be the same as 'HEAD'.
>>
>> So now we can use 'git show @~1', and all that goody goodness.
>>
>> Until now '@' was a valid name, but it conflicts with this idea, so lets
>> make it invalid. Very few people if any probably used this name, if they
>> did, they can rename it by using the full-path (e.g. refs/heads/@).
>
> People can write master short for refs/heads/master, but can't with
> refs/heads/@. Would it be better to detect if dwim_ref("@") exists,
> then disable special '@' and warn user to rename '@' to something
> else? After they have renamed it, make '@' special and forbid it in
> any component in the ref (i.e. refs/heads/@ is forbidden too).

I think that would be extremely tricky. If they have refs/heads/@, we
could try to warn them about the conflict, but I think it would be
pretty clear when 'git foo @' doesn't do what they want, and still
they, can use 'git foo refs/heads/@'.

I think it's overkill to worry prematurely about users that most
likely don't exist. If say, we introduce this for 1.8.4, and some
people suffer from the decision, then we can do something about it for
1.8.4.1, but it's more likely that they would just do 'git branch -m
refs/heads/@ whatever' (we should probably fix that because it doesn't
actually work with any refs/heads/X). Of course, the much much more
likely scenario is that nothing will happen.

If there was an easy fix, we should go for that, but I just don't see any.

-- 
Felipe Contreras
