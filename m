Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD4EC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFF92071C
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="NDtXYWfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKVUXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:23:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42047 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:23:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id q17so3828291pgt.9
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Xm+myWBt7Pso3bOsIOxgauZoXdyLPHSIUpRa9ogNh0Q=;
        b=NDtXYWfT3nm/HefqcBFeIX3jMMRs/NN999a+28FQrXslIlJPapuAatDzfxrFjWyMtn
         /dDOtGbkwSP4U+90m2i+t/K1rW3TnHDDd1rNRmuSXF2DApzlc2sD3kYjsSP8FCwou0lB
         EI6VeYcQo46FbCNFU3zg8ZmTeCf2N9Etx3dD7V9TF4S2NuKwFU0uLgTzF+IHI/nB9/1Y
         pHk6UZ83JlnKKv/DeYV91EHSACNwkVTcUd8XheorEgeZNeLSZTjGpWa/gll7DW+DYimn
         rekZWUWFEuztsVN+51aaFqgSTN4YrZVGnw+DARKPSNi4xnp9b3TptMQfkESOqszjPEmi
         g1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Xm+myWBt7Pso3bOsIOxgauZoXdyLPHSIUpRa9ogNh0Q=;
        b=OrnRgRUuufEHzxStUATKpfFtYUOIKxRNRLE4iPYxYWl1bfmP30t3uspCqICC+P5C5/
         pgg5+NCf3LDd/0IJip0M1MCCW1XuCHzlKDock/47GLq3aM5CIHEPtstmEwlKmfsCUc3q
         2BOZUNRTF2AXLJa/LvpWC2+iMoou7xcetLd/LI6OIWFMXO2CCFvaYhuNsFjbjA7vpS+d
         e03kZ7Dn6HvE/RpRg8QqOxBWa32v8U/Yx/iKliZEx7EejL6LPsGlvKFKTBQJ0lZZjRSE
         Y6ZoD3c8QeDib9dNXrfqGczePLsabWo1XceC/Id2qgyPZk+AUSktAdGvc/c3YaqFePqd
         0YUA==
X-Gm-Message-State: APjAAAXbaIXYIG3i+3f8YrgDXtDOznSIfilSqgzB6ACBAjHocpU8nn+A
        14KngNPbuzKH03VIz7Am/hZYkveUCFY=
X-Google-Smtp-Source: APXvYqwqDizlxZDLQlLAbQapexPg3AzIQWQZvLTymc+BSyVoFFfOOVJH86+mcsUNqP+SGfKjS4UnmA==
X-Received: by 2002:a63:4a01:: with SMTP id x1mr17841669pga.312.1574454213312;
        Fri, 22 Nov 2019 12:23:33 -0800 (PST)
Received: from localhost ([182.232.178.105])
        by smtp.gmail.com with ESMTPSA id 83sm22142pgh.12.2019.11.22.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 12:23:32 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: limit search for primary key fingerprint
In-Reply-To: <xmqqeey07exp.fsf@gitster-ct.c.googlers.com>
References: <20191116180655.10988-1-hji@dyntopia.com> <20191116180655.10988-2-hji@dyntopia.com> <xmqqtv712145.fsf@gitster-ct.c.googlers.com> <87d0dkbyxb.hji@dyntopia.com> <xmqqsgmg7hyf.fsf@gitster-ct.c.googlers.com> <xmqqeey07exp.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 22 Nov 2019 20:23:09 +0000
Message-ID: <87v9rby82a.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22 2019, Junio C Hamano wrote:
> Wouldn't some of the fields this helper works on be of type "char *"?

Wow, that's embarrassing.  I completely messed that one up after a
looong day.  Gah!  Fixed and re-built with DEVELOPER=1 and re-ran the
test suite for both commits in an attempt to avoid further fuckups.

I also fixed the criticism on 2/2 (even though you mentioned that
there's no need for that) and sent it as v4 because I'm not sure what
the right approach is for changing only 1/2.

For future reference; how does the project prefer fixups for a single
commit on a multi-patch submission?

--
hji
