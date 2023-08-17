Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0729FC2FC04
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 02:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbjHQCXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 22:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347634AbjHQCXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 22:23:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93AA269F
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 19:23:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bddac1b7bfso3447745ad.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 19:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692238986; x=1692843786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bXPW+S8G0SE08vhh4DImmdai5a0YTfGrX3zQdc8o3E=;
        b=e9sCMuNLEreJ7nMDr/k9JcO2vmz1a7kaYJqi70EI+4qmftNDUlQp0yLbL/g5JISU9I
         RZVDEFCvMUFTRFxl6owmrlF9JQShtalWCY9RzdmSiwFXn51SQ7ebrCCaRNVF47EmudZQ
         nPMh5wKmWKEXRy87UwAaZoO13XZx/WUvrl9ITWCAWCMhSV90SxKcrWJxSBMEll3aaQLe
         2mDhe6/2leqsS/HUEEHqILeZ0DQW7Xm3es670A20stW4ekml7YAiA9iQZ7vuj0oyzdIE
         i5WPr9t7b6cxF2C6oCjTEJNDROijsf6XIzeqyJQf67xyMd+YTkQxU1dXt3Tg/Rz5Ty6J
         XchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692238986; x=1692843786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bXPW+S8G0SE08vhh4DImmdai5a0YTfGrX3zQdc8o3E=;
        b=j1j9z0VdTKD06UPCZV6E3Debc+p632FLpm+wrWLjbjmA9U2vOS9wRRNFvTiLtwnTZW
         xLFHjofSmfL9n/tMjbtfw2NG/BOYj6Thtb3W1ovnilxzGwG7362jxPYVRTwJwyVCr1rv
         3pMG0NZWdsGHGrysCyCW7ai+1JNf4igxi4tYCJEdFMo+WGUQJhoIpLAmzQg2nHvUDF/k
         kOc2dU1rk/2bR2SW1yV09cyBzEz7vAlKjmq+xTZoLNyajFDIUTr8t/W0wo/OflGqVMDK
         yYNqK0jSib0og+UNHgfWEpL/wFDBOqjcF5J5oQdfT0wyDlylRsWnYyFCUsulCIGukRMC
         e7nQ==
X-Gm-Message-State: AOJu0Yy41V7hY3D1QvpMxXsK4mWznua+wOo4WVzIwkuYWF3q/oqb0kIZ
        eLGyHXxjH3lOCN+dxeQ/eJs5ylCocWEkFA==
X-Google-Smtp-Source: AGHT+IFkAWqY2Pjg8bYfY9DYp4vy+mfPV8s1WL4uxijN7hjPfrIBc7dx8aTGmdhjuE1xIhHbXUzifw==
X-Received: by 2002:a17:902:ce8c:b0:1bc:edd:e891 with SMTP id f12-20020a170902ce8c00b001bc0edde891mr2015089plg.1.1692238986037;
        Wed, 16 Aug 2023 19:23:06 -0700 (PDT)
Received: from localhost.localdomain ([2404:2280:2000:10:bbd1:e247:bbd1:e247])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b001bdd68b3f4bsm7930811plk.295.2023.08.16.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 19:23:05 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     martin.agren@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org
Subject: [PATCH 1/4] notes doc: split up run-on sentences
Date:   Thu, 17 Aug 2023 10:22:57 +0800
Message-ID: <20230817022258.74357-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.328.g2e11c30e.dirty
In-Reply-To: <a8e5a98da5f577fc6235bff07d7430377344dd93.1692194193.git.martin.agren@gmail.com>
References: <a8e5a98da5f577fc6235bff07d7430377344dd93.1692194193.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Martin Ågren" <martin.agren@gmail.com> writes:
> 
> When commit c4e2aa7d45 (notes.c: introduce "--[no-]stripspace" option,
> 2023-05-27) mentioned the new `--no-stripspace` in the documentation for
> `-m` and `-F`, it created run-on sentences. It also used slightly
> different language in the two sections for no apparent reason. Split the
> sentences in two to improve readability, and while touching the two
> sites, make them more similar.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Documentation/git-notes.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index bc1bfa3791..9043274ce8 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -141,17 +141,16 @@ OPTIONS
>  	If multiple `-m` options are given, their values
>  	are concatenated as separate paragraphs.
>  	Lines starting with `#` and empty lines other than a
> -	single line between paragraphs will be stripped out,
> -	if you wish to keep them verbatim, use `--no-stripspace`.
> +	single line between paragraphs will be stripped out.
> +	If you wish to keep them verbatim, use `--no-stripspace`.
>  
>  -F <file>::
>  --file=<file>::
>  	Take the note message from the given file.  Use '-' to
>  	read the note message from the standard input.
>  	Lines starting with `#` and empty lines other than a
> -	single line between paragraphs will be stripped out,
> -	if you wish to keep them verbatim, use with
> -	`--no-stripspace` option.
> +	single line between paragraphs will be stripped out.
> +	If you wish to keep them verbatim, use `--no-stripspace`.
>  

LGTM.

Thanks for catching and fixing these docs.

>  -C <object>::
>  --reuse-message=<object>::
> -- 
> 2.42.0.rc2.215.g538df5cf27

Thanks
