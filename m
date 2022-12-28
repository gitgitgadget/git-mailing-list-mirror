Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF29C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiL1SKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiL1SKg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:10:36 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537FF24
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672251027; bh=GC1qXQWuFBF9ONqnPOJPHqJsR2DSmMU7+8DAvSahswM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BNU7nAhP6DT1nU3pVzmDtojaBayMH1V4U0wLbtvrP2LWBe1cUtIw/NTY7mAXjUmxl
         s23sN93eqBgNTjDwQSnnfuhFDMUvinT7TBoFQ/smhm/7p4rBqrGdhM6eQAaIZido+9
         JbA3BwJf7wdPuQnMuw6BTAivljlmhWs8GjqsPoJ0mCqBoOWEysFtHyTPjERGfTlSR7
         8e1iG+eEab/H4SwUAjap43y+8H0qpA2vrafeGd0g0svuoKwNlHxcpFqCESSxENLWdU
         h2qEIOgqNcN1IO95Ytpr7wlJhDKricu66EhABZ4rPxEmz1WCXbz82Ci1OH3vAbM7mo
         XRwn953n0fmCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1okz7w0WtH-010B9J; Wed, 28
 Dec 2022 19:10:27 +0100
Message-ID: <c1d75914-9a73-b61e-c9a1-fe7c95129c9f@web.de>
Date:   Wed, 28 Dec 2022 19:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 04/20] commit-graph: use free() instead of UNLEAK()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-04.20-5be87f9720c-20221228T175512Z-avarab@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-04.20-5be87f9720c-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ytQxjwRPzATRyxMcfDYoUAxcPUN0PnnyTBPivaXOzYVe7st+6Tp
 LJuCPxS2n262p8ynmOKMz/dmaWrmBYdDcMJQq9oVMAdFXHflbWHa0plu6gnfIMcZGbCjnue
 G6jbtc72XQ32f91Lmg04PVOnQ4prVAr3DOWs0S7YHcCAwolhv0yyZlxRM3jFjmM23SfccpD
 FaliGDP3luOmTRlyim1gQ==
UI-OutboundReport: notjunk:1;M01:P0:JyB2R64UOGQ=;FXy5t4m4ow41Hj6b8gCEpNaKvjV
 YSh/tZi0LjT0WJ+TLKdYxB/srS4YhYijZSHYWG3Xs2rxcy/XG1tWkGTxLyvmhXTm7M0OYhys+
 9qbd5+toJMjIpyjZI0OUvCubcGlLcg5uHUsIRfNkxvgCbCHV/LgXSMxkHPdG3QH3YwsrUQ3Ik
 /AKlBsz7LY1YmGY57G6VRAMc88IId0tfK+BW+ycQXVF8FiQHCzGK1tNSEnQ4O8nkPORl/b/E8
 fOduJqIl0Dst5BRfSJHK4Awe7FUwCLw7pVBPzrqYycd256wN/BzVJPL9n3JAR4PFLJOd6KI6d
 /Z3n77MqgeA2A5HQWSE+ShYVhAonwfWTVykWuUXsroEmTlTXxyWuEswYfRtfKmxSjM3IQhXk0
 9EM4z6U8FdMVClLpCktiSbk4PUs9p2aMbwa2xW+7PVHrTNXDG8IOx8CJp8NLt7Z3CRlfPFxpG
 UcdxfJ1Vis5U+xVihU/32INn7dz01hR4qjVaMqAr713VkHwYX1GerEGubJaomIAT2bwhvLE5w
 nmYeKrs9kAgmDPnI/Ba+E+6RntjkemWp7ca0HdE4v/i3sQqV9Y7BNWuw8SedeGo/RYiNCmalp
 mpGz9igbegdouay5G+l9Ldt+Ctaxd3z4Ml90Q8bcLuHjMLYwzjwy49Wu9G6uJRvjeliibtYsk
 Y/2ll3OY6nnTye+ffPmTbcBB1OXCLuAi8IfNR3cS7O2ZbAWTeWma2fhBsRPmB5dQen8Wv8Cwa
 1NQtQb9qoQIY1etBnA5XvTldHLfRojMgunD3+YAKLP00o2M8x7flfgNj9S+rLvsnO9rGAbaXi
 Kd1Vcbw9BuUVJVmZ9rQimB7hVVDcKPnUV7073RX4WgDTdEmSgjS42GUGyqgWmEsZ1h7i83M3H
 HAQT9JU/e0Gtubsd16sVyZz7wKkMHqvOyAVliYNrlrKh4mFvQ9WTkHuBE0GEbZpOl3QHy5pG8
 XNSerG39/aXj+Z9eqg90EaotZys=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> In 0bfb48e6723 (builtin/commit-graph.c: UNLEAK variables, 2018-10-03)
> this was made to UNLEAK(), but we can just as easily free() the memory
> instead.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index e8f77f535f3..b6e5726b082 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -67,6 +67,7 @@ static int graph_verify(int argc, const char **argv, c=
onst char *prefix)
>  	int fd;
>  	struct stat st;
>  	int flags =3D 0;
> +	int ret;
>
>  	static struct option builtin_commit_graph_verify_options[] =3D {
>  		OPT_BOOL(0, "shallow", &opts.shallow,
> @@ -111,8 +112,9 @@ static int graph_verify(int argc, const char **argv,=
 const char *prefix)
>  	if (!graph)
>  		return !!open_ok;
>
> -	UNLEAK(graph);
> -	return verify_commit_graph(the_repository, graph, flags);
> +	ret =3D verify_commit_graph(the_repository, graph, flags);
> +	free(graph);
Shouldn't this be "free_commit_graph(graph);" instead?

> +	return ret;
>  }
>
>  extern int read_replace_refs;
