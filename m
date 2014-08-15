From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 11:04:31 -0700
Message-ID: <xmqqy4upzl1s.fsf@gitster.dls.corp.google.com>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de>
	<53ED0257.3070505@jump-ing.de>
	<xmqqppg21wyk.fsf@gitster.dls.corp.google.com>
	<273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqbnrl1ya1.fsf@gitster.dls.corp.google.com>
	<FF233C51-7AEA-4A10-8446-D8233F55E89B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:04:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XILrw-0002SS-Qh
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 20:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbaHOSEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 14:04:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51568 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbaHOSEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 14:04:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC83D31067;
	Fri, 15 Aug 2014 14:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MWCMU3nHhbpbqZXNguqSX2VxBCU=; b=Tomrej
	f0c4TAAyAqPTXq2AfnYV6sVy1/NYSM8jS5Nzr1zhphaNFZz+3of5wi5OeFniA1uE
	1yNqRl467ygaAaGJYBoBAqyvbd1la/6duBdZMtJefbX644M1luiwe8ReBGjWN5LE
	+ZRzGSymwgVZ4juaKU+ko3QVxjDumHdfrHRqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W3Qd/vu74rZNdporKiCr40Dkv/8T/SSP
	X+ieaQn60vvuHiaHu1jRytrF94Y+VHYFastDrHpJjgFAJuE7T+1B/yKsqUrD8mt/
	7ONAaBHCPtgIRhjqCSnPGKQHNP2vhYNVKhOBF/DqMuXdm2TqLEIPXL/Pe/dWuroQ
	2d2/A8HQ0yc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1DC131066;
	Fri, 15 Aug 2014 14:04:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 31F7C31054;
	Fri, 15 Aug 2014 14:04:33 -0400 (EDT)
In-Reply-To: <FF233C51-7AEA-4A10-8446-D8233F55E89B@gmail.com> (Kyle J. McKay's
	message of "Fri, 15 Aug 2014 10:56:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C39A5E2-24A6-11E4-B6ED-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255299>

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> +	# i.e. "begins with [15678] and the a dot" means "10.4.* or older".
>
> s/the a dot/a dot/
>
>> 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
>> 		OLD_ICONV = UnfortunatelyYes
>> 		NO_APPLE_COMMON_CRYPTO = YesPlease
>
> Otherwise looks good.  Mac OS X 10.1.0 doesn't actually fit the
> pattern (it's still Darwin 1.*), but it's so old and it doesn't affect
> the 10.4.* or older test (or the later 10.1.* or older test), so let's
> just ignore that anomaly.  :)

Thanks.  The 10.1.0 anomaly actually was bothering me, too.  How
about doing it this way?

-- >8 --
Subject: [PATCH v2] config.mak.uname: add hint on uname_R for MacOS X

I always have to scratch my head every time I see this cryptic
pattern "[15678]\."; leave a short note to remind the maintainer
and the reviewers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index f8e12c9..414760f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -86,6 +86,10 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	# Note: $(uname_R) gives us the underlying Darwin version.
+	# - MacOS 10.0.* and MacOS 10.1.0 = Darwin 1.*
+	# - MacOS 10.x.* = Darwin (x+4).* for (1 <= x)
+	# i.e. "begins with [15678] and a dot" means "10.4.* or older".
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV = UnfortunatelyYes
 		NO_APPLE_COMMON_CRYPTO = YesPlease
-- 
2.1.0-rc2-283-g1433d67
