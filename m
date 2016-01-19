From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t5304: Ensure wanted files are not deleted
Date: Tue, 19 Jan 2016 10:36:03 -0800
Message-ID: <xmqq60ypbeng.fsf@gitster.mtv.corp.google.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
	<cover.1452704305.git.dougk.ff7@gmail.com>
	<670a9d9268beb0d70fb877a7c62d769062babba9.1452704305.git.dougk.ff7@gmail.com>
	<xmqqmvs9mc6h.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TfcJBbO_QJGH-Z9a3AHLdsO+H+k_fAS2EtJOH8bVwFEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:36:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLb8W-0005nb-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbcASSgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 13:36:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932721AbcASSgG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 13:36:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 763153C416;
	Tue, 19 Jan 2016 13:36:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ffIjEY209w2NOvNrZfXAxyVUCFc=; b=aQhcA5
	pysFbBPh4K+RdRNruIAZ3FktDnCQKjg1U7o+sJyGxL6nbs9Xv5DMtT6LqZcM1jwE
	8/mX01EpuOgytTZLIdUDx+n16ZF4ePI4NqZL+UTi5gHUY/KH8vPjUrr19hitx3Bq
	VhmDEnCV/DW3SBSweKxdnV2xDAAgqrGo2jASQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GXPziTQbHdbJEax+xhVLk7AJ83mUZU9v
	t3fzz2ABy1vn9HDxMAs96ytU/ClWNtrfLjmCSRNcSXD4r3qcW+mVBYWEFuPHr9iR
	jOPAAO3402ZKZgFOACvfpaTW7Clq0g8szgbynB4QDqVNK/JFBrRbN1sF+wMGFywD
	XbEAUGTWzYE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CC513C415;
	Tue, 19 Jan 2016 13:36:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D59B43C414;
	Tue, 19 Jan 2016 13:36:04 -0500 (EST)
In-Reply-To: <CAEtYS8TfcJBbO_QJGH-Z9a3AHLdsO+H+k_fAS2EtJOH8bVwFEg@mail.gmail.com>
	(Doug Kelly's message of "Mon, 18 Jan 2016 10:54:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F6C1D20-BEDB-11E5-8524-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284368>

Doug Kelly <dougk.ff7@gmail.com> writes:

> On Wed, Jan 13, 2016 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Doug Kelly <dougk.ff7@gmail.com> writes:
>>
>>> Subject: Re: [PATCH 3/4] t5304: Ensure wanted files are not deleted
>>
>> I'd suggest s/wanted/non-garbage/.
>>
>
> I'm okay with this.
>
>>> Explicitly test for and ensure files that may be wanted are not
>>> deleted during a gc operation.  These include .pack without .idx
>>> (which may be in-flight), garbage in the directory, and .keep files
>>> the user created.
>>
>> "garbage in the directory" is not well defined.  "files in the
>> directory that clearly are not related to packing" is probably what
>> you meant, but the definition of "related to packing" is still
>> fuzzy.  Please clarify.
>
> This is probably a good point.  Perhaps a better way to think about it
> would be by rewording the paragraph to something like this:
>
> Explicitly test for and ensure files that may either be desired by the user
> or are possibly not garbage are not deleted during a gc operation.
> These include .pack files missing a corresponding .idx file (possibly due
> to it being in-flight), .keep files created by the user, and other
> unknown garbage in the pack directory.  These files will still be identified
> by "git count-objects -v", but should not be removed automatically by
> gc.  Only files we are absolutely sure are unnecessary will be removed
> as a part of the gc process.

That, especially "other _unknown_ garbage", looks much better than
the original.

> I'm not saying there's nothing to be said for the difference in the base
> filename without extension.  Currently, the logic to remove pack garbage
> doesn't look at that, though: it only considers the extension, and what
> related files are found in the directory.  Whether this is good or bad, I'm
> not sure.  It certainly does what I need at fairly low risk, though.
>
> Does this help clarify the situation more?

I was shooting for making you _think_ exactly about what you wrote
in the above paragraph, i.e. what the current logic does and if it
is sensible, is overly pessimistic for some files, and/or is risky
for some other files and if so in what way, as that would help you
record the thinking behind the different treatment for files based
on various file extentions clearly in the log message.

Thanks.
