Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA09BC001DE
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 10:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjHBK37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 06:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjHBK3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 06:29:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377D49F6
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 03:26:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so9483676a12.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690971899; x=1691576699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WnP9l5D+LrfAIZsd+HaoYlIVizQvyK39UjTlqwf6wA=;
        b=mcTT4EDWITtjLJ78k4nDIBur76RuDjdkx37i/uPaw4Q7k5hLDAJJ3qAUtHJPI1d8x1
         aBU051vw2gfDYYRM9RjKZbaHmj5ZC2MG81YkRsL0xirh0nrc2tB9sPUu9bHkiyD8FKmp
         F3gDIkMFDNudPD9GpvGdWCChmZt4P+MMdGh0+UWQgLrwvNYGQOopocTpSvOAiiDL7QLE
         tTWuWM1EJOKVt2byk2IvllRmNAyZfqUYm1NKSO+iy4/trJQe5XItDS4MJMcXLL1PZr+Q
         TmGsMlFxKIx6XLn66wB+a2J4r2F7PIPkVSF4XWq9EqZrlvJ/cDht2sP6d8yetEhhH+xw
         nqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690971899; x=1691576699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WnP9l5D+LrfAIZsd+HaoYlIVizQvyK39UjTlqwf6wA=;
        b=PvKXCbrkSs94q8thwNVSXiU4DEaCbDvdbKgDarHlPb2gaaspNeNKwzpCF6cIY9/9Tb
         Kif3wf0HIgPmBswvLVuQ8/48nKGZMVVYbUqQyMpB6DZnH+/e/3LLCxXj1atl3T0ebweT
         1lCrv4TKCYG0e5U7j/jq8vNBBDNAMY0Yi+H1KMWGVfiJLsdiWu2duSneEPeeB6DAPItP
         thzT9d8AklR600O22RRQIpF9UGp5AK0eFnryRYQWnzKs8YKzpvA875pWQGC7bFZAcNV1
         6jwojqv2ZYmR8cf+OOPD4L/24Xo4VxY8d9BtAD/0q3WKfISoU5bCNfmwY2MAQHleUyDw
         Q54g==
X-Gm-Message-State: ABy/qLbp5PbL90s86ufN3VL1y4RJVwFuWW1NhNQZb5tYoPjVXOCTxxr4
        YdR00IE0g2eHwEunQAmDvg2Bb3jvNAyMdc6vJOkYOeIH5/U=
X-Google-Smtp-Source: APBJJlFS6+QEBU5Nt6GOzolrfhIF2yBrDP7nODcKVWbBOdthsLcuclEy58CfoOjCjUCKRYgIqm6E/BCqVXd/W/+YEEw=
X-Received: by 2002:aa7:d382:0:b0:522:56d8:49c0 with SMTP id
 x2-20020aa7d382000000b0052256d849c0mr4634409edq.37.1690971899433; Wed, 02 Aug
 2023 03:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RvAbmS1SwFja8_+NSBBoL0gTH1RgpSN5CYtDWZscMYZA@mail.gmail.com>
In-Reply-To: <CAOLTT8RvAbmS1SwFja8_+NSBBoL0gTH1RgpSN5CYtDWZscMYZA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 2 Aug 2023 12:24:47 +0200
Message-ID: <CAP8UFD02tYrz+bxoR_GQfYuxxrmv5=BXjcZuiqXbX3m7N2dPaQ@mail.gmail.com>
Subject: Re: [Question] git rev-parse verify for non-existent object
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2023 at 9:50=E2=80=AFAM ZheNing Hu <adlternative@gmail.com> =
wrote:
>
> In my case, I often need to use "git rev-parse --verify" to verify
> if a revision exists in the repository, and this usually works:
>
> git rev-parse --verify HEAD
> afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3
>
> git rev-parse --verify afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3
> afa5ff0f56bc60d1c9abe839726e7fb2105a9ca3
>
> git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> fatal: Needed a single revision
>
> However, when I started checking for a non-existent OID that happened
> to be exactly 40 characters long, something unexpected happened.
>  "git rev-parse --verify" did not produce any error messages.
> I consider this to be a BUG.
>
> git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

The doc says:

"
      --verify
          Verify that exactly one parameter is provided, and that it
can be turned into a raw 20-byte SHA-1 that can be used to access the
object database. If so, emit it to the standard output;
          otherwise, error out.

          If you want to make sure that the output actually names an
object in your object database and/or can be used as a specific type
of object you require, you can add the ^{type} peeling
          operator to the parameter. For example, git rev-parse
"$VAR^{commit}" will make sure $VAR names an existing object that is a
commit-ish (i.e. a commit, or an annotated tag that points
          at a commit). To make sure that $VAR names an existing
object of any type, git rev-parse "$VAR^{object}" can be used.
"

So "--verify <argument>" only checks that the <argument> provided to
it can be turned into a raw 20-byte SHA-1 (or perhaps a raw 32-byte
SHA256 in case the repo is using SHA256). "^{object}" should be added
at the end of the <argument> if you want to verify that the raw
20-byte SHA-1 (or the raw 32-byte SHA256) also corresponds to an
actual object in the repo.

$ git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa^{object}
fatal: Needed a single revision

Hope this helps.
