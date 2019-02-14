Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8EF1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfBNWr1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:47:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40162 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBNWr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:47:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so7716541wmc.5
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 14:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lwlrWdmeavdreqniyUrOQxch6oSYtRc2OAYmb5aaBog=;
        b=WCd8+i5SceaAx9A+lme31sUmWAnLuEKgfwwSr3YlikUnq7hXCU1WAnG9GkizWgGYUn
         v1Y5DQx19opSkx6GTCcsXnftHtg5gX2K6hWg8bq9AEq2KnRCsPMbO2fsXpPO1aoVB2gL
         pF7W/UXcHHEeHf6X/qYlFZ8Nwbx5bTFNYPyoM6oiJ3j86jbH3IbPDEHiVY6Y92od4Ez8
         0PKYlOKQyGi1u2wWPDmB99z53KlVEpVk7aQnPPM1kmOLNbU63bogPZTbvLgK67ks9njs
         yJx+6MTdNnU743CDwGbzKxA27LjpTZQ+KhTM/+k5y5OR+735aJ+M93e8wDwsridyMQng
         tsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lwlrWdmeavdreqniyUrOQxch6oSYtRc2OAYmb5aaBog=;
        b=Vfmn98gHlg/HqgUO5W7KtXLXTzSQXvaRVPMYekoX/VN4zoPqiEwz0ZBDyplIQG9knv
         QiOoXZMy+Ppdf85VjoXRK+u65EvIBHKF7TjI6RWObxfICtzFC+zhwGrtmmSAHZLVRkYN
         0qpDYhGekRpBSEueANbKa1DiY5kxcCdEkJq55ljsQS2Im/q9wVrw9Uir89bb/vhNsmws
         ILLrKrP9FDMka4V4FnvnySdadDIy3ApeaqcqBMpZCUTMJnirE4WNDX6g2EsV4QoAG3CK
         MdfqBOTrKJMUkh+pef1SmFixbP1HuE2TlSgv9JJBXIcOvnzx1i2XPSLHCI0WQvxCv828
         lAiQ==
X-Gm-Message-State: AHQUAuYUKxmwUvPk55it0ajVAy3c/9TfJWz1A41us0pi7PopRT4X5F9n
        41YDI3axd5JcJ/QIT+kBFq4=
X-Google-Smtp-Source: AHgI3IZNDsHw5e0V9E+gugXOdENFWbpF3BoB7uJoAYbDnwFXcPy+a1p408Prw3+CD8lMYkWnUbJ/9A==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr4048020wma.20.1550184445367;
        Thu, 14 Feb 2019 14:47:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h71sm7699006wme.20.2019.02.14.14.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:47:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 5/5] remote-curl: use post_rpc() for protocol v2 also
References: <cover.1550170980.git.jonathantanmy@google.com>
        <25ea75eb435ed8fed759b30a4c362a68818a8905.1550170980.git.jonathantanmy@google.com>
Date:   Thu, 14 Feb 2019 14:47:24 -0800
In-Reply-To: <25ea75eb435ed8fed759b30a4c362a68818a8905.1550170980.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 14 Feb 2019 11:06:39 -0800")
Message-ID: <xmqqa7iy6l8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +	# Ensure that the list of wants is greater than http.postbuffer below
> +	for i in $(seq 1 1500)

test_seq.

> +	do
> +		test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/big" "commit$i"
> +	done &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" git \
> +		-c protocol.version=2 -c http.postbuffer=65536 \
> +		clone "$HTTPD_URL/smart/big" big_child &&
> +
> +	# Client requested to use protocol v2
> +	grep "Git-Protocol: version=2" log &&
> +	# Server responded using protocol v2
> +	grep "git< version 2" log &&
> +	# Verify that the chunked encoding sending codepath is exercised
> +	grep "Send header: Transfer-Encoding: chunked" log
>  '
>  
>  test_expect_success 'fetch with http:// using protocol v2' '
