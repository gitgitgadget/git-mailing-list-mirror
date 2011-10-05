From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 14:29:22 -0700
Message-ID: <7vy5wz5dql.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:29:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZ1w-0007EX-Py
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407Ab1JEV31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:29:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab1JEV30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:29:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6B9D6173;
	Wed,  5 Oct 2011 17:29:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mgTLhY5boZrYI2GnTcIWSLrbl0c=; b=IDiFqL
	zbC1UPyUtKj5vkqmI6THlJ5mSGmqKnNgL4ZBw/iiZSOEydPrxyOBO75Zqg0leXPv
	+YGJhVEQg1+LUe8ZZv99noqJgb35WNeXHCzQ12x8dfuCuSq0FajMC8rn9aDkmRAq
	1d0QItfmu0ndU/xVcb5zIsUAiSvCfa+/tSPIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LrNxHSQ91MDHGlGeGruGxgT8sAmahQIr
	H77UOA3hTZ9XfptWAD07AMawvBzUZ6o9SKkOUpbLfeeNkrqKwD0ybKTIQYFmIeH8
	3pqUoiiZrVcstO8jNFJIfbkCAwjQXxrPGesEM9LOwMVr3qTGBcIC7GhelCv/TLjk
	kwc4NXOgNrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE7276172;
	Wed,  5 Oct 2011 17:29:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB24616F; Wed,  5 Oct 2011
 17:29:25 -0400 (EDT)
In-Reply-To: <CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 15:11:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19198078-EF99-11E0-884A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182885>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Oct 5, 2011 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Also, while I might recommend new-workdir to my coworkers with the
> advice "don't checkout the same branch in multiple workdirs", never in
> a million years would I say "use new-workdir, but make sure to only
> use a detached HEAD in the workdirs." The latter would make their
> actual HEADs explode. :-)
>
>> ...
>> Because you forgot that the high level operation "branch renaming" needs
>> to be aware of that "this branch is checked out elsewhere" information,
>> you allowed it to break the workdir. If you hooked into lower level
>> machinery that is shared, you wouldn't have caused this breakage.
>> Similarly, if delete_ref() were taught about the new requirement, you
>> would have covered both "branch -d" and "update-ref -d".
>
> I did not forget, I just hadn't gotten there yet while this was still
> an RFC/PATCH.

You conveniently also forgot that you also said:

> Aside, there's nothing wrong with renaming a checked out branch.

With that lack of understanding, it wasn't "hadn't gotten there", but was
actually "didn't even know it was needed".

But that is OK. We have discussions to find out what we missed by learning
from others' insights.

> Another issue to resolve is what happens when the workdir or repo are
> moved in the filesystem. And making prune aware of HEAD reflogs in the
> alternate workdirs.
>
>> I do not necessarily think that it is a good approach to forbid the same
>> branch to be checked out in two different places, by the way. One reason
>> people would want to keep multiple workdirs is so that while they are
>> still working on a branch and are not yet at a good "stop point" to even
>> make a temporary commit to get interrupted, they find it sometimes
>> necessary to be able to build the tip of that same branch and even make a
>> small in-working-tree fixes (which later will be carried back to the
>> primary branch). The problem arises only when one of the repositories try
>> to update or delete the branch while it is checked out in another working
>> tree.
>
> That is not at all my experience of how workdirs are used.

I am afraid to say, with that statement, that your knowledge about the way
the tool can be used is not wide enough to judge if one policy restriction
(e.g. "never check out the same branch in multiple places") is general
enough to add to the tool. I do not claim mine is good enough, but I at
least know better than proposing a rule that may be too restictive to
negatively affect other people's workflows.

I always maintain four workdirs that I can use to build the tip of four
integration branches while I work on other things in the primary branch,
plus another that has a detached HEAD so that I can "reset --hard" around
without having to worry about what I do there would negatively affect what
I do elsewhere or vice versa. Of course, updating 'master' in my primary
repository will require the "build master" workdir to be "reset --hard"
before it is used, and that is part of my workflow already. I consider it
is one of "people learned to work around the restriction of the tool so
well already that they may not realize it" we discussed earlier.

Also, if your goal is to give a different semantics, like:

> In my mind, we're trying to make new-workdir usable for non-advanced
> users. I think it's conceptually simplest to allow a branch to be
> checked out only once.

you would really need to make sure that your changes would not harm other
users of the same tool that you are not targetting for, and also the
changes to the core part of the system that needs your specialized policy
makes sense in the wider context. The former you can claim "the policy
does not kick in when configuration is not set", but that is weak if the
policy is too ad-hoc and not well thought out. I actually care about the
latter more, as it is not worth having to spend maintenance effort to
carry changes that only stop some but not other kind of mistakes in the
core part to be more widely applicable.
