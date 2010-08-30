From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Submodules: Add the new "fetch" config option
Date: Mon, 30 Aug 2010 00:34:13 -0700
Message-ID: <7vsk1wftai.fsf@alter.siamese.dyndns.org>
References: <4C7A819B.3000403@web.de> <4C7A81F0.4090209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 30 09:34:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opyst-00078e-GA
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 09:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab0H3HeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 03:34:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0H3HeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 03:34:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93F6DD17F1;
	Mon, 30 Aug 2010 03:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1FONMtH5w94gjzvqxdpp8qg0unU=; b=m5j+70
	cXcK+oyd/4h36cDuU5edTxOtuOM4CAFe/K4AzP9QnDSGLefOqJyx4lMfEUgLS1eK
	pSx5CaZAaoHF1psROlai5n6ebVrO9ZQohtNQifds2R9u2Czqdk9B/j5uK/0fXqME
	ZHh5C3OSVeELLxy97685EuL+sV+nm74T5j1Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tKJMOS+dJRr9ZChKAcogbPBC2O3H2wyT
	jSr37KQTuFVCQb7SOjPq3Cq61ZKuJYE+zvkOtdcKRLxyUFXgRO6PbOEKezxJxxPs
	DngOJTVuk2M4zEOmFOr98VmbiZ0psyMPIgagUK7EoQWHmGydh3wjmUMPb1ELO9WC
	HfVOkGjUyeA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 322FBD17ED;
	Mon, 30 Aug 2010 03:34:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74DD0D17EA; Mon, 30 Aug
 2010 03:34:14 -0400 (EDT)
In-Reply-To: <4C7A81F0.4090209@web.de> (Jens Lehmann's message of "Sun\, 29
 Aug 2010 17\:51\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF6273D2-B408-11DF-B582-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154773>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/submodule.c b/submodule.c
> index e4f2419..8c98fad 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -100,6 +101,14 @@ int parse_submodule_config_option(const char *var, const char *value)
>  			config = string_list_append(&config_name_for_path, xstrdup(value));
>  		config->util = strbuf_detach(&submodname, NULL);
>  		strbuf_release(&submodname);
> +	} else if ((len > 5) && !strcmp(var + len - 6, ".fetch")) {
> +		strbuf_add(&submodname, var, len - 6);
> +		config = unsorted_string_list_lookup(&config_fetch_for_name, submodname.buf);
> +		if (!config)
> +			config = string_list_append(&config_fetch_for_name,
> +						    strbuf_detach(&submodname, NULL));
> +		config->util = (void *)git_config_bool(var, value);

Hmm?  We get this here...

    submodule.c:110: error: cast to pointer from integer of different size
