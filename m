Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EBC1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 22:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbcFXWi1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 18:38:27 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35323 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcFXWi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 18:38:26 -0400
Received: by mail-wm0-f53.google.com with SMTP id v199so37358118wmv.0
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 15:38:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=pxAcpeCkLfX5ZKC8OMVU5xJmkDDI9QGWfGCsYGJYA8s=;
        b=w6OfM62jaq1yI2BXoBHa/hmBfiiY9S6Muy/M4T2mMb9gDtQ/aAywMNj3WImX8jaXUE
         3bVf7A3wTZOLeJeyYZVnKSGXKz//ZLJOkQ2mScueX6o4AVqH5dFpqvrybFN5hw+jPVZ/
         aQoKyQbCYacBmY6UJ8mdHpvRLNpzz0nXM0UzpMJehZXskdZcpECEYas3lKwGaXphV6qp
         kelYdnYgZoAArjfxei5BhPCt88Kgi9gJ3XsjGrXbtUjRrUWqA3kulkrsbFVH9kaNMy5Y
         YyLcVqlWo/uLV0mS6rONB5zI2uyDHwCMZ6RhU05k9gMINmr5Tki4c0P17nM21oAnjelc
         jaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=pxAcpeCkLfX5ZKC8OMVU5xJmkDDI9QGWfGCsYGJYA8s=;
        b=AhGyiC/2jEh6z5N0lhawnLJ4J1a7/Fryvo51fSmrHkGVq7/PS15cFWq9z0Ir0kdjyT
         4nKgQfFTThnmpJfuAtg+9I/B9hpQ0ULKK/lInxfxvQ/gUZfkdbkLwBwjJFVH0bQhlYdJ
         ReZVjVGcpqWfYn7su5uQ5nDurUrwBNw4Xy/Xab5bElnBvuH/QmCV73SCkzflcPyli/tF
         QsJlMvc9DDcQ5UDj+9mTzYr8dUsNSAqqVCf4p9j4FtoZqI6tN0l8YDqGWliefeWVnSEr
         Cj7TaPd5vyXIos2gWDX473jyZ7Vfzp2P8GuxN2tl0ikjAEgpdru1OD78LWsyNIsFyyAG
         r2yg==
X-Gm-Message-State: ALyK8tL6SKHyABNoHkcSoGtT5UG5859XVZakO9Mu6Q6/V+bXOC8xJmhNkCmB9M6DtVxcAQ==
X-Received: by 10.28.69.134 with SMTP id l6mr339622wmi.80.1466807904683;
        Fri, 24 Jun 2016 15:38:24 -0700 (PDT)
Received: from christoph-laptop-16-04 (ip-103-010-005-185.cpe.my-wire.de. [185.5.10.103])
        by smtp.googlemail.com with ESMTPSA id g10sm7102573wjl.25.2016.06.24.15.38.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 15:38:23 -0700 (PDT)
Message-ID: <1466807902.28869.8.camel@gmail.com>
Subject: [bug] Reliably Reproducible Bad Packing of Objects
From:	Christoph Michelbach <michelbach94@gmail.com>
To:	git@vger.kernel.org
Date:	Sat, 25 Jun 2016 00:38:22 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

when run on a 32 bit system (Linux system, don't know about other
systems),

mkdir test && cd test && git init && touch someFile && git add someFile
&& git commit -m "Initial commit." && dd if=/dev/urandom
of=bigBinaryFile bs=1MB count=4294 && git add bigBinaryFile && git
commit -m "Introduced big biary file."

reliably produces this error message: "error: bad packed object CRC
for"

Since git counts sizes in byte and uses ints for it, it can't handle
files bigger than (2^32 - 1) byte. That's 4'294.967296 MB. If you give
git a file bigger than it can handle, it usually just says "fatal:
Cannot handle files this big" without corrupting the repository. Btw.:
It'd be nice if the error message stated that this only occurs on 32
bit system and only with files 4 GiB in size or bigger.

To provoke the bug, the commands above creates a file which cannot be
compressed slightly less than (2^32 - 1) byte big, probably resulting
in a commit more than (2^32 - 1) byte big.

I was able to reproduce the bug on a Raspberry Pi Model 3 (ARMv7 CPU)
and a virtual machine running Ubuntu 16.04 32 bit (which was
specifically set up to test this, so it was a clean installation) on a
host running Ubuntu 16.04 64 bit on an ARM 64 bit x86 CPU (i7-4720HQ).

Output on raspi: https://gist.github.com/m1cm1c/d874f03be5b12cbd8b86ced
79fa456d1
Output on virt. machine: https://gist.github.com/m1cm1c/d0dd47828386bb0
f1e001b9f750416e0

Note that on the raspi I concatenated `git gc` to the end to show that
the object exists but is corrupt but you can already see that something
went wrong before `git gc` is executed.

If you look at the output on the virtual machine, however, you will not
see that something wrong until you read the part where I typed in `git
gc` which I find particularly worrying.

When checking whether you get the same result, please make sure to use
git 1.7.6 or newer. If you use an older version of git (older versions
are still being distributed, for example for Ubuntu 14.04), git will
try to memory-map a too big file resulting in a different error.

-- 
With kind regards
Christoph Michelbach

