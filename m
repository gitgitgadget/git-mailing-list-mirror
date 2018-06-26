Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3751F516
	for <e@80x24.org>; Tue, 26 Jun 2018 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965434AbeFZNZm (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 09:25:42 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46353 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965374AbeFZNZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 09:25:41 -0400
Received: by mail-lj1-f174.google.com with SMTP id u6-v6so5609390lju.13
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=U9ho6uUApxIM/RUt53NJm+AuZOFSEmqKTM8L4lRSTww=;
        b=GjMuRDOPjKUDhwL3X63rnZSLB3pXG0Oo0LqA4l6nnHP5upG6hxr6uCXAyLGV0QoZcZ
         Z/JpxpaCE1pA1mXI+stc7Q8zS8w1uh8qf+kiJuog7fiHG2FeSxhosFZar2ozTOgdIg2u
         +MmcNdpSHLoktes18AaJRj9OZ/DmHchP+/xRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U9ho6uUApxIM/RUt53NJm+AuZOFSEmqKTM8L4lRSTww=;
        b=s85X76wWZDO08PX2QMnIqXuhT5jxAQ0BM9FpsRh1mkeCL5jtPfvaEnqibuf1E1Ic2b
         MovPpLf4dXcMl+XQZF1n6Nrx9VFCGL/2S7pX8yWCDBGpWGAomPF8wGleC9tFvIHfDJGX
         k868KccJJAtXfcNTIHWIr/CyhO/E85rtXTTN7yj59rfJ7/SwdSTwrldIp26L97KMCOiF
         eFxOheGwefVfeDL2vfOo/D7ki5ZGSxyzYRJmCaeYBTny2y73yoKog3kgTSCtPKw+/Ynf
         3oQ/tRhDrlt+NeMbrQ+YaJIvPb940+XCm/UEXSB6ZaEKoFOMgADJCGUDgi8Fox1mJuYn
         aoEQ==
X-Gm-Message-State: APt69E1DpftWfJGtacr1XpamavPPbg/MiW8dWvpHPTmTLKPUWFHokdua
        nw2CxgWTQ/hPTMV6srdRt28mfKgIc0Ly/4ZUHerChacT
X-Google-Smtp-Source: AAOMgpfI+OCBZng/Mv12CXxJl2pCIpPgWTabeTq9Ua9QxvuW+lOEE1gxpq09X1BLDizKDnihvX5MJVUXBvrC6phe7Qs=
X-Received: by 2002:a2e:94d7:: with SMTP id r23-v6mr1240843ljh.102.1530019539617;
 Tue, 26 Jun 2018 06:25:39 -0700 (PDT)
MIME-Version: 1.0
From:   Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date:   Tue, 26 Jun 2018 15:25:28 +0200
Message-ID: <CAP71WjzHffLRCDbjvF7qpexjXDMFcJkaPpEn=AtbSMCJd6QkBQ@mail.gmail.com>
Subject: git rerere and diff3
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi there,

i have noticed that merge.conflictstyle has an impact on the rerere
resolution. looking briefly at the source code, it seems that git
tries to discard the common ancestor diff3 bits, but what I am seeing
is that if i do the following then it fails:

1. from a clean rr-cache state, with merge.conflictsytle=diff3, git
merge <branch with conflict>, resolve the conflicts, then commit
2. undo the previous merge, remove merge.conflictstyle=diff3 (disable
diff3) and merge the *same* branch, then rerere won't fix the
conflicts

Is that the expected behavior? I am not familiar with git code, but
browsing rerere.c makes me think that it should have worked..

Of course, if I merge the same branch without modifying
merge.conflictstyle, then the merge conflicts are properly resolved by
rerere.

thanks!
