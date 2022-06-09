Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B1C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 06:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiFIGPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 02:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFIGPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 02:15:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F710F1C5
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 23:15:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so36364306lfo.13
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faYfcniCgum9e1tBPKIwemFq2Au3i7mX6fl1lMSeFTc=;
        b=itgxoXKkUZNvL6bzpx92XJre978I1DG3ZpwQQbK3iKotVlw/MdAXIojmum3BIx/IuF
         MwkV+4BDm0dMTvrU95c0MXCAKds1ZhEcRViT0D6tD9nUAGV5p9NR+VCeaVIh+Jb8Co2Q
         4H3shCOgrJZqqKmM78GSWwwOs/cvyZ+OWst4io1Hn+qGR2f77gtPe7rXtMcddIpBTZ5v
         vx+3W8XcScIDt0HulAmh5CfojjpPC53zP0gBCP130nRAVQrRcqKlveCBqHE1oq+XIk1R
         QGgvIMeYCZ7RAYd6cLA9Y+TfxkgFVOUtHO4OY2svLjdx0NCTr6m6vX7WdVmamrlVMu7F
         CKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faYfcniCgum9e1tBPKIwemFq2Au3i7mX6fl1lMSeFTc=;
        b=3cOQ4Gt/dN8ulQ+6BEf46nrUL5hxIMXjTt/GD7/4cYdoN+aFWGz2DIkJgwymGI7DY5
         /6QbIifj5kg8r0dKdclLWLv0EcclZrKqoXLx5eyMEi+sGwUZ46+AaltSDTnL6kDeHah+
         yWRjENrJrectQyKZ+ZOd+CvAtXoi8k+snJw4rjLuXlfcy71b3Ykzg+zio1sbo3chmFNY
         OFMyrL0pJsMq0mKqKzuFJEevRGjsIZAEuQfVcX9FYfrpTn5gaD8IH5oSW+LG4YBEsvTV
         tS993I5PSQmBbD1tmGOlHTEuxToM+kJUQh0XDlQWiz1ZpqqCP4tnWQuEbo/yAS0Bp6L5
         WQsQ==
X-Gm-Message-State: AOAM531O9cGeEl5eJsMbSwy/BHo8sMrQnDHl2iM4mgCtpVjVsCeWJwVd
        saycJ1idqs0oKxeqYUutpmJx+YCBPHVah0o9VcE=
X-Google-Smtp-Source: ABdhPJwteqp+ZtVdlkGJuzq66oJzZdDXdWGjgyF+TyQXaYhsKmfYaDblm/VOyNeY4O76brZzc9fVT69AtgPfeBZ+RW0=
X-Received: by 2002:a05:6512:1288:b0:479:40f2:d885 with SMTP id
 u8-20020a056512128800b0047940f2d885mr12825816lfs.660.1654755304181; Wed, 08
 Jun 2022 23:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com> <xmqqy1y960hq.fsf@gitster.g>
In-Reply-To: <xmqqy1y960hq.fsf@gitster.g>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Thu, 9 Jun 2022 14:14:53 +0800
Message-ID: <CAO0brD3tq-18p8g3P7DX=L=2zzUJnZXN_CRisM4cFRDhpZpU-g@mail.gmail.com>
Subject: Re: [PATCH v13 5/7] object-file.c: add "stream_loose_object()" to
 handle large object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 7, 2022 at 3:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> > "freshen_packed_object()" or "freshen_loose_object()" will be called
> > inside "stream_loose_object()" after obtaining the "oid".
>
> That much we can read from the patch text.  Saying just "we do X"
> without explaining "why we do so" in the proposed log message leaves
> readers more confused than otherwise.  Why is it worth pointing out
> in the proposed log message?  Is the reason why we need to do so
> involve something tricky?
>

Yes, it really should be made clear why this is done here.

Thanks.
-Han Xin

> > +     ret = end_loose_object_common(&c, &stream, oid);
> > +     if (ret != Z_OK)
> > +             die(_("deflateEnd on stream object failed (%d)"), ret);
> > +     close_loose_object(fd, tmp_file.buf);
> > +
> > +     if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
> > +             unlink_or_warn(tmp_file.buf);
> > +             goto cleanup;
>
> So, we were told to write an object, we wrote to a temporary file,
> and we wanted to mark the object to be recent and found that there
> indeed is already the object.  We remove the temporary and do not
> leave the new copy of the object, and the value of err at this point
> is 0 (success) which is what is returned from cleanup: label.
>
> Good.
>
