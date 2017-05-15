Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5383320188
	for <e@80x24.org>; Mon, 15 May 2017 06:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759774AbdEOGs2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 02:48:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32810 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759688AbdEOGs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 02:48:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so4314528pfe.0
        for <git@vger.kernel.org>; Sun, 14 May 2017 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9CkCa2tHygUMu2v/kYgaeLgSxAXUkKbLAh7hOyJjcag=;
        b=KkQIESKfE+7xnUaxG2NAzlQ8IM4JBXN2nkhcoRlocTc9/nOj+WL+/iHKVEQzPsDJUt
         oSwqlf8R0SdqZVgUOUsLq6LyjXRUdj24tJAONhniDWUx2RvCDbOwnLvPa3tlNEq2CAZp
         q6+sDBQyUWEvLZvuLOUDy+re4kzASU097uQLv901+SKwow9ra2EUjqBourigNMzPUH2H
         s7Gzk+58W0KzgVETdvhZfkJ6MBpm9pTGWttnrGMoSPCuhtaUMAnO/enDCGudznusvrGd
         SXMVOPYDV01hdfpq0jJ3L7zUUPX66BGNi84R1HgFBey4xlbpJ8cGA4O30Wn/L0TKyURG
         2dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9CkCa2tHygUMu2v/kYgaeLgSxAXUkKbLAh7hOyJjcag=;
        b=uAR326VHAqd6STwzanG1WelKs6mMywSMbIse8J82NgpjFkTPskM8BRmIN0nR1jLgf3
         WLBLy7zEXr6oRCv1KPjq9EN3ATjo3vWIZ9hKF8GXReyR80ZCULBn5BExvyCi2QInGgSZ
         zicPeyqZC/rgoAVN8kuvBPh8+dT7+9WHQgiDHonXj43+N2tIdyj193zWdx7zW4p2jxtg
         vMIcwdVJRj2rbCxgEG07YA5t9zTbmho8sKSxDcppj/kwreV2zLGpuntI8cEw+w7XRCMm
         59c5p16FAxRYq5Ss5mvkRenI2yBIHRWDvatbCMWlcsH1an5EEVK3LyKlX8FBQcgQ2Gvn
         leyw==
X-Gm-Message-State: AODbwcA1tVlQ20GY2jCsQE2iOLYzDup5YTrmum6m3YN1UFSS5PVWcBwm
        Y3iA+pT5svVtsg==
X-Received: by 10.84.238.203 with SMTP id l11mr6345917pln.17.1494830907227;
        Sun, 14 May 2017 23:48:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id c23sm17296423pfh.131.2017.05.14.23.48.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 23:48:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 02/19] diff: move line ending check into emit_hunk_header
References: <20170514040117.25865-1-sbeller@google.com>
        <20170514040117.25865-3-sbeller@google.com>
Date:   Mon, 15 May 2017 15:48:24 +0900
In-Reply-To: <20170514040117.25865-3-sbeller@google.com> (Stefan Beller's
        message of "Sat, 13 May 2017 21:01:00 -0700")
Message-ID: <xmqqk25ivcnb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This patch moves code that is conceptually part of
> emit_hunk_header, but was using output in fn_out_consume,
> back to emit_hunk_header.

Makes sort-of sense.  If I were selling this patch, I'd remove the
first two paragraph and stress on how completing the line inside
emit_hunk_header() is conceptually cleaner than doing it outside.

	emit_hunk_header() function is responsible for assembling a
	hunk header and calling emit_line() to send the hunk header
	to the output file.  Its only caller fn_out_consume() needs
	to prepare for a case where the function emits an incomplete
	line and add the terminating LF.  

	Instead make sure emit_hunk_header() to always send a
	completed line to emit_line().

or something like that.

Note that I am not saying "buffering the entire diff in-core?  why
should we support such a use case?".  I am saying that this change
is a clean-up that is justifiable, without having to answer such a
question.

>
> Meanwhile simplify it by using a function that is designed for it.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 3f5bf8b5a4..c2ed605cd0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -677,6 +677,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
>  	}
>  
>  	strbuf_add(&msgbuf, line + len, org_len - len);
> +	strbuf_complete_line(&msgbuf);
> +
>  	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
>  	strbuf_release(&msgbuf);
>  }
> @@ -1315,8 +1317,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  		len = sane_truncate_line(ecbdata, line, len);
>  		find_lno(line, ecbdata);
>  		emit_hunk_header(ecbdata, line, len);
> -		if (line[len-1] != '\n')
> -			putc('\n', o->file);
>  		return;
>  	}
