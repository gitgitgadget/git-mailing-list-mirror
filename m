Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0230920281
	for <e@80x24.org>; Wed, 27 Sep 2017 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbdI0F3J (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 01:29:09 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:47104 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbdI0F3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 01:29:08 -0400
Received: by mail-pf0-f175.google.com with SMTP id u12so6708364pfl.4
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 22:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1P2wnruewrHCOODL+KahPl/rLWJynR334M9T0+D/BCE=;
        b=EmnywWyZZnRqXb4yipwHkNS1hd3zj/wFevjGaFJnO8gzeAVKqFTZikEg/ABi0YSvJo
         +RLqkA0xMmuf0UojeVT16k/6im//N/KbrOkb0m+ARFK49eGtFciV2SHM1e/rYRG4ccFK
         /zzkiUngdmZ0d9XDnYmCq2NxUwce4OU9gdY/5aO9r1nXUs4ONq7t7rtLBwrQf7cw5o/Z
         KmHT/o9YXKsZz1IfxX50W3YRCDH7Mo49AczlzgVA+JTpjnIBeGNTKy8kZzBJESs3T217
         ybXvq8LYvxQwNFEtvNja/KZmeYtXN3Ipkbxgcaa/g3WTbOxMmFfEXSl6S6GwLCz8jgdb
         28dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1P2wnruewrHCOODL+KahPl/rLWJynR334M9T0+D/BCE=;
        b=HGhlMMy9fN9WBF9L76u72hTQX5wZSjQlmGm2cx9p4H7IotKZ17n09MdSk39qZ0kZNn
         gcRf7xceMIvJRJ9aNm41PtfIEyNv4MRhOO5OBwkB4jZwsxxYal7Z6JOjGRwVaHATiDXM
         MzvE6CXlPOY9tRUOcAmGyoAjiiBYYvXssqmfmBp7BWk9BVRUtzYQC34J/NIT7GWfJNjY
         knEzL4vTE+juQV5FfdHEOuJuzaTblNHavjYW+gi+ytIlXyOsW1Lt6ETfLwRJYNSe8+3F
         wnX8mpAZrb86xElRf7fPesaGL3tT8uhTCb43FqtbqVer/5PvTia2Mk6SD4Otp/yFM8s9
         1sig==
X-Gm-Message-State: AHPjjUg6iAdxjQJpKl2G6XCcPnNsu83hfHCpzlcmsL+srAzrhiJb8s5X
        4hMznoFAizu0AMZwQbXbf70=
X-Google-Smtp-Source: AOwi7QBwU2fmxTQGhBgqtoR4155WpFLbiB1/R3CYEx6TIt5TCp8DIiE6MVr5pG8KH8GYJMMbDE0eHA==
X-Received: by 10.84.225.130 with SMTP id u2mr248255plj.334.1506490148002;
        Tue, 26 Sep 2017 22:29:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id w188sm3248316pfb.67.2017.09.26.22.29.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 22:29:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 6/9] connect: teach client to recognize v1 server response
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-7-bmwill@google.com>
Date:   Wed, 27 Sep 2017 14:29:06 +0900
In-Reply-To: <20170926235627.79606-7-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Sep 2017 16:56:24 -0700")
Message-ID: <xmqqpoac676l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
> +static int process_protocol_version(void)
> +{
> +	switch (determine_protocol_version_client(packet_buffer)) {
> +		case protocol_v1:
> +			return 1;
> +		case protocol_v0:
> +			return 0;
> +		default:
> +			die("server is speaking an unknown protocol");
> +	}
> +}

For the purpose of "technology demonstration" v1 protocol, it is OK
to discard the result of "determine_pvc()" like the above code, but
in a real application, we would do a bit more than just ignoring an
extra "version #" packet that appears at the beginning, no?

It would be sensible to design how the result of determien_pvc()
call is propagated to the remainder of the program in this patch and
implement it.  Perhaps add a new global (like server_capabilities
already is) and store the value there, or something?  Or pass a
pointer to enum protocol_version as a return-location parameter to
this helper function so that the process_capabilities() can pass a
pointer to its local variable?

>  static void process_capabilities(int *len)
>  {
> @@ -224,12 +239,19 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	 */
>  	int responded = 0;
>  	int len;
> -	int state = EXPECTING_FIRST_REF;
> +	int state = EXPECTING_PROTOCOL_VERSION;
>  
>  	*list = NULL;
>  
>  	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
>  		switch (state) {
> +		case EXPECTING_PROTOCOL_VERSION:
> +			if (process_protocol_version()) {
> +				state = EXPECTING_FIRST_REF;
> +				break;
> +			}
> +			state = EXPECTING_FIRST_REF;
> +			/* fallthrough */
>  		case EXPECTING_FIRST_REF:
>  			process_capabilities(&len);
>  			if (process_dummy_ref()) {
