Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D3CC3DA7C
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiL1S1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiL1SV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:21:29 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03128DF7F
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672251655; bh=YiX9vrsHU2c0b9VuCWL2T8YQGMAByjrov7TxuBE7PU4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Jvv1bv8LjNvIeTtHYtqUP6aFB+GiNAmq1wY3LB3RVJ0BcVXDBvZdUmVa4GYg904qo
         9u0yO4VUGrkxrtwAyQxYlvkksHys1PWV+PpEFl3MF4lDFYapTg31auOxnw4GmEp/dV
         oLbXJU6o266n32uG7E28KokwHAjxIKLZfYp+UgUses2CT/awvMK+zcNexurYS95xKo
         9jPsKjPmqOLHZVygYEmlo2J2VHAxO9gCGfZHRd7tJ9/6cIukhgB2aujREO3Q3kOC0j
         eHygh90W1EY4BSL+9mm8El9WYIajxpe2Aa9m49gQUTGqaatf2gnkSaEWzEAdJGGQtf
         BkqUeD8+M0pOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYLmq-1pOT6z0qAs-00VmZ0; Wed, 28
 Dec 2022 19:20:55 +0100
Message-ID: <ae6c99c1-3f6d-5fa9-3a43-ab10785e2ea9@web.de>
Date:   Wed, 28 Dec 2022 19:20:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 05/20] clone: use free() instead of UNLEAK()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-05.20-49e6714939d-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-05.20-49e6714939d-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Us4prlApZIAxjWplPzkCvFYL3h1sSPnhfancviYCSB/5nH6Hj15
 +KbXc3yMkPGKxU7cFtIPRJ+Jg9+FTeIdNJG5kqobbdwQvkkVsHfTHk03pnU+Augkx2VPzl+
 nZQB8i3e1+ystAp/o6gPUfbMFynfYKXb3oZUU9GCXTmeOhn7YR+kBN2zBMMfsVoJ5Oe1Zly
 rfayn+C9WWwDJxGmEYFzw==
UI-OutboundReport: notjunk:1;M01:P0:bZfSey56rVo=;4JyTc7O2Gk3VLfY5Z4KV00F0cg4
 Mp1dJFwmm/zgK+xbwI8Qw/mns1BpX4jX3IN01qtr1wB3e7o01z5Hmmo7W3FI9wsgD/eHBJR8l
 Jk7qDmhFBclktnW2KwOHl+w1FRENMTnD1KsAEbf3VCWzeE9FGmHxW30qFabp4OZ4pjeMhcmfV
 2Xe9cRVtxgB1LcMWehHkieENPersvRxSl9yPfy0dBDmn2t2uB0gDx1F7uSthe3h4G3WLrOFFj
 98SlijqyLOdi++GptZnmcOg2NpDylJpqqssaf/3PHHdx3k+JxWNI/zYnCiRnDG23x+Ls5KKs3
 xh8VYMdN/EBd3B5y95ZUllYG9muiToRNlRnwmunnhj2GkjNhwJOpC9Trp6EV8udMkgxaIZ7qq
 o415ThKJ/QMuJ9tFqQFldr0jyL1TXH+Bz8pPA4ehEGptnDbe1oG45dADDUl60stqilp2QZR/W
 Xzo2IkvN+S6bLSubo4BjVMrWCX9BH4mWsRQU191rpMts3efA7THis5NSrMt8RlVuRyAglukd/
 Lhs1Ay424DXRgKyReAY4mH/bEuE82HvFhAgfnJHCNgY41QsQPP0nlwiJVvBLjF3lCp0Sg84cE
 p2jG33luemYXmCMxeH9h6/a94GI7544h0YTEpd7jcmrGwBCxXImFFR0PdBrs0T+0hezn/ys7B
 htMD3FqRckp4ICgOaK5rEu9uKtLEQc84d0lYZkMPNHJDGZkcZQ2cHtfbhgsX+nW9c21+vyb+z
 ACLpUPFmk7n+298qu0WHqXQetkTiuQQEouyisKHdXp605ezerz4y6MdTzDtUTKyhXoWiWe7Hh
 jr7yVC3U0VOkAlY1UtQtM1tHFhg18yefL9Sa3JNKilpNmbEz0xT41nFrcUCvOhlV2dTMso5xe
 Zep8EUFnpjfnq6EQf25UHfQ+JMEmN/m+emph4XKo5T4PraataxU7ygCVYXN5KVI4LKAtpfmMj
 VFe1uw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change an UNLEAK() added in 0c4542738e6 (clone: free or UNLEAK further
> pointers when finished, 2021-03-14) to use a "to_free" pattern
> instead. In this case the "repo" can be either this absolute_pathdup()
> value, or in the "else if" branch seen in the context the the
> "argv[0]" argument to "main()".
>
> We can only free() the value in the former case, hence the "to_free"
> pattern.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/clone.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f518bb2dc1f..48156a4f2c2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -892,6 +892,7 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
>  	int is_bundle =3D 0, is_local;
>  	int reject_shallow =3D 0;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
> +	char *repo_to_free =3D NULL;
>  	char *path =3D NULL, *dir, *display_repo =3D NULL;
>  	int dest_exists, real_dest_exists =3D 0;
>  	const struct ref *refs, *remote_head;
> @@ -949,7 +950,7 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
>  	path =3D get_repo_path(repo_name, &is_bundle);
>  	if (path) {
>  		FREE_AND_NULL(path);
> -		repo =3D absolute_pathdup(repo_name);
> +		repo =3D repo_to_free =3D absolute_pathdup(repo_name);
>  	} else if (strchr(repo_name, ':')) {
>  		repo =3D repo_name;

Alternatively you could do "repo =3D xstrdup(repo_name);" here to simplify
memory ownership of this string, at the cost of a small allocation.  But
the approach taken by this patch is fine as well.

>  		display_repo =3D transport_anonymize_url(repo);
> @@ -1392,7 +1393,7 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
>  	free(unborn_head);
>  	free(dir);
>  	free(path);
> -	UNLEAK(repo);
> +	free(repo_to_free);
>  	junk_mode =3D JUNK_LEAVE_ALL;
>
>  	transport_ls_refs_options_release(&transport_ls_refs_options);
