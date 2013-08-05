From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: reject non-characters
Date: Mon, 05 Aug 2013 09:54:54 -0700
Message-ID: <7vpptskrhd.fsf@alter.siamese.dyndns.org>
References: <cover.1372957719.git.sandals@crustytoothpaste.net>
	<20130704171943.GA267700@vauxhall.crustytoothpaste.net>
	<alpine.DEB.2.00.1307051345260.11814@ds9.cixit.se>
	<7vfvvozvx4.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.1307091213090.2313@ds9.cixit.se>
	<alpine.DEB.2.00.1308051346530.3657@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:55:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6O3n-00040P-Ry
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab3HEQzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:55:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab3HEQzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:55:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AD7B3663A;
	Mon,  5 Aug 2013 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J6y8nMV1mCp1N+ZAI7UrxwdGgSs=; b=RMylme
	RGsZE3OHg2avskiNcPSjuRZ1c4NPGKO9ehzQrdg3VyUYBP7UwYLZKY5sX1XLwXAt
	LLmMc/+81gYF76XWGsvVNixLlhfU4h5FHK3O27aU78flJu4rj/Swdk/X4/Isxbmu
	jbCeqy4HJD6e4NsR0N6SFouGFIoMlfVi1OEdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JQwyasbOp4FmvLDUzKn3jVEiDPNdQRhh
	rMRIyWx6VLLjPxX7I+KYmqdjs98GPqwRVFyrM/GhwYrWYxhJpnUrvWg869hHoGuP
	2ghe7LkJOO53uG5xdADD448s5aYYQPZYa5xRCfW6TymArUHm5chIRJpFyBgQdAk+
	hhXynEZSnqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9EFB36639;
	Mon,  5 Aug 2013 16:54:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8036336638;
	Mon,  5 Aug 2013 16:54:57 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1308051346530.3657@ds9.cixit.se> (Peter
	Krefting's message of "Mon, 5 Aug 2013 13:48:28 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C292E9B2-FDEF-11E2-9975-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231678>

Peter Krefting <peter@softwolves.pp.se> writes:

> Peter Krefting:
>
>> -		/* U+FFFE and U+FFFF are guaranteed non-characters. */
>> -		if ((codepoint & 0x1ffffe) == 0xfffe)
>> +		/* U+xxFFFE and U+xxFFFF are guaranteed non-characters. */
>> +		if ((codepoint & 0xffffe) == 0xfffe)
>> +			return bad_offset;
>
> Drats, there is an F too many in the bitmask, it should be:
>
>  +		if ((codepoint & 0xfffe) == 0xfffe)

Indeed.

-- >8 --
Subject: [PATCH] commit: typofix for xxFFF[EF] check

We wanted to catch all codepoints that ends with FFFE and FFFF,
not with 0FFFE and 0FFFF.

Noticed and corrected by Peter Krefting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 7dcfeea..38d8979 100644
--- a/commit.c
+++ b/commit.c
@@ -1306,7 +1306,7 @@ static int find_invalid_utf8(const char *buf, int len)
 		if ((codepoint & 0x1ff800) == 0xd800)
 			return bad_offset;
 		/* U+xxFFFE and U+xxFFFF are guaranteed non-characters. */
-		if ((codepoint & 0xffffe) == 0xfffe)
+		if ((codepoint & 0xfffe) == 0xfffe)
 			return bad_offset;
 		/* So are anything in the range U+FDD0..U+FDEF. */
 		if (codepoint >= 0xfdd0 && codepoint <= 0xfdef)
-- 
1.8.4-rc1-129-g1f3472b
