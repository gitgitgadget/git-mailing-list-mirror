From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 13:58:52 -0700
Message-ID: <7v62pal5v7.fsf@alter.siamese.dyndns.org>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
 <7vboz2l6h1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 22:59:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM4si-00074O-15
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab1EPU7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 16:59:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1EPU7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 16:59:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0124445BB;
	Mon, 16 May 2011 17:01:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sdp8oP1Fw1qj1aAFHp5vQ2njyIw=; b=E5Xjtj
	UC5ss/x8hRRWljeb/AB71Ue5k4RQg4Z+UIh5+UMFvCm8tSQorjkrksGMCO5j4+Uk
	kMW1TILKa3Kh8mdxVeas43993wdBtyvghqcAoy+xxPAEDgQHwZeFiu62LpGCAOJy
	1q1A1o8k/1v0zeVyrQ6svTIqZ0mLTqndXEoAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yjUX8Hswj2yUhvFARHvNK89BjdVlSoa6
	L8irANyzyIhfT/5IKEk1lnQYNEYP8k4SlESiF+D3GbYhxnNxE2/m7sM5vJv8jz4g
	peSnFiXwQvB3jNJNV1AyDYye13oJpGfVx4Zlynyda+ZgjF0+yIHKOse0REHZ7Y3T
	NxwZ9JKz+Og=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2A5345B9;
	Mon, 16 May 2011 17:01:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3E96145B5; Mon, 16 May 2011
 17:01:00 -0400 (EDT)
In-Reply-To: <7vboz2l6h1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 16 May 2011 13:45:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E083270-7FFF-11E0-924A-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173759>

Junio C Hamano <gitster@pobox.com> writes:

> Ahh, perhaps I was the one who said something stupid like:
>
> 	echo >&2 "$(cmd)"
>
> should be equivalent to
>
> 	cmd >&2
>
> which is not the case when output from cmd does not end with a single LF
> (i.e. either an incomplete line, or with trailing blank lines).
>
> Sorry, if that is what you are trying to address, please let me take that
> back.

Having said that, depending on how the strings are distributed, I have a
feeling that we might be better off having two variants:

	say >&2 "<message string>"
	gettext >&2 "<message string>"

The former would be

	say () {
		gettext >&2 "$1"; echo
	}

and minority of callers (they may be an empty set) that care about
trailing blank lines they output can include their own terminating LFs in
the message to be translated and call gettext directly, letting it output
the translation without stripping trailing LFs they (or their translation)
produce.
