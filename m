From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/18] sha1_name.c: get rid of ugly
 get_sha1_with_mode_1()
Date: Tue, 03 Jul 2012 10:19:14 -0700
Message-ID: <7vk3ykwynh.fsf@alter.siamese.dyndns.org>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <1341268449-27801-4-git-send-email-gitster@pobox.com>
 <vpqsjd9nuid.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 03 19:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm6l1-0000bd-Rs
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 19:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933303Ab2GCRTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 13:19:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756840Ab2GCRTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 13:19:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BB8C8856;
	Tue,  3 Jul 2012 13:19:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=74JflLm+jAbE85L5LP4I8hd/IQM=; b=ldRRp+
	0B5bCTEBUrQrNceVRmoqsG8Xt5MC5/AxPV6XxXhkUxi6ZLLHnRc8B3YrZkmwDu42
	4SynuVSiFYyfqSlijG8mrz6X8Wor9aW708xGXrYOuK1wG3reMf8WUYjIhVOxK7r2
	OJlg89BwKDyKKnXPrO2YK6dNbVoxeO6zMssAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GfWaqAyutTe92HVbZN5Apj8ILps95a4y
	/Om8WGTptsJHQ522xHLOdNMCOm3qPL3jNu3kYUiW4qDKOUvPUPjv2BtrDvpSY4jW
	34CXfM+lyubcBJ36/iQhu65TMJuhqeo+hl4e+XiC6eHvdPd4OY75jsd3m3ptbAT9
	JNFAMmGw79U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 924878854;
	Tue,  3 Jul 2012 13:19:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F84D8849; Tue,  3 Jul 2012
 13:19:16 -0400 (EDT)
In-Reply-To: <vpqsjd9nuid.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 03 Jul 2012 10:01:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37680B56-C533-11E1-B2FF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200920>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +/*
>> + * Call this function when you know "name" given by the end user must
>> + * name an object but it doesn't; the function _may_ die with a better
>> + * diagnostic message than "no such object 'name'", e.g. "Path 'doc' does not
>> + * exist in 'HEAD'" when given "HEAD:doc", or it may return in which case
>> + * you have a chance to diagnose the error further.
>> + */
>> +void die_on_misspelt_object_name(const char *name, const char *prefix)
>
> It seems unusual to have a function named die_* that is not a noreturn
> function. I'd call it die_*_maybe, or diagnose_* instead.
>
> (but as the comment above documents the behavior, it's not terribly
> important, you may ignore my comment if you whish)

I was hoping "on" may imply "if not misspelled, ignore and keep
going", but apparently that failed.  I am not good at names.

die_if_misspelt?  maybe_die_on_misspelt?

I am fairly negative on "diagnose" as it does not say much about
what would happen after diagnosis (namely, we _die_).
