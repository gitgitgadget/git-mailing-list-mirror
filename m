Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4587AC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiHBVlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiHBVlh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:41:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962213F00
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:41:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ec41637b3so10538462fac.4
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0YSJI8lriga/xmY7U3bzNo/FDT1eUigDYLcskDZch6k=;
        b=GzXbM45rHW3M8IWftk+yUm4rlGl11FKI7y99Auyqg60wbsYTOp0KfYrFwbMVF606Fq
         8kV/LErETD7AFOK6O9eN3zsG3Lli7rZeryvvpXhq+c8yQIuhLX/q0etN5EG9vbfWpyTA
         fACG4SepbtEC98vxD05CxfNNmkuCg+6yO7BNP5Z/B0/HUJ5iughiJMSOqEhon4AtsTqG
         H9Zr5bbz7FCIig4jcbava5Azu0hFEzfyA0Uh2UUnW8Q79g1Q9nwHoPKueDGWLFmmJ5bg
         sPWKNUIiaHFhrMw7gzHbNx/ZA8Z7tG4SwngARuGO6EAa7/oJeIHQekgB9uGYXT+WVM51
         jQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0YSJI8lriga/xmY7U3bzNo/FDT1eUigDYLcskDZch6k=;
        b=llwtic4g1X4owwtFWdC66yTD//CRGkvQQfpT6+XXFO99xNpy/hutkctVROFHSV/+hF
         EvFXI/fBtkvh9YAJYmaP+aKnqsNHDR0XMvTk5WeHYBRqN+sbKpQHwGPsF1ryeMCokBZF
         Da90FPNdpwMZ6RDUXEm6luaxmxX9IhHNPuFYaVBN7q5t6OoOoLtNwchs4d+KLRBez0Ax
         1PO3HYOgvmVAr9K/1On2We4rfqCwdeMpqkmkfyusVClKsitN43u0zT4dDwTouiGxGTSp
         S8ifNvk1RT/0yrN3oIg4DiJUd723/FeI7FQJKrPArN60NZvKfEwkj/nYQWdd7h6eisfZ
         SuJg==
X-Gm-Message-State: ACgBeo2x0trZ+Ixx+7jzBhEHZa/QYWk+EmB/KeLoAYJrLdl5Tly8AZJi
        eFSH0tqYDmIRl/cDynv4M5e2hq2Cczo=
X-Google-Smtp-Source: AA6agR4L4WhcSBJPjgg2lD3Rmy1IiyE893477IUIzOCunUtKwmnYD+w1juUcn/E/xyEpxqMa1ZxcJQ==
X-Received: by 2002:a05:6870:d1d2:b0:10c:d05:7588 with SMTP id b18-20020a056870d1d200b0010c0d057588mr631658oac.180.1659476495571;
        Tue, 02 Aug 2022 14:41:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:5c95:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n1-20020a9d7401000000b0061c358e989csm3751261otk.46.2022.08.02.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:41:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] mergetools: vimdiff3: fix regression
Date:   Tue,  2 Aug 2022 16:41:32 -0500
Message-Id: <20220802214134.681300-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.313.ge269dbcbc5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I wrote vimdiff3 to leverage both the power of git's diff3 and vim's
diff mode, but commit 0041797449 broke that.

Here you can see how it used to work:

https://i.snipboard.io/hSdfkj.jpg

The added and changed lines are properly highlighted.

After I fix the conflicts vim still properly highlights which lines were
changed, and even what specific characters were modified:

https://i.snipboard.io/HvpULI.jpg

Now I get absolutely nothing:

https://i.snipboard.io/HXMui4.jpg

To get the highlighting the content has to be in a window, and only
*after* the diff mode has done its job can it be hidden. The current
code does nothing of the sort.

Additionally, every time I run the command I get an annoying message:

  "./content_LOCAL_8975" 6L, 28B
  "./content_BASE_8975" 6 lines, 29 bytes
  "./content_REMOTE_8975" 6 lines, 29 bytes
  "content" 16 lines, 115 bytes
  Press ENTER or type command to continue

Because that's what `bufdo` does

Here's the patch that restores the intended behavior so vimdiff3
actually does something.

Additionally I noticed that vimdiff3 relied on specific values of
`diffopt`, specifically `closeoff` not being set. This worked fine in my
setup, but vim has `closeoff` enabled by default. So I'm sending a patch
to make it work regardless of the user configuration.

Felipe Contreras (2):
  mergetools: vimdiff3: make it work as intended
  mergetools: vimdiff3: fix diffopt options

 mergetools/vimdiff | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

-- 
2.37.1.313.ge269dbcbc5

