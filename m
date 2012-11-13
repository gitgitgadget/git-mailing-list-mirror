From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff: introduce diff.submodule configuration
 variable
Date: Tue, 13 Nov 2012 08:27:08 -0800
Message-ID: <7vlie5foyr.fsf@alter.siamese.dyndns.org>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352653146-3932-3-git-send-email-artagnon@gmail.com>
 <20121113053336.GA10995@sigill.intra.peff.net>
 <CALkWK0nJwznx36yoAUKXRnyA+32143tBVJHnnrosz-Ht7VhwHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:27:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJKh-0001Ns-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab2KMQ1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:27:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361Ab2KMQ1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:27:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33A11A563;
	Tue, 13 Nov 2012 11:27:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bpxO+dmDxrUcbRDMVtVumdhKe+k=; b=Swszq4
	3nXHOfe2gwjC2GfyvJhztCvRt+0AJOryTdIGlr3QgQiTaxRaKwAsxri29NA2lzFt
	K0QREbqACKs4KvIfdlvtjZUIlcOPvTdh8GIRvrVixds2QZz/5VfZo+DgPbFx/U9v
	2v7oHPPY22PXJBmEMWMk+AotfnYJwJE/BavzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=noQjTmQ0jTbGgb5rgIewoiehC1cNte23
	hLYsUqy5URRhr1y8NGC8px9M8MwTvjLbEOaSOE2WYAzS5brJO4x9qP9o+yWjPquV
	Tlvv2kP3wvreU1uHQTnO+eRlRhgmgMEgkKJH8zg9lB9DVTojiSlPSbjiu5DnSrjG
	sHjbECDC5AA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 175D5A562;
	Tue, 13 Nov 2012 11:27:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6290AA560; Tue, 13 Nov 2012
 11:27:10 -0500 (EST)
In-Reply-To: <CALkWK0nJwznx36yoAUKXRnyA+32143tBVJHnnrosz-Ht7VhwHw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 13 Nov 2012 21:15:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F944AA84-2DAE-11E2-A42C-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209628>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jeff King wrote:
>> On Sun, Nov 11, 2012 at 10:29:05PM +0530, Ramkumar Ramachandra wrote:
>>> @@ -223,6 +238,15 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>>>               return 0;
>>>       }
>>>
>>> +     if (!strcmp(var, "diff.submodule")) {
>>
>> Shouldn't this be in git_diff_ui_config so it does not affect scripts
>> calling plumbing?
>
> I honestly didn't understand the difference between
> git_diff_basic_config and git_diff_ui_config.  The latter function
> calls the former function at the end of its body.  Why are they two
> separate functions in the first place?

In case you meant s/didn't/don't/, git_diff_ui_config() should be
called only by human-facing Porcelain commands where their
behaviours can and should be affected by end user configuration
variables.

When a configuration variable should not affect output from plumbing
commands like diff-files, diff-index, and diff-tree, it must not be
read in git_diff_basic_config(), but in git_diff_ui_config().

The output from "git format-patch" is consumed by "git apply" that
expects "Subproject commit %s\n" with fully spelled object name, so
your configuration must not affect the output of format-patch,
either.
