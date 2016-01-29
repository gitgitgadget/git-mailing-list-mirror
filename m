From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] stash: use "stash--helper"
Date: Fri, 29 Jan 2016 10:34:37 -0800
Message-ID: <xmqq8u38jkua.fsf@gitster.mtv.corp.google.com>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
	<0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>
	<CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
	<20160129112152.GO7100@hank>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Matthias Asshauer <mha1993@live.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:34:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPDsb-0002th-9z
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbcA2Sek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 13:34:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756674AbcA2Sej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 13:34:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22C833F468;
	Fri, 29 Jan 2016 13:34:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3XyFr9SSCetKaAHmZoWYNkQ12lM=; b=Jj0eDM
	jXFxVobJrfjoO4K/RQ+9byzhAF3hYsqM5ZZOkruLXmnD3S5heTDGEcwJiF4b7zeY
	DT34IpI01Y5h49U6x0IDDdWWqN/yktPUwpSVtTf3/hyr0IPj/MgLhsVZfCQxUO2D
	AjnfxRrjCpDUGpppT3AQ89iXinH1trn2/fEtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ar2YuMlBoD2HxRCU4xBeKDVPt9w5N6r8
	CbZI+jn6x1q+MSaGUMq98M5E/U05OktrdGMKD2KeEGDQ7gxjIKE6OdZ8gdiFhrSw
	GZXfOTxTHFvo0tB9Kj/Un0DMJF0drJ+cEoeRWq+2/j/r04tM5kocW6VH82s+sx/4
	qVu8kBRwgls=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AEE43F467;
	Fri, 29 Jan 2016 13:34:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8B2063F466;
	Fri, 29 Jan 2016 13:34:38 -0500 (EST)
In-Reply-To: <20160129112152.GO7100@hank> (Thomas Gummerer's message of "Fri,
	29 Jan 2016 12:21:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F411D29A-C6B6-11E5-ACA3-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285084>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Matthias, feel free to squash the following (or something similar) in
> when you re-roll.
>
> diff --git a/t/perf/p3000-stash.sh b/t/perf/p3000-stash.sh
> new file mode 100755
> index 0000000..e6e1153
> --- /dev/null
> +++ b/t/perf/p3000-stash.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +test_description="Test performance of git stash"
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +
> +file=$(git ls-files | tail -n 30 | head -1)

If you use "tail -n 30" not "tail -30", which is good manners, you
would want to be consistent and say "head -n 1".

> +
> +test_expect_success "prepare repository" "
> +	echo x >$file
> +"
> +
> +test_perf "stash/stash pop" "
> +	git stash &&
> +	git stash pop
> +"
> +
> +test_done
