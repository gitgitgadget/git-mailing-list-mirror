From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: Allow @{U} as a synonym for @{u}
Date: Wed, 17 Aug 2011 15:53:37 -0700
Message-ID: <7vhb5fd4zy.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com>
 <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 00:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtoza-0000km-4r
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 00:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab1HQWxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 18:53:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763Ab1HQWxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 18:53:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3283A493F;
	Wed, 17 Aug 2011 18:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wHQX/rtTrm6wg606e0SeFomdCsM=; b=TbwUPv
	Zv7vrISokdDtj0daWvLA19B315P8xP2qfnJKgx5pdEUvwYprXOZMCqDvJUwqXyqA
	OabVsURqBgNrCZYBaKnwjbdePNo5Npb4i7pkEdyIi6J33s2LWlnYOBdJfrG8z2mO
	LchUgmbmpRwsNQ29eptgtJgeRipE2nocEPetM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HVFQITf6u3CqSgFn0XcIHKDSsSD/q1mR
	+CuNmXxG5Tf/bIKIYForLELlzHqOLGbyNffQQhpDVCdWvu15JGrUwwxhuAnyDg1P
	4kAeo5RDUmHqSE1X3BjyVUDKq/uBy1wcgYZ4DiqNwrCstgTbX2uWggraNLCJtS1S
	qOPUr0CV9Lg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2909D493E;
	Wed, 17 Aug 2011 18:53:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DBD6493D; Wed, 17 Aug 2011
 18:53:39 -0400 (EDT)
In-Reply-To: <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com>
 (Conrad Irwin's message of "Sat, 13 Aug 2011 18:57:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF98137A-C923-11E0-A3FF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179543>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> This facilitates specifying the upstream of a branch if you have
> difficulty synchronising your shift-key and other characters, if you
> just want to SHOUT at git, or if you're expecting consistency with
> @{1DAY}.

> +test_expect_success '@{U} resolves to correct full name' '
> +	test refs/remotes/origin/master = "$(full_name @{U})"
> +'
> +
> +test_expect_success '@{Upstream} resolves to correct full name' '
> +	test refs/remotes/origin/master = "$(full_name @{Upstream})"
> +'
> +
>  test_expect_success 'my-side@{upstream} resolves to correct full name' '
>  	test refs/remotes/origin/side = "$(full_name my-side@{u})"
>  '

Even though I sometimes use @{upstream} these days to keep track of
origins of various topic branches (some are fixes and fork from maint
while others are features and fork from master), I never felt a need for
@{U} or @{uPStreAM} myself, so as a new feature, this change is a "Meh"
for me personally.

Currently, we use @{...} for:

 - Negative integers are "-N branch-switching ago" (only without any ref
   on the left);
 - Non-negative integers "The tip of the named ref before it was changed N
   times";
 - An approxidate that is case insensitive; or
 - "u" and "upstream".

Letting u/upstream spelled case-insensitively does improve consistency
among the above, but at the same time if we ever wanted to enhance @{...}
notation even further in the future, we are restricted to a payload that
is case insensitive to retain the consistency.

The only remotely semi-plausible enhancement I could think of is perhaps
to allow @{/regexp} to find a reflog entry that matches the given pattern,
and in such a use case we would certainly want to take the pattern in a
case sensitive way. This change closes the door to that, and that is the
only downside I can think of right now.

I hate to declare that we will never support such a feature with this
change, but at the same time, I do not think I would need such a feature
that often. But for that matter, I do not think I would miss @{UpStREAM},
either, and that takes me back to "Meh" for this change.

What do people think?
