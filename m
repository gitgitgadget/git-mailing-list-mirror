Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DE61FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 15:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936280AbdJQPV0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 11:21:26 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:50313 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933923AbdJQPVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 11:21:24 -0400
Received: by mail-qk0-f180.google.com with SMTP id o187so2471121qke.7
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=livid.pp.ru; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=t4etaLkfYGntHy8puPtmU3zfJ8CZJDxsvcsN3zSmvQA=;
        b=jGX1/BntqUUy4J4r5te/+A25kSnacMfC3l5JlAX2Kr/7BUPp1F00P11FwOVr2NO9p+
         Ogj8GU1BNwpGC8/i/+TCE79Irk/gB/JQB/DZvpD/IuypCT+zsxTUW6qFrY6JbMK/ZyX3
         /Td5th7WozLCbXl5hVgltdLPqEjvgZoJS4vQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t4etaLkfYGntHy8puPtmU3zfJ8CZJDxsvcsN3zSmvQA=;
        b=cc23y7mG6ldFTmHoPXBVsWo6ANGFUWe7xmnx+Ffm3e8Jaxt4FQRjZSnDnNAwvYwSwQ
         U/d29CZl2KROgyGrnA0952ps33qSDqv76W2uYNdHx2gpXeqJ0C7zzYzuOhiwxIRYMKbE
         9eGjz6OsXCUnS/0bUH1L4yDPYg02v+oD6cbgQ80Q+unOOthwyNieEIwPx/BwWHGK75jB
         KMIjygtBbl8LJfZat6McnniBVqxJeYY9LvFh1LEPs6dVRTkxLNEhN96uhUKRmfJFkD0g
         pBo29aRN9uKfWU/zzZ6G5gQM6DCcYTzVNjzbNHyVK+zgB3feckG2WpyHcekSo4wo5Tqm
         XTzQ==
X-Gm-Message-State: AMCzsaV9HIwqydwv6g027uk9cZKjFr1Zm5QW2oGdGTG8fCFUuIT4NgT4
        6SSJOcpwp0j6w+wHnTCu0YzL5E0G3mH24G8xdQv17s0XhIw=
X-Google-Smtp-Source: AOwi7QDzpeKweiR4+iInbj6oaECuIBx+zDwjdpB/cKHpwuhhFRu1s12W09CRIE2yW33GrQl5GlJgnynQas3puaL3iAw=
X-Received: by 10.55.118.7 with SMTP id r7mr19963726qkc.241.1508253683169;
 Tue, 17 Oct 2017 08:21:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.53.76 with HTTP; Tue, 17 Oct 2017 08:21:22 -0700 (PDT)
From:   Nikolay Yakimov <root@livid.pp.ru>
Date:   Tue, 17 Oct 2017 18:21:22 +0300
Message-ID: <CA+A=rXEyQ4aQL=p55f_+kbbrnDyDr9ULSq9gqBE2YE9y6+oJ3w@mail.gmail.com>
Subject: Multiple paths in GIT_EXEC_PATH
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello. After updating to a recent git release (2.14, I believe, but
possibly earlier), setting GIT_EXEC_PATH to multiple directories
stopped working. It did work before, and I believe the culprit is
'git-sh-setup', which uses 'git --exec-path' output directly, while
most other git components observe PATH syntax, i.e. multiple paths
with colon separator. Is this intended, or is it an oversight?

For why I need that is another matter. Long story short, I need git to
look for '.gitignore' in a particular non-standard location, since I
have multiple git repositories in the same workdir (that workdir being
$HOME and git repositories being stores for my different configs)
