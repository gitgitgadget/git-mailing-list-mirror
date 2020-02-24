Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941CCC11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B6920726
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IDlvXfs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBXSGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:06:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64692 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSGD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:06:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21FB4C8F09;
        Mon, 24 Feb 2020 13:06:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5h395PdB3zaDJtZipEBxJtdpgIk=; b=IDlvXf
        s2GD5Pd+olFPYHKtzb/pSMb6oN6jJi3RGTLtsrMFvsISPjtfqX+UgB2pyPuqlkzs
        K43x7h9vw0qN7KOl1101z4LJqITeI0zt5OhoVF8ahqj84LdbiAfrCLqX4rKibbZi
        2Up8I2X6nUogGmInQ63qNECwRG+iLutK5uei0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cG/F56RPSRtCh9TcQfdfTq3T4aVr4Q0y
        n1rEoVOounLwrDNPn4xwQwDmhuQ0BODH5Rqip/NYM1pRU09FMezHFQ6yG4G6YYmn
        iYDFl1SZBc4erj1Xd26hTov9yHcuO+/T+F8Vc7i+p0IOFme6V2H1hyPrWQtupmQC
        mlNPj6ytNl8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C00BC8F08;
        Mon, 24 Feb 2020 13:06:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22BD2C8F04;
        Mon, 24 Feb 2020 13:05:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 10/24] t/helper: initialize repository if necessary
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-11-sandals@crustytoothpaste.net>
Date:   Mon, 24 Feb 2020 10:05:55 -0800
In-Reply-To: <20200222201749.937983-11-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:35 +0000")
Message-ID: <xmqqo8tnrhbw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EE056B6-5730-11EA-98AD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The repository helper is used in t5318 to read commit graphs whether
> we're in a repository or not. However, without a repository, we have no
> way to properly initialize the hash algorithm, meaning that the file is
> misread.
>
> Fix this by calling setup_git_directory_gently, which will read the
> environment variable the testsuite sets to ensure that the correct hash
> algorithm is set.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/helper/test-repository.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
> index f7f8618445..ecc768e4cb 100644
> --- a/t/helper/test-repository.c
> +++ b/t/helper/test-repository.c
> @@ -75,6 +75,10 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
>  
>  int cmd__repository(int argc, const char **argv)
>  {
> +	int nongit_ok = 0;
> +
> +	setup_git_directory_gently(&nongit_ok);

No need to initialize nongit_ok to any specific value before calling
setup_git_directory_gently() and I personally find this initialization
unhelpful to new readers, as it misleadingly hints the setup process
may be affected by the value passed in by the value in nongit_ok,
when in reality the variable is purely used as outout-only (the
first thing the function does is to clear it).

Was it necessary to work around a compiler warning or something?

>  	if (argc < 2)
>  		die("must have at least 2 arguments");
>  	if (!strcmp(argv[1], "parse_commit_in_graph")) {
