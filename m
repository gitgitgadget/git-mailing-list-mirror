Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC84202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 00:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdJXA0T (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 20:26:19 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:55023 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdJXA0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 20:26:18 -0400
Received: by mail-pg0-f44.google.com with SMTP id l24so13080834pgu.11
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 17:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netskope.com; s=google;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=Zh7ANxQNd4yJxtopAIVWlK1fzRaeSUPDbpoa7W1JaNQ=;
        b=CKt+ovLjMngbDAbIrB3+ODhjwPb7xJijMepKqxcA9L8rb/iLH09N8QGRXNVbldBG18
         GEf9ed5/q7B2Piy9M993S4r8aLBdYf0g+A4Ihxo6OGMwZrtfsYi1HxYRr2h5sNW3ScqD
         uKVHNn8SOpAW9+FUkp0LgruDgkV631fpZ14HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=Zh7ANxQNd4yJxtopAIVWlK1fzRaeSUPDbpoa7W1JaNQ=;
        b=kPomWdc9rBr1yjp50bLg/jeIgBC5SCZmnLSKG5ZXwbi97wW668g7G9169m9bP5D/2M
         Oi7UCL4mHNu2uGOjuykzbI3/z/YdnHmmBX3s8WByxyWI/fWomBW8gCKdOwIyiCS435Kj
         pKl8Xww+aY7AbWIhjWh7ZxdFmVhnxTucD5B5YEPz8UT1xnkNJKiJK9uG/VRbX8Do+FOB
         dDo97HbSSarZ/X02rY9U7dgQ8E3hwwE5no6kvnipJyV1c7t/jLbE+DQJ18nue2uUfQps
         s5SxJu6r1RKWpuJjjrYAQL9sWwCdnC/z43TPsgqPbqoDxsgKB6B8ec3s0cO2iduhLKbj
         8W5w==
X-Gm-Message-State: AMCzsaWYgEHWfeX38jVFpQnb1+vhYmcIuRacf01TZLpZUDie27wzd0yl
        pFO9PS5yl7HY1vVXnfAM0Z0ZMlBVrt0=
X-Google-Smtp-Source: ABhQp+THPywrKGQloGklYU/KQuwZzoxZcmISqrzEAd0oaNk3GO0wnxREU8RhVudUjNUbospz77DmoA==
X-Received: by 10.84.128.9 with SMTP id 9mr11656895pla.332.1508804776685;
        Mon, 23 Oct 2017 17:26:16 -0700 (PDT)
Received: from [192.168.65.161] ([216.38.152.90])
        by smtp.gmail.com with ESMTPSA id m9sm12592271pgt.49.2017.10.23.17.26.15
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Oct 2017 17:26:16 -0700 (PDT)
From:   Kai Zhang <kai@netskope.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Question about purge git history
Message-Id: <5E33218C-F943-4400-9F78-399A1DD74738@netskope.com>
Date:   Mon, 23 Oct 2017 17:26:15 -0700
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I have a git repository on server side, and a client keep pulling this =
repository periodically. After a while this repository gets very big =
(even after git gc), and since history is not very important to us, a =
purge strategy is needed.

I did some research on internet, and found two methods are available to =
purge history on git repository:

1. Remove .git folder
    1. Remove .git folder
    2. Reinit repository
    3. Commit all existing files
2.  Create a new branch and remove existing branch
    1. git checkout --orphan latest_branch
    2. git add -A
    3. git commit -am "commit message"
    4. git branch -D master
    5. git branch -m master
    6. git reflog expire --expire=3Dnow --all
    7. git gc --prune=3Dnow

Here I have two questions:
1. What would happen if client pulling is executed concurrently with =
above 2 methods? Would client side repository gets corrupted?
2. Is there anyway to propagate purged repository to client side?

Thank you so much for your attention.

Best Regards,
Kai=
