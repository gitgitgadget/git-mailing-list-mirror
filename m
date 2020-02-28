Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0576C3F2D1
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F4B2469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQtRrrCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgB1Koy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:44:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33343 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1Kox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 05:44:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so9056580wmc.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 02:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SwdV2CS8CEBHMNH81h95lhcjLRAKln9h5OCMHgAuKMc=;
        b=qQtRrrCvvPJ63PmnDdL8Vld+XOEFlg+NHPZNsaNVHFWIVJ6oMzh+uvysJDYgXCNbnW
         j4bYShLaCf/cPnq/tAvBvWBQlQyKQ5hQ2mKhMYJ8lLep61o0XRjbelaiqbTZn/nRxCxl
         /JZ12F3jfjFLH4kWdWLXFQ12gxZDih5ZjXrLXqn6H4j71UC0Z3W+mHy2VzyIS7PBHNiw
         +q7rEREMG/7VuuG8ImSJhXuUdBQsWEshgFBFKUFqkl78d/K3qozDKJEZ7JfYpIbl8Omb
         zohBZ09rMu+4WWAMLXIedGQfVtOzVdSv+BIjEB8o6gOdP+Fn8TkWGSlb21wM+owrd/eF
         JW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SwdV2CS8CEBHMNH81h95lhcjLRAKln9h5OCMHgAuKMc=;
        b=c1fgLJSgb62hcXAreMIHoqlRRyfT0h6EyLE5/xYtdqMZKtr1l8Fg5iiflWDoAKE76A
         7e2AF6aSO0dT8UC3tTyZTpd/BRENxbdolKKinqoJyfFKtZiP9QHN131ODcnalZSivg4S
         PexAQW2mineLemXlJHG48AyyJ+shEEQQnzCUttV4zJYpuXKExk/xRVl1LBXFk4teDgPZ
         2FU7EsptRhdmNoIDEOcJ21YgGgTnEOfXwrTkz5PhsDK9b/oCFm/FUGU9/xoyFdqvf6X3
         fZF8uyXQN2MfHCAcgDBiZE1L5Rpe+B0q5hxtMU8eviaOqQvhkbwKX1pbTlV4uFC7uAkY
         7sHg==
X-Gm-Message-State: APjAAAV3HPJ3T3TN6AdmP7B09Fx/dATNyW6nHHRbDLDoHKRaP8DxWqsc
        tuPktwrMy49H4dMv7Xnk44Jpql/Mn1E=
X-Google-Smtp-Source: APXvYqwMD3X7LheWlTXGdVzhGZlL6TGXx8cbjg60eh3x7Lvt3k2d794X9oi8zvkT/oy3VdxFIS3q2A==
X-Received: by 2002:a1c:a789:: with SMTP id q131mr4343455wme.127.1582886691491;
        Fri, 28 Feb 2020 02:44:51 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id a9sm12637925wrn.3.2020.02.28.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:44:50 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Fri, 28 Feb 2020 11:44:49 +0100
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/4] doc: --recurse-submodules
Message-ID: <20200228104449.o42twhy34fynalk4@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 28 Feb 2020 11:42:39 +0100
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that git-switch.txt states that
	Using `--recurse-submodules` will update the content of all
	initialized submodules according to the commit recorded in the
	superproject.
but actually only 'active' submodules will be updated.

Should I also update the doc? It is already stated in `gitsubmodules(7)`
that only 'active' submodules are considered for recursion.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
