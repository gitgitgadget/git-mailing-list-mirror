Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCDBC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiGLAGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiGLAGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 20:06:30 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4DE4A827
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:25 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a39so8055030ljq.11
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b83QffmpRGII2PDtrN0ObBoFwDeOPtMrHfFVKFLgO7w=;
        b=TtPVMcaCJzBwLR0UmVJ/4nO/byd+F2kHXT3875JsfEBKefmdOoyIY+VsNU9i3ycy+o
         SPOzXElnU0WZYecL3G35iIl9nlN/5zWX/65EWAGGBCZ0ikPmt6rJEqVubyBbfxjRooWD
         TiiqPzmKVLnFUi9kgVeMxE0KQjCZ1g2tU0xqTMz3SKSSACb1BzUanICsoTJ2/KSalCem
         WI28bQZOKCe+AZaSKDZoSTOIx9myZvn/I3k949fMhQ8n0ncU+99ta+OJ6EQnjMtFOfcu
         B7wjFw+veU3Z/MsYjDkMtdjZKacDDoYOnwrfod8fsDaIXgWc+blljG/SVvBfTEkZCxmh
         OTAw==
X-Gm-Message-State: AJIora+nF5N9V1tXYoJqV4dyFymX+WenQE8dNH35k2jlMhGOdD6oGa69
        SKkDHUiYhv5lealvISdTriQEPcThARgCthqhacHvNCrs
X-Google-Smtp-Source: AGRyM1upKWgaotpsjGKemr2fDaeAClh+BgQy9aa2qzH0KCvURb6+ftfo6lxb6X2gmyoHZLmF3ZiKh3PVCnmK8xVCGhE=
X-Received: by 2002:a2e:a286:0:b0:25b:bce0:720c with SMTP id
 k6-20020a2ea286000000b0025bbce0720cmr11588048lja.458.1657584383161; Mon, 11
 Jul 2022 17:06:23 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Oates <andrew@andrewoates.com>
Date:   Mon, 11 Jul 2022 20:06:12 -0400
Message-ID: <CAAVLcG42wom6Rf=6YZoc+iUnXDxshBfGOjqQPryGkzXxRxb-hA@mail.gmail.com>
Subject: vimdiff mergetool diff mode detection in vimrc broken by commit 0041797449
To:     git@vger.kernel.org, greenfoo@u92.eu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I believe commit 0041797449da61f4131bb1673fa5d4c3af48240d ("vimdiff:
new implementation with layout support") broke the ability to detect
diff mode in a .vimrc, because it removed '-d' from the command line
use to invoke vim ('&diff' evaluates to false, because diffmode isn't
enabled until the commands are run, which happens _after_ vimrc is
executed AFAICT).  I check &diff in my vimrc to set various settings
specifically when doing a diff/merge.

Just adding '-d' back breaks the layouts unfortunately. I can hack
around this with a heuristic that looks for a mergetool-like
invocation, but ideally there would be a way to set the canonical diff
setting correctly.  It may be as simple as adding some extra commands
to close the extra windows opened by adding '-d'.

Thoughts?

Cheers,
Andrew
