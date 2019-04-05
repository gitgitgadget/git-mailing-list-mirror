Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E5320248
	for <e@80x24.org>; Fri,  5 Apr 2019 08:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfDEIFy (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 04:05:54 -0400
Received: from mout.web.de ([212.227.15.4]:53935 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfDEIFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554451546;
        bh=M+pyfHi5JWyR/7fjVEmxKjzCSouUhVCUlz6yo+gV4LA=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=S2dg45lPApj5fQ98lC+0go/1+KXTpRxUdHwgSHBcGYb5RvUKH/1xK+sM2V5DvwV5v
         Ee8ki7VhW9eZW1dP+Z2bEW5PTQRrOFgX1zZVY0RNFdx9hi5ZRJ2eYD0+HbbOch/ETa
         aa3XPe736qe3TonBR2aR2etKcB2iw6WNlKmph3Es=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.22] ([79.203.21.163]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTuQz-1hKwp91ZBp-00Qj6p; Fri, 05
 Apr 2019 10:05:46 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 04/12] packfile: check midx coverage with .idx rather than
 .pack
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232546.GD21839@sigill.intra.peff.net>
Message-ID: <726ad2d6-ab39-8f5e-1b2d-f991c8765a08@web.de>
Date:   Fri, 5 Apr 2019 10:05:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404232546.GD21839@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27ntcn+zTR1fZcQHBfqcMS+a+eifJJ/gTI7cvr1BwicWhw/5ZBO
 PKctukKeQ1FgLIt/KjYyYY0gso7KNwm6tmbB22p2MrW18nC8mw3ep68bUda4frvk218cDby
 R6zE7q4bXGc3KoaKQEMc1sJ+50InR5N1Qwo6mJQMUszfgfIPadci58kUBmpo7ztOi6C4mDj
 YJ3tudSEm8HV0q4U/GUxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8nKVeaWPX64=:UystRRbDyz+oj5wDPb5sK7
 gh6Gj3cUAL6eZbIqCHTYAfcQD33ppuSeTnKWt1oCI9NnJNJtmdTr7WIKuMk1A9Y32bxpUgQop
 wmwH7LxfNcnw7JPpVyaVRcufD5EtWrKkH8SQW2uhXk8N5K/RoSrH10i6h/cenlPRoOYPAveVw
 RnKXQxx+/ygUnHVa3GyFojidQxxi1533/D6pXNtkbeodB1dSYBld9bcy+y22NWR74clLF6SxZ
 h7OyQbDLSLJ1rx0EmrCb35GnjKeHOamAbWmZ0Ga/vkeq9ftUeN73/GCzU+bigXoywd3qsXvMq
 9iFhZYLqxnxcWZA1zd/bOLin8QyyUgjghCHrSfLURcj6cfE9oSviIJeXYgehue1yF076s1xbn
 R7pU10MN7NggF+chkIshtJnSQMSXrJuYuWQQn0GCfCwv4n19PS3vRvRNtQsitq2tmHta/giEz
 QuHmLSCCJ5eKI/JkQG0bUwke3Nx72GzbzImzHtFOPr4kt9P41VSLf649lSOIPq3MS1HoXT0H6
 TXmUVWXecuerKI6O2347ONNoqRCR9LewJEOo46gCM5q4LE3Nvqq5mx8sZYAAcJblHCMlYz++4
 j2qvKFx/ZDeNLFEPGgBpSkw7aFd9GJLaVkjspjTvZz8gHiM0epzmJhhdmaE+5AqJqHYtj+Eao
 9gZYDl90Fgst3wt3DTwsF0DTxGcxtVugvdiRUeEBMdsvfG2yxyXKNYCl71NhoyrNzf/ChBo1D
 HA+CWiyIsEUsWGRT3vHYmoZyVaTptrGMYQj6Uzj9R3FXxqSgcIeNG9gq/GZ0fpVp9nK4xuDFo
 iOw/pcwgQvACvWQ6C+PZ6/jxVFtQOmHrwyX3mJ+yXUbHIXzgCxdZ5KQIcaNqakqA2T4XgjkFX
 tUQNItXsn14Di/2ydB4sng+Yj5s6Ts/t5zbkAVVlIPXIMLlVthzrnD3PPZvOuX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.2019 um 01:25 schrieb Jeff King:
> When we have a .midx that covers many packfiles, we try to avoid opening
> the .idx for those packfiles. However, there are a few problems with the
> filename comparison we use:
>
>    - we ask midx_contains_pack() about the .pack name, not the .idx name=
.
>      But it compares to the latter.
>
>    - we compute the basename of the pack using strrchr() to find the
>      final slash. But that leaves an extra "/" at the start of our
>      string; we need to advance past it.
>
>      That also raises the question of what to do when the name does not
>      have a slash at all. This should generally not happen (we always
>      find files in "pack/"), but it doesn't hurt to be defensive here.
>
> The tests don't notice because there's nothing about opening those .idx
> files that would cause us to give incorrect output. It's just a little
> slower. The new test checks this case by corrupting the covered .idx,
> and then making sure we don't complain about it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   packfile.c                  | 17 ++++++++++++++---
>   t/t5319-multi-pack-index.sh | 14 ++++++++++++++
>   2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 054269ae5d..e7ca135ed5 100644
> --- a/packfile.c
> +++ b/packfile.c

> @@ -486,15 +496,16 @@ static int open_packed_git_1(struct packed_git *p)
>   	ssize_t read_result;
>   	const unsigned hashsz =3D the_hash_algo->rawsz;
>
> -	if (!p->index_data) {
> +	if (!p->index_data && the_repository->objects->multi_pack_index) {

So if there is no multi_pack_index, we skip this block now...

>   		struct multi_pack_index *m;
> -		const char *pack_name =3D strrchr(p->pack_name, '/');
> +		char *idx_name =3D pack_name_to_idx(pack_basename(p));
>
>   		for (m =3D the_repository->objects->multi_pack_index;
>   		     m; m =3D m->next) {
> -			if (midx_contains_pack(m, pack_name))
> +			if (midx_contains_pack(m, idx_name))
>   				break;
>   		}
> +		free(idx_name);
>
>   		if (!m && open_pack_index(p))
>   			return error("packfile %s index unavailable", p->pack_name);

... which also means this open_pack_index() call isn't done anymore if
there's no .midx file at all.  You don't mention this change in the
commit message; is it intended?

And I wonder if it would be easier overall to let midx_contains_pack()
accept .pack names in addition to .idx names.  Perhaps with something
like this?

int cmp_idx_or_pack_name(const char *idx_or_pack_name, const char *idx_nam=
e)
{
	while (*idx_name && *idx_name =3D=3D *idx_or_pack_name) {
		idx_name++;
		idx_or_pack_name++;
	}
	if (!strcmp(idx_name, ".idx") && !strcmp(idx_or_pack_name, ".pack"))
		return 0;
	return strcmp(idx_or_pack_name, idx_name);
}

Ren=C3=A9
