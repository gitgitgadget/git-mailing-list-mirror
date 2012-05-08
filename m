From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 08 May 2012 09:25:17 -0700
Message-ID: <7vd36ey70y.fsf@alter.siamese.dyndns.org>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
 <4FA904C3.7070208@viscovery.net>
 <CABPQNSZjdpz8zqYOwBQ_SPeh0JqyxQ1bjrghG1vzxt0GiLR22w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 18:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnE7-0002QC-6q
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab2EHQZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:25:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810Ab2EHQZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:25:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D40F6409;
	Tue,  8 May 2012 12:25:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3LiST8SeCAm30liGDbhf8d3RNKE=; b=tstRmI
	acfcKrPtprmmicUrYJ2A1CHynUZhhXj8rCLSrjq10LuZqgNtH5jlxjc2UlE2E33w
	onND/ePzrkxxRvIdoDAfz9lzpsVWXE2vUuDpKCDU3sOEE1pCwB8R4ZRfvhBFQoKp
	GRIej10ha3EzbIS6vDt645qm9nFkvEGff1iFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P4WXG5Eq1ibyvv3GcD6mmHhpnQL9YEhn
	0ksY2F66Y5mP0bsKHIsXDIbYehZ1lCeVMFwLuDTiT4h/Ud8MGSJU35YLCLV0zeUG
	cDpat/suxlfYymuf6aBmNPbh2841zfDsdyrZ8C/poOGW/F2Uh7higr1cFDaRGz6p
	44gK4yUhaFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938B56407;
	Tue,  8 May 2012 12:25:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 170D963F2; Tue,  8 May 2012
 12:25:18 -0400 (EDT)
In-Reply-To: <CABPQNSZjdpz8zqYOwBQ_SPeh0JqyxQ1bjrghG1vzxt0GiLR22w@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 13:50:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66DA0978-992A-11E1-88DE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197383>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> But if I apply the following patch, the test passes. I'm not saying
> it's the right thing to do, though.
>
> (Warning: white-space damaged because of copying diffs between terminals)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 23fc56d..d70e819 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1096,8 +1096,11 @@ int cmd_checkout(int argc, const char **argv,
> const char *prefix)
>                 int flag;
>
>                 if (!read_ref_full("HEAD", rev, 0, &flag) &&
> -                   (flag & REF_ISSYMREF) && is_null_sha1(rev))
> +                   (flag & REF_ISSYMREF) && is_null_sha1(rev)) {
> +                       if (!opts.new_branch)
> +                               return 0;
>                         return switch_unborn_to_new_branch(&opts);
> +               }
>         }
>         return switch_branches(&opts, &new);
>  }

This patch, if we ignore submodules for a while, actually makes sense to
me.  If you have a commit, you are on that commit and you haven't done
anything since you have checked out that commit, "git checkout" (no other
parameters) would be a no-op.  If you "git init" a repository, and you
haven't done anything since then, the above makes "git checkout" (no other
parameters) a no-op.

Am I missing some corner cases that we _should_ error out, perhaps for the
sake of safety?
