From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git config: report when trying to modify a non-existing repo config
Date: Wed, 24 Feb 2016 12:11:52 -0800
Message-ID: <xmqq60xduauv.fsf@gitster.mtv.corp.google.com>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
	<b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYfmx-00076J-N8
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbcBXUL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:11:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751750AbcBXULy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:11:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7679456EB;
	Wed, 24 Feb 2016 15:11:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9uSdz+FCj86dl7U99QQYokybwkk=; b=KKQNzB
	0O5tn//UIg+7mbwot6w4gx0Pjrffa0KiKj8gsCvMFOw/va22Jwxty/QocsarVsCD
	a0VSRGeFXOJg1w6q/vOZLueZt2I/xF0QxHGB/dXwzWOLxKNsDmeL+KpoxhG1OPK9
	Rfhmm6VW/3HyL4CppolxIAtFjn9YwdyO2zRDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SGV41HGwC3FzoSj4edRfJEtSAYbvWfrZ
	biYDeW725ULYMOSCv1aWf1yR9WLz0HEI+tbuF8CqzEJABOZoYBNEs2eiIoWwfGxm
	rhpNEwbH7qqPWg4+yFDZJqtZFTknR0vcLhuB2kpGGX+WDTNFu/R2MewOIOQMe0Hg
	Z0gsTAP/ENQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE840456EA;
	Wed, 24 Feb 2016 15:11:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 47299456E9;
	Wed, 24 Feb 2016 15:11:53 -0500 (EST)
In-Reply-To: <b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 24 Feb 2016 13:48:11 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D89373C6-DB32-11E5-9772-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287222>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 91235b7..f62409e 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -218,4 +218,13 @@ test_expect_success 'check line errors for malformed values' '
>  	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
>  '
>  
> +test_expect_success 'error on modifying repo config without repo' '
> +	mkdir no-repo &&
> +	GIT_CEILING_DIRECTORIES=$(pwd) &&
> +	export GIT_CEILING_DIRECTORIES &&
> +	cd no-repo &&
> +	test_must_fail git config a.b c 2>err &&
> +	grep "not in a git directory" err
> +'
> +
>  test_done

Please make it a habit to run tests that go up/down in the hierarchy
in a subshell.  It is not a good excuse that this new test happens
to be at the end _right now_.
