Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43D82035F
	for <e@80x24.org>; Thu,  1 Sep 2016 01:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbcIABIf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 21:08:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56442 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753793AbcIABIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 21:08:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C64B73BD42;
        Wed, 31 Aug 2016 21:08:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AykAHFRxe2FbSOJabDC3MQDomvI=; b=pRD8XM
        iqCNI1SqAJW6hLXMaq15+lcLjPHT47ZQ1fYOVAxQsCiSz22gUOOkdm1ijYvJihCX
        6bOdJ37TINLWdo9GHnPiCUH77XM+U9ryU00nqsO9KRjPp3drOQs6CRpjHIyQmf4+
        ONYPoDS6oAHwcIX3aXlW7b2SJ7qUNABbYTu5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=miwZQ9AF4/ECf8RjATbPdG7Ti+JvLBVv
        JF1K7j3lOdK04lD602q6QFfSkI7eJW++OIFFQcDWWUcmpMZfJoM4oNdTt+07xnNt
        w6z3DySAHyZDUCXS9FGOTci3PK9qiQ6aPl18hcpGDi5Nq3XakkJamcO/buBXvIfw
        qYWg38IGABU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF5B83BD41;
        Wed, 31 Aug 2016 21:08:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43A593BD3F;
        Wed, 31 Aug 2016 21:08:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v12 0/8] submodule inline diff format
References: <20160831232725.28205-1-jacob.e.keller@intel.com>
Date:   Wed, 31 Aug 2016 18:08:28 -0700
In-Reply-To: <20160831232725.28205-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 31 Aug 2016 16:27:17 -0700")
Message-ID: <xmqqoa48xw8j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 987A8368-6FE0-11E6-AE70-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> @@ -523,8 +523,10 @@ char *git_pathdup_submodule(const char *path, const char *fmt, ...)
>  	va_start(args, fmt);
>  	err = do_submodule_path(&buf, path, fmt, args);
>  	va_end(args);
> -	if (err)
> +	if (err) {
> +		strbuf_release(&buf);
>  		return NULL;
> +	}
>  	return strbuf_detach(&buf, NULL);
>  }

Thanks.  My copy was lacking this hunk.  Will replace.
