From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 1/2] format-patch: demonstrate that color.ui=always
 produces colorized patches
Date: Mon, 12 Sep 2011 11:07:10 -0700
Message-ID: <7vwrdd7hyp.fsf@alter.siamese.dyndns.org>
References: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
 <1315849601-26497-2-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	martin.von.zweigbergk@gmail.com, sdaoden@googlemail.com,
	ib@wupperonline.de
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:07:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Auc-0006bs-NY
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 20:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab1ILSHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 14:07:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab1ILSHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 14:07:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41043783;
	Mon, 12 Sep 2011 14:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oC+A2FpEvMudT44g8Ou4yhyRIzU=; b=Xh0v8E
	Fw5kdWCFmSBNbvOwT8Pd6QShjeOeV5HwQRTHqMZqUEsEym4Mt8LoBBYVsz7rm/Rb
	nNSWe17bJ/UhF7N9plXiKPZJB5zEUzSaoQgPFGG5yjRy6oESh5bxtqAYbzkZHbJk
	Ap6fMZ8gknG82lDBhhtWGHFNIspBGu4Vx9QYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gUGF7EamlRCEVGRN5xwIrqtyz0tINU92
	WtgwEAllqSnKK16anPQvjOyC33ZdzKhKlcfhu2YoMhNGBKo89lfRt8f9HuampIsO
	JZPqWizAvVWYb5bsF4KwPYbX7bZC/e5Dkhi+U9/ia9TiMtgJIw/XfYkXVtd/vlNd
	XXYGOEijaKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAF333782;
	Mon, 12 Sep 2011 14:07:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 751703781; Mon, 12 Sep 2011
 14:07:11 -0400 (EDT)
In-Reply-To: <1315849601-26497-2-git-send-email-pangyanhan@gmail.com> (Pang
 Yan Han's message of "Tue, 13 Sep 2011 01:46:40 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0967D90E-DD6A-11E0-8BF7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181231>

Pang Yan Han <pangyanhan@gmail.com> writes:

> commit c9bfb953 (want_color: automatically fallback to color.ui,
> 2011-08-17) introduced a regression where format-patch produces colorized
> patches when color.ui is set to "always".

Thanks.

I'd very much prefer this "one setup, one test" folded into an existing
test script, instead of wasting a new test number. Perhaps in t4014 whose
title reads "various format-patch tests"?

> diff --git a/t/t4051-format-patch-config.sh b/t/t4051-format-patch-config.sh
> new file mode 100755
> index 0000000..cea9c7d
> --- /dev/null
> +++ b/t/t4051-format-patch-config.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +test_description='check that format-patch does not respect porcelain config'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo foo >foo &&
> +	git add foo &&
> +	git commit -m "commit1" &&
> +	echo bar >foo &&
> +	git add foo &&
> +	git commit -m "commit2"
> +'
> +
> +test_expect_failure 'format patch with ui.color=always generates non colorized patch' '
> +	git config color.ui always &&
> +	git format-patch -1 &&
> +	mv 0001-commit2.patch actual &&

If you have a concrete output file, there is no point moving it to
"actual", especially when you are not comparing it with "expect".

> +	test_must_fail grep "\[31m-" actual
> +'

Hmm, is this grep safe?

Perhaps adding something like this near the end of an existing test script
might be simpler and sufficient, no?

test_expect_failure 'format patch ignores color.ui' '
	test_unconfig color.ui &&
        git format-patch --stdout -1 >expect &&
	test_config color.ui always &&
	git format-patch --stdout -1 >actual &&
        test_cmp expect actual
'
