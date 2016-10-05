Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A944B1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbcJEQse (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:48:34 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33248 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbcJEQse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:48:34 -0400
Received: by mail-qk0-f172.google.com with SMTP id n189so150634697qke.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V8x3QsSbDfvGy4Er8vBYmCXsKf/SFet73XbgOVoQQv0=;
        b=aNJZ2tVXFbMSDU29Iee0eUlrXxRhYJV6S9SZWyC/coRx2yIGC6MG2Ld2DyZ0/WRTWD
         ppT1+il+nOD3HwyRNXPAjUrpjguwFO3PK5B8D0VERwArBtUyo1zF1NsGu0s7V+4HuXIQ
         cfTkeG4gMHTrjfZeuQO4HgaLvJvmrlk3AGR/L0z5pCGu42j7HasuLZXvWzDRDHu7FP4z
         mbwRKsezMafLu25NIjhYMKE+H2Wi7r6NDIraPAxn6GVhFeJxeUOcaONYONzzyReWSpdD
         K+AK4/k7F0eNbbgGthd4lJu2jg8wHqAGTecf/1TXjySBTOj4GXz1XEJDZnMn/bhoXP4o
         OCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V8x3QsSbDfvGy4Er8vBYmCXsKf/SFet73XbgOVoQQv0=;
        b=JClc7JDOiIIIhBrIS991bhD/WfWnGVrM64CgHmRn0AD0M4a1aZjVttDiEPrMCa7I5u
         7HgozAucnHr5FvKzBdSPNZ6eXOubIaWdVqZ8gdRiq/ImqEYT6FdzwQs8gEUAizW7OSdv
         YwGHnTv3hMmXxMu/McsrX6zWJCQBaqrAFjCZQeE6MY3jfcLeYatJlm/1HIUHCy6sGbhv
         BY/rtrbI+LiuSOEQZRW7fmM1T3du4mkpASWEmZcMjKCisk+TvdPG3i9B0Zz5WehIJg+0
         NQijSIpWOtzYsV3A0lbEf3lFlAW9Ypw3Fv0WBN39BM16XuDvILYAnp6XbS0bNlQuQdZx
         sHgA==
X-Gm-Message-State: AA6/9Rl8SqlNpPA70KMTKW34Pbex1qdroSnwV9gvJXZBoXYLuuWIJWhdMiWIJbBID8bpFlY1+6A8CC/yXlB/fyCR
X-Received: by 10.55.56.11 with SMTP id f11mr9572511qka.255.1475686112961;
 Wed, 05 Oct 2016 09:48:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 5 Oct 2016 09:48:32 -0700 (PDT)
In-Reply-To: <20161005142929.l7fy3jxkme4iwunc@sigill.intra.peff.net>
References: <20161005142929.l7fy3jxkme4iwunc@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Oct 2016 09:48:32 -0700
Message-ID: <CAGZ79kb_VVoAO0p-XtvZRa3akm+UEMJQjOUip4yrH6m36BVRrg@mail.gmail.com>
Subject: Re: [PATCH] clone: detect errors in normalize_path_copy
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2016 at 7:29 AM, Jeff King <peff@peff.net> wrote:
> When we are copying the alternates from the source
> repository, if we find a relative path that is too deep for
> the source (e.g., "../../../objects" from "/repo.git/objects"),
> then normalize_path_copy will report an error and leave
> trash in the buffer, which we will add to our new alternates
> file. Instead, let's detect the error, print a warning, and
> skip copying that alternate.
>
> There's no need to die. The relative path is probably just
> broken cruft in the source repo. If it turns out to have
> been important for accessing some objects, we rely on other
> parts of the clone to detect that, just as they would with a
> missing object in the source repo itself (though note that
> clones with "-s" are inherently local, which may do fewer
> object-quality checks in the first place).

This explanation and the implementation make sense.
Thanks!

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Noticed by coverity;

I saw them, too and wanted to start preparing a patch,
but I cannot quite compete with your speed here. ;)

> the recent alternates cleanups mean that all of the
> other calls to normalize_path_copy() are now checked, so it realized
> this one was an oddball and probably an error (I actually looked for
> others with `grep` when doing that series, but somehow missed this one;
> hooray for static analysis). The fix is independent of that series.
>
>  builtin/clone.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index fb75f7e..6cf3b54 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -345,8 +345,11 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
>                         continue;
>                 }
>                 abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
> -               normalize_path_copy(abs_path, abs_path);
> -               add_to_alternates_file(abs_path);
> +               if (!normalize_path_copy(abs_path, abs_path))
> +                       add_to_alternates_file(abs_path);
> +               else
> +                       warning("skipping invalid relative alternate: %s/%s",
> +                               src_repo, line.buf);
>                 free(abs_path);
>         }
>         strbuf_release(&line);
> --
> 2.10.1.506.g904834d
