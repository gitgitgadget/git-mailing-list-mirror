From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 11:26:19 -0500
Message-ID: <CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud10c-0006on-By
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067Ab3EPQ0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:26:22 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:53977 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab3EPQ0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:26:21 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so3227918lab.37
        for <git@vger.kernel.org>; Thu, 16 May 2013 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Fu/tXCWtqExssWzaR21KU4DGTZropX/7GpXxfIevfHM=;
        b=dDjHBDTemlYeP9oAsQzwI0aCOyMvvA84zqWF9vkCuf68eNZH+6GIF6iKH/gb74/okh
         sobKNeHpXf43paUkEulzVrtHHSRx5gm/+BrZXx8chPo79xyjpPN/JEvudYaUOC/VXAfX
         SMZYw7XIMKTD3dynhfB+QiYsZjbFFW2MKRoFXJGJbWtbSjX6iexO3UnUqUgYlfke3YeP
         JE6nwhE84qQgmuFsfUhrVCtMhH+bBdusubnmq3lzarFTZRMDLy8ZGGXp+pIvJkrNxbFU
         uYBFqSPo9C0U94j+K+GM0TeDK1s5pWa5xPVXPQ/DlK2MaqTcpP8X/LTHT4NGeR0PDW07
         FYew==
X-Received: by 10.112.163.71 with SMTP id yg7mr10876979lbb.8.1368721579950;
 Thu, 16 May 2013 09:26:19 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 09:26:19 -0700 (PDT)
In-Reply-To: <7v61yi9arl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224592>

On Thu, May 16, 2013 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I _think_ the real reason you want a "git fetch" while on "mywork"
> to go to 'origin' is because you are building your "master" off of
> somebody else's work that comes from 'origin', and you want to check
> what has changed to see what you need to rebuild both your "master"
> and "mywork" branches on top of.  If 'master' were forked from a
> remote that is not 'origin', then making "git fetch" ignore '.' and
> instead go to 'origin' would not solve anything.  For an updated
> behaviour to be useful in that workflow, it needs to follow the
> inter-branch relationship ("mywork is a fork of master which is a
> fork of frotz branch from a remote xyzzy") to see the first remote
> repository and fetch from there, instead of blindly fetching from
> the 'origin'.

No, the reason I want 'git fetch' to fetch 'origin' is because it has
always done so. It only stopped doing so when I configured 'upstream'
branches. I'm not even sure I want 'git fetch' to fetch from the
remote of my current branch if it has an upstream branch.

> Having said all that, I am not all that sure that it is a good idea
> to introduce such an exception for "git fetch" to ignore '.',
> regardless of where it goes instead, either the 'origin' or the
> first remote repository it finds by recursively finding its
> upstreams, to break the consistency at the UI level.  It is dubious
> if the benefit of convenience to fetch from remote 'xyzzy' that is
> an eventual remote of 'mywork' without having to say so outweighs
> the cost of additional UI inconsistency, making things harder to
> explain to both new and old people.

That doesn't change the fact that 'git fetch .' does not make any
sense whatsoever. The user *will* get confused when (s)he does 'git
fetch' and nothing happens. The problem is not solved.

% git checkout -b fixes master
% git fetch
% git branch -u master
% git fetch

# scratch head

-- 
Felipe Contreras
