Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEB4C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiL1Tph (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 14:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiL1Tpd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 14:45:33 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6953C120B7
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 11:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672256725; bh=ZyR4wR+uc0pfDgxmBXz+gwUJHDMHwIe4aWLA66u+KPI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PeRK8ZaFuYzcfIcD2DnhzhaZEhLCENL9QB+YOdaQySv1dEoC6hzy0/IaAyAOSPFd1
         AFqJWHNNf8FTXma5IyJGMqbsMsyF5VPpAeNoO5WiDc+6FkJ/9sBwkixDIYVZaWqMGC
         vVNdFeIarFHJNqx0JTQUdFXBmU9NPvuAqnR3VIc8NSAcyct3i0m8dA1IDPCCDnpRWw
         6JUwjNwyIg6r+ruVj/oTyIcPg5sX0oiUjsBitGbDuGaE/5s93AaH0NC+C7f434jHsS
         Z69cuzl7rTk/p1enA2J/UmvsKiw71wtnxxpG+T5ezRzsAuW63wYslFAoNRSQU4YPXX
         SXmfKxXfxPgMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qvH-1owVHs1ms9-00wLTF; Wed, 28
 Dec 2022 20:45:25 +0100
Message-ID: <ac9621a0-1046-30de-872f-0171412049bd@web.de>
Date:   Wed, 28 Dec 2022 20:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 07/20] stash: fix a "struct pathspec" leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-07.20-e5a0134d1bb-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-07.20-e5a0134d1bb-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aytun2Yjv4/cTyN0YhVMNcSwHzDHRr0fob9d4a3jVO3socGGcO+
 cJK3O92cgjLpx4S+BSq/NujmHMCElFXEkv8Jnc0aMXETHyyCq4ufLmJ61UH2JeiBZntxjJC
 fDS3WrcBcUrb254h4O8SEOtymYJPa+le87vWw6LKZFleR9Ri82ZndKeJHLE8sX3mAVL2rSZ
 8dTh0u8xGPzXbpIHrMNtg==
UI-OutboundReport: notjunk:1;M01:P0:jHTvZXmq7qM=;GZaC3TJGjYvRab32udoPrkpgMwj
 v4/a6b6fgYJsDuDHmaoj8MasS9lW/wBWBLMxxJKJVZPcfX7L++C/hFW02o6cHQQMFZykQogfu
 V5n1JbZHcikss5icOb689WTDG5FFcHvcnKWi/+6JAcnGuArPkvu/G9k5J8MemxvQYgdzOgpvM
 hAvUdWqQZ6MoDci411yeR21CisnKK+QncxgGS/vHyrABKcdWjueDqZs4yF3e0ZW5OJIz72uga
 POUEbtVmi5fydbNjsYcrhoZhY6MO8J8Ia3rLLMd9nbXSRJsCsMnRWzXgHnbN2FacqZupHR1lr
 h23GFtjNakcdA3pMbXL6EUv+GmMhoJwZsNhIJFSzUuojcPhbrfXFsCQjWWu6FsZgXKBtoaAat
 BiQR69cUG+rtuhU3r/pSdsqdGK2swB4BaodrcJqBU1BwKiukOgAqqnHnH5TYzc4k32DwDb833
 opyyIJbHYYjiCOOBPhtkXC5KVQ1Uwt3RCv0Dgz8sYiT1NsfFtRg/bIbd8zL1U2R8Xm3Lt6qB7
 4vyRDjT3S9/9h3+D+UMOxh74h7aU+EyEGa/nF89023SHceIowiM3saAKnBwMmk7L8dECH4LW4
 cviWb5AKA4V4Te/LgNTopzNWIh3dhW9ntAVaRRQDVXwm6T2/r3PBsdY1k2nP1zv+ImtZEAWA1
 r+azwSYGQcM5vtrdpHP+ndguHFLU2StsVmXbiqkCfQMmd4Yg6+2TOqyNvBgwYBM4mA6OV5yLj
 X8t0dXDc/RxWoLyDQMZhaqFiZQZhb4y90vMgEjNZaqBG2DozdcwG9FuMdAd5yVBNA+Xe2rpjx
 RyuMiz7nye0caHh9Np+6YihDV+aUptrxrkJeyjA+D94TpcpoH+e3aoEEWK2hEUPwcrjAc7DGc
 AzH981b3X866fu1lXXmUoJ6C6tNLXdtErJQ6u+e88/EiOSOKemcYTV1js774TxhbkHHOcGKgT
 h16CGg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Call clear_pathspec() on the pathspec initialized in
