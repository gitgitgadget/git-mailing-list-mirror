From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/5] modernize test style
Date: Sat, 03 Mar 2012 00:04:54 -0800
Message-ID: <7vpqcu6rfd.fsf@alter.siamese.dyndns.org>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 09:05:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3jxf-0007Ou-Nv
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 09:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab2CCIE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 03:04:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab2CCIE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 03:04:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A114D3769;
	Sat,  3 Mar 2012 03:04:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ZCLYh4F16CriLHJfBYeqwD6vzvw=; b=xBBkb3ubtGC/tVyHqGji
	tbgdIJxAEhIxnhQ8Y8+alSlQ7jUYubd95Sxu5LyTNtyTT1STQQbLE/iz6MEgNUmb
	oCX2TxCfZbBFCogiTQrQl/SsBScNzjdgSMkZbC7iGebLk1bHsi+wS3PuqFex1p42
	SygYz025EwY3djRE6nNJ+8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HlXoygCgw5mwkXI7pYgLL4X9dFZhW4vN5TvWqustLrcmhr
	9c8Dsxqr1SlpU+/zZdRgTRUohd1Ew9S3fMbhfjLhwxkkDtidIrMAGyhzb7hGv0O7
	SuIv8UCiTZKzld1nH8dbdc/EPcKEXJvG7RPgm9JS8xg0sRzeTtQGZW/BuFrOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9891D375E;
	Sat,  3 Mar 2012 03:04:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21F45375D; Sat,  3 Mar 2012
 03:04:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90870200-6507-11E1-86DC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192099>

Tom Grennan <tmgrennan@gmail.com> writes:

>   t7004 (tag): modernize style
>   t5512 (ls-remote): modernize style
>   t3200 (branch): modernize style
>   t0040 (parse-options): modernize style
>   t6300 (for-each-ref): modernize style

Hmph.

We would want to keep/make the codebase uniformly conform to our style
guide for longer term maintainability (this is not limited to the test
scripts) but at the same time we would strongly want to avoid churning
patches from interfering other patches that are still in flight that do
"real work".

There are only two appropriate occasions for file-wide clean-up patches
like these:

 (1) The file has not been touched for quite some time, and it is not
     expected to be touched for some time to come; or

 (2) You are going to do extensive work on the file for reasons other than
     clean-up, and nobody else is working or expected to work in the same
     area for some time to come (in other words, you _own_ the file), and
     your real work will be easier to review if it is done _after_ such a
     clean-up patch.

Let's see how active these five files are:

$ git diff --stat v1.7.9..pu --  t/t{7004,5512,3200,0040,6300}-*.sh
 t/t0040-parse-options.sh |   60 ++++++++++++++++++++++-
 t/t3200-branch.sh        |  122 ++++++++++++++++++++++++++++++++++++++++++++--
 t/t7004-tag.sh           |   96 ++++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+), 6 deletions(-)

Given this, I do not want to take three of your 5 patches that touch these
files at this point.  Please hold onto them and wait until topics that
touch these test scripts graduate to 'master', and then wait a bit more
until some time passes without anybody touching them, before redoing the
clean-up patches.

On the other hand, we can see that 5512 has been dormant for quite a
while.  Note that the latter diff is against 3 cycles ago:

$ git diff --stat v1.7.6..pu --  t/t{7004,5512,3200,0040,6300}-*.sh
 t/t0040-parse-options.sh |   79 +++++++++++++++-
 t/t3200-branch.sh        |  236 +++++++++++++++++++++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh  |  101 +++++++++++++++++++-
 t/t7004-tag.sh           |  128 +++++++++++++++++++------
 4 files changed, 490 insertions(+), 54 deletions(-)

so 5512 and possibly 6300 may be worth reviewing.

Thanks.
