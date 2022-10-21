Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D38C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJUXpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJUXpb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:45:31 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5163024C94A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:45:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y80so3611993iof.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HP/KJFuZWxvZJu+RpC7UleD4wepOQYqtSTpwKYM2DOY=;
        b=t6DGQV7DiIEw9lvxgg5xz2sYAgqMmyElRcqmlEGF7/wF5tx5F3jrgE2n7GCXTm9A27
         CCEoAZkABgd4USqE0audvLV9BqsDnKQ/0r54neb6y3ubzp4vfz8hgTqt0qpT9xCEaoSE
         FCypjta8E8elJjA1Ja7IVTNCj26SipD61C0eIhxOrTOM40wyOaHv5G3U+2m5p2XEHzd7
         XefP+sa+rHHylmgXAYngPLFc0vh7H+LAQ3xqGM5Akf68+BS4ShT5i4bKOFo+Mw1b/1h3
         a1ZbLpDxvkxMvK2N0+NZr4eI/ipU3571AyNK0IIXHLbyu8T7Qz7C+UkjqVOshIj69Opj
         plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP/KJFuZWxvZJu+RpC7UleD4wepOQYqtSTpwKYM2DOY=;
        b=vUd4Im073gcc38fzjLZgv2TGpFHJFwvSs7hLP/7Vi5+xL00m0+RXrkssgfdwyN+pQX
         OWGC5rJgu0/ZwhnR51aqLFNSfmUZHHs3qFh15VqSMbKeK1elJewrnkeRP0eUakgoJcOT
         LjhRNivkgKQ7tSgHrRigMRbkMeHFxc5qyQAKQAlOneeoyubgoLKr1VddoBMqlujji4tO
         fXV9QWgH4B9P7ygDkk7kfkZdzuUNi4v0JhTbRcm/flgLoz0bPwBqlC18fNNxvbj2vPh8
         XTHoZ+l8/yNX6jIuGXhy2Z165q76de/p74r3jhxu0t5yJsSh8Yb1vl3GFEmxjq3vaNv9
         61/Q==
X-Gm-Message-State: ACrzQf1RXht5QZKt/BL406FHEW6+irnVZMtqlipU/IbMGGE/39mS+5o4
        xcj0UfSTndCIS5Smgxg34S9iDg==
X-Google-Smtp-Source: AMsMyM5XpdBV4R3+elB0XydCeK2CvTsX801qRkG0qxRB254vdtrbHDohYR1ADZQ5Of6Ni4DGv04XjQ==
X-Received: by 2002:a05:6602:148a:b0:6bc:dbff:d9b0 with SMTP id a10-20020a056602148a00b006bcdbffd9b0mr13781594iow.48.1666395929698;
        Fri, 21 Oct 2022 16:45:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z16-20020a92bf10000000b002fb78f6c166sm4537196ilh.10.2022.10.21.16.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 16:45:29 -0700 (PDT)
Date:   Fri, 21 Oct 2022 19:45:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 3/4] repack: use tempfiles for signal cleanup
Message-ID: <Y1MvGIVz9bTTsS25@nand.local>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MTJz3wy5xDEPEH@coredump.intra.peff.net>
 <xmqqmt9oizcq.fsf@gitster.g>
 <Y1MqPjnYoWcOgXo6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MqPjnYoWcOgXo6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:24:46PM -0400, Jeff King wrote:
> On Fri, Oct 21, 2022 at 03:30:29PM -0700, Junio C Hamano wrote:
>
> > > @@ -867,8 +860,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> > >  		split_pack_geometry(geometry, geometric_factor);
> > >  	}
> > >
> > > -	sigchain_push_common(remove_pack_on_signal);
> > > -
> > >  	prepare_pack_objects(&cmd, &po_args);
> > >
> > >  	show_progress = !po_args.quiet && isatty(2);
> > > @@ -1020,14 +1011,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> > >  			fname_old = mkpathdup("%s-%s%s",
> > >  					packtmp, item->string, exts[ext].name);
> > >
> > > -			if (data->exts[ext]) {
> > > +			if (data->tempfiles[ext]) {
> > >  				struct stat statbuffer;
> > >  				if (!stat(fname_old, &statbuffer)) {
> > >  					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
> > >  					chmod(fname_old, statbuffer.st_mode);
> > >  				}
> > >
> > > -				if (rename(fname_old, fname))
> > > +				if (rename_tempfile(&data->tempfiles[ext], fname))
> > >  					die_errno(_("renaming '%s' failed"), fname_old);
> >
> > It now got a bit confusing that we have 'fname', 'fname_old', and
> > the tempfile.  The path.buf used as the argument to register_tempfile()
> > matches what is used to compute fname_old above.  I wonder if tempfile
> > API does not give us that name so that we can stop using fname_old here?
>
> It does, and we probably should use get_tempfile_path() in the error
> message here. But sadly we can't get rid of fname_old entirely, as it's
> used below this for the second block in the if-else chain:
>
>   if (data->tempfiles[ext]) {
>      ...do the rename ...
>   } else if (!exts[ext].optional)
> 	  die(_("missing required file: %s"), fname_old);
>   else if (unlink(fname) < 0 && errno != ENOENT)
> 	  die_errno(_("could not unlink: %s"), fname);
>
> OTOH, it would probably be equally readable (or perhaps even better) for
> that second block to say:
>
>   die("pack-objects did not generate a '%s' file for pack %s",
>       exts[ext].name, item->string);
>
> And then we could drop fname_old entirely. Which is nice, because it
> gets rid of the implicit assumption that the tempfile matches what is in
> fname_old (which is always true, but since they are generated by
> individual lines far apart from each other, it's possible for that to
> change).

TBH, I've always found fname_old to be a confusing name. It's not really
"old", in fact we just had pack-objects write that file ;-). It really
does pertain to the tempfile, and I think using get_tempfile_path() when
we have a tempfile to rename is sensible.

I think that your proposed error message is good, too, and doubly so
since it lets us get rid of fname_old entirely. Yay :-).

> -Peff

Thanks,
Taylor
