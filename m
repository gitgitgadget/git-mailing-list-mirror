From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 16 May 2013 16:17:54 -0700
Message-ID: <7vobca3465.fsf@alter.siamese.dyndns.org>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7Qv-0006YA-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab3EPXR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:17:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab3EPXR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:17:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80A141FAC7;
	Thu, 16 May 2013 23:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y5sz/4Eh6v81aaSluMu9Qufq7pI=; b=Zw2dg2
	emi9RVtw4r12riZTwueZ19Fsh3cT9liSE0Dj8Bk8K4OH/iIX26eRIrpwJ6VTIdmb
	Ph5fajTkanamTmONf5tvDrOYzL1Zm3Ll3MW/nsIUUSzj6P4tS3135WsYtOKDWmLV
	a/2xT5IiWWqXMa+92ly4GQK+0QWI+U4/cuEeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wWpiWOaw7zb0hQhRsPDS1Szwy2+otuiS
	+1DXTGMEbogk5fha9LuA2G/rPhVX7Hs13gwbqC6rmEPRPlKCO2oqNAWXzCt+vxDY
	5JhbbOXRWHLvdrvWsz/CDzEsGK8r9JbNzRISGUX2y1EDeVzir36bFwzx+vVZhPgD
	4W8yu701y1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B381FAC6;
	Thu, 16 May 2013 23:17:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E65601FAC5;
	Thu, 16 May 2013 23:17:55 +0000 (UTC)
In-Reply-To: <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 18:03:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D729AAF6-BE7E-11E2-A633-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224632>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 16, 2013 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> The value "upstream" for push.default does not make sense in the
>> context of a triangular workflow, as you may well base your work on
>> 'master' from the upstream, which is a branch with a very generic
>> purpose (e.g. "to advance the state of the overall project"), but
>> your work may have a more specific purpose (e.g. "to improve frotz
>> feature") that deserves to be on a branch named after that specific
>> purpose in the repository you publish your work on.  That is, after
>> working on your 'frotz' branch this way:
>>
>>     git checkout -t -b frotz origin/master
>>     work work work, commit commit commit
>
> If the user has branch.autosetupmerge=always, that's not correct; even doing:
>
> % git checkout -b frotz origin/master
>
> Would setup the upstream. And I believe for v2.0 we do want
> branch.autosetupmerge=always, but we might not want to always override
> the push location.
>
>> Now I have a curious value "single" in the above configuration that
>> is not understood by current Git.  It is to trigger a new rule to
>> modify the way remote.publish.push refspec is used:
>>
>>     When on branch 'frotz', where pushremote_get() would return
>>     'publish', find where refs/heads/frotz would be pushed with the
>>     refspec for that remote (i.e. refs/heads/*:refs/heads/topics/*
>>     maps refs/heads/frotz to refs/heads/topics/frotz) and push only
>>     that, i.e. update refs/heads/topics/frotz over there with the
>>     tip of 'frotz' we are pushing.
>>
>> That may be a solution for those who do not find 'current' good
>> enough.
>
> What happens if I want to push to 'refs/heads/topics/frotz-for-juno'?

You would weigh pros-and-cons of supporting such a "single branch
only" special case, and add a branch level override, and if the
benefit outweighs the cost of complexity, design and implement it.

The push.default setting is to make sure we have a simple mechanism
to cover more common cases, and my suspicion is what 'current' gives
us is already there without the need for 'single'.
