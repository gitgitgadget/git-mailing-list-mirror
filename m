Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D3CD610E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376329AbjJIREq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377266AbjJIREp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:04:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DB3BA
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:04:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so8395377a12.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696871082; x=1697475882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFmZoEKbBB0nCnZhs2mFW4bXPOSgvCrcIjsObOasvf4=;
        b=j/VaZr/ucgsU+8mzHCEnHMCdEuhLtcCL/UwazStzwE3ox5fgTqy5cMgGZNY4eEjC4B
         gq7/gFNiDswmd13Bf9XbwOciCw5p8B0givQ7ubkqlUG6pKRnu5IyDLsUgNtt6on16w2e
         FR0T5ChkOf8ugq8000IkOILVkL1KzQWnRkfysPjCLE+gcHRRt+9kpwrXg0f8LiFIQWyX
         ekDtwqidS5mNfsy/Gir3DAis/ol+9pDQa3nR0I+p0U2zkHUL+aAX0IabJuLzl4gOpY8D
         oHkS7hZC2IC5Cq6V7X1EMpvhmmNXc0xAffJ9Noa+hQy8pNI3Qxcu2Hprk0YaIrnQFhYO
         MvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871082; x=1697475882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFmZoEKbBB0nCnZhs2mFW4bXPOSgvCrcIjsObOasvf4=;
        b=cHWmje0Z5Xc39XRIpuij6ViJa9F9boPLldDDuHciMmEAviD6W82AUvFtu7m8NAwXg+
         SLeBjjLKbEeTY17MjHaxr8mrWNSOh4l2kj+lEQbekD5KxBrniCpL8pcyk6SOG04X6Je2
         slxazfHECF2M7yDEgmFohDYFJNQIbaKe856Wl1f1JfUtMvhSVd9zccT2epOlF6Rvkcv5
         t653iB40WvZEfJMkv+3SxSZ+W5d4ErEw6q4qKlc1SFzRNZC06JZ3s78yIbiLPNO2/K6G
         ekuIRRufj5MsmFYEnPoaffv4dbhBT7gmhQwFNmaY9JnUtM835kI0sssGEXye1KrmlTUr
         QdVA==
X-Gm-Message-State: AOJu0YyxJlrpA5eq+XiPlK2wx1jKcTsZJ7cR3Di9aHCK5Cpqw+EcK02+
        6HDQW+dwr0/c/XGOK0DrDQz4o4+dOf0mhZ5JD7HOgQDF
X-Google-Smtp-Source: AGHT+IGxDqGhyARXigPi9hBAk1eY3M4T3cP/ZR0YfqV6u0x1a6edZl1hXXYXrnbX62QQSGmtwapsdk5vgP+em632zsg=
X-Received: by 2002:a17:907:75da:b0:9ae:40d1:999b with SMTP id
 jl26-20020a17090775da00b009ae40d1999bmr15601594ejc.16.1696871081574; Mon, 09
 Oct 2023 10:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230909125446.142715-1-sorganov@gmail.com> <20231004214558.210339-1-sorganov@gmail.com>
 <20231004214558.210339-2-sorganov@gmail.com> <xmqq34yog3ux.fsf@gitster.g>
 <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
 <xmqq7cnzaav0.fsf@gitster.g> <CABPp-BGxVnhnmoajWyqY_gMvQ42W5S6VX5EOXq3PW=GLVQwe0g@mail.gmail.com>
 <xmqqjzrz5hgn.fsf@gitster.g> <xmqqmswv3p11.fsf@gitster.g>
In-Reply-To: <xmqqmswv3p11.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Oct 2023 10:04:28 -0700
Message-ID: <CABPp-BGL_QzRd3mRhSF7rHYNA4pFWfKPA+UuZDODFgEv-1BHhA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2023 at 11:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> In my opinion, --remerge-diff does this better; wouldn't we want a
> >> ...
> > Between -c and --cc, I do not think there is anything that makes us
> > favor -c over --cc.  While the algorithm to decide which hunks out
> > of -c's output to omit was being polished, comparison with -c served
> > a good way to give baseline, but once --cc has become solid, I do
> > not think I've used -c myself.

Perhaps, then, the user manual should either omit -c, or recommend
users use --cc instead?

> > I personally find that a very trivial merge resolution is far easier
> > to read with --cc than --remerge-diff, the latter being way too
> > verbose.

Ah, indeed, for those that know the --cc output format well (it takes
a bit to figure out for newcomers), your example demonstrates this
nicely.  Thanks.

> > Also, --cc and -c should work inside a read-only repository where
> > you only have read access to.  If remerge needs to write some
> > objects to the repository, then you'd need some hack to give a
> > writable object store overlay via the alternate odb mechanism, or
> > something, right?

Well, it does use a temporary object store with the alternate odb
mechanism already, but I don't think there's any code to allow the
user to input the location for the temporary store, and thus we'd
probably attempt to write it underneath the same read-only directory.
So, yes, read-only repositories would likely be problematic for
--remerge-diff.

However, are read-only repositories worth mentioning in the documentation h=
ere?

> Well, the above did not come out as well as I intended, as I forgot
> to prefix it with something I thought was obvious from what I said
> in the recent discussion in the earlier iteration of this topic,
> where I said that it would be "--remerge-diff", if I were to pick an
> option that is so useful that it deserves short and sweet single
> letter.  Narutally, it came after we gained experience with "--cc",
> so it would be surprising if it did worse.  Just like it is natural
> to expect that "--cc" would give more useful output than "-m -p"
> that predates everybody else.
>
> In short, I would say "--remerge-diff" would give output that is the
> easiest to grok among the three modern variants to show the changes
> a merge introduces.
>
> The above two cases, where I said cc does better than remerge-diff,
> were meant as _exceptions_ for that general sentiment.

Thanks, this is useful.  This does make me wonder, though: Should we
perhaps guide users as to what we recommend (and recommend against) in
this documentation?

If we have lots of options and they all shine on different usecases,
it makes sense to just provide a long list of possibilities for users.
But if we generally feel that one is entirely supplanted by another
(e.g. -c by --cc) it seems beneficial to mention that, and if we
generally feel that one will often be clearer or more useful than the
others (e.g. --remerge-diff), it seems beneficial to recommend it.
Thoughts?

Also, perhaps this would be best to include in a follow-up series (as
it appears from Sergey's latest iteration that we are leaving other
tweaks for a later series anyway), if we do decide we want to do it...
