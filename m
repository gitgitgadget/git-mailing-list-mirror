Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5E5C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CB26143E
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhEMNcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 09:32:53 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48391 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhEMNcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 09:32:45 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620912693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2ycT0sG50SktVSXh/KBTuy2dtVZYRN+tCXyKfm60ys=;
        b=aOFyxUpfv/y64cqjAaCno3vPfnKpvfrszFbetbeKfcVNSV+02gk7bxbfpXW+wc7jvVLYUV
        fRyF0M/rDEE2ssCann/TnjfUR9LI2m6X4BNDOIEpdQXZAXEOLDM8GC6ly1HzP5ZKmJ4hom
        5jaEvrFDobY2NzeFHSKdd5bBqJuObwzab5ZA0iEL1wQKbOG9XNsHcLkHy8vipnSkMDLg6X
        cZarF33Dm8PpWWF3ZGK3xMmKJ5w0OGhNyUv1cmFV+Gdo/eMSYBV0EFaVF+weAR3bqWGDAd
        kooJ/dyXNq5LUy6ZmmOWrvfRqKULd2Nf3bYbpidgX7JN+pavcMD4gvTI4TEtDA==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E78D860006;
        Thu, 13 May 2021 13:31:32 +0000 (UTC)
Date:   Thu, 13 May 2021 07:31:30 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] git-send-email: add option to specify sendmail command
Message-ID: <YJ0qMro2oP1Q5Ohw@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
 <20210513023212.72221-1-greg@gpanders.com>
 <xmqq8s4jcmj7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq8s4jcmj7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 12:58 +0900, Junio C Hamano wrote:
>In short, it is far from sufficient to just "$concatenate @variables"
>to form a single string.  $sendmail_cmd should be left as-is (after
>all, we do want the shell to split it at $IFS whitespace into tokens),
>but each element of @sendmail_parameters should be protected from
>the shell (both word splitting and $interpolation rules).  Perhaps
>something along the lines of this instead?
>
>    exec ("sh", "-c", "$sendmail_cmd \"\$\@\"", "-", @sendmail_parameters);

Does this pose a problem for platforms such as Windows that don't have a 
'sh' (not sure if there are any others)? Is git-send-email meant to 
support Windows?
