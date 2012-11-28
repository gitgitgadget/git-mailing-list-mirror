From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 18:01:20 -0800
Message-ID: <7vk3t6jxjj.fsf@alter.siamese.dyndns.org>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Nov 28 03:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWy2-00056x-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab2K1CBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:01:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab2K1CBX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:01:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F5BA693;
	Tue, 27 Nov 2012 21:01:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1fqJDUBr94YjHgJA2GBqbGA0Ulo=; b=jkIN1j
	YPkZsXd3AAm7iFgfUZbaDZvXSrP/hWKJe86VbbWxBj7LS9gh7Vr+a1T5w/oeUqzL
	pLAmHS+gk2lmbvswurWAlLg7X4+WW+d5aaFFgIYIQHfeOPjU8L1E6OTZntNNG5bn
	ljFvzhW6OnbeNfuLq4utsxJFDSq7KuWbN0/EM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TPSZ8SPxMx2ax7KVwy2dQCZZBScTZtzj
	cbBB1ryQkytdyBJvx13dtOVMCWmdVb3yHDWvE7Sz1/1eJRY8naAAND0bdQMj/hTy
	3RU2ZmH8YY7lX1zA9vzp2wmqbUTk/LaBSvfH75gPJoLia2ZDmI9Sqed25C/8lmcQ
	EgQ5kStNMS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3E65A692;
	Tue, 27 Nov 2012 21:01:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 528BEA691; Tue, 27 Nov 2012
 21:01:22 -0500 (EST)
In-Reply-To: <20121127230419.GA26080@thyrsus.com> (Eric S. Raymond's message
 of "Tue, 27 Nov 2012 18:04:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 820111E0-38FF-11E2-B4D3-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210666>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Junio C Hamano <gitster@pobox.com>:
>> fsck_ident() in fsck.c rejects anything but " [1-9][0-9]* " after
>> the author and committer ident (i.e. the timestamp has to be
>> integral number of seconds since the epoch, not before it, nor
>> with fractional seconds).
>
> Is this architecturally significant?  It sounds like another
> implementation detail.

No.

If you create a commit object that violatse it and have 47 million
existing users pull such a history, they not be able to use such a
history with the version of Git they have.  Don't go there.

As somebody else mentioned, in distributed environment millisecond
timestamps won't have much meaning, so it looks like a very low
priority to me from Git's perspective.
