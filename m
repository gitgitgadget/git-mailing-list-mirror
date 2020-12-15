Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A824C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1984F22D06
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgLOVkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:40:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:45523 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgLOVga (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:36:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BFLZciF018179
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Dec 2020 16:35:39 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Elijah Newren'" <newren@gmail.com>
Cc:     "'Jeff King'" <peff@peff.net>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>        <xmqqeejraiw7.fsf@gitster.c.googlers.com>        <X9glBJnlLMTW6Dns@coredump.intra.peff.net>        <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>        <xmqqzh2e7p6l.fsf@gitster.c.googlers.com> <xmqqtusm7odr.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqtusm7odr.fsf_-_@gitster.c.googlers.com>
Subject: RE: [PATCH] strmap: make callers of strmap_remove() to call it in void context
Date:   Tue, 15 Dec 2020 16:35:32 -0500
Message-ID: <004a01d6d32a$3b92ec60$b2b8c520$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQInSaJaLNehwWvOmRwIC/Ctw4llswKbIC1HATfee0EBSceaCQI+AiLKARKhTaWpFFW4cA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: December 15, 2020 4:26 PM
> To: Elijah Newren <newren@gmail.com>; Randall S. Becker
> <rsbecker@nexbridge.com>
> Cc: Jeff King <peff@peff.net>; Git Mailing List <git@vger.kernel.org>
> Subject: [PATCH] strmap: make callers of strmap_remove() to call it in
void
> context
> 
> Two "static inline" functions, both of which return void, call
> strmap_remove() and tries to return the value it returns as their return
value,
> which is just bogus, as strmap_remove() returns void itself.  Call it in
the void
> context and fall-thru the control to the end instead.
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  strmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/strmap.h b/strmap.h
> index c4c104411b..1e152d832d 100644
> --- a/strmap.h
> +++ b/strmap.h
> @@ -165,7 +165,7 @@ static inline int strintmap_contains(struct strintmap
> *map, const char *str)
> 
>  static inline void strintmap_remove(struct strintmap *map, const char
*str)  {
> -	return strmap_remove(&map->map, str, 0);
> +	strmap_remove(&map->map, str, 0);
>  }
> 
>  static inline int strintmap_empty(struct strintmap *map) @@ -249,7 +249,7
> @@ static inline int strset_contains(struct strset *set, const char *str)
> 
>  static inline void strset_remove(struct strset *set, const char *str)  {
> -	return strmap_remove(&set->map, str, 0);
> +	strmap_remove(&set->map, str, 0);
>  }
> 
>  static inline int strset_empty(struct strset *set)
> --
> 2.30.0-rc0-186-g20447144ec

Looks good from here.

Regards,
Randall

