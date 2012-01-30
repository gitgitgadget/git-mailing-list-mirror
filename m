From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] completion: cleanup __gitcomp*
Date: Mon, 30 Jan 2012 11:03:48 -0800
Message-ID: <7vpqe1au7f.fsf@alter.siamese.dyndns.org>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-4-git-send-email-felipec@infradead.org>
 <20120130175004.GG10618@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwWB-0007Ra-Md
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab2A3TDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:03:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab2A3TDu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:03:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3205B714C;
	Mon, 30 Jan 2012 14:03:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=apM/fydmWMrybSBvO5tbX5D2fmQ=; b=ZS/s99
	/vRzxWBSpXvWHqEto3dnqr422eGbWzP2htQ8J3WZMtdKTbU8bkcFB8qKECmOurYE
	9wE11o+MxMWir3r6rElr22H3B3UAmuM34nw8r19zGxgHk1MOqIzUNjsd7IWndpNP
	t5BSgtsIBqw4PtVi9i8R+ODl5MCxvg4t7jV30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qJiz4XO7fP8seDiAnXAoMgpMlyJ3scn9
	R/mw2+btoDCbDFY3R6bmg+vkzbZERL80r6GUUtAEKaHV9d1VWTd2amehOWsaZo5l
	w54hUwq9bEP+CoYn691SFbWrQ8jO0pzWkFjdlZQ7526z8a+CUhUPK5i5AMR+z/nn
	cd7boSPNiL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2720F714B;
	Mon, 30 Jan 2012 14:03:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95429714A; Mon, 30 Jan 2012
 14:03:49 -0500 (EST)
In-Reply-To: <20120130175004.GG10618@burratino> (Jonathan Nieder's message of
 "Mon, 30 Jan 2012 11:50:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24B7B048-4B75-11E1-9F4D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189399>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I imagine it would have been enough to say something along the lines of
> "The __gitcomp and __gitcomp_nl functions are unnecessarily verbose.
> __gitcomp_nl sets IFS to " \t\n" unnecessarily before setting it to "\n"
> by mistake.  Both functions use 'if' statements to read parameters
> with defaults, where the ${parameter:-default} idiom would be just as
> clear.  By fixing these, we can make each function almost a one-liner."
>
> By the way, the subject ("clean up __gitcomp*") tells me almost as
> little as something like "fix __gitcomp*".  A person reading the
> shortlog would like to know _how_ you are fixing it, or what the
> impact of the change will be --- e.g., something like "simplify
> __gitcomp and __gitcomp_nl" would be clearer.

I love both of the above two paragraphs.  Thanks.

> [...]
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
> [...]
>> @@ -524,18 +520,8 @@ __gitcomp ()
>>  #    appended.
>>  __gitcomp_nl ()
>>  {
>> -	local s=$'\n' IFS=' '$'\t'$'\n'
>> -	local cur_="$cur" suffix=" "
>> -
>> -	if [ $# -gt 2 ]; then
>> -		cur_="$3"
>> -		if [ $# -gt 3 ]; then
>> -			suffix="$4"
>> -		fi
>> -	fi
>> -
>> -	IFS=$s
>> -	COMPREPLY=($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
>> +	local IFS=$'\n'
>> +	COMPREPLY=($(compgen -P "${2-}" -S "${4:- }" -W "$1" -- "${3:-$cur}"))
>
> This loses the nice name $suffix for the -S argument.  Not a problem,
> just noticing.

The patch looks good, including the localness that is kept for IFS.
