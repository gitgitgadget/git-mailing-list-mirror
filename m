Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509671FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 21:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbcKRVhu (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 16:37:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752366AbcKRVht (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 16:37:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F9934E180;
        Fri, 18 Nov 2016 16:37:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=38d2QADlgOEgd3jan/pPoE+NRek=; b=OzG0/a
        DMGd+B59KG3KtGOmCLT/iWvFjMtF9IOxJMCAjs4Iw8uu4ktGSiqgW+NQBRV97WSM
        txkFjXe2s74GqF8WUY97fnVieV7VJd601sGBgL0N8r8+LwuCa0MUh9p3RhIjrRbJ
        b5YNPb06tl3N1Y4oOKslOnW9LC5Zahbx6Tink=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wdZq1H+0VRNmxBoWA7jUCnDQzjjvWM98
        +1RDNEzNexFaofryB1nPBY8pyr7wMDYuAFO+v1i57nX0lX4WrhqFf/5d8/9qDqAJ
        Ukk7jqxYcAeMdotLnnmMLZm2hXD22749lpNCduLPRLZAJbBAU2c9h0S7QpvkAlO4
        0xs6gFxCtlA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37E384E17F;
        Fri, 18 Nov 2016 16:37:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D4B64E17E;
        Fri, 18 Nov 2016 16:37:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 3/6] grep: add submodules as a grep source type
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
        <1479499135-64269-1-git-send-email-bmwill@google.com>
        <1479499135-64269-4-git-send-email-bmwill@google.com>
Date:   Fri, 18 Nov 2016 13:37:46 -0800
In-Reply-To: <1479499135-64269-4-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 18 Nov 2016 11:58:52 -0800")
Message-ID: <xmqq60nkmpud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F847CA2-ADD7-11E6-B923-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/grep.h b/grep.h
> index 5856a23..267534c 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -161,6 +161,7 @@ struct grep_source {
>  		GREP_SOURCE_SHA1,
>  		GREP_SOURCE_FILE,
>  		GREP_SOURCE_BUF,
> +		GREP_SOURCE_SUBMODULE,
>  	} type;
>  	void *identifier;

Hmph, interesting.  We have avoided ending enum definition with a
comma, because it is only valid in more recent C than what we aim to
support.  This patch is not introducing a new problem, but just
doing the same thing that would have broken older compilers as the
existing code.  Perhaps those older compilers have died out?

