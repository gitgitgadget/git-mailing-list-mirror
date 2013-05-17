From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 16 May 2013 19:00:50 -0500
Message-ID: <CAMP44s1dB+VQnzPL-qVADMTC6-Y8AfUvBOmy+4kusujyT_jW4g@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 02:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud86S-0007fY-In
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 02:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab3EQAAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 20:00:52 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33546 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3EQAAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 20:00:52 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so3647618lab.11
        for <git@vger.kernel.org>; Thu, 16 May 2013 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=BxgtNR8QLueUoTZU3B1FL08z+tm6Dsr8szQnnrtqjKo=;
        b=OSum29S8QW1DDN5l6SQdmYS+JguCG2SMCqGt2WRdZdba1B83gW+BSKl3tJlUkt6bm6
         wW/xjUtFOyUT+vzy7n4eBsA//5bcRmOJkFz8M7PmgoDVDXsSzpUZj9ofeI2SJfOELTzM
         TBGneqttbAL+Od2a5A5Szv4tmd5bhWsi8OmYNCgsIkaeqB3rH1opQYKBL4Fcthq9DK3g
         aqq7Jl1+brNGLwWbfo1i8uJ9h/dBh0mR19bKGCOJZCnZ2Kkz0duXg67/iQ7YvD1dZCwB
         +3pBN2HROvRsV12QIPfs9C0KrhnFmzHZaKms6bsskOtb2+NmIOWdqqlhNtWRzTsG6eVU
         haPQ==
X-Received: by 10.112.172.40 with SMTP id az8mr10159406lbc.88.1368748850654;
 Thu, 16 May 2013 17:00:50 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 17:00:50 -0700 (PDT)
In-Reply-To: <7vobca3465.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224641>

On Thu, May 16, 2013 at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 16, 2013 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> The value "upstream" for push.default does not make sense in the
>>> context of a triangular workflow, as you may well base your work on
>>> 'master' from the upstream, which is a branch with a very generic
>>> purpose (e.g. "to advance the state of the overall project"), but
>>> your work may have a more specific purpose (e.g. "to improve frotz
>>> feature") that deserves to be on a branch named after that specific
>>> purpose in the repository you publish your work on.  That is, after
>>> working on your 'frotz' branch this way:
>>>
>>>     git checkout -t -b frotz origin/master
>>>     work work work, commit commit commit
>>
>> If the user has branch.autosetupmerge=always, that's not correct; even doing:
>>
>> % git checkout -b frotz origin/master
>>
>> Would setup the upstream. And I believe for v2.0 we do want
>> branch.autosetupmerge=always, but we might not want to always override
>> the push location.
>>
>>> Now I have a curious value "single" in the above configuration that
>>> is not understood by current Git.  It is to trigger a new rule to
>>> modify the way remote.publish.push refspec is used:
>>>
>>>     When on branch 'frotz', where pushremote_get() would return
>>>     'publish', find where refs/heads/frotz would be pushed with the
>>>     refspec for that remote (i.e. refs/heads/*:refs/heads/topics/*
>>>     maps refs/heads/frotz to refs/heads/topics/frotz) and push only
>>>     that, i.e. update refs/heads/topics/frotz over there with the
>>>     tip of 'frotz' we are pushing.
>>>
>>> That may be a solution for those who do not find 'current' good
>>> enough.
>>
>> What happens if I want to push to 'refs/heads/topics/frotz-for-juno'?
>
> You would weigh pros-and-cons of supporting such a "single branch
> only" special case, and add a branch level override, and if the
> benefit outweighs the cost of complexity, design and implement it.

I already implemented it. I already sent the patch.

-- 
Felipe Contreras
