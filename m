From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git replace: should it check for object type, and can it replace merges?
Date: Mon, 05 Aug 2013 09:41:52 -0700
Message-ID: <7v1u68m6nj.fsf@alter.siamese.dyndns.org>
References: <24928554D0C34B4696DAD74F569E2E17@PhilipOakley>
	<CAP8UFD3yHMKfBdjHc6CxeAXSdQ=ua1MddAb5rRXV3TU0ZW7g6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Nr5-0005e1-B1
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab3HEQlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:41:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab3HEQlz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:41:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 720E236F16;
	Mon,  5 Aug 2013 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0CmQZPA2eD67nWDmAfKB3JtgsbQ=; b=HAlCX9
	XChhIQKU9jMjUN/+61kP9RlpDhFCnRXzHTqxWIP4F6dcaveHP5tkNFtgwMjwLZWj
	G0eni1f2HE3oN0HogQP6Zi4QlcTWKkodcyk50YxHkkmJOu4ji5p6kH/5mMybtotF
	n2+PQ5iZa5/k276KgEaDOuwmYPXilxLlsnji4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/rR0M2E9FkI29wkzwQJ2oHO1vEhodv/
	IZ2c5tncLR9RoIYR8jjjKLwciAyxFmFQpn9vCSJvQH1xJE6B7ft9ZA1sc6tmCWOh
	EDSDwwCl8MPL6BctNsGqZQIqB/ACtSfMWr8ehU6ht0a7sbgs42KFE3TO8lSP7iju
	nfomgV9MimE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6811136F15;
	Mon,  5 Aug 2013 16:41:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCA4136F13;
	Mon,  5 Aug 2013 16:41:53 +0000 (UTC)
In-Reply-To: <CAP8UFD3yHMKfBdjHc6CxeAXSdQ=ua1MddAb5rRXV3TU0ZW7g6w@mail.gmail.com>
	(Christian Couder's message of "Mon, 5 Aug 2013 12:57:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF4E00D8-FDED-11E2-B38F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231676>

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> On Sat, Aug 3, 2013 at 5:13 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> A recent comment http://stackoverflow.com/a/18027030/717355 on a question I
>> asked two years ago about 'grafts' and 'replace' indicates that users think
>> that 'git replace' can't replace a merge commit. The documentation doesn't
>> have any examples and gives the naive impression that one should only
>> replace a simple commit with another simple commit.
>
> I am sorry if the documentation gives this impression.
> I'd like to fix it, but I am not sure what should be changed.
> Should adding an example be enough? Or do you want it to state that explicitely?
>
>> Having looked at the code, I realised that anything can be replaced with
>> anything, which is perhaps not what was intended.
>
> The documentation says in the "BUGS" section:
>
> "And of course things may break if an object of one type is replaced
> by an object of another type (for example a blob replaced by a
> commit)."
>
> So yes it is a know bug.

Is that even a BUG?  The users are pretty much asking for it if they
place an object name of a random wrong object themselves.

I agree that a hand-holding wrapper "git replace" could help them to
avoid mistakes, though.
