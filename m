Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB86DC3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA77C20870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjoIDTte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgCCRll (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:41:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34592 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCCRll (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:41:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id i10so2875248wmd.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=g6/GR3zY+G9Ld0zxbBZ/wwCLutQbxeomDhytrogKhp0=;
        b=TjoIDTteSERm3w/mN5tBzCAmHHDWXEcLOf5pC2V2rjgqEmxLrYdHe4W+6DTPYL77Jt
         zma4x1jCook2t4Tg2bsJuJPE8DCUZFgzUvDAzZLZBXNeoMRhmsQFF/3gUhyGWZXPHPEe
         3SNSMdlEWxpHeRTa1kh9Gm3Gu+FDgWTG0+sPn8jOXl6AoMqcq9lwZscFh+96AqSfdJo1
         xO2JbBWDFWcJ+dsWcob3PCEAxUDlDxyBId3k8fxR4n7fxrGSjYOca4zZPFy1DHxtGSYH
         cyIKNjyKEtmVzkRIaICWOp4BcHwtaBrCpt+tDRMtrXNAnQoW5bhVPAxZZlGPr97CGt3i
         UhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g6/GR3zY+G9Ld0zxbBZ/wwCLutQbxeomDhytrogKhp0=;
        b=n8qonZfCA5VA6qC6kAkHOf6/HeH4tXi3DpasXjrB+AHY/zfZKSu73OW/23j2zQtLep
         jd8SBLt50kcz9UBBYEqgmbvr89mWLz+Cxm/4RvOYef5/3XFeHgYlpMBlFVLRL9TpOaNE
         +n0vAqhc15G/BtSyyr18YIFAR0G8MsNTPLwZd9Hc7MdQ5AgtDPRacHe28dJ4qgxofiFH
         UwhCfGtxbHKu3fWBP3FL+EhXxBQbCMzNOBfMNsC5KX2Kmm+Pxtmin8ihIVe11T5ZtB6a
         in7m4YY1j/Nr8X/TVf+y1V30M/CMgKOAMF9DRPBudih284mBwNsL6XeEDvOo37enTVVz
         5ohw==
X-Gm-Message-State: ANhLgQ2cV8TO6j8K+Rzas4qAgMyDWQl6ZJ/PW6m2RYcIT5txQhXy3BkM
        VrlfLAwLwxyRv5CHbtPXrb0=
X-Google-Smtp-Source: ADFU+vtWL2C35SKoMzrkA9qTCgl2jWzQLj7a0x0jNpvOTMpmtvyKbJ8xHkYlbYoeasYY935WLyjcRg==
X-Received: by 2002:a1c:1d88:: with SMTP id d130mr5282963wmd.138.1583257298751;
        Tue, 03 Mar 2020 09:41:38 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id m21sm4759735wmi.27.2020.03.03.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:41:38 -0800 (PST)
Date:   Tue, 3 Mar 2020 18:41:36 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: update the documentation of pack-objects and
 repack
Message-ID: <20200303174136.ess5lfxrsrt6qvdu@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 18:26:46 +0100
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
 <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
 <xmqqk142bn5f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk142bn5f.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Mon 02 Mar 2020 at 10:57:16 (-0800) :
> Missing full-stop (.) at the end.

Oups.

> > +--write-bitmap-index::
> > +	Write a reachability bitmap index as part of the pack. This
> > +	only makes sense when used with `--all` and the pack is not
> > +	outputted to stdout.
 
> Using "output" as a verb and conjugating it like this makes my head
> hurt.  Let's instead borrow the phrase used in the description for
> the "--stdout" option, i.e.
> 	... and the pack is not written to the standard output.

Yeah I was not too happy with my formulation either...

> It took me a while to realize that this only inserts "are passed to
> `git pack-objects` and" and does nothing else.  It would have saved
> reviewers' time if the whole paragraph did not get rewrapped.

Sorry. It looked to me like the documentation has an implicit wrap of
around 78 characters, so I rewrapped the paragraphs accordingly. But you
are right that since I was expecting comments on this patch anyway, I could
have rewrapped only in future versions, to simplify the diff for this
version.

> I wonder if it helps the readers to tell the implementation detail
> (i.e. are passed to X) upfront like the updated text.

It is also a question of consistency. Some options are already documented
as being passed to git-pack-objects. So when the user (ie me :)) sees an
option in git-repack that also exists in git pack-objects, it is natural to
assume it will be passed too, but since this is not explicitly stated for
*this option*, whereas it is stated for *other options*, the user may wonder
if this is truly the case. The user (still me :)) then looks at the source
code to check, but would have appreciated if this was already in the
documentation.

> It is true that it would help the interested readers who want to know
> _more_ to tell them that these corresponds to the options the underlying
> command has so they can go to the documentation of that other command and
> read more about them, though.

And it also helps to illustrate how a 'porcelain' command like 'git repack'
uses a plumbing command like 'git pack-objects'.

> >  	`--window-memory=0` makes memory usage unlimited.  The default
> >  	is taken from the `pack.windowMemory` configuration variable.
> >  	Note that the actual memory usage will be the limit multiplied
> > @@ -122,6 +123,7 @@ depth is 4095.
> >  	prevents the creation of a bitmap index.
> >  	The default is unlimited, unless the config variable
> >  	`pack.packSizeLimit` is set.
> > +	This option is passed to `git pack-objects`.
> 
> Here, you use a different way to add the information to help readers
> who would want to learn _more_.  And I think this approach makes
> more sense than the previous two.  All readers would appreciate if
> they can learn what they need to know to drive _this_ subcommand on
> the documentation page for _this_ subcommand without having to
> consulte another page, but those interested _can_ use reference like
> this.

So currently in the documentation of git-repack, for options passed to
pack-objects, either
1) it is stated that this option is passed around and the option is not further documented (apart from refering to git-pack-objects(1)), eg -f, -F, -l
2) or the option is documented but git-pack-objects is not mentioned.

So for options of type 2) I added a link to git-pack-objects.
I agree with you that it would be good if options of type 1) were also
documented in `git-repack`; it is annoying for an user to have to open
another man page. I can do that in my next reroll.

> > +Default options
> > +---------------
> > +
> > +The command passes the following options to `git pack-objects`:
> > +`--keep-true-parents`, `--no-empty`, `--all`, `--reflog`, `--indexed-objects`.
> > +It also add `--exclude-promisor-objects` if there exists a promisor remote,
> > +and `--honor-pack-keep` except if `--pack-kept-objects` is passed.
> 
> This is somewhat unconventional.  I think we usually say, when
> describing each option --<option>, if it is enabled by default.
> I kind of like this sort of summary where options that are on by
> default can be seen in a single place, but (1) if we can reach a
> concensus that this is a good practice, we should do it in more
> places, and (2) if the sections for these individual options do not
> say that they are on by default, we should make them say so.

The problem here is that
`--keep-true-parents`, `--no-empty`, `--all`, `--reflog`, `--indexed-objects`,
`--exclude-promisor-objects`
are always passed and not driven by any options of `git repack`, so I
did not know where else to put them.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
