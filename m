Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D15C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B2F20866
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYf5xNj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgCCR0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:26:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45891 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCCR0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:26:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id v2so5337913wrp.12
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YS1hKR/5iKKULxNXkQX8N6wPiUq3j2KF8mAKLCbTD90=;
        b=mYf5xNj7uiZmi54R/zGZLlZSgYV497W3k5OmgYJsS1z81rK7Wd1ylTKXwGm7D8GU16
         zuNQGOUcPUbH49gWQ+WMP06LCn3+TgsDF7CsOy8UNT8dRj7aamVrq48WZJBAuJwqoiUv
         52EwX5hpiNK9yJylSGjA/he5ixeayeIq3ypDqk+iFCXf6PyH2KbMmV7cjR5jT94RbxPX
         uTm63Aeep2olKo2kU9myNXjYwP9XoPqHn5brYV6IJSzRjlQHyATt/PQBfgrpZg3J9u5H
         +xxq0iyG1n5cPny0y8is+pz3OaLKSt70mLFpBPMH1Whky5sKKDN4vorT25rxzXRFA/bf
         OS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YS1hKR/5iKKULxNXkQX8N6wPiUq3j2KF8mAKLCbTD90=;
        b=omubYBpyIVOn631qYoxT44NdNDNLq5ACtVTB3mlajRUtZQlWUGZIbMjzdomnRXMMoy
         r25mXWnGOiVCHbCwDYlnnzXI6urItYlPX3kNll0qZ4qIwKjQ2dPKJ4PabNhqv7yVU22e
         Q5CS3pd5YbidvJ3jBm1Ctz0aHI7Qmo278TvfPrpugp0uVUSW9ESDomrrv8ZUYv5q43Ym
         hyuGIa/DgnRJ9ZvFqC99V8QGoupBAVTbFx2CXdiMlDCucWRTkqcJ/OM/6YwUFRfD7eyj
         msojr9Pwfeb6zDLZQa97ldZcERoi94lBglFw3X5YLEsq8x4+lm49b2MqRnuzpPxgkp/k
         V0Jg==
X-Gm-Message-State: ANhLgQ1MbiMOTvpIZebqUf/0GdPfGkbdcMgnjhzKaev59oic5JiXN/o6
        4UVz+zrNbVqL73g2JVC8XcDCKpmuRv0=
X-Google-Smtp-Source: ADFU+vv2dgD5hqFchoQmkI+6JBFgmU3P5t07Sj/WtQEfm27UgZH61Q4kNQxeTkFVAu8LsbICzmGSAg==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr6586243wrv.308.1583256375683;
        Tue, 03 Mar 2020 09:26:15 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id t83sm4941733wmf.43.2020.03.03.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:26:14 -0800 (PST)
Date:   Tue, 3 Mar 2020 18:26:13 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] doc: document --recurse-submodules for reset and
 restore
Message-ID: <20200303172613.vmd47i5bcwg56vyt@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 18:09:17 +0100
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200228103558.1684937-3-damien.olivier.robert+git@gmail.com>
 <9831AAEE-8FBF-4CBD-B589-3F045720D6DC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9831AAEE-8FBF-4CBD-B589-3F045720D6DC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Philippe Blain, Sun 01 Mar 2020 at 23:45:02 (-0500) :
> 

> From previous testing I had done, when the submodule is modified (either modified content, 
> new commits or new commits, staged)  and `git reset` is invoked (and so `git reset HEAD` is assumed),
> the submodule is only touched if `--hard` or `--merge` is given, 
> i.e. not when `--soft`, `--mixed` (the default action) or `--keep` are given.
> So this is in line with this option just coming into play "When the working tree is updated", as you wrote.

Yes essentially reset.c only update the value of submodule.recurse
according to --recurse-submodules. Then it is 'unpack-trees.c' that handle
recursive submodules.

> However I just noticed that according to the doc `--merge` should abort in that case (I think?), but it does not if 
> `--recurse-submodules` is given. I don’t know if it’s a doc oversight or a real bug though...

Good question...

> > +	work trees of submodules will not be updated. Just like
> > +	linkgit:git-submodule[1], this will detach `HEAD` of the submodule.

> In fact `git submodule` does not unconditionally detach the submodules HEAD 
> (if `git submodule update` is invoked and a branch is checked out in the submodule that points
> to the same commit as the one recorded in the superproject, the HEAD is not detached and the branch
> stays checked out unless `--force` is given.) So I would instead link to `checkout`, 
> which does unconditionally detach the submodules HEAD.

Ok. I copied the above line from git-switch[1]. Should I also update it?
git-checkout[1] also says that git-submodule will detach HEAD by the way.
