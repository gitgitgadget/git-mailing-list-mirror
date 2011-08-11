From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] Reduce parse-options.o dependencies
Date: Thu, 11 Aug 2011 16:35:02 -0700
Message-ID: <7vr54ro72x.fsf@alter.siamese.dyndns.org>
References: <1313054138-30885-1-git-send-email-divanorama@gmail.com>
 <1313054138-30885-3-git-send-email-divanorama@gmail.com>
 <20110811110441.GD5012@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 01:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QremR-0002hT-Dj
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 01:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab1HKXfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 19:35:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab1HKXfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 19:35:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3E0D47AD;
	Thu, 11 Aug 2011 19:35:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/Fmc2RfW/KSehyf/DsXtHORG7pk=; b=Zeu1s5gfq+saa4hHS/1u
	WAxGglSI7QeN7txG3wQrdbLwOoIuk1DSqm0VW90Ee1Jvhs0i1PoIgcXCfSg0coPb
	X/oE+RbdDw6SMzoJiEwxhzBvurpWc0Ot64krN5eyTrIwyzeuNFLZmr6s/J6sxeMN
	5dN/vZx7H3Mcav0LUpU9aSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=iaQSQyB2rz05sMiasBsYei6+1TD5VqNJGeD7vYNL0sFSAH
	kj50eDvg6LSUW4dnEcwJNI12A9H/uCS2i56Is4CAzzT8uCtGf1s4R7dqtQMNBiJi
	lLmqI4A+y+0AiXK2LCiSudRVNCkxNnrBEcykA7GLFCrWaluLtOdqUv8QBEgkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBDB947AB;
	Thu, 11 Aug 2011 19:35:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10D8D47A9; Thu, 11 Aug 2011
 19:35:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89F26708-C472-11E0-9057-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179155>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> diff --git a/parse-options-cb.c b/parse-options-cb.c
>> new file mode 100644
>> index 0000000..c248f66
>> --- /dev/null
>> +++ b/parse-options-cb.c
>> @@ -0,0 +1,125 @@
>> +#include "git-compat-util.h"
>> +#include "parse-options.h"
>> +#include "cache.h"
>
> Style: Files in git tend to use only one of "git-compat-util.h",
> "cache.h", or "builtin.h" and put it at the top.  So in this case, it
> should probably use just "cache.h".

This needs a bit of clarification.

The compatibility rule actually is to have git-compat-util.h at the very
beginning. As cache.h is a very widely used header almost everybody that
needs to access the internals include, it includes git-compat-util.h as
its first thing to include.

So if this is an old file that existed before git-compat-util.h, then it
is perfectly fine to start it with

	#include "cache.h"
        #include "parse-options.h"

Otherwise the three-line include above is also just fine.
