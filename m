From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] remote-bzr: add simple tests
Date: Wed, 28 Nov 2012 09:36:16 -0800
Message-ID: <7vy5hlvddb.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <1352643598-8500-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdlYp-0003B1-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 18:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab2K1RgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 12:36:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab2K1RgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 12:36:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C5638D1E;
	Wed, 28 Nov 2012 12:36:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8lLE5+Oz/av35Q5K3AXY81wal7A=; b=huA/PF
	IOnoSSAym7LmUsI9Gof2FTUfA2xxAzNL+qOEVfsFni4ZR15ER91ri7MT5WaYLlaD
	xzk7ETijKuVB41F046OD9/MpOvDgWldjzZ353TdUkjYLhYS+FaE0ggX+A19XZWPT
	bh/G5qKhzJnR5PaGE7/VBFRJ3O7UUWEC0lYeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hsgxcwMAefW277l7XHhZsitQEwidAtbF
	1k15p8/C+LGQJU/IYy6h4bd/TxxhyxBzyRs3fRr11oFAESqdk5nbZQ+R89ZsV2LK
	A/L+Vq9UcM6zyQ/JMUgA1sR6p4/3817CPT+ftF656FmAZ0xnQWaNmZAWCDW+y/BA
	8YqJZuiNqmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDFDD8D1D;
	Wed, 28 Nov 2012 12:36:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 511638D18; Wed, 28 Nov 2012
 12:36:18 -0500 (EST)
In-Reply-To: <1352643598-8500-6-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 11 Nov 2012 15:19:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DD2A0D4-3982-11E2-8A97-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210744>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/test-bzr.sh | 111 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100755 contrib/remote-helpers/test-bzr.sh
>
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
> new file mode 100755
> index 0000000..8594ffc
> --- /dev/null
> +++ b/contrib/remote-helpers/test-bzr.sh
> @@ -0,0 +1,111 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Felipe Contreras
> +#
> +
> +test_description='Test remote-bzr'
> +
> +. ./test-lib.sh
> +
> +if ! test_have_prereq PYTHON; then
> +	skip_all='skipping remote-bzr tests; python not available'
> +	test_done
> +fi
> +
> +if ! "$PYTHON_PATH" -c 'import bzrlib'; then
> +	skip_all='skipping remote-bzr tests; bzr not available'
> +	test_done
> +fi

> +cmd=<<EOF
> +import bzrlib
> +bzrlib.initialize()
> +import bzrlib.plugin
> +bzrlib.plugin.load_plugins()
> +import bzrlib.plugins.fastimport
> +EOF
> +if ! "$PYTHON_PATH" -c "$cmd"; then

I cannot see how this could have ever worked.  It could be that you
wrote it for zsh and tested only with the version of zsh you have;
zsh I have here does not grok it (and of course dash and bash won't).

In any case, I do not think this is a POSIX shell.  Just replace
"=<<EOF" and "EOF" with single quote and everybody's shell should be
able to read it.

> +	echo "consider setting BZR_PLUGIN_PATH=$HOME/.bazaar/plugins" 1>&2
> +	skip_all='skipping remote-bzr tests; bzr-fastimport not available'
> +	test_done
> +fi
> +
> +check () {
> +	(cd $1 &&
> +	git log --format='%s' -1 &&
> +	git symbolic-ref HEAD) > actual &&
> +	(echo $2 &&
> +	echo "refs/heads/$3") > expected &&

Style: s/> expected/>expected/;
I won't repeat this but there are many others in this file.

Thanks.
