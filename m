From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Handling of non-UTF8 data in gitweb
Date: Sun, 11 Dec 2011 21:26:01 -0800
Message-ID: <7vhb169x92.fsf@alter.siamese.dyndns.org>
References: <201112041709.32212.jnareb@gmail.com>
 <7vehwhcj3q.fsf@alter.siamese.dyndns.org>
 <201112101718.34848.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=BCrgen?= Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:26:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyOx-0005uQ-Rz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab1LLF0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:26:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1LLF0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:26:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D350133AB;
	Mon, 12 Dec 2011 00:26:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kdXx0hlfC7dgmLU6aLYa8vQv4iw=; b=GjeoZ9
	4iLBzKhBLQ+3I7jDPbU0vcKyXFuNTC7gYtQz0SrAF4r6M63Da4bwjZZ+ptredNSP
	1DYGJxykzTfpgmtDKrm5JUYZ1YDQ5PN+uPJU9WVaXqM93qN+lb2wHLyLkGfSkKri
	eQTBM2tYQFGAFh74c1mdWf4aTet4VluxYDPJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fsp4BVnYAN0f4ynyJlD6TdBzAfh4bClE
	f0rnltNeuxhGzY1B6ixccPwVWUpsjfMzQurER1H0ws0RFty6c6JvX7ri5QSdgcyd
	F1NoC6hcm1anrn/0UrOpOUcjqN2PDL9CvgYOtFKLZq8FkKdVhOX2NcusVcKDRcHk
	wAMLbM3CCcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5F5433AA;
	Mon, 12 Dec 2011 00:26:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 451BE33A9; Mon, 12 Dec 2011
 00:26:03 -0500 (EST)
In-Reply-To: <201112101718.34848.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat, 10 Dec 2011 17:18:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C89D25AA-2481-11E1-A3A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186823>

Jakub Narebski <jnareb@gmail.com> writes:

> On Wed, 7 Dec 2011, Junio C Hamano wrote:
>> I think we added and you acked 00f429a (gitweb: Handle non UTF-8 text
>> better, 2007-06-03) for a good reason, and I think the above argues that
>> whatever issue the commit tried to address is a non-issue. Is it really
>> true?
>
> I think that UTF-8 is much more prevalent character encoding in operating
> systems, programming languages, APIs, and software applications than it
> was 4 years ago.

Yeah, that was the kind of "reasoning behind it" explanation I was hoping
to see spelled out for people to agree or disagree.

But then the updated gitweb won't have trouble showing history of some
projects that has 4 yours or longer history (hopefully Git itself is not
among them).

> The proposed
>
>   use open qw(:std :utf8);
>
> and removal of to_utf8 and $fallback_encoding would be regression compared
> to post-00f429a... but the tradeoff of more robust UTF-8 handling might be
> worth it.
>
>> > ... I guess
>> > it could be emulated by defining our own 'utf-8-with-fallback'
>> > encoding, or by defining our own PerlIO layer with PerlIO::via.
>> > But it no longer be simple solution (though still automatic).
>> 
>> Between the current "everybody who read from the input must remember to
>> call to_utf8" and "everybody gets to read utf8 automatically for internal
>> processing", even though the latter may involve one-time pain to set up
>> the framework to do so, the pros-and-cons feels obvious to me.
>
> There is also a matter of performance (':utf8' and ':encoding(UTF-8)'
> are AFAIK implemented in C, both the Encode part and PerlIO part).

Would a reasonable first step be to replace the calls to bare "open" with
a wrapper that simulates the "open" interface (e.g. "sub git_open"), but
still keep the same behaviour as post-00f429a that could be much slower
than the native one?  Then a separate patch can build a "regression but
uses native and much faster" alternative on top, no?
