Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADDFC35679
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 08:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AF920661
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 08:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=booking.com header.i=@booking.com header.b="qpp/IrFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgBXIjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:39:42 -0500
Received: from mailout-101-r1.booking.com ([37.10.31.1]:54352 "EHLO
        mailout-101-r1.booking.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBXIjm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Feb 2020 03:39:42 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 03:39:41 EST
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=BmPo7+9eXRXPyiZtst0kjKyynZ/10BFDBKWkR1CqMhY=;
        b=hxQ44lnhx1yNXQeQ7TpjHxzMN46hmbYUUkaWsc2wD+IbeHQ2GMUJFV5GJrNU9P/k3E
         1N6pkb4rtVZKoolPJvfEdlLjdLLzsSobLtPPoyQQwuFNuYN/nibABL64Rc9TWOEU4+Ut
         QcVYfv53jjXR6K+HkQZaq++go6uCMsoXQxqb8XkQemtU1r6YBdrraLSc9e2NFS/iTw9U
         8QgPHE6o7HghPtPEJebkh0bQy1qd4ruye+7I0+kpX04o2ppW9D59UdAl+XgAfBx9hNor
         4e/QtrHVH5Lii5JjaE3JJqwK31lmn2PEGsD+ZEjUZ4ZCMnfMqakt6ziR/aE5pgJ0+aNH
         TPxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=booking.com; s=bk;
        t=1582533211; bh=BmPo7+9eXRXPyiZtst0kjKyynZ/10BFDBKWkR1CqMhY=;
        h=From:Content-Type:Mime-Version:Date:Subject:Message-Id:To:From;
        b=qpp/IrFxLyXGiMN+VZqyAFHsg/NddLKZ9TTV/MK+/LHgeAaxODVl/nDNcE7+xyjrx
         hZtn43LrdB5RnpCZ86883+FCL5K/VLhARGruTqiNUNA7/AQnIZHZKi+V+7qWb3BUwW
         MIZkuovj3hp2TEtR7pD0Vi553/bugH78iym/Gvd4=
X-Gm-Message-State: APjAAAWh7pttufmvf4jo6M3WPWJKfeBqHxYWyUztar3lpgjEQHOh6Uqr
        8Z37e/6UdRxSWeXyj3eFYYeT9NLuiboqAAPHQn7zkIZbbTj2uXvRuV50Z+6S0kHbcOEoGg8VITC
        6r9vS42dd4T/ySbIJQ13/MNo=
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr14058370wrw.194.1582533210904;
        Mon, 24 Feb 2020 00:33:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwi2WXK8eH27sMXhZIvHvaoJfvjpxGlRZvhv5Yp7VL94cfpsACGvURHv8AAq4MZtoqUShrRQw==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr14058356wrw.194.1582533210719;
        Mon, 24 Feb 2020 00:33:30 -0800 (PST)
From:   Son Luong Ngoc <son.luong@booking.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Date:   Mon, 24 Feb 2020 09:33:31 +0100
Subject: Git Rebase: test failing with GIT_TEST_STASH_USE_BUILTIN=false
Message-Id: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey git folks,

I have been trying to build git from source and noticing that some tests =
have been failing since 2.25 with the flag =
"GIT_TEST_STASH_USE_BUILTIN=3Dfalse"

I think in 2.25 t3903.103 started to fail (rebase related) and current =
master t3904 may be failing also.

Is "GIT_TEST_STASH_USE_BUILTIN=3Dfalse" is still being tested with or =
are we totally deprecating this flag?

Cheers,
Son Luong.=
