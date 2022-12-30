Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DFCC3DA7D
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 16:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiL3Q1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 11:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiL3Q1B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 11:27:01 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF3C3D
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672417613; bh=5wit03cZkdpLlOnvEAVzGlgEOj57eUEuwAjT5MWRuAY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=n3s4/RkV5/DH3W87YdyhHkiiFknRjVgkbblQ0Sgth1TCefH3yoO8b4PHPpjZaXcEL
         0mmS1twx50jTO1E3C/TyMGydvCvltL6VGcFdHGYEHxZpvayxyVf1CaGnYg00daTmGA
         R37OpEeENN6VDhZ7ZKsk/oEVm9DvGCFEV6wDu+Aapd9ndDsj0n4nCa3j12qm8BFdZ6
         r9vIeeegDllHQ2SEmh4M+cjz8PXdz+fQBFIHoIFiWQO9GUH9X68p9KR3GY/Csj7bso
         Kqc+z8S/kW5NwbQJ7tOSvto4eKUNtTHZRZlnpRa2nV/olgNGk/ES4pyhcgi+Blkwgu
         nhj8EVLykeGVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1ot4oQ3831-00rO1e; Fri, 30
 Dec 2022 17:26:53 +0100
Message-ID: <64923db2-fa0c-5ca3-6a43-ba215b85509e@web.de>
Date:   Fri, 30 Dec 2022 17:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 03/20] commit-graph: use free() instead of UNLEAK()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
 <patch-v2-03.20-a840a1cb330-20221230T020341Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v2-03.20-a840a1cb330-20221230T020341Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g58C1Inx1scJyxCYtjbw4NrLt8W1JoJux5epJKVCfP8tR3r/4IF
 ALTCSQtu/qcSmXke3HMVbBbaNh99LCffoG8QLM/8W1l6w+t0nT5Sk8nHsCWXW/enzmoaY6/
 7jHwWUv2PmP9YDT7Qnsaf+6YNmkpAs+wj+gPlrbYdpqbME0KW+pVxpeoYi73QfI5NN1bXCb
 5sIIutVae0Rb2V1lYCeTQ==
UI-OutboundReport: notjunk:1;M01:P0:eB7eFbysOFk=;8PMmUWNR22J46jQarpPcnsNChY3
 glTR96AjoGOpNKQSWopYPzrLoI2vmrgDpGg0dYoHl2/WHRMV6ygOM/Tmqf6dgcV3bvNqnocNU
 9sUS8ruHRlzXgnpfeHpLkIs+yEPkQ7GeCgZUbxnLvaSITtocCf6sr3WTFtwOBrP5hGVQbghFs
 42kzGR3klbG4+PCz41Wh9VMv6eeDNcl+8frhVr5QkkHsMsZfdO0ufr6ZxbPTkthX5VWuVt5Lh
 kXVRHCrQTJtw7Y1LKk2o5aNOWu7kJb8HbpL+RoXoPfJzFzdYodwtZNPN5yLCnejZ4gu1kTkj7
 hwILxUEuqrb+xlfiuK2nS2FIIxoodVoQHq/hwLqJvTeYcGnFzX25f+ipkJCcSMciDtIyrzMJM
 rcWLArJo5TygedoomicTWKfQZABfvES0/EKIUbq3jv9M5B/2761obw8B5AjaJo8JombcSakjd
 mwBDGo+p/EIjalv8pSlYtwZHiSr0VjEhXASuszmGuLJ7M3GfP5UA+VaIkunhIoub9tOYc52SR
 91DGDGMBK3fOrvtclT95Q0lZZAebzapV7rSL4Zmo0a7Qb2r5r0cQEXztw1mq7mVzAtDIufkcW
 Q9hqina6oTQB8r0CgJ20KcNBj9vrUd6JRKafuFbz3d2m0aNszwiUHpvaJI5Jmfc+nRxSLhF26
 Eq9nBWuGYBUCmAsLaJhYBhTbChF9LeMw0bk7WE1KHghFFu8g+NMaaqtN43o76aI/Nsy3kzvTn
 G8T/5piH4Xlxr7juwYaZ4ZOq+lxsDJFp5PU92F5D0vP7IFVQkeChIRR5ircRMCM+19b8oQv//
 LpWwCsw3uYRJ/+h6vJkomPurU3kRUbjJPOpZ40Q/k+2KM8vx3v7tbpqdR+/VsY/IZlCZz0HY3
 o0v7mhepLA49xqfWOq4GS7CzHdHvKvf05P/eTQHtboG3jEYvfZyyoVG3RwWRpvnehteJ2CGzw
 SjTs+g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.12.22 um 03:18 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> In 0bfb48e6723 (builtin/commit-graph.c: UNLEAK variables, 2018-10-03)
> this was made to UNLEAK(), but we can just as easily invoke the
> free_commit_graph() function added in c3756d5b7fc (commit-graph: add
> free_commit_graph, 2018-07-11) instead.

Patch and commit message are about free_commit_graph(), but the subject
still mentions free().

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index e8f77f535f3..0102ac8540e 100644
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
> +	free_commit_graph(graph);
> +	return ret;
>  }
>
>  extern int read_replace_refs;
