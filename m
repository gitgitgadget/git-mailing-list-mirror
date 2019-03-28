Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B397A20248
	for <e@80x24.org>; Thu, 28 Mar 2019 01:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfC1BGX (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 21:06:23 -0400
Received: from mail.farhan.codes ([155.138.165.43]:53148 "EHLO
        mail.farhan.codes" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC1BGW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 21:06:22 -0400
Received: from think.farhan.codes (pool-100-36-37-117.washdc.fios.verizon.net [100.36.37.117])
        by mail.farhan.codes (Postfix) with ESMTPSA id B6723C80C
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 21:06:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=farhan.codes; s=mail;
        t=1553735181; bh=ocCpKktDWqSluh5haQEpKh0Z20zPvor9UVFArwIx6rg=;
        h=Date:From:To:Subject;
        b=Si4uewo9szwUmQ6ZkMTV5doSCXuc2yhAv2lrQcN6X5sK/zEJu66RQ6pPtWI0vcsre
         NA8DCzXo0ZoBUG5FAcMCP+w9O9XNvR3Ji61tC4SZmER6T0nhNcfoPBeulUCxQBj1Vy
         9aYcce2QmUBNwnlaZbOsRzfc97f2teJ9H/H1gvo0=
Date:   Wed, 27 Mar 2019 21:06:20 -0400
From:   Farhan Khan <farhan@farhan.codes>
To:     git@vger.kernel.org
Subject: Calculating pack file SHA value
Message-ID: <a48b86698802006045ed0af060b4e822@farhan.codes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: RainLoop/1.12.1
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am trying to figure out how to calculate the SHA value of a pack file when you
run `git index-pack file.pack`. I am close, but having a bit of trouble at the
end. Here's my understanding so far.

Git buffers data to be processed and when its exhausted, updates the SHA
checksum with the previously read data. This is from builtin/index-pack.c,
specifically fill() which calls flush() to update the SHA value. My question is,
how does git determine how many bytes at a time to process?

The size of the buffer is the file-scope variable input_len. This size seems to
be 4096 several times until the very end where it reduces to less-than 4096
(obviously this depends on the pack file, but in my case its 1074 bytes).
Ordinarily I would think its a result of the read() call not receiving the full
4096 bytes, but there still are left over bytes in the file but my manual
verification shows there are still remaining bytes in the file which are not run
through the SHA checksum.

How does git calculate a pack file's SHA verification? How does it know what
size (number of bytes) to read when running flush() to update the buffer?
(typically 4096). How does it know when in the file to stop updating the SHA1
value?

I hope my questions are clear. Thanks!

---
Farhan Khan
PGP Fingerprint: 1312 89CE 663E 1EB2 179C 1C83 C41D 2281 F8DA C0DE
