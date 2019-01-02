Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40F31F770
	for <e@80x24.org>; Wed,  2 Jan 2019 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfABUzz (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 15:55:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36887 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfABUzz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 15:55:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so28658206wmd.2
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 12:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+VMtiDWa9i7XWa3UXd5GDkZnGEG8L1Xg6BkiYxc7i+I=;
        b=TOWOvTBFFLdjy8j7u3M0RqqKOFZoB9faJJNT8ZBnkdE+5ZfmeVeoJ+TO5I67GXIaFx
         G057hz/MX+/PHLF6mj5RqLtUu2QW+xaCuUgWCWN9DH7AIMMdS63wjEB4JeJAioBv3EJZ
         hEgiNGnFa3SBpookwfjDLlOuC+E8nlThyEYUZ1c5S15/exmrBZZVPR+KYdJWTv/x0E+t
         au3QLkLNVbqDd9LhUG52fqTkxCuP4zOWtsTwSQ1ymrHQIUf28kctcZb2JdAM/VwUwEa5
         b4nJMRETPH2aFxh39QEkDvdI0GVZ+GH+Q1w10xwZTClxINRtJbgo8SgRpNc3qnc2THCJ
         VMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+VMtiDWa9i7XWa3UXd5GDkZnGEG8L1Xg6BkiYxc7i+I=;
        b=mk5Wub5+MENr7zm27LtkBsKkXu1aOBBzsGrl7CB6vAfc0+6tYrN4cJ0REGTjyxDmdp
         KUE3zKoWlyHZUia2OnuKYk049mYEdNimRowWMmSn2g76iqVj1O8oQ4v4UqR7bL09bvLy
         HgmNz9NNXAuunhZgW4I9Lo/xVduk5aK86x6saayB87cNLKIOIiMhXj9c+vu4f51mMoI5
         Jb5m2+qlcliB68bHK7bfr/0rLmrLlSTsPFYw4/1B++XseR6EQA894zQlnOCVmrby+BmA
         F8qEwB56YvFNWRYkVfLhCl7ftEIgqzzm3p4+TF485QTeuxRevRrC0FNTkzowXkf1IxFU
         x5/Q==
X-Gm-Message-State: AJcUukfmHWGBhjEewbbEfGa8GPtnUAldkeEVT2rPazLWdKchNUHqtW70
        eZe+WEWwbs60YGO5zGqRjxU=
X-Google-Smtp-Source: AFSGD/VuREPE4/cct3DvpBeAat/IPkry3Y82wr1oQCyC8xhxasBdce7Sga07WJvYzUF66Eu3Gvgkgg==
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr33453186wme.64.1546462553022;
        Wed, 02 Jan 2019 12:55:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h131sm53047033wmd.17.2019.01.02.12.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 12:55:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 1/4] transport-helper: use xread instead of read
References: <20181228233556.5704-1-randall.s.becker@rogers.com>
Date:   Wed, 02 Jan 2019 12:55:51 -0800
In-Reply-To: <20181228233556.5704-1-randall.s.becker@rogers.com> (randall
        s. becker's message of "Fri, 28 Dec 2018 18:35:56 -0500")
Message-ID: <xmqqbm4ykcdk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This fix was needed on HPE NonStop NSE and NSX where SSIZE_MAX is less than
> BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
> was the only place outside of wrapper.c where it is used instead of xread.

Thanks.

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  transport-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index bf225c698f..a290695a12 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1225,7 +1225,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
>  		return 0;	/* No space for more. */
>  
>  	transfer_debug("%s is readable", t->src_name);
> -	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> +	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> - 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> - 		errno != EINTR) {
> + 	if (bytes < 0 && errno != EINTR) {
>  		error_errno(_("read(%s) failed"), t->src_name);

Can't we also lose EINTR check, though?  When read() returns
negative, we check errno and if it is EINTR, continue the loop.
