Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208FE1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 19:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754965AbdCaTwB (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 15:52:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61968 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753702AbdCaTwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 15:52:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A47A7DAD9;
        Fri, 31 Mar 2017 15:52:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pbUmHZ9xqJxzEWmaRQTyY2vnv28=; b=bb9rtL
        PS27STncqiVHjYy4OXMSOWyzrr8fzJtTNUoCxJ8rwEYusIForKPAg3GX1IzPcFBi
        vpFUdqe5cOg0nqylCvd44XRoAjZVGE4ZKz5gNEiQzBNNPcxXZjIKNInsD6MpbGbk
        JYuhTiUT7jhQm5Jp12tUOvQE5RVze99jyApaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ci02P8TVsyhU6T334Ri5vLvBmES2szc/
        on8DQ578A1Ug2ZIa3kTq6W8OmgpPUE3i76y9QODAVMcKo7HnyH+fjQagqnM7Auzw
        le4FvY9Oks0qc5lTpvfRLp8ydBrRfHhFlyCVaauFUnxwVqsT91KHIP7XzDjOx5QQ
        OOQqXoe2MUQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37A487DAD7;
        Fri, 31 Mar 2017 15:52:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86EAE7DAD6;
        Fri, 31 Mar 2017 15:51:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] http.postbuffer: allow full range of ssize_t values
References: <20170331172631.12024-1-dturner@twosigma.com>
Date:   Fri, 31 Mar 2017 12:51:58 -0700
In-Reply-To: <20170331172631.12024-1-dturner@twosigma.com> (David Turner's
        message of "Fri, 31 Mar 2017 13:26:31 -0400")
Message-ID: <xmqqfuhtxm01.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80B2E9A2-164B-11E7-82CB-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> +static int git_parse_ssize_t(const char *value, ssize_t *ret)
> +{
> +	ssize_t tmp;
> +	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
> +		return 0;
> +	*ret = tmp;
> +	return 1;
> +}
> +
>  NORETURN
>  static void die_bad_number(const char *name, const char *value)
>  {
> @@ -892,6 +901,14 @@ unsigned long git_config_ulong(const char *name, const char *value)
>  	return ret;
>  }
>  
> +ssize_t git_config_ssize_t(const char *name, const char *value)
> +{
> +	ssize_t ret;
> +	if (!git_parse_ssize_t(value, &ret))
> +		die_bad_number(name, value);
> +	return ret;
> +}
> +

Thanks.
