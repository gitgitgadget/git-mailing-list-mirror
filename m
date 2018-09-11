Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB87A1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeILAxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:53:51 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44725 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeILAxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:53:50 -0400
Received: by mail-lf1-f43.google.com with SMTP id g6-v6so21345983lfb.11
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saintandreas-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=7FrCkRLW7espCppTadCxb80KCyecv2Rw8pBiCo4ht9U=;
        b=Fy/KXe8qn1Ck/dqAoG4/ZpxAbx4BM0uW1UGf1xI59kYG1KwKS0q9b8tkQB7VLOJ82F
         koBrUnp0P1+6/JsKFV/yW/bXOJXpWzp9yyxYwnPzJiPLi8i3r8F6rgzClcUVkmoi54uc
         AfBP/IX+SBAg/oMBpZMU3Jcbbx67+n0KuDzcEYfVAw+eZGjakEkEieOjMV7Ek3Eh2yau
         zIjugsrKpzQ5uWXQch/JtWNGBt5sYArkOPO5pc7m7woD3onshwalxfV+bg/vaBCMcFju
         ui7LbmavPGe8IVD1NfvXTlx0boutTFtG3kjCgwk4tEi2RWC/ZAoLm7eiedy+gluIPmKm
         5U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7FrCkRLW7espCppTadCxb80KCyecv2Rw8pBiCo4ht9U=;
        b=lKjZJMdJjl3R84139G/ySnPKGBFGmCpqDnp/xPAMnx7/9m/n0AiP+ZlWctPZFnLU7p
         lglW+AigK/T44g1+F8E2E+8lISHVRjePScOou6REVS4DFkeK1ZJnRzmsAPi2DxjLhMMe
         2NawRBwjk2qu/V8g7mf0Pt1etcbI4pa9iV5OIG+JQe9op8wmz1YBZi4HF2cJQluGX76b
         AINxHZkswgfwsP2Sz14EIQdn1O/K3A6InMMbX/7wLOWRLpB6wVxfW39c6I3RxB+TqKdm
         kZ8m3eH1x0zl62UydNsBEOOc5xL+/3Nme+h99XSykKGMWZnXjh0wWdI5ykjNFABii+Zy
         Otcw==
X-Gm-Message-State: APzg51CydGnMwQsrd5We4vTfiqg5sxdcd3CDKYvqkN3igAJUsJitufO7
        z4ltJCIjKoA9HAoH/Znlrbb3avO8VNAQ+FqwfApSNo4Km6Q=
X-Google-Smtp-Source: ANB0VdbAPdjxQMEPT0BF72+stYG5QHQCGzEfLWeSy+taSnAPTBb+TxPZhHC6wl5hX/LM8twKhXShcDq0wjWRwjLbrKM=
X-Received: by 2002:a19:164a:: with SMTP id m71-v6mr16187968lfi.82.1536695578864;
 Tue, 11 Sep 2018 12:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:508f:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 12:52:58
 -0700 (PDT)
From:   Brad Davis <bdavis@saintandreas.org>
Date:   Tue, 11 Sep 2018 12:52:58 -0700
Message-ID: <CAMK-fcye+nNyB9pFrp1nQwQC1+sQWMt_4yq2f7svJUiB=ZnnJA@mail.gmail.com>
Subject: Allow git bisect in reverse mode?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm currently trying to determine when an issue was fixed in a long
list of commits.  I attempted to do this by running `git bisect` and
marking the commit where I knew it was broken as bad, and the tip as
good, but I got back an error message saying that good revs weren't
ancestors of bad ones.

I'm currently working around this by mentally reversing the meanings
of good and bad, but it feels unnatural and error prone to have to say
`good` when I encounter the failure and `bad` when i don't.

Couldn't git simply do the same thing and internally reverse the
meaning of good and bad if the bad revision is an ancestor of the
good?
