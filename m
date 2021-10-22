Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081FBC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE3B61108
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhJVVWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJVVW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 17:22:29 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638DBC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:20:11 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w15so4213847ilv.5
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a9w0w5ZgpnIGhsWWziO5yyrWAYokkmUl9gfacRMeWw4=;
        b=Oq3QgNs5B/32ncVryF1xQLKDBQ7jcAnuyKuhu97O9zGhoT3V4Mxj37/1yT6M833X60
         OgwoWg2XRCTK22m20k3jk2ar+5mFyWsQU+5CMNgRioNgLHnsHTHx3pUwc15WVI9JThMK
         011OjSJNgUwS5zhxFrlo7PZ+87IU+719hKdX/DOezKviY0iyzMT6WWsx76AATMARGSLX
         /WzVHuwkD2pli528DFOvQwBLdeJl6rFPYAwnWFL/BaiL0ZmoPT+ZJfQCikUkq1VC+luW
         pKQiAY5DIiKNEP1Dqo1GwxKTWnsSAx6mTyn0WhF4FrLF88RNn4HesuS9YXoWitln+GDn
         ZXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a9w0w5ZgpnIGhsWWziO5yyrWAYokkmUl9gfacRMeWw4=;
        b=qn9Y9tegLdZsnEF/yAYucaUx9huZTc9T83D27mRO4Gwgwtjeey250e5EDvaRMuESyV
         th3Q6x4fCF0nA5vHnI3ohkQa7RpK9ZYpK/dpikEUlGF0tvlw339P0KBe2n8uhX+FxYZQ
         dy1NkMuL4pvQqqZzVnK+88gaeQWYfr3ddsvcJMIMBDY/jZku38U7Rprc5AXyT7mgG/9g
         KMs5KCLak2pKr9w2rit7ij/k98NYB91lVqfw5jsoQasswHBOH/tx3Wv3moO1CRIZvZHG
         D213e/vBnj90XVTbDyGJDk7TH2mh2Vx6pF7881XCz0qvHwPA1SRyQlFamDbI18d54a7A
         AFJg==
X-Gm-Message-State: AOAM531ZPENsnqL59uiVz3jg0+/DL6CIgVDXVl3snBqHKDD7N2efLIcl
        clKB38tyeR65LfFNlMiUSn3Cug==
X-Google-Smtp-Source: ABdhPJyIGofCzm4IU5Ff0pnYjGXlOW5ZP2LIPm8fcCvdnOKXnoha6+yVjRPhtzyExP0+CEQgKZjCAA==
X-Received: by 2002:a05:6e02:1a29:: with SMTP id g9mr1377500ile.135.1634937610815;
        Fri, 22 Oct 2021 14:20:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v63sm4668863ioe.17.2021.10.22.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:20:10 -0700 (PDT)
Date:   Fri, 22 Oct 2021 17:20:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/10] Makefile: make generate-cmdlist.sh much faster
Message-ID: <YXMrBMvkrtfLSeOz@nand.local>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 09:36:04PM +0200, Ævar Arnfjörð Bjarmason wrote:
> This version of this series drops the Makefile-powered version of the
> cmdlist in favor of making the shellscript much faster, mostly with
> suggestions from Jeff King.

I'd be happy with the version that you suggest here, since at least the
net-effect is that generate-commandlist.sh is faster than before without
much additional complexity.

That said, I did find the structure of these patches somewhat confusing.
There is a lot of refactoring of get_categories() and related functions,
and those patches were a little tricky to read for me. I wonder how much
could be cleaned up by placing "generate-cmdlist.sh: stop sorting
category lines" earlier in the series, getting rid of the caller.

It's too bad that the penultimate patch slowed things down a bit, but
I think that things are so fast now that much more discussion in this
area is really just splitting hairs. It would be interesting to hear
from somebody on Windows whether or not the speed-up there was worth it
(otherwise dropping that patch might make sense).

Anyway, I think we've all spent a lot of time discussing a rather
straightforward set of patches ;-). So this version looks good to me.

Thanks,
Taylor
