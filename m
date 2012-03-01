From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH 0/5] modernize test style
Date: Wed, 29 Feb 2012 17:45:16 -0800
Message-ID: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <20120223002215.GE2410@tgrennan-laptop>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2v5k-0003zH-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab2CABpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 20:45:46 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52025 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab2CABpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 20:45:45 -0500
Received: by vbbff1 with SMTP id ff1so74765vbb.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:45:44 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.178.40 as permitted sender) client-ip=10.52.178.40;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.178.40 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.178.40])
        by 10.52.178.40 with SMTP id cv8mr4194307vdc.82.1330566344677 (num_hops = 1);
        Wed, 29 Feb 2012 17:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5SJ3V2v/NjAplKV5E6SahkmuMHjs/7FxPTNR3krdkWM=;
        b=aheeap0q9/jc3mmIEWmnlJU1lW3uc1zeZ+wsHSpPtG/eJvcugRgX22VvRKRkBboNoJ
         pmq6sQnAIfdy3lkDWBIBGjMJJczcn/U/VCh2Urkv6h0VZOlyzkopxVqY+dp808gdJGsT
         LeYcLXBmDz8XvE6XXknsXFnYBt7hNFWm51578=
Received: by 10.52.178.40 with SMTP id cv8mr3591945vdc.82.1330566344630;
        Wed, 29 Feb 2012 17:45:44 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n14sm502335vdj.22.2012.02.29.17.45.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 17:45:43 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <20120223002215.GE2410@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191873>

Tom Grennan <tmgrennan@gmail.com> writes:
>On Tue, Feb 21, 2012 at 10:33:29PM -0800, Junio C Hamano wrote:
>>I know you are imitating the style of surrounding tests that is an older
>>parts of this script, but it is an eyesore.  More modern tests are written
>>like this:
>>
>>	test_expect_success 'label for the test' '
>>		cat >expect <<-EOF &&
>>                v0.2.1
>>		EOF
>>	        git tag -l ... >actual &&
>>		test_cmp expect actual
>>	'
>>
>>to avoid unnecessary backslash on the first line, and have the preparation
>>of test vectore _inside_ test_expect_success.  We would eventually want to
>>update the older part to the newer style for consistency.
>>
>>Two possible ways to go about this are (1) have a "pure style" patch at
>>the beginning to update older tests to a new style and then add new code
>>and new test as a follow-up patch written in modern, or (2) add new code
>>and new test in modern, and make a mental note to update the older ones
>>after the dust settles.  Adding new tests written in older style to a file
>>that already has mixed styles is the worst thing you can do.
>>
>>This comment applies to all the patches in this series with tests.
>
>I'd prefer, (1) precede each "--exclude" patch with a "pure style" patch
>to update the respective tests.  However, since this will result in a
>lot of conflict with concurrent development;  I'll separate the test
>patches from the code and documentation.  I'll then cycle on rebasing
>the style and new test patches until the development of each is
>quiescent.

Per request, the following series modernize the style of the respective
test scripts.  The common themes are:
	- Guard setup with test_expect_success
	- Single-quoted, tab prefaced test blocks of < 80 cols
	- Redirect unwanted output
	- Use a "here" filter for some expect generation

I also used pipelines to validate expected results rather than temporary
files, i.e.
	TEST | test_cmp expect -
vs.	TEST >actual && test_cmp expect actual

Since the later three patches have a lot of whitespace change, I've included an
alternate, PATCH-w series that filters these for more substantive review.
However, even the filtered series is very large causing me to second guess
whether such style modernization should be pursued; so, I look forward to your
input.

Thanks,
Tom Grennan (5):
  t6300 (for-each-ref): modernize style
  t5512 (ls-remote): modernize style
  t3200 (branch): modernize style
  t0040 (parse-options): modernize style
  t7004 (tag): modernize style

 t/t7004-tag.sh | 1680 ++++++++++++++++++++++++++------------------------------
 1 files changed, 783 insertions(+), 897 deletions(-)

-- 
1.7.8
