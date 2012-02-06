From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] completion: work around zsh option propagation
 bug
Date: Mon, 06 Feb 2012 15:20:08 -0800
Message-ID: <7vvcnj4kif.fsf@alter.siamese.dyndns.org>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
 <1328214625-3576-2-git-send-email-felipe.contreras@gmail.com>
 <7v1uqbpsyh.fsf@alter.siamese.dyndns.org>
 <CAMP44s3SruBpM74BjWuTLfS=_66p7r6rkjJ+ObLr4bLq0nERNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:20:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuXrA-0002mJ-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 00:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab2BFXUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 18:20:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355Ab2BFXUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 18:20:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 793847B89;
	Mon,  6 Feb 2012 18:20:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5v7f0+1vibFkjF6tbKDPhvcubAI=; b=TgDUTl
	5HcFWLLuM8ycQDvvP1nJNvkk+HNyRach3EbK/gPi1fRnSkWPVqtAaxzgDkkCkzmY
	YGojL72wTL8kI28t63ulNFxENa1nXsi7P5YCHx/h7Okl93xcNu1OU2xK/l39RoJC
	vbNr0qDYCYqAzrkXe/QreUTr3i7yeUsK0wk3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKh45wT4xvTQEtuIw/5sF+Tu9zBYSHvR
	CCMO2aunUnJDPkatjDHyzWTJeMgM1l1QzpWTXC+lnV/qrSINj/FG36xlc1KKheQ8
	rKWQ/zuL3MmNkvCydKUwjAxNVPg4T88aX3vKPEl6j18+qOHpVUBE8cA69P8bZlH8
	KdFG0YFKZZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 702FD7B88;
	Mon,  6 Feb 2012 18:20:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E18BA7B86; Mon,  6 Feb 2012
 18:20:09 -0500 (EST)
In-Reply-To: <CAMP44s3SruBpM74BjWuTLfS=_66p7r6rkjJ+ObLr4bLq0nERNA@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 7 Feb 2012 00:59:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CF42A36-5119-11E1-A82F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190120>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I find that what Jonathan gave you helps them much better:
>>        ...
>>        fn () {
>>                var='one two'
>>                printf '%s\n' $var
>>        }
>>        x=$(fn)
>>        : ${y=$(fn)}
>>
>>    printing "$x" results in two lines as expected, but printing "$y" results
>>    in a single line because $var is expanded as a single word when evaluating
>>    fn to compute y.
>>
>>    So avoid the construct, and use an explicit 'test -n "$foo" || foo=$(bar)'
>>    instead.
>>
>> So I'll take the first two lines of the message (good bits), and simplify
>> the "This fixes a bug tht caused..." from the last paragraph (or perhaps
>> even drop it).
>
> I'm not sure about it, because this relies on knowledge of how printf
> works, and it's not used that often; an example with 'for' would be
> much more clear IMO.

Meaning, replace the fn() definition with something like:

	fn () {
		var='one two'
                for v in $var
                do
                	echo "$v"
		done
	}

I can see that may make the issue easier to see; as you pointed out, it
requires no implicit knowledge that printf "loops" over the arguments
and applies the format string as manu times as needed to eat them.
Let me update the log message before I merge it to 'next'.

My main point was to illustrate the problematic pattern for people who
write for bash, not for zsh, and that does not change with the above
improvement, though ;-).
