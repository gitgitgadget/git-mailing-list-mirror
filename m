From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support specific color for a specific remote branches
Date: Mon, 08 Aug 2011 14:31:39 -0700
Message-ID: <7v62m7wpxg.fsf@alter.siamese.dyndns.org>
References: <1312818553-25042-1-git-send-email-avivey@gmail.com>
 <7v8vr3zsh1.fsf@alter.siamese.dyndns.org>
 <20110808205214.GG18294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aviv Eyal <avivey@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:31:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqXQK-0002Vh-Vp
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab1HHVbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 17:31:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122Ab1HHVbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 17:31:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11AC553E6;
	Mon,  8 Aug 2011 17:31:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3I1FzZ6Je+ZHZ41A5rLGKWf/dlw=; b=rtCGYz
	cvpAM5eT90qWzBMbExxYD9rEMKr8KL0wwcd0v2u83XSKPreouTX76O3yUvxiA2bM
	MaWa34OP4AeLrvxopYtWtkSwU6TuecaBLUzw4BOOhIOuHTR+FZTuQny/+kFq+/Vq
	d5i4vZTj5+Mvg3vA1PcT2oZg9P8f3TYRx8NBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a4DUdYb9homuxobbdcMRz/AiX1yv+He0
	wDgu+DrY3TjJYH9TkBOgXutM/1zTOVYrRxPRaA8L0i7P8fOVnE+nSfY1otD9STpb
	i63I/f2bPGFw10MwWm3vhbxH4ypo676V1WQM/MbGUaVxnTOH9vfs1WKKwFk/3DON
	ULVCulb/XJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0928453E5;
	Mon,  8 Aug 2011 17:31:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CD7353E4; Mon,  8 Aug 2011
 17:31:41 -0400 (EDT)
In-Reply-To: <20110808205214.GG18294@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 8 Aug 2011 14:52:14 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE5C9A68-C205-11E0-B239-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178990>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 08, 2011 at 11:08:26AM -0700, Junio C Hamano wrote:
>
> This seems related to the recent thread about showing branches only for
> a specific remote:
>
>   http://article.gmane.org/gmane.comp.version-control.git/178668

Yeah, that one I do recall.

> Right now, "git branch -r" means "show everything under refs/remotes
> instead of refs/heads". This would be easy to implement if it instead
> meant "show all refs created by the RHS of a fetch refspec in a
> configured remote". The two are equivalent in the default config, but
> the latter may make more sense in a complex case.

I actually am a bit ambivalent about this. I do not necessarily consider
the contrived "remote.frotz.fetch = refs/heads/*:refs/remotes/nitfol/*"
example something that we _must_ solve. It is unlikely people would do
that, and if we give them an unexpected result, they deserve it ;-).

But in real-life, it is entirely plausible that people with multiple
integration branches are taking advantage of the simplicity of the old
layout, i.e.

    [remote "origin"]
    	fetch = refs/heads/master:refs/heads/origin
        fetch = refs/heads/next:refs/heads/next
        fetch = refs/heads/maint:refs/heads/maint
        fetch = +refs/heads/pu:refs/heads/pu

I have many repositories of this style, and it is very convenient to be
able to say:

    $ git checkout master && git pull --ff-only
    $ for b in master next maint pu
      do
          git checkout $b && make install || break
      done

I do not think I want to ever switch them to new layout, and I suspect
that many others do feel the same.

Now, for these repositories, is "next" a local branch or a remote one? I
have a feeling that it might be easier to understand if we label anything
that you can update with "checkout && commit" a local one for the purpose
of "branch -r" listing; IOW, the current "git branch -r" classification
would match this use pattern better, even though refs/heads/next _is_ an
RHS of a rule to follow others.

In that sense, I would be entirely happy if the configuration variable
used in this series were branch.<namepattern>.color and let you specify

	[branch "refs/heads"] color = yellow
        [branch "refs/remotes/origin"] color = purple
        [branch "refs/remotes/nitfol"] color = cyan

It becomes complicated (and for no good reason, in my opinion; see the
"next" example above) if you try to tie this with remote.<name> hierarchy,
as it obviously becomes illogical not to use the "RHS of a fetch refspec"
logic when we are talking about remote.<name>.
