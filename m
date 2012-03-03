From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 0/5] modernize test style
Date: Fri,  2 Mar 2012 18:15:32 -0800
Message-ID: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:16:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eWO-0001oY-Sn
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775Ab2CCCP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:15:56 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48188 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab2CCCPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:15:55 -0500
Received: by vcqp1 with SMTP id p1so2024061vcq.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:15:55 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.23.199 as permitted sender) client-ip=10.52.23.199;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.23.199 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.23.199])
        by 10.52.23.199 with SMTP id o7mr21108358vdf.79.1330740955167 (num_hops = 1);
        Fri, 02 Mar 2012 18:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E6G62Z0EhBDczGJ0gEA4jU4enumkxG9ogjvblXYPcCY=;
        b=uRfPmaqT//Pw0PaTJIqeqOTZE8DdohUnHPRSNo7HwnUSPVg8B6ZiemmCwBB+zQqv7o
         ZvUjmJKtwRbH+uO/Nvz2c4IJUWJLfoMkA16cURPQ+UJ70fQw95uor9ZvZSw5OvDXrMVu
         wydON54WYJoKI1DQUs09ATYGssDyu4rlpBl3BqzzNj3CyRZCWAEQ4sjrrUoOPjPs+7yH
         JVSzlbX0F70bc0e0EP1tf8Rl6fNMguV4dGhS833H4ioTJag+Ee2JapBPKfIdxWZ9xrOn
         xqW5aokPrcXbWQ+8Xjugy8afn8Utls4PpGMTzYMl/Ws1JG+XIP4j1clxvhzP+ikbQQ0j
         /oTQ==
Received: by 10.52.23.199 with SMTP id o7mr17996363vdf.79.1330740955122;
        Fri, 02 Mar 2012 18:15:55 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.15.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:15:54 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192078>

I <tmgrennan@gmail.com> wrote:
>Per request, the following series modernize the style of the respective
>test scripts.  The common themes are:
>	- Guard setup with test_expect_success
>	- Single-quoted, tab prefaced test blocks of < 80 cols
>	- Redirect unwanted output
>	- Use a "here" filter for some expect generation
>
>I also used pipelines to validate expected results rather than temporary
>files, i.e.
>	TEST | test_cmp expect -
>vs.	TEST >actual && test_cmp expect actual
>
>Since the later three patches have a lot of whitespace change, I've included an
>alternate, PATCH-w series that filters these for more substantive review.
>However, even the filtered series is very large causing me to second guess
>whether such style modernization should be pursued; so, I look forward to your
>input.

The following series is a much less ambitious modernization of these tests.
This version does NOT:
	- Support running with t/TEST.sh vs. (cd t && ./TEST.sh)
	- Redirect unwanted output
	- Pipeline test_cmp
	- Rewrite blocks to be less than 80 columns 

This version DOES:
	- Guard setup with test_expect_success
	  (in one case, a shell loop was unwound to facilitate this)
	- Single-quoted, tab prefaced test blocks
	- >FILE instead of > FILE redirection style
	- Use a sed filter to process formatted whitespace test cases

I've also included PATCHv2-w for review alternatives.

Thanks,
Tom Grennan (5):
  t7004 (tag): modernize style
  t5512 (ls-remote): modernize style
  t3200 (branch): modernize style
  t0040 (parse-options): modernize style
  t6300 (for-each-ref): modernize style

 t/t7004-tag.sh |  828 ++++++++++++++++++++++++++++++--------------------------
 1 files changed, 447 insertions(+), 381 deletions(-)

-- 
1.7.8
