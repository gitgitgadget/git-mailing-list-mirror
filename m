Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A24D2098B
	for <e@80x24.org>; Mon, 17 Oct 2016 01:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757139AbcJQBEh (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 21:04:37 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32872 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757071AbcJQBE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 21:04:29 -0400
Received: by mail-pf0-f182.google.com with SMTP id 128so72517645pfz.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=faOtRuWc/d+MmY+WnlNL131nXpIaZAbLEBTkmzSLalY=;
        b=vWiWJNm5xHF0QVQUad7+cBT6HsZ5Tj2ko1MhENbgz7bFaXg2KEkYTSbiQucJ6rs5cm
         44jTYAvOgZrA4GiIJoP3daVftqU+f15c/XJ0ytouzQNbKRIQoeIcJ5OAPjfilrLyOTp6
         FZV52YMGNtLES+VdMXmYpmsUPCLIk9Yaotv8bj+geu/ioPBMxMlspkA6XraYr5gNmDVm
         72iHWFwk9PAfzuRcZv1VBpCJNcpOsFbpiYc7lvqsyAt+hm6fWWiyo5dVfD9pvbO4Fg+J
         tb24RBYosi2nJceKlj5J3cOaNFlAg+CMEetBBpsrY8Ol8LKjbTtXdkJa87Uog9OzM8Ms
         47dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=faOtRuWc/d+MmY+WnlNL131nXpIaZAbLEBTkmzSLalY=;
        b=Fin6xSkK/I/TKxft8cTDEt1t67x2SrT7NGEJhi52LDXMx3dIwgNcpG7dSsQodYsBOL
         bbIkbWZHqPzkh7rbDp/S9G+H4BXwWBHhudixsVzE6StsXoepPCjBiE59w67UoApuW9Ru
         7AzqwiPisVEzljYMZ0av+1Dbv3TdKKxD71YZYOh8iFKCxYpwFn9ftkp8xEEwhqsDyFpF
         V9xfl7BJ9RwCz3GBpIYHWDqCPo5D9kB5sXesQ3gDQfWBc8ez86T5eiKH8PYxC5IJl1ev
         FgXWefgLY4sbZx68TU79ccZHNTfiHZ0464SdWc3qcTFRAOfZ56LAnc0h+DgXx+aIHqyD
         nS1g==
X-Gm-Message-State: AA6/9Rk5MUm3i4HGHk7RixE+pk6JuDn0VC7Ia4YAH3mPN3P3wN+yR95PukH3+UshkvJ33Q==
X-Received: by 10.98.141.217 with SMTP id p86mr29448829pfk.109.1476666268617;
        Sun, 16 Oct 2016 18:04:28 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id f1sm42964486pfa.29.2016.10.16.18.04.27
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 18:04:27 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [RFC] Case insensitive Git attributes
Message-Id: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
Date:   Sun, 16 Oct 2016 18:04:26 -0700
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git attributes for path names are generally case sensitive. However, on 
a case insensitive file system (e.g. macOS/Windows) they appear to be
case insensitive (`*.bar` would match `foo.bar` and `foo.BAR`). That 
works great until a Git users joins the party with a case sensitive file 
system. For this Git user only files that match the exact case of the 
attribute pattern get the attributes (only `foo.bar`).

This inconsistent behavior can confuse Git users. An advanced Git user
could use a glob pattern (e.g. `*.[bB][aA][rR]) to match files in a
case insensitive way. However, this can get confusing quickly, too.

I wonder if we can do something about this. One idea could be to add an
attribute "case-sensitive" (or "caseSensitive") and set it to false 
(if desired) for all files in .gitattributes for a given repo.

### .gitattributes example ###

* case-sensitive=false
*.bar something

###

I haven't looked into the feasibility of an implementation, yet. However,
would that be an acceptable approach?

Thanks,
Lars



