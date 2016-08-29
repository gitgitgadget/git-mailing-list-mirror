Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83BD1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbcH2Uyx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:54:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58486 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755524AbcH2Uyv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:54:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 596FB3AD5B;
        Mon, 29 Aug 2016 16:49:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hLdcJ1NDHg6a9lFXpSFmCAvjnNA=; b=U/k6dJ
        4AU37OWNLYW1boKHA4lta5kvj1iaVXvmI/5Ori2/OV0eGXnB1niUUr1B49Rocl+D
        Z1bYQBUw7sCj+nCeBL1WQAJ7oeYwLH5er8Z2wo8sAUcBU5HxLD8xtuOX+TU1HSZC
        z9W5df2DjZN5pqF/N8PYqAA1lLgvPVlFc+INc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DvOjBMG1uU9O6S5FAzuAUyTPg+WUnByq
        R6lhavkqAYIb5AAOci8PGQOIrKhKCKoEmAXVdt4+5xLVIig5e0l9FVEisMsvNp51
        XqJX9w23Ls/Be25Dq5AwrRx2TkB2jIfh29rFkNoyUJg6tZhkDVvR7xfGpIhYrWSc
        qU+eGpkazM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51ADE3AD5A;
        Mon, 29 Aug 2016 16:49:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCDA83AD59;
        Mon, 29 Aug 2016 16:49:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/14] sequencer: lib'ify save_head()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <729cf9d7cca4ec3fe9caeb6f21a322f3c68ce135.1472219214.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 13:49:11 -0700
In-Reply-To: <729cf9d7cca4ec3fe9caeb6f21a322f3c68ce135.1472219214.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 26 Aug 2016 15:48:01 +0200
        (CEST)")
Message-ID: <xmqqy43f8fnc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B4B47DC-6E2A-11E6-8D49-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  	strbuf_addf(&buf, "%s\n", head);
>  	if (write_in_full(fd, buf.buf, buf.len) < 0)
> -		die_errno(_("Could not write to %s"), git_path_head_file());
> +		return error_errno(_("Could not write to %s"),
> +				   git_path_head_file());

Same comment around a left-over lockfile applies to this.  An extra
rollback being minimally intrusive also applies here, I think.

>  	if (commit_lock_file(&head_lock) < 0)
> -		die(_("Error wrapping up %s."), git_path_head_file());
> +		return error(_("Error wrapping up %s."), git_path_head_file());
> +	return 0;
>  }
