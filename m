From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/18] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 15 Feb 2016 21:17:05 -0500
Message-ID: <CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215244.GG10287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:17:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVVCU-0000om-H3
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 03:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbcBPCRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 21:17:09 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36309 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbcBPCRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 21:17:06 -0500
Received: by mail-vk0-f68.google.com with SMTP id k196so8953759vka.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 18:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0QZCy7gN40lQiOG/9fBbLe6eCJ5MiS3q3BXMWqLdb9A=;
        b=GA7Pi7IDmIx3GUTrg2uMt7Ho1Wf98VUNL4keBpTaPWrx3LACuTLBN18Y/JeEFhG61H
         hyh4LfP8P+EMxY8VFU8GdfNhQ/QJCYJIuft8ss7Ju+m0e2GQdNkERN92d/CNDvDDdSv4
         uHqq++pUHb20ndnXQ9d79D+wiW1TJCmZ35pYqwE7FF0LQnK/sP7BiGo3uwLb45kcuDqX
         JBq/RKe3QFyEK0Cn3tvm95bnriYNKr8ftPrGYQeqFjEjQKcLhgc6dbuLY3qmDP0smvOE
         UufZ6ccU+tj/dH5WzkDKZieovVgxmydIywYDGEWqLe4GC0PKozVSve0TC7Fxkiyknbnx
         STCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0QZCy7gN40lQiOG/9fBbLe6eCJ5MiS3q3BXMWqLdb9A=;
        b=jQfXgeJQM4fQaHRFJpEEST8tSfawntAkYfS+o1OTGhelRFPR0HI/cI3PTuI5EW5cbR
         8nRpILhnQ4gf0rK/iYan8u7d5ElVpwpY/OXhwsw47km96ft66WJ/4zU77juptaLhzhFX
         yBrUWefSDfne1vdGdp0X12GVocsPNY1VtBGgoFtyDyRnsTzuqMbuMO98lnQuJ5bswfOi
         nxWuKR4tZaDa2Dy0FUugQ6o1lpYiUFbrNVchcYaT2Y0eT375JC9FBItf9qI6Y4HXRw5q
         8wDt27VvvKctLg65rUMmEk9v2GE0xOOostW68M2GB+GtmL5jMUL1s47dE/5dFDISx4x/
         hVAA==
X-Gm-Message-State: AG10YOSv7XxYyIV2tngh4WKI4e7JKt5uSWdM/EP2qP96sNb/uUciILrMFZz9vIUj+4sewrnS56XqlelcMMHiyQ==
X-Received: by 10.31.146.2 with SMTP id u2mr13781850vkd.19.1455589025273; Mon,
 15 Feb 2016 18:17:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 18:17:05 -0800 (PST)
In-Reply-To: <20160215215244.GG10287@sigill.intra.peff.net>
X-Google-Sender-Auth: hhmkQrX1BHrHdFTgnnIP6DEIr5s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286305>

On Mon, Feb 15, 2016 at 4:52 PM, Jeff King <peff@peff.net> wrote:
> Using FLEX_ARRAY macros reduces the amount of manual
> computation size we have to do. It also ensures we don't
> overflow size_t, and it makes sure we write the same number
> of bytes that we allocated.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> @@ -412,8 +410,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
>                     !memcmp(ent->pattern, pattern, len))
>                         return ent;
>
> -       ent = xcalloc(1, (sizeof(*ent) + len));
> -       memcpy(ent->pattern, pattern, len);
> +       FLEX_ALLOC_MEM(ent, pattern, pattern, len);

Does the incoming 'len' already account for the NUL terminator, or was
the original code underallocating?

Answering my own question: Looking at reflog_expire_config() and
parse_config_key(), I gather that 'len' already accounts for the NUL,
thus the new code is overallocating (which should not be a problem).

>         ent->len = len;
>         *reflog_expire_cfg_tail = ent;
>         reflog_expire_cfg_tail = &(ent->next);
> diff --git a/hashmap.c b/hashmap.c
> @@ -256,10 +256,9 @@ const void *memintern(const void *data, size_t len)
>         e = hashmap_get(&map, &key, data);
>         if (!e) {
>                 /* not found: create it */
> -               e = xmallocz(sizeof(struct pool_entry) + len);
> +               FLEX_ALLOC_MEM(e, data, data, len);

Ditto. I guess the new code is overallocating (which should be okay).

>                 hashmap_entry_init(e, key.ent.hash);
>                 e->len = len;
> -               memcpy(e->data, data, len);
>                 hashmap_add(&map, e);
>         }
>         return e->data;