> push_stash().

This puzzled me for a while.  This patch adds an {0} initializer to the
declaration of the pathspec.  I assumed that this is necessary to avoid
giving clear_pathspec() an uninitialized struct.  It isn't, though,
because the pathspec is handed to parse_pathspec() first, which
initializes it.  So you can safely drop the first hunk.

> Initializing that structure in this way is already done
> by a few other callers, and now we have:
>
> 	$ git grep -e 'struct pathspec.* =3D { 0 }' -e memset.pathspec
> 	add-interactive.c:              struct pathspec ps_selected =3D { 0 };
> 	builtin/sparse-checkout.c:              struct pathspec p =3D { 0 };
> 	builtin/stash.c:        struct pathspec ps =3D { 0 };
> 	pathspec.c:     memset(pathspec, 0, sizeof(*pathspec));
> 	wt-status.c:                    struct pathspec ps =3D { 0 };

Not sure if this part of the commit message is useful.  It seems to
suggest that the only place to initialize a pathspec with memset is
pathspec.c itself, but there are a few more.  Here's a really sloppy
way to find (some of?) them:

   $ git grep -e 'struct pathspec [^*]' -e memset --all-match -p -n | awk =
'
      /struct pathspec [^*]/ {
         decl=3D$0
         declfunc=3Dprevfunc
         var=3Ddecl; sub(/^.* /, "", var); sub(/;/, "", var)
         next
      }
      /memset/ && declfunc=3D=3Dprevfunc && match($0, var) {
         print decl
         print
         next
      }
      {prevfunc=3D$0}'
   builtin/log.c:726:	struct pathspec match_all;
   builtin/log.c:737:	memset(&match_all, 0, sizeof(match_all));
   builtin/ls-files.c:572:	struct pathspec pathspec;
   builtin/ls-files.c:600:		memset(&pathspec, 0, sizeof(pathspec));
   builtin/stash.c:1469:	struct pathspec ps;
   builtin/stash.c:1474:	memset(&ps, 0, sizeof(ps));
   builtin/stash.c:1787:	struct pathspec ps;
   builtin/stash.c:1813:	memset(&ps, 0, sizeof(ps));
   merge-recursive.c:479:	struct pathspec match_all;
   merge-recursive.c:480:	memset(&match_all, 0, sizeof(match_all));
   sparse-index.c:364:		struct pathspec ps;
   sparse-index.c:388:		memset(&ps, 0, sizeof(ps));

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/stash.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index bb0fd861434..e82fb69c2b3 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1708,7 +1708,7 @@ static int push_stash(int argc, const char **argv,=
 const char *prefix,
>  	int pathspec_file_nul =3D 0;
>  	const char *stash_msg =3D NULL;
>  	const char *pathspec_from_file =3D NULL;
> -	struct pathspec ps;
> +	struct pathspec ps =3D { 0 };
>  	struct option options[] =3D {
>  		OPT_BOOL('k', "keep-index", &keep_index,
>  			 N_("keep index")),
> @@ -1727,6 +1727,7 @@ static int push_stash(int argc, const char **argv,=
 const char *prefix,
>  		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
>  		OPT_END()
>  	};
> +	int ret;
>
>  	if (argc) {
>  		force_assume =3D !strcmp(argv[0], "-p");
> @@ -1766,8 +1767,10 @@ static int push_stash(int argc, const char **argv=
, const char *prefix,
>  		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pat=
hspec-from-file");
>  	}
>
> -	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
> -			     include_untracked, only_staged);
> +	ret =3D do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
> +			    include_untracked, only_staged);
> +	clear_pathspec(&ps);
> +	return ret;
>  }
>
>  static int push_stash_unassumed(int argc, const char **argv, const char=
 *prefix)
