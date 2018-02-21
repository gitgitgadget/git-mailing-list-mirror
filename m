Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3173A1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeBUX5v (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:57:51 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35299 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBUX5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:57:50 -0500
Received: by mail-ot0-f180.google.com with SMTP id p8so3085694otf.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarifai.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=V9XoKegX13JwGxZ+oVsd89gsZRiX8PYxNWF541iVc8k=;
        b=eLThtgRrhnAZmHfv2kuVgqCjYVcFW+A3Ml1fQOXcKdg4M0deC5khWAphiarx4hzYFJ
         modsIEbSR0O7mPOH8FsIQqAucU/kf8E8p7H3PJbp5J/2Cvk/T2c90Rw4EjbdetVaM/3O
         CwEtW3oAZQS93lDOk8ar4aXa3WKIQp2oja5Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V9XoKegX13JwGxZ+oVsd89gsZRiX8PYxNWF541iVc8k=;
        b=W6985CNpgsxrFF6+4+bG4v/Y9ybXR5buacIfldG8rDJTd9bf8hZErrXEkeCHQqW7OG
         DamGrlQg/Pf8p+ToNcnPePjcRBE7Sd+lp4XmnojEbkkMkwr2q+ORMzhSHo5F+OtJ3yZE
         cNwxEEXPxhwVRxuQkfDbXozf70lL+MeSOlT561oBdMoJNPCfBxJTey0PL1Ct+dQLnCPE
         ImqMvmDA+ZSKXPw+MRrbHapxURCi/Eta/A8EeSbkcDR1MrnAmBl5IarrtiUJs1APp9fa
         2S3lL+wj7VTZa43eUGy8x1mExjypog2mWNF7FO7VGbE7K0fK6KRcTTOG6lzgpnAhvmYi
         E0Wg==
X-Gm-Message-State: APf1xPB2mCKwDPbcKXXRoAhOgXXdeXT7OhoTHiMM5OMcXyYG9jPGP6ZY
        BkAtPW4pVeiAzadISmJXsbN+A/LGhp4NGNNtYY45rlnsc+w=
X-Google-Smtp-Source: AG47ELtQisSgDogYhVJXwvjGo6v9YD4ki4V6BJvIPErc0f7LBYsIb6amSLFl5CQAE5MOK3aiBLrHBu6JJFzGOlRybHg=
X-Received: by 10.157.24.48 with SMTP id b45mr3130598ote.195.1519257469834;
 Wed, 21 Feb 2018 15:57:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.138.221 with HTTP; Wed, 21 Feb 2018 15:57:29 -0800 (PST)
From:   Josh Tepper <josh@clarifai.com>
Date:   Wed, 21 Feb 2018 18:57:29 -0500
Message-ID: <CAPFeJUAF99buo=yTZQeHawU-npLHk0iJ1iQxYwMroFdDcKhqjA@mail.gmail.com>
Subject: Bug: git log: boundary commits do not respect order (e.g. date-order,
 topo-order) 2
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git log, boundary commits (ie, those commits added by
specifying --boundary) do not respect the order (e.g., --date-order,
--topo-order).  Consider the following commit history, where number
indicates the order of the commit timestamps:

<view with a fixed with font! 3's ancestor is 1, 6's ancestors are 4,5>
0----1----2----5  <--A
       \         \
         3----4----6  <--B


Executing the following command:

$ git log --boundary --date-order ^A B

Should produce the following order (boundary commits shown with dashes):
6 -5 4 3 -1

However, it in fact produces:
6 4 3 -5 -1

Please advise.

Best,
~Josh
