Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB4C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 20:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjDCUQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjDCUQT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 16:16:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A23589
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 13:16:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id fb38so20031343pfb.7
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680552975;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5axUphmActJYd9dTv0WjYYVkemgFZxhE+6OtlPDZQeo=;
        b=l/z+1tZlL3AMes67axXK948Gv/gLdEctFWwv1IAzcci40oGALfyfal1N9oGe9d7bnY
         +vWgBdpYaW+BmgCw5LANYgfI6E4NcNEYPi7Jb7o6PnFxQGduaFdeJIHZZYXtMir0r3D8
         0yEimeDkwVFCTT31dX5JjJd22hNKahLihzK57VsFwPCbmI5o9bMlnr2EvSR4iHkquzfJ
         opJ8/hyiEAUUPn720ibDqeVV3VRqCypHRvU/PAEtr4MoM2IR7mdMBPX/N/C76jZFIZvB
         dRUN9xNZ1m6zDlMXzVzIV/nnd9QYxRcsynp/qwlL0DkMuacU6GdP7Wv5EUYZATh1rT26
         oFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552975;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5axUphmActJYd9dTv0WjYYVkemgFZxhE+6OtlPDZQeo=;
        b=NA0xD++NZvFPQbHMB40vYmeUkkwjqEqWgLy1Az+f2P77FlNzVf8wbtYNODbJ3D2vKY
         YPMfYeykQ0is6GrHKbuXTKoqxr0HX52Y3Q+tX+1U2sgoW4A0xkCQ/AoF0960vCBWcxao
         oN4S6Yy3AIWitBrKLpQEQXlVQr1aNA5vbHSd3Z9L4Tjywkv/saJIGqAjjTXjBvP6+LG2
         6/Xes7jGEGNtI7UFUsZSPtQKOGvkatw5qi0yOc28+v9i0FuZ++PAGQzR7zuTY7wlIy9K
         IV0t5v0oYc+vjBb027W4FTowte0hXEbzO8WZzFCHyIdpcAGHacUE8/9v1RtU8prdPcjG
         O2EQ==
X-Gm-Message-State: AAQBX9eJECscf6Z/uZtzVCFFJ92+xHM2vpNIgRHbYxgKKbPBwswlqiK7
        4rR4aJhzrtueJ51EshCTrWg=
X-Google-Smtp-Source: AKy350Y0M7GQE1ZxYJxeOO0Xoo4kQfwZ+XtsiXovKZ3lici/4aTDHhmyjtmmXbpwY1nvHHsUQWHGiA==
X-Received: by 2002:aa7:9809:0:b0:62e:32c:b579 with SMTP id e9-20020aa79809000000b0062e032cb579mr6828892pfl.12.1680552974795;
        Mon, 03 Apr 2023 13:16:14 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b0056d7cc80ea4sm7340568pfn.110.2023.04.03.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:16:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/3] doc: interpret-trailers: =?utf-8?Q?don?=
 =?utf-8?Q?=E2=80=99t?= use heredoc in
 examples
References: <20230331181229.15255-1-code@khaugsbakk.name>
        <cover.1680548650.git.code@khaugsbakk.name>
        <38f9a4bdf89f854c30a7b708e955e2089b031c13.1680548650.git.code@khaugsbakk.name>
Date:   Mon, 03 Apr 2023 13:16:14 -0700
In-Reply-To: <38f9a4bdf89f854c30a7b708e955e2089b031c13.1680548650.git.code@khaugsbakk.name>
        (Kristoffer Haugsbakk's message of "Mon, 3 Apr 2023 21:21:59 +0200")
Message-ID: <xmqqmt3o4t81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -357,15 +356,14 @@ Fix #42
>  $ cat ~/bin/glog-find-author
>  #!/bin/sh
>  test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
> +$ cat msg.txt
> +subject
> +
> +message

When I suggested to use "cat" to show contents, instead of
pretending an interactive session, I didn't check if we already had
examples, but it looks like we did, which is great.

> +$ cat msg.txt | git interpret-trailers --trailer="help:Junio" --trailer="help:Couder"

Do not "cat" a single file and pipe into another command.  It will
always be equivalent to redirecting that file into the command on
the downstream, i.e.

   $ git interpret-trailers --options <mst.txt

> +$ sed --in-place -e 's/ Z$/ /' commit_template.txt

Avoid "--in-place"; not everybody's "sed" has it.

Other than that, I didn't spot anything glaringly wrong.

Thanks for working on this series.
