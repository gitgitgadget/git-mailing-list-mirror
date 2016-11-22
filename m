Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989F61FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbcKVOmi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 09:42:38 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36129 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932974AbcKVOmh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 09:42:37 -0500
Received: by mail-ua0-f177.google.com with SMTP id b35so16016916uaa.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=BFPeofbzbQeMMSCVJG5v4V/iMnWv+ccrp+9sPfOo0tE=;
        b=OxnzpkI61QqR5lqX+turTzzn+Kl5cyQ1cCMuW0T3KK6O2TZgzNYuT+m6X0mY0EKJpj
         sMD4WzGzWCe0T+VQbEt2aqMz+6lm3IZ6fxNsvDkRRJMrTWd8VUeKnGxHxbeaZVQ8OiGx
         fb7J8BYPY+MWqOUtL+t8AoraYO+t3Zs81EA91mRGocAc4Qrr0mxzLfETlApUkbjBneO/
         UWyEUzT2Vy6BIM51glPzJqi1ff7cfeS7NmFB+lZSEomXPif9HVlaMhwzWifut6gnqbvN
         PQGl3sMKohwRqcgi9rbFi96rb5Wt5+Bx6zzuJ25VhJERpUMqtYSmx0fnzv6g7B0BCA7g
         0BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=BFPeofbzbQeMMSCVJG5v4V/iMnWv+ccrp+9sPfOo0tE=;
        b=Z4cU7YvGnlxj0M27+qWWiQWBZDumIwYFTj1KoNW8kOYO9rE7NC5yH2qdufBRn1q6Dc
         ahZ/U5+cviwuijAM6qZC44p880UJeTqQwoZ6i6uOCg7VnLV2p+Cdw7cDMyC+qplsG/oF
         3e8Ww27qFgD7guNM0IzYs8KVHXm18sIgqc4GoOoik2IR+7NJnaj7c59R+2NbmFw5qJvd
         bByOzB7Lau8VOPGd0J+bwBPpFZ1ET2zknX+VuUWvaacPLeDT7vOmHg+TOruYyMAbv3lW
         wpox3YN1JnZ/KZtecmEH/9QdkRDBjiODJ5+TDpoR0RVwY/0eeJk5s3GiwAAxumu2n4l+
         s6Iw==
X-Gm-Message-State: AKaTC0184KdD10FTtWzxZX3MHnt7/tjBLd9UCqlVClYo1qt+qTM8YQZWvFO+m7T+Uqvq+XTWhTjlWPKZmQIL6g==
X-Received: by 10.159.40.97 with SMTP id c88mr10819340uac.17.1479825756603;
 Tue, 22 Nov 2016 06:42:36 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.67.166 with HTTP; Tue, 22 Nov 2016 06:42:36 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 22 Nov 2016 08:42:36 -0600
X-Google-Sender-Auth: -QCx4b-eCIIBOJETJo_RWm8muT0
Message-ID: <CAHd499AjXh1YnVgBj_8j0fgvOgOn53y+sPBBy6y7mSM-+dCyVw@mail.gmail.com>
Subject: v2.11 new diff heuristic?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The release notes mention a new heuristic for diff:

* Output from "git diff" can be made easier to read by selecting
which lines are common and which lines are added/deleted
intelligently when the lines before and after the changed section
are the same. A command line option is added to help with the
experiment to find a good heuristics.

However, it lacks information on exactly how to use this new feature.
I dug into the git diff documentation here:

https://git-scm.com/docs/git-diff

It mentions a "--compaction-heuristic" option. Is this the new
heuristic outlined by the release notes? If not, which is it? Is the
compaction heuristic compatible with the histogram diff algorithm? Is
there a config option to turn this on all the time? For that matter,
is this something I can keep on all the time or is it only useful in
certain situations?

There's still so much more about this feature I would like to know.
