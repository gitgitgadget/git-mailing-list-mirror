Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5378C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACE9206C3
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHFKkiJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDFSmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:42:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44509 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:42:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so671726wro.11
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HB7mP4+tEzdFT1rLYUfkxILmmBZjACj7Jy8JKl7gojg=;
        b=rHFKkiJzFDThb5SSAI3YHX2ky6F89H2zSnflRa0uVDqr7F45+/tMz9O4PW+w2ISnzq
         0/J0tFFiy8liH23Aqks9U6py1tVcvYXiJUPtHeFhqhszrnoLtAwFaVyueroU9sQedK7S
         zU/j6m8tsjWTOP+RnxL781td/9OYtrdziNMLZbiAtt59XSfbZVXXkfeMKDC1K52RYF+T
         csTvXizg47kybI4n11jtp37e6xMmTB/tLyE6MMWQyTDjKzgQKgSQ+aD3tMKeEKKbaXyW
         aIH5Hjx52uK87VCQkV76p4SiKDfaAVCgG6b+v4SW6bnrdjvSDCBsjU2rK00J+S273q7I
         JzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HB7mP4+tEzdFT1rLYUfkxILmmBZjACj7Jy8JKl7gojg=;
        b=LRI14MjVukOuMHJkL2EIQIBokAJaNfQW4k2CB3FWqubIr1SaipNtIsPrRsRIPRlKs5
         RhuUnrqCrEZle89as7oOELmG+IfJdrMVZXWztmrHidCeG1BBhgXrKjWdIQwo+EcatXvU
         pY2x4dEAhSCrS5B13dcNs6lLGPt+sWEKMIrsT2G5DpiKwM1qkk1LsW+SJrYsKrPr4b4I
         8olHhV9zp1sGHlp+GjzL8I1I64ZqzevmI2R9Surw4ogBG2cYIZyl11YxW4TF5shPvXtC
         0rIymBm8ImU7jVcoGmP2FFnDIFvOrwuoESUmUBBvVDrI8+Gaf2fEz+skvcsV7HsKqQHW
         jFFQ==
X-Gm-Message-State: AGi0PubcembTZPUqsMlXuq56XWtKJRxt+7XUBc7EBGeSdBmHL11pAtN0
        5dSoV3oPAPJvZZUHWEPK+fM=
X-Google-Smtp-Source: APiQypIuuhzyXxgC45Na3CsneVLRpde2xjYEoAIqEwncWQEaDyVeVzs6Zt1BJp72i+gzKvf1Z9U5QQ==
X-Received: by 2002:adf:db42:: with SMTP id f2mr670422wrj.226.1586198550717;
        Mon, 06 Apr 2020 11:42:30 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id n1sm14853271wrw.52.2020.04.06.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:42:30 -0700 (PDT)
Date:   Mon, 6 Apr 2020 20:42:27 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v5 4/5] doc: be more precise on
 (fetch|push).recurseSubmodules
Message-ID: <20200406184227.zdej7q7eynjwosfv@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Mon, 06 Apr 2020 20:40:25 +0200
References: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
 <20200405201633.704987-5-damien.olivier.robert+git@gmail.com>
 <xmqqk12twq7x.fsf@gitster.c.googlers.com>
 <20200406134926.fid74suincbqlibu@feanor>
 <xmqq8sj8wl9a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8sj8wl9a.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Mon 06 Apr 2020 at 10:56:49 (-0700) :
> Thanks.  You may want to wait a bit so that (1) others can spot
> similar mistakes, if any, in the version on the list and (2) you
> yourself find some similar errors while waiting for others.

Well this was mainly the only change compared to v4 which was sent 10 days
ago. This change was suggested by Philippe Blain, so it has already been
read by him, me, you, and then me again when I sent v6 and checked
carefully I did not miss another quote around 'on-demand'.

Hopefully that will be enough :)
