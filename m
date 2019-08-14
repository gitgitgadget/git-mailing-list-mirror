Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295181F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 16:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfHNQPw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 12:15:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57276 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNQPw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 12:15:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F31FB8FC6E;
        Wed, 14 Aug 2019 12:15:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wYUa3hNoOxNA1fmidqa16VFgynA=; b=BxMuxd
        URSKLl/c3t3bxIUcXnNN4lLmpGKGVvSGPZOw/S2jmK6wLKYhhpB7yvsM6jXQqmNj
        gh+tsl7CDWew5suyck5gTRdW+vhGpECOatfQK7qGZsJGjdyeCOCg1b4DWWjAkfle
        vWcx/xEUPacIpLzQoZWDGfEYcIBtQnAXKQjH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ykcwJwSkKM0SZGVdEEf+wwf7yqRFE+eq
        Oj8H/abCx1CEGl0zHFiSmdB17qfilEGWQh7mkU+T+jCRMNUT+4ZV6qvbvj2rGKe8
        mthjcVc1gXECR/GNtI+epEHWN15ZxRki172OSvaGX1juLFUPx2JOfgOUu7uAarmR
        bjVgDB68Gug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB6438FC6D;
        Wed, 14 Aug 2019 12:15:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 270128FC6A;
        Wed, 14 Aug 2019 12:15:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Paolo Pettinato \(ppettina\)" <ppettina@cisco.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] get_next_submodule(): format error string as an error
References: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
        <20190814155953.GC12093@sigill.intra.peff.net>
Date:   Wed, 14 Aug 2019 09:15:44 -0700
In-Reply-To: <20190814155953.GC12093@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 14 Aug 2019 11:59:53 -0400")
Message-ID: <xmqqtvaj67v3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6490916-BEAE-11E9-8F4B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 14, 2019 at 09:57:50AM +0000, Paolo Pettinato (ppettina) wrote:
>
>> Could not access submodule 'sm' # fails, plus no newline here :P!
>
> This part seems easy enough to fix.

Indeed, it is ;-)

> diff --git a/submodule.c b/submodule.c
> index 0f199c5137..a5ba57ac36 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1478,7 +1478,7 @@ static int get_next_submodule(struct child_process *cp,
>  			    !is_empty_dir(ce->name)) {
>  				spf->result = 1;
>  				strbuf_addf(err,
> -					    _("Could not access submodule '%s'"),
> +					    _("error: could not access submodule '%s'\n"),
>  					    ce->name);
>  			}
>  		}
