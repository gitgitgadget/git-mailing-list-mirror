Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D9BC77B6C
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDLWBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDLWBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:01:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2AE59CA
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:01:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f188so45222670ybb.3
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681336868; x=1683928868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5LuY1P7B1pC4wEUx/o+TLqKuhLm2bRhk1ulg8tFfDg=;
        b=upTwYcvvYi0IZdlJIP/nI2Dd6alazdP5h1Ic6CwihN8wZnxS1LgSbpY1NKgLP1UVdw
         RrrF+H/omukY/GUBpt8WPG3MrIWSbTf09yp0IcMHf3wyWcDvFcyDwy567ScLf/eeL7Yd
         AjFjA8ywKzNTjUzmAZ4gORQRr+qxHsyM8cK7Wf6iBTj+R4nDctpWyXvL/k75aDot6esH
         3BJGSANTbkfjH7lzmp+NqLLxZ7hdl90D2J0H+FzkzTo/9wAgNfgu/JDcp+KDSNJJh5sr
         6tG1ygRpKOJX4le1/6Nb5tTL/DumcwO3/bZpWIvIZ+nccoh91E/PnvHJ3hDZfa8mJglq
         51mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336868; x=1683928868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5LuY1P7B1pC4wEUx/o+TLqKuhLm2bRhk1ulg8tFfDg=;
        b=ekR++n9KqR7HDhYHypUY2iJVp/lRNnPXBD8V87o2tdv5HO4Qu45EykfqBjNUN/iZfn
         5p+v5tNphiEXdcrVEAOcYfRJQOm/hAp2c5P8iv5d/xED34Hw8rkGUU3iKy4W7m3sDesd
         VJoKoN74HK/wsIWa9vQ6vOWgU9WAv1jswPZCaH7Om7oV/Y9a0fig6nEWvlo/qOoYzKaV
         x9apiKLIqrGidPRwDfakwD9TwkoLvn5IREPWt+y1pbDpoF5z0Nn7jvsU+OlQRKCtFCbp
         Nr4RiH0irWOb0+tWK6mYuJsS4gnYpsKnqtggtlnqEyLOoGCetff+dkqoNInsy2hujpWk
         jksQ==
X-Gm-Message-State: AAQBX9efbl42msAocA3wJrr2qgQT3UQ9NMBpCC072RjYSvDVo66/WoeM
        8NHX5qASI65AzP+BcJN/pNxCdQ==
X-Google-Smtp-Source: AKy350bCMBLepJeehk5TJ9GA2wYZL1ok3zEcBWt9I36iOkpn2HF5ZvLsDSu5BOo7ADAsZlMZMzA1+Q==
X-Received: by 2002:a25:1844:0:b0:b3c:b0ea:378d with SMTP id 65-20020a251844000000b00b3cb0ea378dmr15975280yby.59.1681336867856;
        Wed, 12 Apr 2023 15:01:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v72-20020a252f4b000000b00b7767ca747csm4557315ybv.25.2023.04.12.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:01:07 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:01:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 8/8] repack: disable writing bitmaps when doing a
 local geometric repack
Message-ID: <ZDcqIjSUMW4sKNXE@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <b74d0a037b07706d07fad7b438fa0cb211726575.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b74d0a037b07706d07fad7b438fa0cb211726575.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 12:23:01PM +0200, Patrick Steinhardt wrote:
> Now there are two different ways to fix this. The first one would be to
> amend git-multi-pack-index(1) to disable writing bitmaps when we notice
> that we don't have full object coverage. But we ain't really got enough
> information there, and seeing that it is a low-level plumbing command it
> does not feel like the right place to fix this.

I might actually advocate that we either fix this in both places, or fix
it at the lower level only. I think that we would still be able to
trigger this problem by invoking `git multi-pack-index write
--bitmap --stdin-packs` directly.

> ---
>  builtin/repack.c            | 20 ++++++++++++++++++++
>  t/t7703-repack-geometric.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index f57869f14a..07d92fdf87 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -881,6 +881,26 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects = write_bitmaps > 0 && !write_midx;
>
> +	if (write_midx && write_bitmaps && geometric_factor && po_args.local) {
> +		struct packed_git *p;
> +
> +		for (p = get_all_packs(the_repository); p; p = p->next) {
> +			if (p->pack_local)
> +				continue;
> +
> +			/*
> +			 * When asked to do a local repack, but we have
> +			 * packfiles that are inherited from an alternate, then
> +			 * we cannot guarantee that the multi-pack-index would
> +			 * have full coverage of all objects. We thus disable
> +			 * writing bitmaps in that case.
> +			 */
> +			warning(_("disabling bitmap writing, as some objects are not being packed"));
> +			write_bitmaps = 0;
> +			break;
> +		}
> +	}
> +

In terms of the higher-level fix here, though, I think that you could
reasonably assume that the alternate repository has at least one pack,
and that the combination of "write_midx && write_bitmaps &&
po.args_local" and "has any alternate(s)" is banned (or, at least, emits
the above warning and disables writing bitmaps).

But certainly ensuring that there are indeed packs in at least one of
the alternate(s) doesn't hurt either, so I don't mind this approach at
all.

One thing that I don't quite follow with this logic is why we need to
have geometric_factor set. You could (somewhat unreasonably) write a
MIDX containing a single pack (git repack -[A|a] --write-midx
--write-bitmap-index), or a MIDX containing just the new pack along with
all of the existing (local) packs, (git repack --write-midx
--write-bitmap-index).

So I think we'd want to drop the geometric_factor from the above
conditional. (And in the future, I think we typically refer to whether
or not the "geometry" pointer is NULL or not to indicate whether or not
we are doing a geometric repack, though the diff context doesn't give me
enough to know whether we have even attempted to set up that instance
yet, so this is fine, too).

Thanks,
Taylor
