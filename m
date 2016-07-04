Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199A820179
	for <e@80x24.org>; Mon,  4 Jul 2016 16:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbcGDQqA (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 12:46:00 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35939 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcGDQp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 12:45:59 -0400
Received: by mail-pa0-f47.google.com with SMTP id uj8so523402pab.3
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 09:45:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=hiuqnx+tVyUEn3AYmjm+/kMNAvofTvE53iyClPGefGc=;
        b=DGHRKKKP7S+7BLq41OMptO/7oy+53Lp634w3LQkOClna0VF017UX2wb/K44tYqucj9
         hfGOsWqKqcWsKjq7snvlnJlinb4XZPzkp3fEUFXUinKJWRXz1kUCKfb7k+kAWF62oluu
         0cLe74DJpJU9GlKLDgVvEDHTCgIA/zyHs6YzbZXUTEdGMKzSRZTdAma7k+GV9nc1RSWU
         POIdjVxSA1KF14nNeEKafKYJW5DKstzRHZPeXW+V7bWXg19DA0992cuBtjlT+onQ9FYF
         Ja9rSWDuddkI4spWy8gIYPaHmHchVxFPqoWQU22oQQh0dMK+nxlJWe1JPDss4bOQxS2p
         /2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hiuqnx+tVyUEn3AYmjm+/kMNAvofTvE53iyClPGefGc=;
        b=fhbSOFOajrAkB7+LCXlD8StkOePHKcjASo/nzQtA1xHS2xMdV/cNZtSViFaF/wq01f
         dEP4AXUfHIDL0Xlp5xZG/9IjSLvznG4V8doUQqRk1egeW2UZ/ohQ9Liis+7j5AxhoWMy
         mjGHPiV90KkG06dqux7kU50B/4cTqrT8gaYhEczcYingJopyij/t7VLdmgwK4kn+h0Rt
         x+biiGiqE/XgqhJ0omLCk1uzOX65KXbPYQAs+8XVd38fO1DrO4faEwQXvaXe3uhdXQVO
         gt2Cy/prLJ5P5JgOw9QdtsdI2d/1NnNRtcKNum6EHI+qV7H21kgDr+k8XNhc83yj7h9o
         3m7A==
X-Gm-Message-State: ALyK8tILqRHBFZlj5gwUjIWrJl/NFcMLb6AdU1OeFHqR91KqyA6x/UT2PdYsGpKTHb77dqdw2OOr7mMXek+ltA==
X-Received: by 10.66.25.171 with SMTP id d11mr24135183pag.3.1467650758963;
 Mon, 04 Jul 2016 09:45:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.66.126.147 with HTTP; Mon, 4 Jul 2016 09:45:39 -0700 (PDT)
From:	shawn wilson <ag4ve.us@gmail.com>
Date:	Mon, 4 Jul 2016 12:45:39 -0400
Message-ID: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
Subject: split directories into branches
To:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I've got a chef cookbook repo where everyone started developing
cookbooks in a single dev branch (not project specific). Minus a few
edge cases, it should be fairly simple to split this up into feature
branches based on /cookbooks/<feature>.

I tried:
$ git filter-branch --subdirectory-filter cookbooks/<feature>-- <feature>
And
$ git subtree split --prefix cookbooks/<feature> -b <feature>

Which both seem to do the same thing (haven't looked at the subtree
bash - guessing it does exactly the filter-branch). The issue is that
it removes the directory tree (so obviously merges wouldn't work). I'm
thinking some type of filter-branch --index-filter with a cherry pick
(or similar) should work...?
