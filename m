Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6EC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKCAJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKCAJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:09:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27BB644F
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:09:47 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r81so160266iod.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a916SVkYmz2GVt6zlUyDzhuNR4+E8fKi4aj3Rv1ZImo=;
        b=gfm1N4oEG3nwA2rBOsOG4J6grYSpEJWHpIu6seD63cyBlmOUwnyPJeB2wBNK6rsi80
         rQiyie1USoOf8oG9IqLYtJJW7/baDGJGPl22FF9S8KMTpzW6ZXkR0jb/vbnA1gCLfbgV
         4+jbggXdRBJPAFkDfirob5cJteuuCC5KYASr4+SfIGoVp97yX5DB2mK3iCoRgA3U8Eb6
         PA/XJk3gqGvqdLzEH7mpnn+zezeEE0k6lMJm+i55Elm1XaHkwrzCorxRs6x7drd5ipc9
         JLnTaTmi5xB/HjVANs9jGw3/OH3pXx1fqVwxHhloTPKQZ+ERdp9Gqzc56ux54Cg4vpYm
         qsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a916SVkYmz2GVt6zlUyDzhuNR4+E8fKi4aj3Rv1ZImo=;
        b=63JeOpyxlxJrODAQPUjZyyRnFQfk48N9bSGHjXn/tsdNyd4jB+FqKVz79Gle5KT/Au
         R8oI0zjqIBQTj/qk3jVcGXbD/oAKyChYx4fDyY/fLB4WZ0PgwBZi2rQFxc5hXATnMRX2
         6cHYg2DPY4XgxUS539br1TGCCrqXASf5WLBLD0oevWJTVtiv7eq1TS3NH763unqkZd2F
         HnR9F1M2wUzJcxWRAobojE5LfsVh/xdUBsbGhbyXmumXQ2WJ4ZNyi2lhg/scdEMRlvQO
         Vf3TOqERTRatdz6fS6H8n+2P28j3rQOSp1uBZhmbdI8OcRQrPFMZnoQaq4/pIx3QV+Kf
         SSbg==
X-Gm-Message-State: ACrzQf22JQZ1wwuf+zNa0aHQNlJO3V8E7fSldkAf/52tSEOq26Uzndsk
        hzbP/8TzqI3HjO5VV8OyA/QgtGNxpVDSnbGI
X-Google-Smtp-Source: AMsMyM4kv443nv6sEvMQt4py7Xl/38yiAi8kmwvcLOVjnM5+yOk8FDypVTQbEmdWZK6ZL2qEn4NiNg==
X-Received: by 2002:a02:9085:0:b0:375:8557:5a8b with SMTP id x5-20020a029085000000b0037585575a8bmr3230912jaf.262.1667434186154;
        Wed, 02 Nov 2022 17:09:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e11-20020a056602044b00b006cfdf33825asm4244502iov.41.2022.11.02.17.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:09:45 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:09:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "L. E. Segovia" <amy@amyspark.me>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git format-patch incorrectly follows the mailmap when used
 with --cover-letter
Message-ID: <Y2MGyM3O7ljEZ4Hm@nand.local>
References: <cb90779b-edb0-1911-c8bd-a6c56203a201@amyspark.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb90779b-edb0-1911-c8bd-a6c56203a201@amyspark.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 08:54:32PM -0300, L. E. Segovia wrote:
> What did you expect to happen? (Expected behavior)
>
> The cover letter should have tallied my commits and associate them with
> the current repository's user.name value.
>
> What happened instead? (Actual behavior)
>
> The cover letter follows my active mailmap and applies it when tallying
> the commits. There is no way to tell it not to.

Are you referring to the shortlog in the cover letter, the patches
themselves, or both?

As you note, there is no '--[no-]mailmap' option in format-patch, though
implementing one should be relatively straightforward.

Thanks,
Taylor
