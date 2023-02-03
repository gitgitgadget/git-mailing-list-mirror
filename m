Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69143C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjBCRLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjBCRLr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:11:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE31E5E3
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:11:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so5555334pjb.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=be6WTvSsQ4us1Zwf86/crGuO+1YnFA6UXyffQYVPqAKh7skPXL0y19soqQyAqKhbKF
         Sq0BksZ1aLXDvErf6qz8nrdY0wdoBt+aO2tE+R6q3yiTeVL2T2K2eWj2bA+GwBx+cuk0
         LDjKwevag/33owQJSKMb+FhaySHP22TVgUxNE+8v6czO/I1VBZ46BLt0KBYW1dvJ9fi4
         aFRcM1e7L8kd+tOtM+wO0GO6WjPI127fiQ1QoDHyOmgZc+dCN3pM2OrgqH5rZd+KOj33
         0FMGcklhbZ4YdaPKIX9xUMZXCG0yVJz4epGSTUl+ejiB01NbktWKP/QcGKFnzS8QXgGD
         0W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=I+LdKhdICtgFiYktG0rPjfCVGzoaLh6PDz5f8Nx6J9aLEwMPt25o6Ht4IRyA3a7EQI
         Y/s05ekHqs2pFSmeNZq9f9SZxTb4L2E02PDmg1gq2c3ILSXJYgzNSzxj23rGK3AJz2iQ
         rEVVlgJZfa93m2Y1goa0S6esvaZV+bM02vfU5qFYxm/42cDjYW/uEOA6a4xWVAp1VLKf
         tF5eKac45cXWFay8MKzIslr8OKfmpjL7lQy6WnZIkDPm9j9HUVnfSb8FdLeNajUcbFDk
         lcc2pyYyLL3IRt7PYtKEOyZNxfcgXrmu8vHVp+9us2LYTCTWseEwV9b2tkYDy588ssae
         poHw==
X-Gm-Message-State: AO0yUKUWc7nZLkVrWn6g5z0dflc7jl6XkrXL3KRPzESgYPJbhy89sKjN
        ymdXCF0x2/Licb2dEG6PaO1PaboZjIJqaujy
X-Google-Smtp-Source: AK7set/SRuc+uYAiwSVvV5P72P8dDbfNzIaJjqWuH0aHNGQLQyiBHh/SeRywmRYfOP7ooPoNfvnGTQ==
X-Received: by 2002:a17:902:d1ca:b0:198:ca77:f7f2 with SMTP id g10-20020a170902d1ca00b00198ca77f7f2mr4305128plb.31.1675444306728;
        Fri, 03 Feb 2023 09:11:46 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.182])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709026b8100b00194d2f14ef0sm1842719plk.23.2023.02.03.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:11:46 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     gitster@pobox.com
Cc:     five231003@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
Date:   Fri,  3 Feb 2023 22:41:42 +0530
Message-Id: <20230203171142.122983-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqq1qn7sm49.fsf@gitster.g>
References: <xmqq1qn7sm49.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


