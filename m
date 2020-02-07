Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D5C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EE220838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5l61zCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGUo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:44:26 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38064 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgBGUo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 15:44:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id p10so278514qkk.5
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EySXxiIIGhNy+QSNb9cXGE4aswOS57nW/1649fCPhT8=;
        b=h5l61zCWVPlaROHnzP7p1GzaohOcE5uKhG6u6fOW9UBzCGaOMBbLs8d1xh2RAY4oSg
         OsIvg//zaz/mby5W7ZDRyqVAx0kHZHg8ebdhozTkqeXgxbH31QUt5/fZ293QnTqpSNRD
         u3P7jv4Uam08lG5o1MwQl19NKnfOdonqdVPMiwxh00sxZb3ElpnRho7a/mEdnMizHPOK
         weSk3HQw7WsjBMe4rfmJ2SfJh/X592e7n44fAoRcA/azxkjvz2aTVj9smEGvanmRoEVQ
         OfERTAXjHmHFJwVFrx4YcpDmGMcp4IWMkZE6VZgmJI+URpbnfeZOsQQVOtYVZ7VtvRGd
         N2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EySXxiIIGhNy+QSNb9cXGE4aswOS57nW/1649fCPhT8=;
        b=HcTTdaBpyUT8CzjRqq13oNFYsTp09s+6x1E2I2hs/P+u08hJDaQnRFlDuTj5GaVbCI
         AQECiuVpkzYu9vI/ymEdAmSuC5j9VQ0ZlgPxXP50sWklHP/6MNd/WztRcfNj/tkvMRoo
         WdHLC7jeLJEzk1tRAuf77Su11pwjUj3EoWvKaI4g2W++6tkqNw6hQ4IitMBSMAAu116J
         J23cUmqfO/ryXFAPMTaZsF28yzy10n0Uxan/kVYacXJteLBW91DXz7KMjhX9y94PbvNm
         S33zNvbaUNZCtP9cLgETNDe7MUIU7ilalBzN122UdcCyPgEOmrfeW7eVlCN3Ut1r1UkK
         RxKQ==
X-Gm-Message-State: APjAAAVsRQX2E/P/HxHlKpbdwsFMA3HbTHh6R+d3/0JEkbMivYHCvP92
        AXhAPqVtCGnStg/IOmHilhN3iq8ZFGcAeudifSTc4sJeUYk=
X-Google-Smtp-Source: APXvYqytP1qul0VkTO4eqyuIRKab8fkd+NmFm5IqFxfqDm8e9d1zETl/ogkSFdYDsqWGmWdP0VQqZjWxPI6QB06Li0w=
X-Received: by 2002:a37:4b48:: with SMTP id y69mr777276qka.216.1581108264058;
 Fri, 07 Feb 2020 12:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20200131221800.240352-1-masayasuzuki@google.com> <20200207204225.123764-1-masayasuzuki@google.com>
In-Reply-To: <20200207204225.123764-1-masayasuzuki@google.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Fri, 7 Feb 2020 12:44:12 -0800
Message-ID: <CAJB1erXMR_aCqVPsH6WQZdC7yybOBCUbwkJDv3LtU2f0ymNmbQ@mail.gmail.com>
Subject: Re: [PATCH v3] doc: describe Git bundle format
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 12:42 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> +=== Note on the shallow clone and a Git bundle
> +
> +Note that the prerequisites does not represent a shallow-clone boundary. The

the prerequisites do not
