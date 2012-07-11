From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default
 configuration setting.
Date: Wed, 11 Jul 2012 15:04:06 -0700
Message-ID: <7v8veqdkfd.fsf@alter.siamese.dyndns.org>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
 <1342020841-24368-3-git-send-email-marcnarc@xiplink.com>
 <7vr4siduq3.fsf@alter.siamese.dyndns.org> <4FFDE4EB.3060100@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 00:04:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp51J-00009U-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758387Ab2GKWEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:04:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab2GKWEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:04:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3A08505F;
	Wed, 11 Jul 2012 18:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7CuklT9duHlAAU2iCniNmEQHdXY=; b=SEJU7p
	704Fr9F0r8pJVADjSbFdtmx1SgIH9CWVi0sAWyrJWUc7LO4X+uy14lllfCCgn3SU
	/v/1P4QZTGh5dGXM4f74V7pLbCTipJ9pV1k2R6MQ4q9DDr2vCB4FGpkG/JQ2EEpL
	ohC35ZCQaX/7JvS/WIy4t2wKZC0DWl1h24Q0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t/5WMItCln+1BdkbfWWqD275nm1swmp/
	UiGwA+/DEeyCIAxHSNyCRPPTOs2q1HtyRMI7/6lp2f2iiLzThQAD9crbJe2TyK8l
	lwvTZ20C+BOZwunLD16/cAaI+nHnEfqHqdPRLAgRjTKMsHfsIZ92iC1mxz9wiMoi
	2lQ3PRQJur0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8EF3505E;
	Wed, 11 Jul 2012 18:04:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 119C2505C; Wed, 11 Jul 2012
 18:04:07 -0400 (EDT)
In-Reply-To: <4FFDE4EB.3060100@xiplink.com> (Marc Branchaud's message of
 "Wed, 11 Jul 2012 16:41:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 564E2B1E-CBA4-11E1-A60B-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201333>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-07-11 02:21 PM, Junio C Hamano wrote:
>> marcnarc@xiplink.com writes:
>> 
>>> From: Marc Branchaud <marcnarc@xiplink.com>
>>>
>>> The code now has a default_remote_name and an effective_remote_name:
>>>
>>>  - default_remote_name is set by remote.default in the config, or is "origin"
>>>    if remote.default doesn't exist ("origin" was the fallback value before
>>>    this change).
>>>
>>>  - effective_remote_name is the name of the remote tracked by the current
>>>    branch, or is default_remote_name if the current branch doesn't have a
>>>    remote.
>>>
>>> This has a minor side effect on the default behavior of "git push"....
>> 
>> Hrm, is this a _minor_ side effect?
>
> Well, I thought so...  :)
>
> It's minor because of what you say:
>
>> Isn't that a natural and direct consequence of "now you can set
>> remote.default configuration to name the remote you want to use in
>> place of traditional 'origin'" feature?  I think changing the
>> behaviour of "git push" in such a way is the point (may not be the
>> only but one of the important points) of this series.
>
> I agree.  Phil Hord pointed out the change in behaviour and felt the commit
> message should explain it.
>
> Should I just remove "minor"?

Is it even a _side effect_?  Isn't this one of the primary points of
the series?  I do not think this patch makes sense if we did not
want that change to happen.

Or am I missing something?

>>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>>> index cb97cc1..fc17d39 100644
>>> --- a/Documentation/git-push.txt
>>> +++ b/Documentation/git-push.txt
>>> @@ -27,10 +27,16 @@ documentation for linkgit:git-receive-pack[1].
>>>  OPTIONS[[OPTIONS]]
>>>  ------------------
>>>  <repository>::
>>> -	The "remote" repository that is destination of a push
>>> +	The "remote" repository that is the destination of the push
>>>  	operation.  This parameter can be either a URL
>>>  	(see the section <<URLS,GIT URLS>> below) or the name
>>>  	of a remote (see the section <<REMOTES,REMOTES>> below).
>>> +	If this parameter is omitted, git tries to use the remote
>>> +	associated with the currently checked-out branch.  If there
>>> +	is no remote associated with the current branch, git uses
>>> +	the remote named by the "remote.default" configuration variable.
>>> +	If "remote.default" is not set, git uses the name "origin" even
>>> +	if there is no actual remote named "origin".
>> 
>> This comment applies to other changes to the documentation in this
>> patch I didn't quote, but I think the phrasing 'even if there is no
>> acutual remote named "origin"' needs to be rethought, because "we
>> use it even if there is no such remote determined with this logic"
>> applies equally to branch.$name.remote, remote.default or built-in
>> default value of remote.default which happens to be "origin".
>
> I'm sorry, but I'm having trouble understanding what you mean.  I don't see
> how the "because ..." part of your sentence suggests what aspect needs
> rephrasing.

You say the remote is taken from three places (branch.$name.remote,
remote.default, or 'origin').

Imagine there is remote.origin.url at all.  If remote.default is set
to 'origin', or branch.$name.remote for the current branch is set to
'origin', the repository you will try to use is 'origin'.  And you
will fail the same way if you try to push there.  It does not matter
if the hardcoded default gave you 'origin' or configuration variable
gave it to you.  The name is used regardless, even if there is no
actual remote under such name.

So "If 'remote.default' is not set, git uses the name "origin" even
if there is no actual remote", while is not untrue, is misleading.
Even if there is no actual remote 'origin', if 'remote.default' is
set to 'origin', git will use that name, and will fail the same way.

Just saying "If 'remote.default' is not set, git uses 'origin'" or
even "'remote.default', if unset, defaults to 'origin'" would be
sufficient.
