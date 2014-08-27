From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/20] rs/ref-transaction-1 (Re: Transaction patch series overview)
Date: Wed, 27 Aug 2014 14:29:38 -0700
Message-ID: <xmqq1ts1d3jx.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140826000354.GW20185@google.com>
	<xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
	<20140826221448.GY20185@google.com>
	<20140827002804.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:30:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMkn5-0004dB-7h
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 23:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935897AbaH0V3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 17:29:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63049 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbaH0V3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 17:29:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51B3E3560E;
	Wed, 27 Aug 2014 17:29:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9dN9996kMJn2EmU1zVXRCOqkHbg=; b=b4Baaf
	oOJnlFYOX7ZUs6pKnE2KG7fWKMVVduXSXfUE6J5w9S7Lzv62wy2nCM8/tSYudsna
	SLfFg5RjSjyal1rsMWcW0tp0+rhsk4P973vd18iuTrvqlrMA2BYE3pOnDlGiU6nW
	GW0EtIKvKxYlr05YUqGFnAxR1WcTJc7rBK5RA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mCqvLGCFVfrUneHd5Imtl90pccSaRAj8
	7RxhSZHaeazWo6oayrkDGCDjOw9D95ko0LbNzWblG6LwwUPfo4/bNBWZVFEOqEoK
	tdq9yZftsb2ZAk0f9VrVTtiaVO+9z59AgL+wzHwuGYCP1UGD2IiJGXe/y0M3ngA1
	I/sKPmqbisE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 474DD3560D;
	Wed, 27 Aug 2014 17:29:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50D5635606;
	Wed, 27 Aug 2014 17:29:40 -0400 (EDT)
In-Reply-To: <20140827002804.GA20185@google.com> (Jonathan Nieder's message of
	"Tue, 26 Aug 2014 17:28:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40CD56D8-2E31-11E4-978C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256048>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> This series teaches the tag, replace, commit, cherry-pick,
>> fast-import, checkout -b, branch, receive-pack, and http-fetch
>> commands and all update_ref and delete_ref callers to use the ref
>> transaction API instead of lock_ref_sha1.
>>
>> The main user-visible change should be some cosmetic changes to error
>> messages.  The series also combines multiple ref updates into a single
>> transaction in 'git http-fetch -w' and when writing tags in
>> fast-import but otherwise doesn't change the granularity of
>> transactions.
>>
>> Reviewed at https://code-review.googlesource.com/#/q/topic:ref-transaction-1

Thanks.

Will queue, but the some other topics may have to disappear from my
tree while I try to rebase them on top (or while I wait for you guys
to send a reroll, making it unnecesary to do the rebase myself).
