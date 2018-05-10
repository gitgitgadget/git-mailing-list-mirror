Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEB91F42D
	for <e@80x24.org>; Thu, 10 May 2018 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756774AbeEJJYK (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 05:24:10 -0400
Received: from mout.web.de ([212.227.17.12]:33697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756627AbeEJJYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 05:24:08 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpJ4-1eTwNI3CNC-00oDCF; Thu, 10
 May 2018 11:24:02 +0200
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
Date:   Thu, 10 May 2018 11:24:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7sBrEaVYXcnOWAApk/sn9IKf2Tnt/w/TsI9K5q0M1+LV6EZQjJd
 0Zj9SD0AqYWeDu8F1ye2cV2o1q7idhFuNGr4EgvStMKpGWSfSnXzNeqCyENH6JDPGdF1egp
 nR7hRveNxu3T6RJqE85pgoyHPo4Zj5qQ256MDJNjgq1cnUPHz1AueIGA1psbNIz8wyuuZxt
 YQ2gYGuGNqKqBEiuS2guQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:djS4kVlIH9I=:UNvJ5ROWRQzpXfe8XohUD2
 SwlVJoQRV1DnblotPAstEprrZr9+FRZUFi2Dbalo7upde3sJ7QYlQNbeoeWoVkq+RGKlppW3+
 cnmymf8d+q5cUc1wUggfGzW79RoI7Vx7geTAnX2SD59dNG/wdVfHXad/F0ktP6g7AiS0iH3ex
 arg81wUOiWcvGnTfH9Q2GQNRhdUKmWZ5Cz5NfVio4HHnLWvH4rX6A2LN0EADH9u3DHMCNhGTK
 M3ScHncQTmU3S8Ov0ShwYwz5/+TVgOwv5fYvEyaB6E5VBy/FqoyWa5rJiShFyQUuKUlgPyQPV
 EXawkVzGh/oWcl2OBIpzS+ccBIYuOMhcJ6r2kRmhvrio6aj47VABxYcWVE+Dt+iwLGZsAscjY
 2rkMJNo2brfaEUPOUo1Bg7H2ppYuoqezXnk0j4qceG3fDzhS7mCQruBL/RRGXPTa21FaqrUT1
 4VQb/Z/CECRJB62cj8sNYYctEN2M3d7Wx96HiL/o2UApGJ4ZliDuZbrzTJrCWrOTrQmlbaX7l
 ndMTcshXpoFAVhqQ+8s3u90zLniNukSh0LXvHTlC7GT3iS18cJf1vI8bn/pnv/2yQBr35h+JU
 lkkxbAzhWoRhu4Usn4y8PAqp08UakIY/v/jrvp0NJwTBRyJSBGxU26XjrI4pdrw6fqZ3gD0n4
 pZs8juyICpMMBFgrTUOS5k08VRQ4WNlepBk77vAzHqTrgFiGlye1+ZUb7szruf4+lDcFnOf6S
 W6iietY4BMwC+BxIfYyKsiFHdlKXg4pjN0sK3ew5Jki6b1Pii8HBQ3pCeCuluWESddQ7KuZAv
 dvNX37+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.05.2018 um 23:06 schrieb René Scharfe:
> Clang 6 reports the following warning, which is turned into an error in a
> DEVELOPER build:
> 
> 	builtin/fast-export.c:162:28: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> 		return ((uint32_t *)NULL) + mark;
> 		       ~~~~~~~~~~~~~~~~~~ ^
> 	1 error generated.
> 
> The compiler is correct, and the error message speaks for itself.  There
> is no need for any undefined operation -- just cast mark to void * or
> uint32_t after an intermediate cast to uintptr_t.  That encodes the
> integer value into a pointer and later decodes it as intended.

Having thought about it a bit more I have to say: That seems to work,
but it's not portable.  

The standard says about uintptr_t that "any valid pointer to void can
be converted to this type, then converted back to pointer to void, and
the result will compare equal to the original pointer".  So void * ->
uintptr_t -> void * is a proper roundtrip, but that doesn't imply that
casting arbitrary uintptr_t values to void * would be lossless.

I don't know an architecture where this would bite us, but I wonder if
there is a cleaner way.  Perhaps changing the type of the decoration
member of struct decoration_entry in decorate.h to uintptr_t?

> While at it remove an outdated comment -- intptr_t has been used since
> ffe659f94d (parse-options: make some arguments optional, add callbacks),
> committed in October 2007.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>   builtin/fast-export.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 530df12f05..fa556a3c93 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -156,15 +156,14 @@ static void anonymize_path(struct strbuf *out, const char *path,
>   	}
>   }
>   
> -/* Since intptr_t is C99, we do not use it here */
> -static inline uint32_t *mark_to_ptr(uint32_t mark)
> +static inline void *mark_to_ptr(uint32_t mark)
>   {
> -	return ((uint32_t *)NULL) + mark;
> +	return (void *)(uintptr_t)mark;
>   }
>   
>   static inline uint32_t ptr_to_mark(void * mark)
>   {
> -	return (uint32_t *)mark - (uint32_t *)NULL;
> +	return (uint32_t)(uintptr_t)mark;
>   }
>   
>   static inline void mark_object(struct object *object, uint32_t mark)
> 
