Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ADBC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F912072F
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQxiUhV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgCLSYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:24:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39931 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgCLSYv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:24:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so7480703wml.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UNhyBe0pBInGsMvOIeGPkRDotqmNFalgoHgk+oY5MOk=;
        b=pQxiUhV1pL+z7ZNfWa57sg62ORK6409UpM5wtwu86glOakosk/KAWqg83P1VVP+qvy
         F4lhg/BZmoZzLdl8KKq1Bq44KT+HyAWleqSdbQlcEnRl7Gzb1egukxCL44D5Tz3IxBTF
         +WPnItT6z/gcH/MhcoDFIb2DNk4pPNTl/HH/9Pu/RNrPwR+w0npCU3fF01J76xpvIxOI
         V97cfT9dYGwOsNVRe6Z/OCUIoU6I5QN/cMmWIZN9VMJPFRNu9YGecgNTmMT36+shKh+0
         /e0mhqbdL/MC3bEs6Enbdu3jVRcJ3wcxOaovupRd8IpNwFvZhggapInemg7LI/G+LT7z
         SmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UNhyBe0pBInGsMvOIeGPkRDotqmNFalgoHgk+oY5MOk=;
        b=Ng+5lwgmNlnmMEvvboJAHIzlkrn5nW/CjGstXKbzojHOeCTXwtRLgZzkvfFineZqkG
         dqEqs9TSvGRuZlEgZ5cw4nWT8DS0TtdfUPwls0yo6ar7h2LwLrLFr5EZa0+9LZM4+WSF
         j2fTnqkCkdTXKAxZ2YUIHk4e5ZVpA2ibIxZ2ppO7p3smj8quDX9FAZ5WmdGvDv86lxZi
         dmdB4m7+tZmr4uP1SnVjxmw3D4H35/gZ1Gzx9hC0t2UGFWn5PQYl+oYYYFcdZm6N0qNG
         Gt2+Z3bhZKZHh90PkF6XqrBOu8spqNMlRjOZyYqkzxDcsdWOePKURRzmRlZZAnhBwPci
         GF4A==
X-Gm-Message-State: ANhLgQ0F0A4UBSiaypi8YFqiTAviiVichmQSoCRyo8+hrhLuEwNnD66b
        6VT6BrhjqXnBFjD4QgrVUv0=
X-Google-Smtp-Source: ADFU+vsJhaS+AhhY/zkb7XsELcMLpLTtnuCoXdYxEchFDZfa0yksP/CTIGjWN/OUDDqUGzKErJCMRA==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr5907164wmb.141.1584037489831;
        Thu, 12 Mar 2020 11:24:49 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id w22sm13708390wmk.34.2020.03.12.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:24:48 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Thu, 12 Mar 2020 19:24:46 +0100
To:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/1] midx.c: fix an integer overflow
Message-ID: <20200312182446.6zqjtudkptsvr6uh@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 12 Mar 2020 19:23:52 +0100
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
 <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Damien Robert, Thu 12 Mar 2020 at 18:35:20 (+0100) :
> When verifying a midx index with 0 objects, the
>     m->num_objects - 1
> overflows to 4294967295.
> 
> Fix this both by checking that the midx contains at least one oid,
> and also that we don't write any midx when there is no packfiles.

I forgot to add: previously I was wondering about a warning when in 'write'
when we only index one pack file, but this could make sense in the case of
a 'midx repack'. So I only warn if there is no objects.
