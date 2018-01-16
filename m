Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA131F404
	for <e@80x24.org>; Tue, 16 Jan 2018 22:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeAPWNb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 17:13:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55136 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeAPWNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 17:13:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D898DB5E10;
        Tue, 16 Jan 2018 17:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O6EXOJaj2xy7
        RTwCLtoI4cmnqUQ=; b=dJKDRYHKInSBflORmNxZzTAwCkTZLgae2NGHxu5P2TAB
        CfYYH98TTYOSggvEBPcCnRhjygsFYNRJjy8xEKyTU0r3dg4cAvLp8NfeQNVjiAlz
        TVxFKp2sBwHe+XF266NHcKy294xhTD92aoDhMyDOTxPyPpF+IK5EAJ558Wz3h6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aFdITG
        aQRsp1Gb7Lj3e+yiBru8WJDdIzrACTDW8KaXermuGP2sT22mCe8ux6rfnTg7+nOb
        LtpYBdQAS0OVGTWzh6uF9E2FmBDc2GKWZzkp5WSSH4FWlJw01nkiKaDSfnCmy9Wl
        PnIJdtFCd6gUxdXKM116RjhQq2g6UcIe0yy4E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CED16B5E0F;
        Tue, 16 Jan 2018 17:13:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42BB4B5E0E;
        Tue, 16 Jan 2018 17:13:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 6/7] trace.c: print env vars in trace_run_command()
References: <20180112095607.18293-1-pclouds@gmail.com>
        <20180113064949.6043-1-pclouds@gmail.com>
        <20180113064949.6043-7-pclouds@gmail.com>
Date:   Tue, 16 Jan 2018 14:13:28 -0800
In-Reply-To: <20180113064949.6043-7-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 13 Jan 2018 13:49:48 +0700")
Message-ID: <xmqqmv1dtptj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B2DA158-FB0A-11E7-ADFF-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +test_trace() {
> +	local expected=3D"$1"

Style: "test_trace () {" is how we start a shell function.
Portability: we do not use "local".

> +	shift
> +	GIT_TRACE=3D1 test-run-command "$@" run-command true 2>&1 >/dev/null =
| \
> +		sed 's/.* run_command: //' >actual &&
> +	echo "$expected true" >expected &&
> +	test_cmp expected actual

Consistency: everybody else in the test script contrasts "actual" vs
"expect" (they happen to be of the same length ;-); don't say
expectED just to be different.

> +}
> +
> +test_expect_success 'GIT_TRACE with environment variables' '
> +	test_trace "abc=3D1 def=3D2" env abc=3D1 env def=3D2 &&
> +	test_trace "abc=3D2" env abc env abc=3D1 env abc=3D2 &&
> +	test_trace "abc=3D2" env abc env abc=3D2 &&
> +	abc=3D1 test_trace "def=3D1" env abc=3D1 env def=3D1 &&

Portability: "VAR=3DVAL shell_function args..." does not work
everywhere, unlike "VAR=3DVAL command args..." that exports the set of
environment variables for just a single shot invocation of the
command.

Running this script with dash fails, even though bash does behave as
you expect.

> +	abc=3D1 test_trace "def=3D1" env abc env abc=3D1 env def=3D1 &&
> +	test_trace "def=3D1" env non-exist env def=3D1 &&
> +	test_trace "abc=3D2" env abc=3D1 env abc env abc=3D2 &&
> +	abc=3D1 def=3D2 test_trace "unset abc def;" env abc env def &&
> +	abc=3D1 def=3D2 test_trace "unset def; abc=3D3" env abc env def env a=
bc=3D3 &&
> +	abc=3D1 test_trace "unset abc;" env abc=3D2 env abc
> +'

Taking them together, here is what I'll be queuing on top to make
today's push-out to pass the tests.

Thanks.

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index e6208316c3..24c92b6cd7 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -141,26 +141,41 @@ test_expect_success 'run_command outputs ' '
 	test_cmp expect actual
 '
=20
-test_trace() {
-	local expected=3D"$1"
+test_trace () {
+	expect=3D"$1"
 	shift
 	GIT_TRACE=3D1 test-run-command "$@" run-command true 2>&1 >/dev/null | =
\
 		sed 's/.* run_command: //' >actual &&
-	echo "$expected true" >expected &&
-	test_cmp expected actual
+	echo "$expect true" >expect &&
+	test_cmp expect actual
 }
=20
 test_expect_success 'GIT_TRACE with environment variables' '
 	test_trace "abc=3D1 def=3D2" env abc=3D1 env def=3D2 &&
 	test_trace "abc=3D2" env abc env abc=3D1 env abc=3D2 &&
 	test_trace "abc=3D2" env abc env abc=3D2 &&
-	abc=3D1 test_trace "def=3D1" env abc=3D1 env def=3D1 &&
-	abc=3D1 test_trace "def=3D1" env abc env abc=3D1 env def=3D1 &&
+	(
+		abc=3D1 && export abc &&
+		test_trace "def=3D1" env abc=3D1 env def=3D1
+	) &&
+	(
+		abc=3D1 && export abc &&
+		test_trace "def=3D1" env abc env abc=3D1 env def=3D1
+	) &&
 	test_trace "def=3D1" env non-exist env def=3D1 &&
 	test_trace "abc=3D2" env abc=3D1 env abc env abc=3D2 &&
-	abc=3D1 def=3D2 test_trace "unset abc def;" env abc env def &&
-	abc=3D1 def=3D2 test_trace "unset def; abc=3D3" env abc env def env abc=
=3D3 &&
-	abc=3D1 test_trace "unset abc;" env abc=3D2 env abc
+	(
+		abc=3D1 def=3D2 && export abc def &&
+		test_trace "unset abc def;" env abc env def
+	) &&
+	(
+		abc=3D1 def=3D2 && export abc def &&
+		test_trace "unset def; abc=3D3" env abc env def env abc=3D3
+	) &&
+	(
+		abc=3D1 && export abc &&
+		test_trace "unset abc;" env abc=3D2 env abc
+	)
 '
=20
 test_done
--=20
2.16.0-rc2-179-g03f5267cd7

