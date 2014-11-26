From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extended splitting for "git add --interactive"
Date: Wed, 26 Nov 2014 12:24:59 -0800
Message-ID: <xmqqtx1lpv50.fsf@gitster.dls.corp.google.com>
References: <5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de>
	<xmqq3895rdr1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 21:25:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtj9C-0006PV-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 21:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbaKZUZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 15:25:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751028AbaKZUZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 15:25:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29F77217FD;
	Wed, 26 Nov 2014 15:25:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hg8KRiZplvSEeFXauhqm2YRF0eQ=; b=udTLFm
	pqyvJEexNDSRUJQcPGMkqASIo+GxTqW9lGRFobdAruGDPpVYG4AHfzJbL7fkUTC8
	JTuwX2KC2AwC6LoTBHEBoOFJDX3CQG0eNCPH0U91i7fVvKgD3eZhOoddfMs0wAhK
	0V9vIh8Kw3q8M3XAMANLYarScLvsG51ne9ecU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=frMtUnoynWvOsi5XZbXgpGrutQ2FjRSs
	EnXphZaqfPnjT3TxRifGcFWjaOyssO6RGKwN/T59h2/QDXZ2DpHECi2XsVVmIgn1
	3nB4LskBtPxvPGAosAP4lSNH/3sFC5tcHt2yxH0ZQfQTEyGYqHUCQNIRFtQTtmt0
	wiy+Dnph87k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18E0A217FC;
	Wed, 26 Nov 2014 15:25:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B52E217F9;
	Wed, 26 Nov 2014 15:25:01 -0500 (EST)
In-Reply-To: <xmqq3895rdr1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 26 Nov 2014 10:57:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C5ADC26-75AA-11E4-9448-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260301>

Junio C Hamano <gitster@pobox.com> writes:

> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
>
>> Another split that is not possible is a split across an empty line, like:
>>
>> +AAA
>> +     <empty line (in reality)>
>> +BBB
>
> Likewise.  An empty line is not that special.  AAA may be adding one
> block of lines "if (condition) { ... }" and BBB may be another, and
> it often happens that you would want to separate these into two
> changes, with or without an empty line in between.
>
>    +if (foo) {
>    +  do foo thing
>    +}
>    +if (bar) {
>    +  do bar thing
>    +}
>    
> Having said all that, I am not opposed to a usable idea to allow the
> user to specify where in a contiguous block of -*+* to break a hunk
> and how.

Of course, splitting at blank or at any arbitrary point that the
implementor of this new feature decides to be good is not end of the
world.  If the split at that chosen point is undesirable, the user
can join them back.  But then the feature did not help such a user
very much.  So that selection of "any arbitrary point" has to be
fairly a good heuristic, making majority of users happy, to be worth
for users to try.  If they try splitting with the heuristics and get
a good result 80% of times, 20% of time they instead may need to
join the wrong splits back, but overall it will be a win.

In an extreme case, we could have an option to split a run of zero
or more "-" lines followed by zero or more "+" lines into one line
per hunk, and let the user pick the line they want, which would
solve your original issue of turning "-A-B+C+D" into "-A+C" and
"-B+D", while allowing them to be commited with a different
splitting, e.g. "-A" and "-B+C+D".

But at that point, I suspect most people may choose to (e)dit the
patch themselves instead.  I dunno.
