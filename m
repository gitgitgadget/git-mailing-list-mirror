Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F918C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68FD6113A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 08:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhDJIMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 04:12:20 -0400
Received: from mout.web.de ([217.72.192.78]:42017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhDJIMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 04:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618042321;
        bh=YElSxS7kgZZhrmWXcjdzf6l0NsPYhNM6N5B9Ht/udEI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j2JgCL9swNU50LyeedNA1N00bbHaC2h8w5SOQg81lpslnU3FNK0z/+7lt1Hf4YRHi
         hhtaWAH4ZonnkPtNv27QDmOpISeYSlFetsdHxRX02E+7TFNbPf37EM0T/HeKOj0HDP
         QCdhJ0NpV9AgpW0wJOIXEAmct0mZURqtq1a8C9TQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M6pYS-1lUYtL2aq6-008Gsu; Sat, 10 Apr 2021 10:12:01 +0200
Subject: Re: [PATCH 03/12] ls-files: free max_prefix when done
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
 <beccdb1778697a2a46b81c85fc91c477c040397c.1617994052.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6a72a920-134f-541b-7caa-debe24658005@web.de>
Date:   Sat, 10 Apr 2021 10:12:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <beccdb1778697a2a46b81c85fc91c477c040397c.1617994052.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YGc9avVJyDPU5C8SbYFS/e8qhXar6982xPKjZSm98oWq4rKnZND
 uYO4Iox3Wwc2WkJ/+qJqvUVd4XJbSPKN010qp30XU/ssuBQ9BIL8chbr66sSNBzhWuvSDt/
 7417yiwJZbZ+6+0gD+XN1+Otd3aG9HHx7KmWbf+aeLZYHq+VrYlBwl+NLHCnPrlNAk82MGQ
 qWvFY5Dd1EYE6tO9v7a0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQKOjZjQdHE=:xW+t38mcCYAma/IG1VNIog
 zC6Cj2L2Avi/UPNH4zzYhb15NrtRSY0I4qZj+AspdRFwTb7Ic6R3QZsznhB2sMc5KitZFYRmg
 nlQz98R6H2pYI8g1qCewtBoUr4vxQ83v50TWhXCaSsNHwWzeIKmVNzaHekXBYaY4Dmksz7WUM
 3QrHfABf5M+yVYvRcP2eYRgi54Ab/6DFhrjAT98/15Ns7HC3XR6hFYABBDPPceXWBbWERz5fJ
 9HKbMbjf5JNnc7CzFblo5cInoLwXqbgdmosFCapWT4G2RyTQhUoGOvBfn4Ov5AN/qGqhUGeuB
 wlesy5r+ZB0np/syc5SsAM5doX0Rpo/3k4HxDo3YJps2aEhClyLGcP+OVkSjlGgok95uO2u1E
 ylTq66n10EO+Fvceih2GY0FVgViCwDTazPg8qIrmaS+k2z/TZjf0lCjFFc9Yt4vyKoAF4oiEy
 fDuCYiZNIEvPh1XgkzX66FJCWYkxskSLBDIguF6q9uZJUX6r8shZKfMGbmRcGaozgJ2eK0b0o
 pbePgBzbz9vnF2DXtUDzG3ft34bSrKWBwby34a2Q/K52drwq7hLrMrS7ObUAtIvOZORXwKhTE
 ffKlVCwg9NrA7szqD8FAwz5qwLCo94SFwKIJH0OsFQsoT10TSSxiXtWvKzgz+Ji54yLRFznsT
 M3UD4yNJq+c54Uap98QBI4oF6hQcKTB65LcT/sw7EJVgTk++/79Vz6aOBwFyt+1gwvoveg/rp
 Fk4XAlb8ukB4VrND9vU55c0ZGO2G1/PCLWl8Z7FtzpQIvxB3oiWzt8zWOnU0Pwf6bqv5j+LMG
 Fe/Xz0dLBZKMjjQpS6UlCh1qUPyNBzKcK9RpLi27LWJLrBQpA2yEWkKyX6r3C9DNKomxNwS2g
 DBvxTWFVVXAn2j4404Zsxjz2ikFYU5jFv34rlSD7y1puA0KLs6EbQ/uD+9v0FyCoccB9367Ay
 aCdAGXMnySvhCL5Pm0iu7xcgfXGFakPsE1GW7Ui6w4doQeIaCHV/xnzbP0JSZq7R/PjhoDqdQ
 bW57dN43Z6Tb9J0Qln1zTE296wfBZDfv+xqZEwbka22GIBkZaEqDl1EBi4IjA7y1BsOa3Geby
 oDWspXyBQGgwbf4MVtZoRz5hig/k+PoOnyFQV2okKDIuFRsK6ewoIc3vklkB5sjQpY8GfK+th
 g23cyVD4QacPV6NhVBgqiaPtoiGdCzEiIQybVCXUrcv2i1OVrH/uzXTaxzP1SUigQ8GF0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.04.21 um 20:47 schrieb Andrzej Hunt via GitGitGadget:
> From: Andrzej Hunt <ajrhunt@google.com>
>
> common_prefix() returns a new string, which we store in max_prefix -
> this string needs to be freed to avoid a leak. This leak is happening
> in cmd_ls_files, hence is of no real consequence - an UNLEAK would be
> just as good, but we might as well free the string properly.
>
> Leak found while running t0002, see output below:
>
> Direct leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x49a85d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/bu=
ild/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
>     #1 0x9ab1b4 in do_xmalloc wrapper.c:41:8
>     #2 0x9ab248 in do_xmallocz wrapper.c:75:8
>     #3 0x9ab22a in xmallocz wrapper.c:83:9
>     #4 0x9ab2d7 in xmemdupz wrapper.c:99:16
>     #5 0x78d6a4 in common_prefix dir.c:191:15
>     #6 0x5aca48 in cmd_ls_files builtin/ls-files.c:669:16
>     #7 0x4cd92d in run_builtin git.c:453:11
>     #8 0x4cb5fa in handle_builtin git.c:704:3
>     #9 0x4ccf57 in run_argv git.c:771:4
>     #10 0x4caf49 in cmd_main git.c:902:19
>     #11 0x69ce2e in main common-main.c:52:11
>     #12 0x7f64d4d94349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>  builtin/ls-files.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 60a2913a01e9..53e20bbf9cce 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -781,5 +781,6 @@ int cmd_ls_files(int argc, const char **argv, const =
char *cmd_prefix)
>  	}
>
>  	dir_clear(&dir);
> +	free((void *)max_prefix);

This cast is necessary to ignore the const attribute of the pointer.
It's scary, but safe here because this function owns the referenced
object.

I think the promise to not modify the string given at the top of the
function is not worth having to take back that promise forcefully at
the end to dispose of it.  Determining the correctness of this cast
requires reading the whole function.  Removing the const from the
declaration (and the cast) would improve readability overall.  Thoughts?

>  	return 0;
>  }
>

