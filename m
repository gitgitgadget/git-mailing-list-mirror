Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF852027C
	for <e@80x24.org>; Mon, 29 May 2017 06:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdE2GqE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 02:46:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34109 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdE2GqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 02:46:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so5530104pgb.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QMcEe96+ZanuD6SCspGI7yFUcym9tXl/1ENCqV5wpt4=;
        b=TyvYZQh91Utd0KTF4dKt39V1TPJzdolwszUJf9QkzFgNAiiv+bMPCor1ibRyV1BP+s
         bTuEt1TnJoIR8yxs4poueXQM0jg9ESbCdQy4hGXiPGVHPVZmI2Qq+Zu24jDTLksI49Qj
         LgqMzFUjKK51KoOb5P3iPA0S56RQsc1pnYXaxwqZLd6z2YRNl92OSMsbX7Z8jQOkPxss
         gZgQ8Vou+rvWrsUgbsn7nAcum5GfXtQeFyteL+HIXturyXMwIMiik4VDy6EqKun78NsA
         oTxLuexdmM/Ll9/hBDA5u3CU6K6IMOclv0vpfslV26bpCj/nS5lz3fAk7+InpWn08nE3
         E0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QMcEe96+ZanuD6SCspGI7yFUcym9tXl/1ENCqV5wpt4=;
        b=cHWNbTwjvEnQ31VL/jJrfUFDc2QCSIUrmJwYYBqX/3gtQloKFuqOtV5e2WTV6ijMok
         PNGD5ZMtcvpOG7z1vEOQlTub/4Rzi9WlwAwIHlsJtg+ktLqmm1YVyi2oku5LYqq3Xm7a
         //5rASoUOk90opvl+4lBJkB3FBMW3hQv6VxBfDtNLrhP3pvLTYzP0HgEQiMGZGRfH0La
         5vWOX9CI0jP6WeWasfkQ58zkb6Oa4nyD3YHOp7fzpDpBlkG1d7eanTXVr6m3AoQoPpp+
         L8WqR/PgDZ1GWY9UAEvBkCl6SS15TkyhKHvfnrjtMpmm0WLQEw04DMfsUgSGmJdJzWfk
         x10Q==
X-Gm-Message-State: AODbwcAk8QKuGHMecxCxPIePInkb52AV88wgyWF3NnYMTF68q6LOsW30
        l5x9id/R4SEadw==
X-Received: by 10.98.32.132 with SMTP id m4mr16375382pfj.131.1496040363311;
        Sun, 28 May 2017 23:46:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id j17sm14785571pfk.23.2017.05.28.23.46.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 23:46:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 3/4] close the index lock when not writing the new index
References: <20170528165642.14699-1-joel@teichroeb.net>
        <20170528165642.14699-4-joel@teichroeb.net>
Date:   Mon, 29 May 2017 15:46:01 +0900
In-Reply-To: <20170528165642.14699-4-joel@teichroeb.net> (Joel Teichroeb's
        message of "Sun, 28 May 2017 09:56:41 -0700")
Message-ID: <xmqqo9uc6tzq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---

The title says what the patch does; it does not explain why it is a
good change.  Lockfiles will be closed automatically when we exit
anyway, so one can argue that the current code is good.

If you are planning to add more code to these "missing" else clauses
in future steps in this series, this change makes sort-of sense.  If
that is the case, please say that in your log message.

>  builtin/add.c     | 3 ++-
>  builtin/mv.c      | 8 +++++---
>  builtin/rm.c      | 3 ++-
>  merge-recursive.c | 8 +++++---
>  4 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 9f53f020d0..6b04eb2c71 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -461,7 +461,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	if (active_cache_changed) {
>  		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>  			die(_("Unable to write new index file"));
> -	}
> +	} else
> +		rollback_lock_file(&lock_file);

I think Ævar already pointed out the style issue, i.e.

	if (a-c-c) {
		if (w-l-i())
			die(...);
	} else {
		rollback_lock_file(&lock_file);
	}

The same for all other hunks in this patch.

Thanks.
