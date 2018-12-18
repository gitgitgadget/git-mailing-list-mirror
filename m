Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217771F405
	for <e@80x24.org>; Tue, 18 Dec 2018 14:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLROWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 09:22:35 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:34658 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 09:22:34 -0500
Received: by mail-ua1-f47.google.com with SMTP id z23so5778859uam.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nVKQGstSjB7cnR7c4PGHvlq1vDcur05ldNOPq3HenPU=;
        b=Gt9H7JFWpl4DtKaauTbKI4AVpnDylMntXb8Bpb04tlovwpP5HTMNrpgWF8xSVIhPID
         xzoTDLkQ9TVXOFQ0qsV24Y0KpLWJVU8krIw72YPv5jfOyqEi9sRp2nbqCvs5rdI71FqE
         RNmc+aeQafZ4hI/tBvx5NhEFmOZXeNH/d+ktZAGu5DEeYx12p1RlPjA+FLvlGMVHEZdG
         fpZ3KUeF6Zc4q3jLyG9/ID6dyZsBnXmoXK9ToyIgPb7PAtevD99GefRV6k4SEF94dNdm
         Rsoxz17TTojerP4akpHv8i/H982XwIkgoemyQAsgsbZ5ui7nHsupoO49h7/JJV0Sz1lP
         ty9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nVKQGstSjB7cnR7c4PGHvlq1vDcur05ldNOPq3HenPU=;
        b=Xl9Fqmvwans5iL0nM1a4nd616avmWcpOAT6OovcqfrhnH2m1XjNKjy3Rdrjcom+yr8
         L4di0tr6jSmzUoyGUUjA8CT2zZRM4/VqG50cv2fffcdCz4aP9LOejeumQown34PuBCzb
         VBYZxUsObdc1mwPbkjjSC1FYoi0j8HQs6l51Kw+bo5G0/3XDrr7+I2z7kN5DssGuXuvu
         PXWHaXrWeObRPkHHodBwXbnCR1zSHnZ9WRMRSO9nkO5qfVvyeL6yM9VB3Xo86hx5+A0s
         jVOYWA5V5GjgH+0I77DUIPeZvG1zh5W52H6JrUJho6EM4hb9msEcf4IRDDldjVE7eFDK
         v8hA==
X-Gm-Message-State: AA+aEWZPJwGixh3iYiof+kMJMi9YcEQOPy431yssGr5yk4KNn7hyvYen
        pshV3ODdnURhAZLwuSjLeIP4BkCh0Lpt/3uzPpXTGQ==
X-Google-Smtp-Source: AFSGD/Ulpnt54T+RWe4CirRHHCOWU0ozxaIQC2Ta/oEnF5R2B8zRjIHTGzWif4oKB6CDRMSc1EtjIZ0jqwB399hv7ls=
X-Received: by 2002:ab0:4a16:: with SMTP id q22mr7852331uae.1.1545142952958;
 Tue, 18 Dec 2018 06:22:32 -0800 (PST)
MIME-Version: 1.0
From:   Thomas Ferris Nicolaisen <tfnico@gmail.com>
Date:   Tue, 18 Dec 2018 15:22:21 +0100
Message-ID: <CAEcj5uXJC3Za0YCyazJi82JdF-tLCDs5OrzCwyD8Y155GnJa6Q@mail.gmail.com>
Subject: commit-graph idea: warn when disabled for incompatible repositories
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there,

I recently started dabbling with commit-graph.

Accidentally, my first use-case was a local copy of a big repository
(chromium source) that another developer had cloned shallow (I wasn't
even aware of their clone being shallow at that point).

After spending a little time trying to figure out why no commit-graph
file was being created, I noticed that it worked just fine testing in
a fresh git repo.

Then I discovered the .git/shallow file in the big repo. So I did
fetch --unshallow, and commit-graph started working. Taking a 20
second log --graph operation down to less than a second (wooo!).

I saw some recent release notes that mentions that commit-graph is
disabled in incompatible repositories (graft, replace). I assume this
also be the case for shallow clones.

Here's the idea that may help others on the same path: Some warning
output when attempting to use commit-graph when it is disabled (either
by configuration or automatically).

I think others that come across commit-graph may have tried such
tricks (like shallow clones) to better work with their repositories,
and it could be frustrating that commit-graph has no apparent effect.

Apologies if this is a stupid/bad/old idea!
