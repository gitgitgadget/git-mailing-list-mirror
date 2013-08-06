From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: add shared repo upgrade
Date: Mon, 05 Aug 2013 23:36:25 -0700
Message-ID: <7vfvuniavq.fsf@alter.siamese.dyndns.org>
References: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
	<7vwqnzj1gp.fsf@alter.siamese.dyndns.org>
	<CALWbr2wynb-K-r0sehuBUtmkbgp9Ev5iYK_v2ZFxsjcewTCmfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Joern Hees <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 08:36:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6at0-00080O-Hc
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab3HFGgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:36:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab3HFGg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:36:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66632320FD;
	Tue,  6 Aug 2013 06:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lQqnpkCKNFIpLyrtl/ZwzpQ8sMs=; b=J72fQ2
	YGlmToPVXYJv72POMJCxmtCW7J8j+WLRupxLaxHeS0SRHkcn6FZkt7XQ9JDYIMas
	beKKBlCfC2JusTN/Sk1DCu9blz4yr4ZV8/bWlXGizANIKjfxFpgQtA8e95OEtH02
	WsvlDWFx1CnvzKrE97avpIAGgWeDsnF4rlK6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jkIhmmL4KAFwROX/PJQksuZat89l3sED
	1hxotW/zZYK1Im5CMRT/P7mllSAsg8vHUFA2D8pORFCfpB5RfUKG1qAZnqPynrmK
	oaI0JuKEpt4+XCezgQ2LmJFcsKA8R+tM9wVv755EBZb9b8z/F3M4Ue3TrPp9gZzH
	HrUk94cniQ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C1B3320FC;
	Tue,  6 Aug 2013 06:36:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A98DE320FB;
	Tue,  6 Aug 2013 06:36:26 +0000 (UTC)
In-Reply-To: <CALWbr2wynb-K-r0sehuBUtmkbgp9Ev5iYK_v2ZFxsjcewTCmfQ@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 6 Aug 2013 08:22:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 850D67E8-FE62-11E2-9504-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231723>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Mon, Aug 5, 2013 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>> Is the untold
>> and obvious-to-those-who-are-familiar-with-this-codepath assumption
>> that it is guaranteed that there is at most one "*/clone/.hg" under
>> shared_path?
>
> No, there is no such assumption.
> That is why we create a repository just below if it doesn't exist (no
> copy was found).
> That's also why I don't see how we could split the patch.
>
> We could improve that part of the commit message:
>
>     It's trivial to upgrade to the new organization by copying the Mercurial
>     repo from one of the remotes (e.g. 'origin'), so let's do so. If
>     we can't find
>     any existing repo, we create an empty one.

That is fine, and I do not (yet) have an opinion on this patch
needing to be further split.

Quoting that part I was asking about again:

> +        # check and upgrade old organization
> +        hg_path = os.path.join(shared_path, '.hg')
> +        if os.path.exists(shared_path) and not os.path.exists(hg_path):
> +            repos = os.listdir(shared_path)
> +            for x in repos:
> +                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
> +                if not os.path.exists(local_hg):
> +                    continue
> +                shutil.copytree(local_hg, hg_path)

if you can have more than one 'x' such that

    local_hg = os.path.join(shared_path, x, 'clone', '.hg')

exists, that means in repos[], there are two (or more) x1,and x2,
and in this loop you will run

	shutil.copytree(local_hg, hg_path)

twice, once for local_hg derived from x1 and another time from x2,
both to the same hg_path directory that does not change inside the
loop.  shutil.copytree(src, dst) however creates leading paths down
to dst and it would barf when dst already exists, no?

That is what I was puzzled about the code.  The log message says "we
can copy from one of them if exists, so let's do so", which makes
sense, and a code structure that may match would have looked like
so:

	for x in repos:
        	'''pick one at random, copy it and leave'''
                copytree()
                break
	else:
        	'''nothing to be copied, do it the hard way by cloning'''

but that is not what I saw so that is where my confusion came from.
