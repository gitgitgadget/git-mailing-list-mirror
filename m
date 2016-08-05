Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D661F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbcHFUFD (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:05:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751734AbcHFUFB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:05:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA5C333DA3;
	Fri,  5 Aug 2016 18:48:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=87Iv5/fbmOUNunR8vDmlYwmA+Xs=; b=UoWYZv
	hZR+IxF56zQQ99JDi55ByS+2VZBK8aEF/+aoge5OGd/1+SNGFVV0+Ui02iJDmbD+
	+knsQ8mHLd7v36VKdEC5zzjDyWVE2i0kHf71keTVScR8Gc5gBZ0jDh5H/U0WD4NY
	Blf2hYCDf3Pvj43fs0FSwPdZmXVUFY+tkCfnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n0RJ5BTc323FY2VwyVHoS1BYukbdJZUT
	NgkMx7faP8yzN13LJHw+K1D60hRqA3wKzjmc/v2VEPesfa7+aFkd6nFGEeGYv+fN
	y+AEb+aKmSiFqT4XUNTdJh7mvdV8N+K3W1Ki5nRaJj2RDgeMz3TeOhVbtelcZ2Y+
	y6Q8P2MDs7c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2A2033DA2;
	Fri,  5 Aug 2016 18:48:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E50633DA1;
	Fri,  5 Aug 2016 18:48:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 4/9] status: collect per-file data for --porcelain=v2
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
	<1470434434-64283-5-git-send-email-git@jeffhostetler.com>
Date:	Fri, 05 Aug 2016 15:48:44 -0700
In-Reply-To: <1470434434-64283-5-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Fri, 5 Aug 2016 18:00:29 -0400")
Message-ID: <xmqqbn16vnlf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C46E4874-5B5E-11E6-B57C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>  		if (ce_stage(ce)) {
>  			d->index_status = DIFF_STATUS_UNMERGED;
>  			d->stagemask |= (1 << (ce_stage(ce) - 1));
> +			/*
> +			 * Don't bother setting {mode,oid}_{head,index} since the print
> +			 * code will output the stage values directly and not use the
> +			 * values in these fields.
> +			 */
>  		}
> -		else
> +		else {
>  			d->index_status = DIFF_STATUS_ADDED;
> +			/* Leave {mode,oid}_head zero for adds. */
> +			d->mode_index = ce->ce_mode;
> +			hashcpy(d->oid_index.hash, ce->sha1);
> +		}

Not a big deal (no need to resend for this one alone), but let's
make the above properly formatted, i.e.

		if (ce_stage(ce)) {
                	...
		} else {
                	...
		}                        

Thanks.
