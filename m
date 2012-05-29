From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Tue, 29 May 2012 11:49:00 -0700
Message-ID: <7vmx4q4ycj.fsf@alter.siamese.dyndns.org>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <20120528224729.GK14606@burratino>
 <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
 <20120529121428.GD14697@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 20:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZRTi-0007EW-8v
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab2E2StF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 14:49:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420Ab2E2StD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 14:49:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 997EF82D0;
	Tue, 29 May 2012 14:49:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xIeZa32wZT7haiWr+NHexFqKfm0=; b=dKVVMI
	EFDN3R28jVaJPP6O98TWkQyE55wwM4vmtK/YI2u5t41PuxVfTSuJZdzksleshitd
	GEByyNMtrSNz437gi4h1BSXJKKc/oUdS/OGkHWzMsY8kMz14tQQa8dajPo1eosRl
	vPnz5CtALtJncj6vKVwdHfa1LZoWbNQm2/smM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EtxOd/GQiql/9wetPZzL6Mv5Nfli+R/J
	qWaq0S3caj6j7KMeBTteYLeWHPjJc4/p/2sC5SckZftjrcWP4acNNKc+0yb3jvSo
	wPVfchTHFAnhfkd5lQLc8J9X7yNKLDRKfqiQCcxK6zqUVB39jn0fUQ7Xvk0fW4xo
	yh24G9RYS0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 832FD82CF;
	Tue, 29 May 2012 14:49:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E5F582CA; Tue, 29 May 2012
 14:49:01 -0400 (EDT)
In-Reply-To: <20120529121428.GD14697@burratino> (Jonathan Nieder's message of
 "Tue, 29 May 2012 07:14:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4E40CD8-A9BE-11E1-BDB9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198750>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguyen Thai Ngoc Duy wrote:
>
>>                         The test suite is currently more focused on
>> features than human readable output.
>
> Thanks for clarifying this.  Yes, that's the point of the
> GETTEXT_POISON check.  It is supposed to make sure that running git in
> another locale does not break features by modifying text that
> (internal and external) scripts parse.

Correct.  The most important thing to review in test scripts is that
tests that verify output from the plumbing commands are *not* marked
with GETTEXT_POISON (hence test_i18ncmp).  IOW, storing "ls-files"
output and then checking it with expected result using test_i18ncmp
is *wrong*, as it won't catch mistakenly marking plumbing messages
with _() and N_().

> For a sanity check on the messages marked for translation from a
> translator's perspective, it is generally better to just look at the
> pot file.  And from the end user's perspective, I don't know a better
> way to test than to just use git a little.
>
> As a side effect, GETTEXT_POISON keeps the test suite usable for
> exercising a copy of git configured for an actual other locale, which
> means that in the future the test suite could be used to check for
> problems due to differences between locales other than the translated
> messages (think: charset, collation order, etc).
>
> Ciao,
> Jonathan
