Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E80C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046D96100B
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhFRVhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFRVhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:37:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C768EC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:34:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so11101024oti.2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FG1tdi09lZNHFlv2e+q+ERTryKDll3zT/NDLVhmqEa8=;
        b=uxnfuVDWLD0dzElGawIpHNJ28N4A8QZiZXwU8oGu4/ifDgBmECpkVsPo4wXEGC1ryK
         YGv+YQbfXDwcqJQlNXiTaxEy1NWTfS0QAUVGVI2uC6WuX2/f6/msxLSKG+58DvzUcbWO
         +27wpHuSKh0avVv5h99jUYbaRZfN4LIpx9uw1epUuuJ6jXQcQ+J41tEGTu3U70A8Dpqz
         p/d+8XZ3maxR+Gf1wXkEYZHcrBPUDSPdY0tyEKkK/wPGgtRkR89PBJfgV0KiH50WW8Nk
         lENnXnzYRS07VUvMP2nl/E7AIBaDW3jAFQUtp2HGKYiEWwMmbSESAA9XvpTO4S87MtdE
         TNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FG1tdi09lZNHFlv2e+q+ERTryKDll3zT/NDLVhmqEa8=;
        b=mesXmKaLRE9xbVlOri7kkih1koW9pBXUcKJp9IdgyF2QhKEI3o/ppAsi9wKzPfAg25
         qJYPtGW/I5Q0LpITDdr7oNMg2khUhU17CwdqvJKCv+UVZy3BHgfXeoqgOqDOcKW04aa0
         VkjOAky0EpdLkLx0sBGnvcmQZ1szZjLMnsBFDXwtLZJmAn2G1ntTkPyzeudHOrnyMmJU
         dM1keNO9kf5sk1SOA1fqMvv1nZ7gmB9pH4ttGAWr/P4LYiLKd2pD3Hfc3m65NzI6C8Lt
         0pc1oneMUvcfBPfGRpRapCIXEXU5K99dQ1P0LR3UNrPZzXn+6d7flYpIZaFmFi5jT0ga
         xOhg==
X-Gm-Message-State: AOAM531d4uNYoWLpRxIKCTyjgiAgwaeQWsaC1AheC+TFg4qytflwnIEj
        0rXLrrhAONAiJamNgyRwpbE=
X-Google-Smtp-Source: ABdhPJw1mStaihNis9o+PBH4lHCXLCgsu/dC3ainT+uHCcjRJOxFIRx4RyXFs+eTYtzOQulRrmrKlg==
X-Received: by 2002:a9d:2dc2:: with SMTP id g60mr10881280otb.54.1624052098132;
        Fri, 18 Jun 2021 14:34:58 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w12sm1693601oor.35.2021.06.18.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:34:57 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:34:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <60cd118096008_c0ff92085b@natae.notmuch>
In-Reply-To: <20210618203057.790320-5-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
 <20210618203057.790320-5-felipe.contreras@gmail.com>
Subject: RE: [RFC/NOPATCHv3 4/4] doc: remove GNU_ROFF option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
> 
> By default, groff converts apostrophes in troff source to Unicode
> apostrophes.

This has nothing to do with the actual problem. As stated in groff(7)
the apostrophe ' is converted to single closing quote \(cq.

Our problem was with acute accent \(aa, not \(cq.

And it was due to docbook doing \' where it shouldn't, not groff.

> This is helpful and desirable when being used as a
> typesetter, since it makes the output much cleaner and more readable,
> but it is a problem in manual pages, since apostrophes are often used
> around shell commands and these should remain in their ASCII form for
> compatibility with the shell.

manpages should use \(aq if they want an apostrophe quote '.

> Fortunately, the DocBook stylesheets contain a workaround for this case:
> they detect the special .g number register, which is set only when using
> groff, and they define a special macro for apostrophes based on whether
> or not it is set and use that macro to write out the proper character.

Once again nothing to do with the issue.

The only way in troff source to specify an apostrophe quote is using
\(aq, but that only works in groff. Since there's no better way to
describe the same for other troff programs ' should be used for
portability.

Doing this:

  .ie \n(.g .ds Aq \(aq
  .el .ds Aq '

is not a workaround: it's a proper implementation of a generic apostrophee
quote that works correctly everywhere.

> As a result, the DocBook stylesheets handle all cases correctly
> automatically, whether the user is using groff or not, unlike our
> GNU_ROFF code.

Yes, but you are not mentioning where it was broken, and when it was
fixed.

> Additionally, this functionality was implemented in 2010.  Since nobody
> is shipping a mainstream Linux distribution with security support that
> old anymore, we can just safely assume that the user has upgraded their
> system in the past decade and remove the GNU_ROFF option and its
> corresponding stylesheet altogether.

Correct, but my version [1] goes into much more detail with less text,
it's actually acurate, and points exactly where docbook got broken,
where it was fixed, and how other projects worked around the issue.

Cheers.

[1] https://lore.kernel.org/git/20210608090026.1737348-2-felipe.contreras@gmail.com/

-- 
Felipe Contreras
