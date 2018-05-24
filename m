Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF951F51C
	for <e@80x24.org>; Thu, 24 May 2018 11:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967204AbeEXLpa (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 07:45:30 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:50804 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967160AbeEXJsC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 05:48:02 -0400
Received: by mail-wm0-f53.google.com with SMTP id t11-v6so3332730wmt.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dHVrtXkcTHy5MMNPvoYwqRydt48QeJpk+2kNPRfbHGU=;
        b=VYXhCb6mZcI3gZcT5eL1I0IAcJkkHdudbbcD3Oqj09AKUjedTRQxkiEDmxvQGkNiYG
         yWH8qKPMlm/88xxY4DTKTjCIQeIJXlm3YuHgJtASP3PSAxSpwTPGS5sfK1yDdpvCnPzp
         +VGrSPKphOLUjlQCxUJ6h6gum01dXQa/EqsBJsQonyB/rcVsHstDhqito5FkKKjIGvfx
         9Nly5xL2thSsoOp/KbYhb4GVR7/eLKx4/MWjfbeeQ4ahFXSc6Cbf678XvncPDCwoTJJR
         ZvOG7eIf2Q10E00djtWsYrWbDZnYGL5ZNLrF727WF0RSdkgxOQXYXVifZQfWGTODGsgh
         NiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dHVrtXkcTHy5MMNPvoYwqRydt48QeJpk+2kNPRfbHGU=;
        b=QE4d2OrMe7EMGs8xt/ky7oVR6KsdvXYqJEcgm1W2032FhlDK0VBFkPVrkM0Grtg8UH
         Axn01ho9HG8gTOUjGFOvgGND2m0E48s2Pa+mQSIqy2ZKyPMi90/7ihKAfaOrFawLJJna
         1oBSC+dwh6m+4KFGpCIhgDnPRRF8LiY4W3SG5rb2GJTWANbRFa3XZpOKHF+RspP9RDdQ
         TSFlwUjlnNqlh9lBHqSjbtrrvB1SNUN0iugbWUPGoWrrDRAwmseQaHCYb0unTr47JbTy
         ELdS8JhlUOYhtUuUI0KjqAgT0HFqjWByLOxkzsp9e/FPdn0rQFfWZ7iKptn9TqiOC79t
         8OqA==
X-Gm-Message-State: ALKqPwe8zparVukcxzjVSVPPDJNN3+U5KtvdZ71k7zU3wTCUm73WBYzI
        sotKr/G8v8+Ggf/gNbhm47I=
X-Google-Smtp-Source: AB8JxZrGQGaKyn/X9F/jqWLO8BT5YoAS6pF3qkffC1SD558Z7ymMiW18WtQgh8FVTfoVf1V2jPlegw==
X-Received: by 2002:a1c:a609:: with SMTP id p9-v6mr7680862wme.146.1527155280514;
        Thu, 24 May 2018 02:48:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k28-v6sm26065422wrk.46.2018.05.24.02.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 02:47:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 4/7] rerere: fix crash when conflict goes unresolved
References: <20180520211210.1248-1-t.gummerer@gmail.com>
        <20180520211210.1248-5-t.gummerer@gmail.com>
Date:   Thu, 24 May 2018 18:47:59 +0900
In-Reply-To: <20180520211210.1248-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 20 May 2018 22:12:07 +0100")
Message-ID: <xmqqmuwpqt9s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> To fix this, remove the rerere ID from the MERGE_RR file in case we
> can't handle it, and remove the folder for the ID.  Removing it
> unconditionally is fine here, because if the user would have resolved
> the conflict and ran rerere, the entry would no longer be in the
> MERGE_RR file, so we wouldn't have this problem in the first place,

I do not think removing the directory and losing _other_ conflicts
and their resolutions, if they exist, is fine in the modern world
order post rerere-multi update in 2016.  Well, it is just as safe as
"rm -rf .git/rr-cache/" in the sense that it won't make Git start
segfaulting, but it is not fine as it is discarding information of
conflicts that has nothing to do with the current one that is
problematic.

