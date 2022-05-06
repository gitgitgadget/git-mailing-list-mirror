Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB95C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 09:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiEFJMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiEFJMj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 05:12:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587505DE5A
        for <git@vger.kernel.org>; Fri,  6 May 2022 02:08:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so10325636pjq.0
        for <git@vger.kernel.org>; Fri, 06 May 2022 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4d8ALm5kWcrOiSzP1oMFxEP3ot/QxNUKs3yHJAfW6g=;
        b=XHnDD9MsiC2m27V1XypSYS/Lqlu/fE2g6njv4tYnIa+VkVHOchx6XBnvV6gOX5ol+A
         zS9JeQmeopFXNf6vV5qGsymtYyfTUHbmoB4o2lgZB3OWeL6+nKL46SF93DUjn238GAfQ
         1U+5vNYjJ2Bak0kKIpdeFLMm2bEO1VmDDNxYitowvxSShQGcFfQ6u1AoJ+yQv+eB4thd
         QIfFGbWfHRzzmYwg0kFJZtzK5CJPYQH+65kVdukr6XU+dSJbBh7WmqovIEIHVHs9eiyk
         MI5GdT/50gs4kSILZn92m667ircSOYVYyJJIRIAlmoWuk/UE00sFw8wQSO+CaCveetxC
         SUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4d8ALm5kWcrOiSzP1oMFxEP3ot/QxNUKs3yHJAfW6g=;
        b=LQwKP6eE6I17DhCofQQ+3Y23X1vw6GX31zA5h93FezoMuyHCVjOyJ+H9O/SwGrrdUQ
         y1WnVaSwU+tYS+v5tjN2KGVHisy6WZBb3ICI9bpOIgJgb7ritXt+tyAxw2eIc7LdP7uE
         wLCz8bR05QJkPX6cTelvLjl5X9zcFu2T8n/hV6QJFTpjj/D2jQreJkF5XVUJxEqDJwhN
         S/yF/46PUtLXKr+HmtGNgMktl+gvYlWyJ6ddCIIFMQbaAevMivkKFLKDgw1JRXYkSvud
         NlZbDSvaZyGVC1PIlqT7xsLGRNqnQI+LwQjwRPxTYLFUPnbVff1kewYUFAYWVHssEULk
         8FTw==
X-Gm-Message-State: AOAM5310XFHh8mV1VsBsVVYUuQW8zdCeUS02Ln+ylfEqrXYPScsOWY0b
        ECtlcPvKkB8X1OTujQtIbFk=
X-Google-Smtp-Source: ABdhPJxWMCsj3SkYPNfdCkpANGCdO8OUHyXa1T1SSNQ/DnT886sln6IrS19H3VK0pItbIdmuLU3QtA==
X-Received: by 2002:a17:902:e94e:b0:154:3a4:c5e8 with SMTP id b14-20020a170902e94e00b0015403a4c5e8mr2644355pll.19.1651828135846;
        Fri, 06 May 2022 02:08:55 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.60])
        by smtp.gmail.com with ESMTPSA id s43-20020a056a001c6b00b0050dc762819dsm2792349pfw.119.2022.05.06.02.08.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 May 2022 02:08:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 3/5] pack-bitmap.c: make warnings more detailed when opening bitmap
Date:   Fri,  6 May 2022 17:08:33 +0800
Message-Id: <20220506090833.17033-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.g30faa5f068
In-Reply-To: <YmGTphnsVJn7CX5V@nand.local>
References: <YmGTphnsVJn7CX5V@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Apr 2022 13:25:58 -0400, Taylor Blau wrote:

> I'm glad that the existing warning has been marked for translation.
> There's no reason that it couldn't have been before, so I'm glad to see
> it added now.

Thanks and it's actually suggested by Ævar Arnfjörð Bjarmason.

> But I'm not sure that the new warning tells the user anything that the
> old one didn't. The old warning says "ignoring extra bitmap file: ...",
> leading us to believe that another one has already been opened. The new
> warning makes the latter part explicit, but I don't think it adds any
> new information that wasn't already readily available.
> ... 
> This is out of sync with the warning you added, causing t5310.74 to
> fail.

Yeah, I agree with you about this. 
Will roll back on here and fix the broken test in next patch.


Thanks
