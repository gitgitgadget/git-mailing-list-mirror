From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 08 Feb 2010 14:59:01 -0800
Message-ID: <7vmxzj8hca.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:59:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NecZZ-0004dg-Cn
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab0BHW7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:59:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab0BHW7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:59:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE7A79812E;
	Mon,  8 Feb 2010 17:59:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QRUl1KUSK0s831td2LMgRp+BGqI=; b=Haa0wG
	CjqD1+Z8kPQEvcaP/uCr6cJ08DHkaI1Jjwyg0eX2CMUFnKCk+3tsupV9GybWGNEl
	mAuo+QYUNy0MxSXeuDuSL+1Z8rEojLQbBgLi9MMJMQMYGGr3e7IDbD6CjUqmlsV/
	nXDMnVQE5B6k+CC0K/9EyXdWfRjUUIIoT5l+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bWwLsMUaKJjaXtCTAnCwpCt4sTmysfOA
	jmeTplP3umMYC3RByHgLcD4Oi4BDvbUGXmAAqVHqkzzCKfisBQhjIwGL2W8kmfDM
	0R1yhe9dtiNMY74cAgvG6WJi7nIp4KlGgnJTRr95De8bsVNZ7Zg2UUCMclMJeTPj
	SV/4yDaTyQ8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD4B99812B;
	Mon,  8 Feb 2010 17:59:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 044AE98123; Mon,  8 Feb
 2010 17:59:02 -0500 (EST)
In-Reply-To: <20100208213256.GA470@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 8 Feb 2010 16\:32\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F4AB62E-1505-11DF-A466-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139332>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 08, 2010 at 01:13:36PM -0800, Junio C Hamano wrote:
>
>> diff --git a/builtin-push.c b/builtin-push.c
>> index 5633f0a..f5082d8 100644
>> --- a/builtin-push.c
>> +++ b/builtin-push.c
>> @@ -226,6 +226,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>  	git_config(git_default_config, NULL);
>>  	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
>>  
>> +	if (flags & TRANSPORT_PUSH_PORCELAIN) {
>> +		/* Do not give advice messages to Porcelain scripts */
>> +		advice_push_nonfastforward = 0;
>> +	}
>
> I think this is sane.

I am tempted to suggest adding "clear_advice(void)" in advice.[ch], so
that people adding new advices do not have to hunt for even the above
hunk.  It would be a good direction to go in general _if_ we will have
more like this --porcelain thing in other parts of the system.

I didn't do so because that "_if_" is still iffy.
