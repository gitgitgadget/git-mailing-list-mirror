From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t7700: do not use "touch -r"
Date: Thu, 23 Jan 2014 13:24:44 -0800
Message-ID: <xmqq1tzytmqr.fsf@gitster.dls.corp.google.com>
References: <20140123195404.GA31314@sigill.intra.peff.net>
	<20140123195518.GB31871@sigill.intra.peff.net>
	<xmqq61patnag.fsf@gitster.dls.corp.google.com>
	<20140123211425.GA21377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:24:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Rle-0002vI-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbaAWVYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:24:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbaAWVYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:24:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03C1964DD9;
	Thu, 23 Jan 2014 16:24:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x8Fc++AdL0PffIX4F9j3IfnwkAM=; b=eeFIQN
	5TtFEo8BDaB8hmq+MmnMHaSXBTu/paqKvq3MjfxVrDmjXs5rIiWZK3OLHvwynT2g
	XMsKZo6pEM4fiPHRkoA3uiYjL5dtL5/Sdp7uZEYAR3WMVClR3O/+YSIqizLfzQJ3
	IaoT57ABLpIx9b1kNBHXmPm43HJR/x2aOpXQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IrzOjNvWolhawQxcu8j2r298Fq/su70+
	rRcUcTmwA9JnEly6NLzHfj/21pAj0vXWAQKmyF2hCEsHlL42K2IuKCVMwgs0rv9X
	knQl3dG/JOezsj7+30D2OYuzOncEA6Qi0WKgPgY19RlvTgCTiNjfyuQCvgp0uOhj
	8CPY0rxkQiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C773C64DD8;
	Thu, 23 Jan 2014 16:24:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C45AE64DD2;
	Thu, 23 Jan 2014 16:24:47 -0500 (EST)
In-Reply-To: <20140123211425.GA21377@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jan 2014 16:14:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C936C516-8474-11E3-867F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240958>

Jeff King <peff@peff.net> writes:

> Agreed. I was making the minimal change, but I think there is no reason
> not to fix both while we are there. Do you want to just mark up the
> patch in transit?

Let's just queue this instead.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Thu, 23 Jan 2014 14:55:18 -0500
Subject: [PATCH] t7700: do not use "touch" unnecessarily

Some versions of touch (such as /usr/ucb/touch on Solaris)
do not know about the "-r" option. This would make sense as
a feature of test-chmtime, but fortunately this fix is even
easier.

The test does not care about the timestamp of the .keep file it
creates at all, only that it exists. For such a use case, with or
without portability issues around "-r", "touch" should not be used
in the first place.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7700-repack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d954b84..b45bd1e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -17,7 +17,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	# The second pack will contain the excluded object
 	packsha1=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
-	touch -r pack-$packsha1.pack pack-$packsha1.keep &&
+	>pack-$packsha1.keep &&
 	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
 		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
-- 
1.9-rc0-234-g8e6341d
