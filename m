From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] run_hook: use argv_array API
Date: Wed, 14 Sep 2011 13:01:25 -0700
Message-ID: <7vd3f2uc4q.fsf@alter.siamese.dyndns.org>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215824.GG24490@sigill.intra.peff.net>
 <7vty8ft0oc.fsf@alter.siamese.dyndns.org>
 <20110914185658.GA21352@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 22:01:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3veJ-0006VH-6C
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 22:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992Ab1INUBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 16:01:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932611Ab1INUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 16:01:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B82B740B8;
	Wed, 14 Sep 2011 16:01:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2eRAYXIcGSSCs9Ockz8it64sSN0=; b=Inu1ys
	Hw1Sb717gZg7u8/+q4UGohEmv5/XHTEXUQ5mNra+wtKfU2JtnvR9iHBr6sCqPWL9
	1pmhSBhEvC8Jij3XSfOJHxIfrKb6kdGCo9G3DAE8PA6Z+YpWFTSxeuIL9TItDsOs
	mmdLgYsmwnixYUZbsXRKRyxgyvdFkxjbvcHlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p1qOID79ZyNLl5W2T0qZ05GDozO87T2O
	czG2QznqvPN8QFSSeewDna1ALGsm1W9F8n1G7O6x5U2yn787zRaUtOK0R2jODu3l
	elussWXQiE/YX2m99mKX6Ju4IvwAEMV3dpbP7E+je4kQrIwfeMwjP/wVWbKCbFvW
	Sinu7qGoQ4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967E840B6;
	Wed, 14 Sep 2011 16:01:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E45440B5; Wed, 14 Sep 2011
 16:01:27 -0400 (EDT)
In-Reply-To: <20110914185658.GA21352@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Sep 2011 14:56:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 547F8B5A-DF0C-11E0-B97E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181395>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 14, 2011 at 11:54:11AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > @@ -609,26 +610,23 @@ int finish_async(struct async *async)
>> >  int run_hook(const char *index_file, const char *name, ...)
>> >  {
>> >  	struct child_process hook;
>> > -	const char **argv = NULL, *env[2];
>> > +	struct argv_array argv = ARGV_ARRAY_INIT;
>> > +	const char *p, *env[2];
>> 
>> Given that in argv-array.h you define it as
>> 
>>     #define ARGV_ARRAY_INIT { empty_argv, 0, 0 };
>> 
>> the above will introduce decl-after-stmt.
>
> Oops. Can you squash in removing the semicolon from the macro
> definition?

Yes, I did. Thanks.
