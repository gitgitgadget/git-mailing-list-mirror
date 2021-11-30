Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE47C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 10:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhK3KfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 05:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhK3KfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 05:35:12 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DC1C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 02:31:53 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id w23so40317288uao.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jxFr7e/dlR14QPec66NLggCS6mZKXH7FfpjQEPduEf8=;
        b=eiiPsOpm+koyP6ufOozYzJWI9hAisW4X0MbWgdY/duBXsJkqMpl4ClpbATdSH3CcbL
         gwLIkm0oDcEHidajFjH7z9Byixz3tNbXRsZegW9RuzB/BzzHSjJK5Fqq8Pef+2dy+ZeC
         sDyaEoN+q+pu/pwmw4gVdpN7WBv3RGT6+xaUSbymZUWd6zW5opN7b18XfhunNMcjvIAf
         2nnt/QwNtw/rB66O+Sl7Uk6CKjqMrBcZv9s/aYdFv+CUarfDVij533pZHp3W91Pd5Xhh
         ugpbbePgeyK9Ss4aiwoPPzwFp1AmD9rngG2GbRE7/TOwi/YW9JfZth7qJ2Y1QZA8qzXG
         Kt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jxFr7e/dlR14QPec66NLggCS6mZKXH7FfpjQEPduEf8=;
        b=511sy74zh2Kd0n2tj5i7S5MjqVZ0YNURNprDlNyd4d0nnssNxUcXG6pvzdrIxljj35
         Snxwlg7cqD+YFYsmTCisFOh6VAlcDkg3LSQnmloEfY3vcvLutJphM1fBi9Ogdr0EO73u
         6y8/fcvUCjQ/2kbq0B3CBhO86LA2kL33g0lHmoaxnBGob7u4yaMkWLS8H+Xd/FijmqwI
         Fs48O6WPy432f5xIv/n6JSLnlLpTj18g8KVzvjJrA5zf2cgdlC0K079wMtGBzXadPQWZ
         vQaBK0eFzJ+voKL2mDwdqKM9L6STBr9lZ4w2P9N9oSmmJuLGkxuqTnMAGaAPxyFMWkU1
         AA4A==
X-Gm-Message-State: AOAM5301ALz/U3xz6oqrZTkE7zUrhU0Y5f3HoYfkchDjk6bLUsnFmWrU
        2m6gXsZKnTl38gruNoy5soYzSqiN9QU8G1BFEkAAQUdEfYI=
X-Google-Smtp-Source: ABdhPJxAhezl5h42Wyxkdjy6M0ACLZrYVLoewn7PYI4j1rXQv53V4a/ooscCfXl/iUOvKCxKQ4FlkVRYrrFElcfkbqw=
X-Received: by 2002:a67:c40c:: with SMTP id c12mr39743389vsk.16.1638268312715;
 Tue, 30 Nov 2021 02:31:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
 <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com> <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
 <xmqqbl224k09.fsf@gitster.g>
In-Reply-To: <xmqqbl224k09.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 30 Nov 2021 11:31:39 +0100
Message-ID: <CAFQ2z_M35tbF6+C2MkMRm7hO8CNdUSrGTcx+8Os348+rHu4ojg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 12:31 AM Junio C Hamano <gitster@pobox.com> wrote:
> > +     if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
> > +         ((new_oid && !is_null_oid(new_oid)) ?
> > +                  check_refname_format(refname, REFNAME_ALLOW_ONELEVEL=
) :
> > +                        !refname_is_safe(refname))) {
>
> So, if somebody passes REF_SKIP_REFNAME_VERIFICATION in flags, we
> will not do the check.
>
> Again, like 3/6, this new bit is flipped on by test-helper
> somewhere?  Again I do not see anybody doing so in these 6 patches,
> but I should double check.

The test helper takes the flag as an argument, in decimal. If you look
for 2048, you should find it.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
