From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch
 submodules too
Date: Tue, 05 Oct 2010 14:06:25 -0700
Message-ID: <7vhbh05oz2.fsf@alter.siamese.dyndns.org>
References: <4C7A819B.3000403@web.de>
 <7vocckhcb6.fsf@alter.siamese.dyndns.org>
 <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org>
 <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de>
 <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de>
 <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de>
 <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de>
 <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de>
 <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 23:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Eif-0004mM-7p
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 23:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab0JEVGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 17:06:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab0JEVGe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 17:06:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 273C2DC8EA;
	Tue,  5 Oct 2010 17:06:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5wyFnQIPPSz/enqpUIRXqx5kack=; b=I3hnBR
	w4VDa3YlXQww2aG+PIc/8TQaFLl/PXS4Mu/piesKyKEIGw5KKj/eN+R4gW6UO/EY
	l3/aFFN6KZsu8H+X43dW570yS1IWZpsEfcsG1F/RuCXYB+Zdxpdr24C8PQ1WXvkd
	acAHSpQrXUJTd6NlORv7W5qkbfd5vCfmbR6/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vppwn659OSygGhGejQcXpSJLHfGCKCZc
	L3jbSapLCHaLJww95NzuvAYzxoX8dfh0iT7LjNf6NlFxOYAAhIHMqYzL5f2NZzsi
	yyjzQc9ms+xbuyWY/VE2OtKKp9f+d9IPT4l+DXZQH0ZvwgsHGsNNB+BoUfl2hi9h
	XGY1vVMbrLQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5279DC8D5;
	Tue,  5 Oct 2010 17:06:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE5EFDC8D3; Tue,  5 Oct
 2010 17:06:26 -0400 (EDT)
In-Reply-To: <4CAB8DDF.8080004@web.de> (Jens Lehmann's message of "Tue\, 05
 Oct 2010 22\:43\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D2FFBBE-D0C4-11DF-9F97-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158248>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>    a) "git fetch --all"
>
>       The user wanted to fetch new commits from all remotes. I think
>       git should also fetch all submodules then, no matter if new
>       commits from them are fetched in the superproject, as the user
>       explicitly said he wants everything. Objections?

Why?  I do not see a "--submodules" option on that command line.  The only
thing I asked is to grab all branches for the project I ran "git fetch"
in.

>    b) "git fetch [<repository>]"
>
>       The user wants to fetch from the default [or a single repo]. I
>       think all submodules should be fetched too, Kevin thinks this
>       should happen only when it is necessary (at least for his 'H'
>       repository). While I think fetching all submodules too is
>       consistent with the fact that you get all branches in the
>       superproject too, whether you need them or not, we can't seem
>       to agree on this one (also see my proposal below).

The case with <repository> is a lot more questionable than the case of
fetching implicitly from whereever you usually fetch from.  Imagine that
you fork git.git, and create a separate project that has some nifty
additions to support submodules better.  The additional part is naturally
done as a submodule.  This jens.git repository becomes very popular and
people clone from it.  Your users usually interact with your repository by
saying "git fetch" or "git pull" without any explicit <repository>.  They,
however, would want to fetch/pull from me from time to time to get updates
that you haven't incorporated in jens.git repository. "git fetch junio" is
run.  Why should such a "fetch" go to your repository and slurp the
objects for the submodules?

Perhaps you would want some knobs like these?

        [remote "origin"]
                fetch-submodules = all
                fetch-submodules = changed

        [remote "junio"]
                fetch-submodules = none

I dunno.  I've never been a fan of automatically recursing into submodules
(iow, treating the nested structure as if there is no nesting), so...
