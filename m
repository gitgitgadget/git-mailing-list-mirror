Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF481FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 23:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbcIKXd7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 19:33:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57417 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752789AbcIKXd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 19:33:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D68D93EC8A;
        Sun, 11 Sep 2016 19:33:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SjXpzyxIh9DaXqqnX38SdIWaygA=; b=Betpn6
        pYyjnweDJblAFahEtlxODKgMOqqAzrKfwGC8de4mEE/6CUIjzJGMpOZEFh+heGdg
        VTi1EfpR6H74H0V4NyhnJZIVzf+29b5mIwHrF6a1awVR5hhxVHp7I1C6eIxWDDiN
        m19/FImkcLpRph+M3iAl/exqp1v+zMpi3XTvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XcUNNZUrthIjdsZp7VpVOdEAHWIJW+Wr
        YbKiQcigOm5JleauWd8AeCrGimD4B73A0d2s/w1FT8jhnxWPibT9cvFGiJqBx9Q7
        HSL1rQW+Ds5IPKBlYaQntYSJMcObT4j8BUcef30pi/+DlAwexxDQMremqJOK4zvz
        xbmII/5r6h8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCE9D3EC89;
        Sun, 11 Sep 2016 19:33:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 508493EC88;
        Sun, 11 Sep 2016 19:33:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 24/25] sequencer: quote filenames in error messages
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <db1816339ba9e259e929a45d644c33160f57c5bb.1473590966.git.johannes.schindelin@gmx.de>
Date:   Sun, 11 Sep 2016 16:33:55 -0700
In-Reply-To: <db1816339ba9e259e929a45d644c33160f57c5bb.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:55:57 +0200
        (CEST)")
Message-ID: <xmqq60q26mfw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35AEE468-7878-11E6-B842-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This makes the code consistent by fixing quite a couple of error messages.

Looks OK.  While at it, we may want another one to downcase the
first word, perhaps?

These may not be messages added by your series and can be left
outside this series, but I have to point out that

    if (commit_lock_file(&msg_file) < 0)
        return error(_("Error wrapping up '%s'."), filename);

results in "error: Error wrapping up", which sounds quite funny.

"failed to finalize" or something would flow a bit better, I'd say.

> diff --git a/sequencer.c b/sequencer.c
> index 1e7f29e..465e018 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -255,7 +255,7 @@ static int write_with_lock_file(const char *filename,
>  	if (append_eol && write(msg_fd, "\n", 1) < 0)
>  		return error_errno(_("Could not write eol to '%s"), filename);
>  	if (commit_lock_file(&msg_file) < 0)
> -		return error(_("Error wrapping up %s."), filename);
> +		return error(_("Error wrapping up '%s'."), filename);
>  
>  	return 0;
>  }
