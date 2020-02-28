Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B6C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA1E246AC
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+NMQd/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgB1QBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:01:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54348 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgB1QBl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 11:01:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id z12so3704281wmi.4
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=naHpl/mMf9u1oniL8RJtksV/+k8kb/1WPoeqYHsDJ2s=;
        b=m+NMQd/5GWlg5rqAzNb9V03yCk4TCedWZhsgeK9GVy+/B6jTgWb8HGt0K2kkNClNTg
         uU9x/Oy6BQWbgLzpAZYhiCADUJ3X0aNLelNqhHl7opB+Ld0hVIXgm6Fjdm47ryBiK1vt
         t7uFJ7Dz+fvYyoWY7/LY/K8PVU4xobD7sG1bIdf1JJN15zgKijCnOfE4CoxiaA/5psJN
         g33XN4zfQ+NTP/pVxQ9Wo82i2IWFBHqHMfjTeL+fH1SRL/bvQGlpl3xtBpXyLAh5s5/B
         YGbn3GeGFEehE37kfIlJ/rcOO8TQ3UOM8YjR3+Zej6cjheM2+NvmdinSuDhEZSSx0UZY
         3igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=naHpl/mMf9u1oniL8RJtksV/+k8kb/1WPoeqYHsDJ2s=;
        b=Rti4s7iVdVBDss1/vHWiqToQj6Te9WBvopCYOpOcpQn3m5H3eR/DHgqZRa2uJfDZkY
         1Rv+7lA3F47Man/VUFmWyk3RSWxbkqbAKkmm/VXnXrYUXAE2qWVY0OQSVFaiUnJ537MP
         /5uvuXCRLh3ZgNE/6AULT9xNgF128A4pa7BH2bxlpLzKSJhs5AGKnGIfEKnbFABxznoe
         u7oHThkab7NRr397VsoWJs1SrJB3f7lq12OQ20N9NaUIl2p3ix6CmPAlapdurwo7xdd1
         zAkTiMBtDXgxBBYR2KNmQAfvK1wR2tjFjivACS4CuMqCvTpLf9BQiYVyQRiYEM/Srv3T
         EgWg==
X-Gm-Message-State: APjAAAVBmTKs88arohp0PrRPLkKt+lBj0NimcDaUcOmdIcT9oIEPXU2+
        Wfeo+NIOEhjKL4AUmTKSX7ig4x28CHY=
X-Google-Smtp-Source: APXvYqzO96GXAU6bN9g21+6Kxu4JgQOEKEyQVLFZw4D12OvaAEnPMV83OvE/0LepHr2+ulZFLn+E8w==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr5345683wmi.58.1582905699462;
        Fri, 28 Feb 2020 08:01:39 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id h81sm2187649wme.12.2020.02.28.08.01.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:01:38 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Fri, 28 Feb 2020 17:01:37 +0100
To:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] pack-objects: change the name of
 add_objects_in_unpacked_packs
Message-ID: <20200228160137.iqd3pxtsdameijs3@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 28 Feb 2020 16:57:57 +0100
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
 <20200228154357.1710521-3-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228154357.1710521-3-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Damien Robert, Fri 28 Feb 2020 at 16:43:57 (+0100) :
> Now the function simply iterate through all packs (more precisely all
> local packs not marked as .keep), and add all objects not already in the
> object list.

By the way is there a corner case here?

When using `git repack --keep-unreachable --pack-kept-objects`, since
`add_objects_in_unpacked_packs` does not add objects in *.keep packs, then
unreachable objects there won't be added. Or am I missing something?
