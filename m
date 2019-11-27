Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF4C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77302070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y475/Y6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0SN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:13:27 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43876 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:13:26 -0500
Received: by mail-pf1-f202.google.com with SMTP id w201so14498311pfc.10
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NJP1ahQYMBUyk0fFRCpI0Q8tfcMovbNZF6MATsucUUg=;
        b=Y475/Y6TdvKYwmI/dvDEntUn4QTR8818A2sbO4z35IoklQHgz9i3y9EPQn4jAoyUfo
         OB4yLQ6gm5hWgZy/NoF1HP4LKiYXmB9ERpt3i1qYPJDcO9WkKYkyhKzR5l4u0kjZ2wgX
         udKT5yNTjElPZIH/boBgpm7x37hYvQmOAzGBSV3PNuGq0M+0mykI/xU8NMwVG/C6rL2Z
         AtLxPnSz/gSO/ezjmgegiUeOkqZP6uL5TgrGUnzejrO/Oofatyi/lPo5p3/HFnwYqezH
         4xp2zmrEZFSD5/aNGA8zzF5x+spojHibOoQ+eKzbQ6wbrDJIwMCJIZAi91w4A0nMzmcx
         n+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NJP1ahQYMBUyk0fFRCpI0Q8tfcMovbNZF6MATsucUUg=;
        b=LEPyP6njrgYut7bFPlsPP9MmIuw6iafiWSg0iIT5R1pzTcemXK+lg3DndSxSGWtF4j
         0x0YHaQIRCR+VEJaiOH7oQrS1OhdbAwo01fkriueWKGyqOGvaTgpKch66Qzm3OuYxNMU
         EnsO9xd1sRD7weqs4dOSYrVKhqjyDVpYJnlVxfqU5PO/fgD+WxjPmA2G6zHFPdDtk1pb
         vmYPEUIdgt7CV4GF6ZwTicGvJDseo/swxY6kusveOCWBSW/fw2zuA7Y53fyux6WSuyme
         7tSL3/mRpjUEhO5Q+7iDt+m+JeWbdUhfNyUW+0xOTC2R+1gkHvIyFHdot+XdLuJruC2f
         hXxg==
X-Gm-Message-State: APjAAAWqQxL8QXFnMwOO7jmI62T5F5upaqeSSOC2nOkZzZQKEDSZafsN
        exoaWo4lgmnBgRusNTvwK8aEzaOBa8m2KExJ/NvL
X-Google-Smtp-Source: APXvYqzZ07nhM7gn6XPMUfWSziWHrIEEMqqseh9j1vfBgaIHsxQ24aYr9G+CuWm4RUfY7o5Pvw0w6jjGflU2rKwz1K0K
X-Received: by 2002:a63:dd58:: with SMTP id g24mr6545711pgj.376.1574878405966;
 Wed, 27 Nov 2019 10:13:25 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:13:22 -0800
In-Reply-To: <20191112103821.30265-12-szeder.dev@gmail.com>
Message-Id: <20191127181322.171734-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191112103821.30265-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: [PATCH v2 11/13] name-rev: drop name_rev()'s 'generation' and
 'distance' parameters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     szeder.dev@gmail.com
Cc:     gitster@pobox.com, stolee@gmail.com, l.s.r@web.de,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  		if (create_or_update_name(parent, new_name, taggerdate,
> -					  new_generation, new_distance,
> +					  generation, distance,
>  					  from_tag))
> -			name_rev(parent, new_name, taggerdate,
> -				 new_generation, new_distance, from_tag);
> +			name_rev(parent, new_name, taggerdate, from_tag);
>  	}
>  }

[snip]

>  			if (create_or_update_name(commit, tip_name, taggerdate,
>  						  0, 0, from_tag))
> -				name_rev(commit, tip_name, taggerdate, 0, 0,
> +				name_rev(commit, tip_name, taggerdate,
>  					 from_tag);
>  			else
>  				free(to_free);

All invocations of name_rev() are first preceded by
create_or_update_name(), which sets the "generation" and "distance"
fields in the name accordingly, so this looks good. All preceding
patches look good too. I have already sent emails for patch 12 and 13,
so this concludes my review.
