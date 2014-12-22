From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in t0090-cache-tree
Date: Mon, 22 Dec 2014 14:26:00 -0800
Message-ID: <xmqq7fxj8gp3.fsf@gitster.dls.corp.google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
	<xmqqk31j8ik9.fsf@gitster.dls.corp.google.com>
	<20141222220209.GT29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bdwalton@gmail.com>, dturner@twopensource.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:26:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BQX-0006zY-Jv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbaLVW0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:26:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753296AbaLVW0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:26:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 832062999B;
	Mon, 22 Dec 2014 17:26:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zoJ+sGyijVEIM/cgf3mR9ufIQvM=; b=RzjW2N
	3uW2TqPMjPzSlrM7dDI6Dm/pvQ0XMme9jJY9TKjhQlpL0dFcrvNc3AcY4RhuPIM+
	cJUS3BA4eYYOrFxTYcMw/ZanexgYKtBLVKXrmKTUmFT7Xed8H82kYlJdGFtp6iOA
	e9dpYGIPTrlXVjE8ew3H1+jTY5C1Zjc2tQgOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EoyjvmRLxKlhawQ4h5RCO0uEgKw66rGa
	0vJPMzhTQJu28jlKe3z0WbfmicdMsYJPtZaSmEwwMuIZLecCdrl639HL8Mdhfx4E
	+G7MBKxS/V5xjlVC5I0XDSG5WGA/eD1pvIXMVqNL7XiSK9+V8b059PbNSsdoRYMr
	YySEf+g5WVo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7933F2999A;
	Mon, 22 Dec 2014 17:26:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0170229993;
	Mon, 22 Dec 2014 17:26:01 -0500 (EST)
In-Reply-To: <20141222220209.GT29365@google.com> (Jonathan Nieder's message of
	"Mon, 22 Dec 2014 14:02:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82C51E0A-8A29-11E4-8B62-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261685>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Ben Walton <bdwalton@gmail.com> writes:
>
>>> echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
>>> 0
>>>
>>> And with GNU awk for comparison:
>>> echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
>>> 1
>>>
>>> Instead of modifying the awk code to work, use wc -w instead as that
>>> is both adequate and simpler.
>>
>> Hmm, why "wc -w" not "wc -l", though?  Is somebody squashing a
>> one-elem-per-line output from ls-files onto a single line?
>
> The old code was trying to skip empty lines.

Ahh, I misread the original.

Your suggestion to explicitly check $1 != "" makes sense to me now.

To be blunt, I do not have much sympathy to those who insist using
/usr/bin versions of various tools on Solaris that are overriden by
xpg variants, but it is somewhat disturbing that the one from xpg4
does not work.
