Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D009E20560
	for <e@80x24.org>; Fri, 27 Oct 2017 18:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdJ0STk (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 14:19:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63025 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751167AbdJ0STj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 14:19:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D768BA661;
        Fri, 27 Oct 2017 14:19:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SLpGX3mSV8++aa6peJa2wbIh0fA=; b=eDQJtR
        OdXVQXCQORketw6e42gn5R5BTq3ZOxWSLWsM5WInFlS5/UbsMcV/eNEnDsK3zAEX
        23arryLeC/t151w3G9qhobPZSTgR/LoIwgyjinGJ7ZFXoFovsG3/k4nY7ldbSUlF
        8iG8kko4jmy5JxbUHIUdPD+DRpKfeDlAkrJgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P8QWyOjPjGvvkug+4S4BO3uYZm0DGuxQ
        5ECLlXqX22NgLR/+wfX/ExUbHfCZF+oSnRc3VuNn+CwDjv95chhAQoEqHWVj5Cdu
        lJfLYURCxU7pWmT/Ksw+3lvUr6Wdi+vvaPgSeRGs5Esl8T10ZEdYf7dI6sE04W0t
        o0tavQpUIf4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3240ABA660;
        Fri, 27 Oct 2017 14:19:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A91BDBA65F;
        Fri, 27 Oct 2017 14:19:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell function in C
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
Date:   Sat, 28 Oct 2017 03:19:37 +0900
In-Reply-To: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Fri, 27 Oct 2017 15:06:37 +0000")
Message-ID: <xmqqo9osbghy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64D64650-BB43-11E7-8B0E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> -		bisect_write "$state" "$rev"
> +		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit

I can see why two extra "terms" parameters need to be passed to this
helper at this step; looking at patches around 4/8 and 6/8 where C
code can directly find out what words are used for GOOD and BAD, we
should be able to lose these two extra parameters from this helper
by internally making a call to get_terms() from bisect_write() ;-)
