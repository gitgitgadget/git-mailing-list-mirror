Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F5FC4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 07:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAAHmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 02:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAHmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 02:42:07 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC5617F
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 23:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672558920; bh=rw0Y7eZ6VFwJ9rVMPdMbIta/o5/pJluX0CzkYRTm3b4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Rj/WXhg0i8b/0xUmYWARsPNpJPNNy4MtfBMJpbZ/R6z5W82sHS3OTWnUiZ9p8YTw0
         lBUnh2UfjPZmrkYh17EtyvB2lvghVLsaCO5Hp/XWaYF4tj/C7eL7C9sC30Yy3hnx5E
         +wobilnOOhoJgKzu3nwTseMkYKcUc6hHqWfSbfEWysVjaFL/a1L1laNQxWwNnTjN97
         vgp/uFmfjyw9k8WkVodrMx2AvCBr4l/6HVu3czlmDiYHAiLPiTdAlQInvFZ8l0cI1z
         y6yDsIDoPfz4CiEYwLCSCFJV4IZ2ey4MZevBPGpOv+kTB+2nxdzc3iFcSTJvrhLnDy
         26fG5l8dACrlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1obyrw3u7b-00hv4U; Sun, 01
 Jan 2023 08:41:59 +0100
Message-ID: <220515b3-3924-c8d2-ff20-7017caa7dead@web.de>
Date:   Sun, 1 Jan 2023 08:41:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de> <xmqq8rinhs7t.fsf@gitster.g>
 <xmqqsfguhplc.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsfguhplc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/qMZObq7DlGpQskH0kVekTLyIMOBDihQ//386D5pBcLlJAEdmby
 LKu+dNmtUxOyrllkpzmC4zmr2G42Y8ju3c6DCSb9EEGZJPv/yt4hCuqyN3NzIF1LtUGUuNi
 y4A4SuuBhW4lOOKOds2lIDxpLGKStHsjbOg32AU/A05+Ct2jmO8thZS+KDvVh5Tq9UnWCZm
 fGxvPwCR0Hi7T2Y/CkZBQ==
UI-OutboundReport: notjunk:1;M01:P0:EU3l0QrkN3I=;Rndumyr1eu63XeMNDHyilIzVyal
 tf/ZeUpUjYIgQTzAh2Epy8iVB2hEhiWgy+aGeGJzcJwOwECFUqibdWBse6caqwpjsRY6/Xfzw
 hFBmlbRr/qCvBkSNqOdJX4CXOOFMXpmWtId6o92TLGNIhstwv4zp7qiwj/7daVKiWk+1ybekq
 zMan8cZN+BxbfqaCg/s7dLgjAJte8DEEyB63vGUmnUlPYNlm3LB/OuLuLa/MrAaYCpovW1iWm
 tIxGONpjZAj/klr09S6q4Z1WC4b9tfKDtS9u7gcdkGeZniPTd8qh9pVD6VLT1BtwU//bHkqan
 jP4Qn+pRZ6UlMfN6r3wFL1ILfkLkc6xrov1tOyaxNKoabxILFHtUIJahWcp6iKyXiLDx6D5Ge
 cS8O9eEYZrnVX8wMwu7ydzUfwVCN+/Nmb5MfEz2g5EHX49alMdDH9xd07eK+ZfxlQkDHsC2dy
 RFz/E+NJB/+rdFZLrmboJG7lrF5PEvqYfEhtfxjEFJFWJ3/nJpHjne25L5+vqcqRK8kff97WZ
 JLUgKlpNW0hJEYm7NjX2Wf95D5nxssVDunfieS4t4DsksR6XN+5nW4FkZBDhGBc7mEg2Scd7b
 QcyJgpTJcarohDOnBkGVGl40Xl0zeQNz5+IsRb6EyLw5phHKgs1S4OPW5UrkADqlGEhHFYv9R
 m/l2Y1B2Q1rIepBer5isFfWNncmTTRjnPv++puNhQXUArBIDK6BNV0s5CwYXC1r7+a5U/0lSJ
 hQSC2/krBh4JdSNMnyh98KpTd5BUiU1Mk2gdk6q+YC9++prYgf1BRmAzw5YmNgRuO+wOMJrVJ
 i1hYLVVPxGzlsFAApvGIOD3ACBfY5Og/f5pF9nT4kpBnv6KAUh8VWJa9okcmVNUg07Hdcjq7K
 js5YhIvy0b4YxDnbGheC8Qz77Lke6R7zMMFrMhgjTGILt8qHnq+V7tkRISAsnFMkwIxD+89hW
 MHtzog==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.01.23 um 04:59 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...  I think what you ideally want to enforce is that
>> typeof(dst) is exactly typeof(src), or typeof(src) sans constness
>> (i.e. you can populate non-const array from a const template)?

Yes.

Moving the type check shared between COPY_ARRAY and MOVE_ARRAY to a new
macro is a good idea.

Using compiler extensions when available, as we already do for other
purposes, is a good idea as well.  I managed to ignore the existing use
somehow.

>
> IOW, I am wondering if something like this is an improvement.
>
>  git-compat-util.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git c/git-compat-util.h w/git-compat-util.h
> index a76d0526f7..be435615f0 100644
> --- c/git-compat-util.h
> +++ w/git-compat-util.h
> @@ -97,8 +97,13 @@ struct strbuf;
>  # define BARF_UNLESS_AN_ARRAY(arr)						\
>  	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(arr), \
>  							   __typeof__(&(arr)[0])))
> +# define ARRAYS_COPYABLE_OR_ZERO(src,dst) \
> +	(BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(src), \
> +							    __typeof__(dst))) + \
> +			      (0 ? *(dst) =3D *(src) : 0))
>  #else
>  # define BARF_UNLESS_AN_ARRAY(arr) 0
> +# define ARRAYS_COPYABLE_OR_ZERO(src,dst) (0 ? *(dst) =3D *(src) : 0))
>  #endif
>  /*
>   * ARRAY_SIZE - get the number of elements in a visible array
