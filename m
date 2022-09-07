Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB2C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 06:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIGGBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiIGGBi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 02:01:38 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7EB85A9B
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662530488;
        bh=PU+PsiXjYN0vZrdMfyZs3hoZJEAv0INdBA/zr63fE70=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=cvt/xoNPoobsCmDDXMWtLKVTLbHcvznbrRHlI7PqsBSTB+TDEtuyquotZhMdH8TkK
         Sr9/HIhmI+EGcV6eGKhTZas+OOQTYYCCfUAltxs0srawHcFYepRbMSHbB69UiVXAtH
         del4l77XOIdT3L6mBb0Gjy6ZxeowCkkFEdJtZMeo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.158.123]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2gkf-1oVXfz1cQp-00420R; Wed, 07
 Sep 2022 08:01:28 +0200
Message-ID: <3a2609e3-453a-441b-346d-dcc2877d159f@web.de>
Date:   Wed, 7 Sep 2022 08:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH 1/2] diff-no-index: release strbuf on queue error
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> <xmqq8rmx1saz.fsf@gitster.g>
 <a3e73848-4262-1875-5ba1-085d31297933@web.de>
Content-Language: en-US
In-Reply-To: <a3e73848-4262-1875-5ba1-085d31297933@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8EkchVLHF+yRM4iKvQBikuwqIdGowi69zi9SXu65G2NQJ/KKgr
 D05ZL/e72TNSZd2VTdtDNHNRieAMp6qKXQjFWVoWpo2P8hSknO+6ws0d+lDXA8RUKSXzNVw
 0990fqAl5PQdSntq/38kmj2RXrH6RE0/4iIUKQFyu/KXWV4cFGKZ3p6OL40vXCL+PR8iJtJ
 S+uHK5eV8rW5BGp4VRT6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GmELPyF8HYU=:GoaRGOS6/EHu5KTatkKF3U
 696jjHmz2hARcv5R38B7ZtvjUEIhHSXh67OPNtnKyNVu3FXinnpMpnwnFCD6uDDQJldSbfo4r
 FF/QKubJyy18qAB1LWoWDK6lwFZuNI54tuzPt/E2D1sd/VFvMiNY+fVnFOy+fBgvcJrGUqDvL
 j+chhTgdss5jGJgcIzlaQaV2N4bbFgqbjzoH+nQCbQUr3rlcghQu4RwTYLGzPtmM0Sm/rOjZW
 ldwXVERpKGnji2WNFC9r8HQf5NiRV6hyVf3lQcpeYxWbhypT0e19m9vVMEvMUbN6T9F/6qTuV
 kc9ALUhrG14w4qfBiqHCBXmNYePqqU/RqTwe3XKdHTWTfKdqitJKb6NB9L645QjjHsLHeLnEo
 4bVZDb7j7PKuVDPIjiJ7C7SlQZMIZCdKfoEcC6jXJlKu+xa+yRN24HBInfMdFBRuhUa89aiOF
 Iwy0nBeQqE6RapSZLHqW4qAEy2EV7istsglQAme6kVKov2A4flOYejnDRXtb9FaLQo7hpf7A9
 Vnbi4+O9OQeagGk/HjYU7yBHZ3qvQwDbmIG/jOS2mpQGuLkRrVguA6hTGoDadatM84J0CRAlx
 PzEXOcUHHh8KaSLFh8fp3R4PUIhRLbX+GcPdNcqguuxcGUE6kQFAGql7IQmAEZ4s6U1lcgDpV
 Y2vE6ZX0NAFs64QyP0jUCcDdT1LEDl8NhFEBlfYalrYK/mpMn4C9u0EVHIZ7KD4thtR12TYSJ
 LIHA63hyAEAzNayPWd1iaDfk2q5mL6etrsxF/WklOjxafAAPLjuAw79pmr3Lt2z1e87IgKbF5
 BWrN7eq1YI/xrqHMdz39RezGtoDnJVsNy6joH8oUotT9JuOI5CMeHkfUOm3WCZYJnByB0Wm+b
 hhBpJOQV6RvuyiFIMKcLPSrQRGoVG5N1vepAqaXmfUtagd6M0W1D/9EJb+bYaFtokgkA7+vyb
 vOVMVAEHrvaAOkwvRV/pjSTH/XMBEEnFi8BwQsYVXYoNzHH0rlfwDKxnOHC7GH/AgkvXGKPa4
 B1/pcWJZSG/d060sz8uqlX5VTEtRoYi5gtfBlF3UPPRAGy6K8bgSHL47hkfCTZ7r7S7CGjeyz
 Qp3Gm9f77lpsQ/Mj/5m36HNpdmPPDDuSGLtv9GAd2mDMbREBCfAV57mIjNDglMs4Ds0FzuMd2
 RpNGY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.09.22 um 14:31 schrieb Ren=C3=A9 Scharfe:
> The strbuf is small and we are about to exit, so we could leave its
> cleanup to the OS.  If we release it explicitly at all, however, then we
> should do it on early exit as well.  Move it to a new cleanup section at
> the end and make sure all execution paths go through it.
>

Oh, forgot:

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  diff-no-index.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 9a8b09346b..a3683d8a04 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -243,6 +243,7 @@ int diff_no_index(struct rev_info *revs,
>  		  int argc, const char **argv)
>  {
>  	int i, no_index;
> +	int ret =3D 1;
>  	const char *paths[2];
>  	struct strbuf replacement =3D STRBUF_INIT;
>  	const char *prefix =3D revs->prefix;
> @@ -295,16 +296,18 @@ int diff_no_index(struct rev_info *revs,
>  	revs->diffopt.flags.exit_with_status =3D 1;
>
>  	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
> -		return 1;
> +		goto out;
>  	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
>  	diffcore_std(&revs->diffopt);
>  	diff_flush(&revs->diffopt);
>
> -	strbuf_release(&replacement);
> -
>  	/*
>  	 * The return code for --no-index imitates diff(1):
>  	 * 0 =3D no changes, 1 =3D changes, else error
>  	 */
> -	return diff_result_code(&revs->diffopt, 0);
> +	ret =3D diff_result_code(&revs->diffopt, 0);
> +
> +out:
> +	strbuf_release(&replacement);
> +	return ret;
>  }
> --
> 2.37.2
