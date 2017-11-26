Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7EE20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 22:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbdKZWJC (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 17:09:02 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35951 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdKZWJB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 17:09:01 -0500
Received: by mail-qk0-f194.google.com with SMTP id o6so30179462qkh.3
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=piUn98E4ME5UBI+7tZ+viN5QHlPKU6ns1OxTVYHw8e8=;
        b=Nxv50AtVwyoO+k2o+0bygQhIGhWfq7TaEa9WqANqlI7mmVsfMSF0qZNzcPlltOoAVs
         I8Mp1/TSHXvcuFXEbEgoIIhPDn3Uxn8Ikmeayx/ODzMdUUgxChAtT6pUlKnBFAE32zdq
         2dn/Tp+Tv/ql+VZbNA6UPSewRqMGu/hxrQMEhb3ec4QJTNSVEzDfM+Ll4BV1rBYPaK7C
         1DRizn4vqRINxWBhFAtfhrmIOlKgKoUXg65GUMDySn1DNLtPp8gaPkF5dlK3Ftio+F+W
         akMpSG5w+8+GQgwJX+gp4CMKiS3CN8WJvu1hkaIOBaJfFgk5jvohba541R5Z1zDZMRLj
         a+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=piUn98E4ME5UBI+7tZ+viN5QHlPKU6ns1OxTVYHw8e8=;
        b=hvbj2K/+IKQYuXBdqehiv28iYpocG6Woz0UTZpKx8ysHZrcFZLNo5VCZgnoCV1hHLT
         g3ysc1+cVTE0l7GV2SLHQAJ2qMrciSagxoYljbBgXBH2EMbWfNoRvfUz96G/HI5gHmBR
         OjjCQnndfGkI0zVxdy7ndUL6rURtqEWw9AdXQOrBH98WkjYPhQizc3tm3F4PPGLaW9oC
         6Ly752qfmmHYnRft6ipV5v5GSNn7t7MsT2PmNOKhOWQoUgYTMwdeSn8qnmvT9V0S+Opt
         JuTDqAZbr32IMMZIBv6ODU8wBw477RY1JSChMrI369MEhqj8ydCFbz4MSm3Gw6hDcAup
         CzpQ==
X-Gm-Message-State: AJaThX57WcasBtMJY4Qx5BA38AleolCTw7PwVgi2QnvN65/F/mJAck2+
        O8y/2m1ruHgmkT1eRNBm0mtG8RrPtX9l/OIe0ns=
X-Google-Smtp-Source: AGs4zMYk0xpXfu/97yUVBriTbv0/ZTKYcSTkkhFPu4Udc4BWJoeSxurix8tXG1/pI3yMgAb7GHfnwH6LXkJ1mh593qY=
X-Received: by 10.55.126.7 with SMTP id z7mr17893652qkc.306.1511734140185;
 Sun, 26 Nov 2017 14:09:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 26 Nov 2017 14:08:59 -0800 (PST)
In-Reply-To: <20171126193813.12531-2-max@max630.net>
References: <20171126193813.12531-1-max@max630.net> <20171126193813.12531-2-max@max630.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Nov 2017 17:08:59 -0500
X-Google-Sender-Auth: vIiYD7WTv2NZcNxt5Fm9Z6krgAI
Message-ID: <CAPig+cTuBRzoxtmp1_MQ3fUxC5LXpyFPAaEOL7z96e_Szfqn5w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 2:38 PM, Max Kirillov <max@max630.net> wrote:
> [...]
> Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
> the whole input until EOF. If the variable is not defined, keep older behavior
> of reading until EOF because it is used to support chunked transfer-encoding.
> [...]

A few small comments below; with the possible exception of one,
probably none worth a re-roll...

> diff --git a/http-backend.c b/http-backend.c
> @@ -317,6 +317,54 @@ static ssize_t read_request(int fd, unsigned char **out)
> +static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **out)
> +{
> +       unsigned char *buf = NULL;
> +       ssize_t cnt = 0;
> +
> +       if (max_request_buffer < req_len) {
> +               die("request was larger than our maximum size (%lu): %lu;"
> +                           " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
> +                           max_request_buffer,
> +                           req_len);

Unsigned format conversion '%lu' doesn't seem correct for ssize_t.

> +       }
> +
> +       if (req_len <= 0) {
> +               *out = NULL;
> +               return 0;
> +       }
> +
> +       buf = xmalloc(req_len);
> +       cnt = read_in_full(fd, buf, req_len);
> +       if (cnt < 0) {
> +               free(buf);
> +               return -1;
> +       } else {
> +               *out = buf;
> +               return cnt;
> +       }

This could have been written:

    if (cnt < 0) {
        free(buf);
        return -1;
    }
    *out = buf;
    return cnt;

but not worth a re-roll.

> +}
> +
> +static ssize_t env_content_length(void)

The caller of this function doesn't care how the content length is
being determined -- whether it comes from an environment variable or
is computed some other way; it cares only about the result. Having
"env" in the name ties it to checking only the environment. A more
generic name, such as get_content_length(), would help to decouple the
API from the implementation.

Nevertheless, not worth a re-roll.

> +{
> +       ssize_t val = -1;
> +       const char *str = getenv("CONTENT_LENGTH");
> +
> +       if (str && !git_parse_ssize_t(str, &val))

git_parse_ssize_t() does the right thing even when 'str' is NULL, so
this condition could be simplified (but not worth a re-roll and may
not improve clarity).

> +               die("failed to parse CONTENT_LENGTH: %s", str);
> +       return val;
> +}
> +
> +static ssize_t read_request(int fd, unsigned char **out)
> +{
> +       ssize_t req_len = env_content_length();

Grabbing and parsing the value from the environment variable is
effectively a one-liner, so env_content_length() could be dropped
altogether, and instead (taking advantage of git_parse_ssize_t()'s
proper NULL-handling):

    if (!git_parse_ssize_t(getenv(...), &req_len))
        die(...);

Not worth a re-roll.

> +       if (req_len < 0)
> +               return read_request_eof(fd, out);
> +       else
> +               return read_request_fixed_len(fd, req_len, out);
> +}
