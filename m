Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B79F1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 16:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbcHAQnO (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 12:43:14 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33762 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbcHAQnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 12:43:12 -0400
Received: by mail-oi0-f48.google.com with SMTP id j185so199785000oih.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 09:42:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E81Ud/DjI0kjqFKzhLG0YFnHTTugi+lZJeboS0MBkYU=;
        b=MoSEH0ZCrladLQkTb3gIkPxcuPxe2GB+RVf38rRpWVbdfHLaMdGqwXh/sR977meNac
         jYZi1DOITma5S8CjZdxlLsfDhVf8mDpMe34Yw1en08LIuePzfvPTEBijnJjc8HWcwcxT
         eYUtNcaPRumB3urwpFdAFolkTuryWcbLK9CDPrH8R1p0afmP/cx29W80L0fzYmFvY4g5
         lemPbexJMRbpDD6jvPi/P828VQ5ccbc8oqnAdUhfw/Ls9r4e04TlKERbaGCpo65JqOEn
         1sJZaVyUYZ2m92fFjS4H9pIp2bZSqr6qCsbBHFVFkPD/iCQHoe9WgBfUHdRCL257AIGs
         Fr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E81Ud/DjI0kjqFKzhLG0YFnHTTugi+lZJeboS0MBkYU=;
        b=a6vuNjLPmG2w517l0zH6cS1+iyGNxO2T6jb2CDHhTjUmixvUSRDjWgR08LeAO6Sr8R
         2ZJ+tE98oOGTSDfzd8ZPM0Ie5HP9mUmmnzsm7dG25BDOmuuNzDOx7ysgWobZpWaTU3Uk
         8hToS1pLuXMxj8QRzAvnepOmvZ2+GHtkjvtENXYTOJbO58tMjN+ptr6P3OeZPZPE5097
         8Zr2BlivEs7YDrhNBMeuNHbzwUoRIpoq97joQzhsdIfua8sXyJWpWiiyh0n8LTGuM8vT
         kv5kvHSaCX0QwME+k8wBFzWzNpiiqk4TU/zpNhreiiwVmy9abN8tP0sjOQ/vq7I1H6Co
         imYg==
X-Gm-Message-State: AEkoouujG8JFGvpTsBgT5SaXQT0/ukGyNwI/XVcX6nR1mnRbyw7FMOxtemBVq+SYzbqL9KO0lHTHxMHzzr/d0oXj
X-Received: by 10.202.104.33 with SMTP id d33mr33024466oic.83.1470068163202;
 Mon, 01 Aug 2016 09:16:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.149.226 with HTTP; Mon, 1 Aug 2016 09:16:02 -0700 (PDT)
In-Reply-To: <20160730172509.22939-4-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org> <20160730172509.22939-4-chriscool@tuxfamily.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 1 Aug 2016 09:16:02 -0700
Message-ID: <CAGZ79kY+VHLspQBm+cTarY8NR2_iOewUiVZVv79DHLVsv7v-Qg@mail.gmail.com>
Subject: Re: [PATCH v9 03/41] builtin/apply: make apply_patch() return -1 or
 -128 instead of die()ing
To:	Christian Couder <christian.couder@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 10:24 AM, Christian Couder
<christian.couder@gmail.com> wrote:

> + * Try to apply a patch.
> + *
> + * Returns:
> + *  -128 if a bad error happened (like patch unreadable)
> + *  -1 if patch did not apply and user cannot deal with it
> + *   0 if the patch applied
> + *   1 if the patch did not apply but user might fix it

I stopped and wondered when reading this comment,
what the difference between -1 and 1 is, as the user is
not part of this function.

When reading the code, this makes sense, though.
So -1 is returned when the user set `apply_with_reject`,
1 otherwise? So the user told us upfront how to deal with
certain errors.

What is a "bad" error, that generates a -128?
(Only when the patch is not syntactically correct? Or are there
other -128 errors as well?)

Maybe:
 Returns zero on success,
 non zero for failing to apply a patch
 negative values for hard errors, e.g. unreadable patc.

Though this is less precise, as it doesn't differentiate between
-1 and -128. I dunno.

(These are just musings that should not stop going
forward with this patch, just some thoughts on the precision
of a comment)

Thanks,
Stefan
