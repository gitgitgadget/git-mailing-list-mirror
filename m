Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881BAC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCWUcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWUco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:32:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCF6A69
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:32:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5447d217bc6so414884667b3.7
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679603562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2H7G5yfz4kYzjL6sKaSwnnv6HTZosa1oho8yp109VMY=;
        b=ChHM/Kq2nM2Vm5x57pzKlJga5XlfycRBwdPbR8jU+cG7/HB+5fl3aWZzV8T8WvtHm5
         DW1YxhNaqtjNzxGvje5WfxqY7jYge7cjYGvGFTj+FxbYBrE53pKgZxvzvf7Uci5NvUGn
         M/kECgHRFcLWNBFdNzKkN3AF1x4fa5Hl2YOscpoCqCHGVumhw39xaTZOuoxZMhGP0V+W
         0sUrTeFOxk/2lo7w+1PU0kRwH1gsxu6hjayyvfDegS2Y3Bhczpe+Cn46grfcZVPBtLHv
         sQiHvk6VguKFYNaDZMmm+/uV8Yo+fFQIuucwzJmdOsjJdOSU1LaMsDHSGYApaGtSLjhP
         bPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679603562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H7G5yfz4kYzjL6sKaSwnnv6HTZosa1oho8yp109VMY=;
        b=7kKehEdHMJFSXYmRkMoMOXsy3u192bLQspftzsVMgrkE3qERECIxjIyPosbVB6nG1s
         tOG5dylYY4kcScx2tLzKSMh2Ig8s4LFVldMbDiqXcVLaVib8mMiemsrM0Q60GcBIyn4S
         LjY44OSaCpgp0Vj5ll7CodLx4Ndxq+9OVucQ3StUY2NgPGFM0o25J9dE9KvHWxmvxQ4F
         AXyCcTpDgaAtKUIBIEpPh3k48NCoueaS0Q5aYqKrEey/b6LIl4rmIQcupM/tvyiP4GIX
         cTTILt3Nd8Pu51p6zlhQ0e1+JdacCmTjUcDQsOPhIJ3nzclMSLGfILu5AS8tH4j2FTSI
         x6GQ==
X-Gm-Message-State: AAQBX9eW+eFZP4kRAonwo5XiC3/JK+xjJRx87gHjavxEYgv4Ttl7nfFt
        czyQU/g5/qTv9INfQT1ZD4vro3wcYEdOoNqVQm7foA==
X-Google-Smtp-Source: AKy350buqFstvChc1o/MvGHKfWY5kEuqMg/jnjpB6bs8PWxlQ0HZA+RUI8qow7ud/e47SJAIjeNUJw==
X-Received: by 2002:a81:6546:0:b0:541:69aa:4c6f with SMTP id z67-20020a816546000000b0054169aa4c6fmr5153926ywb.44.1679603562635;
        Thu, 23 Mar 2023 13:32:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u11-20020a81e60b000000b00545a08184f7sm27231ywl.135.2023.03.23.13.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:32:42 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:32:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase: clarify conditionals in todo_list_to_strbuf()
Message-ID: <ZBy3aa+7RhnjJUaG@nand.local>
References: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 05:22:35PM +0100, Oswald Buddenhagen wrote:
> Make it obvious that the two conditional branches are mutually
> exclusive.
>
> As a drive-by, remove a pair of unnecessary braces.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>  sequencer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..9169876441 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5868,12 +5868,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
>  			if (item->command == TODO_FIXUP) {
>  				if (item->flags & TODO_EDIT_FIXUP_MSG)
>  					strbuf_addstr(buf, " -c");
> -				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
> +				else if (item->flags & TODO_REPLACE_FIXUP_MSG)
>  					strbuf_addstr(buf, " -C");
> -				}
> -			}
> -
> -			if (item->command == TODO_MERGE) {
> +			} else if (item->command == TODO_MERGE) {

I dunno. I think seeing adjacent

    if (item->command == TODO_ABC)

and

    if (item->command == TODO_XYZ)

makes it clear that these two are mutually exclusive, since TODO_ABC !=
TODO_XYZ.

So I don't mind the unnecessary brace cleanup, but I don't think that
this adds additional clarity around these two if-statements.

Specifically: why not combine these two with if-statement that proceeds
it? That might look something like:

    if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
        item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
      ...
    } else if (item->command == TODO_FIXUP) {
      ...
    } else if (item->command == TODO_MERGE) {
      ...
    }

but at that point, you might consider something like:

    switch (item->command) {
    case TODO_EXEC:
    case TODO_LABEL:
    case TODO_RESET:
    case TODO_UPDATE_REF:
      ...
      break;
    case TODO_FIXUP:
      ...
      break;
    case TODO_MERGE:
      ...
      break;
    }

which is arguably clearer, but I have a hard time justifying as
worthwhile. TBH, it feels like churn to me, but others may disagree and
see it differently.

Thanks,
Taylor
