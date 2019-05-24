Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A21E1F462
	for <e@80x24.org>; Fri, 24 May 2019 06:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfEXGpf (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 02:45:35 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45850 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388359AbfEXGpf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 02:45:35 -0400
Received: by mail-ot1-f53.google.com with SMTP id t24so7717275otl.12
        for <git@vger.kernel.org>; Thu, 23 May 2019 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EkVJrxb7oRJWLCm4DdJv6jFJAkEGeWEu7ivGPRZ833w=;
        b=TwXUPcBBa+aQxc70t/FNsHbUwxwjT9fzwQ1hiX95vWfXVto+C13nVidldgttCLDedy
         IjBC9PVpBE1XkifftC1ksB4DlMg0g9Swrqn1OCda22766VSAT0S+eQ2AM7KcEEV2JN9U
         9+ART7KzHPHW5cGUyFeLAgXuXBHbqbMvEMMXcCmj6tMa6vRFlH72IKyH0wfqIELqxzSk
         Ic6w5JpQkzw9eL8kpBEPmBRO2XpK1KvHcJsPU9PYF/aoanAZdLcbCAz5O91ktn/PMJEY
         XEkxFNBx2cVrM7jyrq7RGR7skhY/UN2Zhkv9N+GZi71+OhaoySuvsk+FUVXwafG5491U
         buSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EkVJrxb7oRJWLCm4DdJv6jFJAkEGeWEu7ivGPRZ833w=;
        b=bIs9nys4fYAL8pg+LUg+ADkhs67M3rnBA/iWmCvsLXKakNQlwTX0j9iHxZ43LVm+Pk
         c70pKgVmxCvdGBqnbpq4lTezGmSjHCVEyWaPnnx7OC0srXwIjQVaRAxEEx2N1+VW6iw3
         IdXEDN56+QwWNDUKN2UNiAJT5DtBUj+qQ5OvL5+TGq6TGROeL7AZDVTGGqmQodzipLXt
         dJaAsXkjQB8AqeIyXRk3TUAIfZcQehb6VAhM0XT/5C9Mw1z60k4ZuThoLYQJM3KiQWvm
         edplsTWZ8zku4mQUD/J3ItXCI8ihdBCULPoiWr+YerIqzo8rbOoA9Uq/Mf90XLlvPQw7
         b9Rw==
X-Gm-Message-State: APjAAAWKyBDGbODFSIXgjJAqkWxgomplTpkzmDuzQXqMyUP1tM39bDZJ
        lP1jQQXpEtA/u7U77Ni9oQrNFeENsf3IeqsvqCPxi8RJkEg=
X-Google-Smtp-Source: APXvYqzgn1EukP4c/wSS7YQ6Ml0d4w1pRCfbNpe9dMPIRHGftF7FexsRwH2JhOf8M9ezEF5kwLMGViDzH/Z9rNaWPh4=
X-Received: by 2002:a9d:361:: with SMTP id 88mr24639204otv.361.1558680334628;
 Thu, 23 May 2019 23:45:34 -0700 (PDT)
MIME-Version: 1.0
From:   Keegan Carruthers-Smith <keegan.csmith@gmail.com>
Date:   Fri, 24 May 2019 08:45:23 +0200
Message-ID: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
Subject: git archive generates tar with malformed pax extended attribute
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

git archive can generate a malformed tar archive. bsdtar reports the
error "tar: Ignoring malformed pax extended attribute" when reading
the archive. Go's "tar/archive" package also reports the error
"archive/tar: invalid tar header". However, BusyBox's tar does not
report the error (unsure if it just has less error logging).

I can reproduce this when generating the tar on linux and mac. I
tested this with "git version 2.21.0" and a build of next I did today:
"git version 2.22.0.rc1.257.g3120a18244"

Reproduction:

  $ git clone https://github.com/SSW-SCIENTIFIC/NNDD.git
  $ cd NNDD
  $ git archive --format tar c21b98da2ca7f007230e696b2eda5da6589fe137
| tar tf - > /dev/null
  tar: Ignoring malformed pax extended attribute
  tar: Error exit delayed from previous errors.

Kind Regards,
Keegan
