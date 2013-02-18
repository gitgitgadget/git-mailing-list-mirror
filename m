From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell-prompt: clean up nested if-then
Date: Mon, 18 Feb 2013 15:07:02 -0800
Message-ID: <7vtxp98bmx.fsf@alter.siamese.dyndns.org>
References: <1361204512.4758.10.camel@mas>
 <1361204601-4573-1-git-send-email-martinerikwerner@gmail.com>
 <20130218191040.GB3234@elie.Belkin>
 <0c94f24b-f7ee-4699-87a7-6861b927cea4@email.android.com>
 <1361228206.17734.4.camel@mas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon vanaf Telefoon <s.oosthoek@xs4all.nl>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	trsten@science-computing.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 00:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Zo4-0001IU-2i
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 00:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab3BRXHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 18:07:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab3BRXHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 18:07:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF71BE75;
	Mon, 18 Feb 2013 18:07:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e383igwRQK+rRWbtTP4J4VdDr6c=; b=OIclSa
	QLgovmBMxXnE6ljuk2vaZ0v/SombZF6ra8UOJcLuXgTgOmmtoSZXcEY0PsEjZmsW
	lHxvaTADNh6Q/AH3zLjN/keAmBFhcpK2lsBZy0VIaahNH/bqq5W1rBIFLDBgUUwm
	Q2Dyn9Fz8uyZq2h6GK9msRkUIH3PQTVqkev1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GWbt1NSLjMZ6Bhks8ZZLh0hsAnk/I8AG
	7WXQU+SsRJ3owPWhpXYU544DIoWueniO7LWN2ZmKBOqRCY+fQ36xupXZsOoy1/k7
	KqZ4/T1N/ZAk+heXhXG8QV9Rfu9TcwR59bEhM2wUl45ppIJ4uLAvlJI9dgtzzI8x
	LOAJQV/f9F8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B399BBE74;
	Mon, 18 Feb 2013 18:07:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 170FBBE71; Mon, 18 Feb 2013
 18:07:04 -0500 (EST)
In-Reply-To: <1361228206.17734.4.camel@mas> (Martin Erik Werner's message of
 "Mon, 18 Feb 2013 23:56:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8B12D10-7A1F-11E2-9D2D-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216548>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> On Mon, 2013-02-18 at 21:31 +0100, Simon vanaf Telefoon wrote:
>> Hi all, sorry for top posting :-( blame the phone and k9
>> 
>> I have a small issue with the use of test instead of [
>> If that only applies to this section of the entire file. 
>> Coding style has some value.
>> 
>> Combining nested ifs with && seems harmless enough, though should be
>> well tested.
>> 
>> Cheers
>> Simon 
>> 
>
> Ah, indeed, I looked around a bit more, and as per
> http://mywiki.wooledge.org/BashPitfalls it seems like 'test' is bad to use with multiple &&'s anyways.

I think you are misreading a suggestion that is somewhat misguided
(yes "[ <condition> && <another> ]" does not make sense, but that is
not applicable to "test <conditon> && test <another>"); ignore it.

It is fine to write "test <condition> && test <another>" and that
works portably to even pre-posix systems.

But the existing code the patch touches favors [] over test
consistently; that alone is a good reason to stick with [] in _this_
script, even though it is against Git's overall shell script style.
