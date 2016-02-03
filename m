From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] submodule-config: introduce parse_generic_submodule_config
Date: Wed, 03 Feb 2016 15:09:22 -0800
Message-ID: <xmqqd1sdl7bx.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:09:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6YM-0005YV-Hw
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbcBCXJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:09:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754074AbcBCXJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:09:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 776D940EA4;
	Wed,  3 Feb 2016 18:09:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WXvlxaYmAfJumwz+/7vwQJ+gTGg=; b=f3F9LA5tvgSeh6rNtMTT
	cd1niG9hyCRVarUyNzmp+GKGETSK4UoYMDQK/Lnwgu345pRxhRTNXpBcbCiHcnXi
	pftZW3uvo8jmeTLa0UPHTBQU3jtybVvEqpKcNiGyR7kBtqJxh+SvI54aoza8YFPH
	feg69WmJkvGtJv/gspTbt/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=b23Ms2yVX3T4TtjIwFDIjVrDAi9klqImU6KYzgTVbflUaK
	+O3BrmfL8Zrc+1GOGzvInaq6vr9asnhaQfKOvwFTNyCj7Of6KC/C3AqklWHd8AXL
	6/SdiEd+25cMXP3BAMvyrnJ+LZ5e+YbNOE+a7Lel0+Jqdifeq725PPxn8WkDA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E87840EA3;
	Wed,  3 Feb 2016 18:09:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E558D40EA2;
	Wed,  3 Feb 2016 18:09:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2A2EC8D4-CACB-11E5-B6E0-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285380>

Stefan Beller <sbeller@google.com> writes:

> This rewrites parse_config to distinguish between configs specific to
> one submodule and configs which apply generically to all submodules.
> We do not have generic submodule configs yet, but the next patch will
> introduce "submodule.fetchJobs".

OK.

> +static int parse_config(const char *var, const char *value, void *data)
> +{
> +	struct parse_config_parameter *me = data;
> +	int subsection_len;
> +	const char *subsection, *key;
> +
> +	if (parse_config_key(var, "submodule", &subsection,
> +			     &subsection_len, &key) < 0)
> +		return 0;
> +
> +	if (!subsection_len)
> +		return parse_generic_submodule_config(key, var, value, me);

The same comment as in the footnote for the review on [3/8] applies
here.

> +	else
> +		return parse_specific_submodule_config(subsection,
> +						       subsection_len, key,
> +						       var, value, me);
> +}
> +
>  static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
>  				      unsigned char *gitmodules_sha1)
>  {
