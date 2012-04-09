From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 14:48:49 -0700
Message-ID: <7vy5q4tw3i.fsf@alter.siamese.dyndns.org>
References: <1333997276-sup-2760@pinkfloyd.chass.utoronto.ca>
 <1334002082-5375-1-git-send-email-bwalton@artsci.utoronto.ca>
 <m2vcl8bon4.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, gitster@pobox.com,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 23:48:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHMSH-0005dy-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 23:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab2DIVsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 17:48:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab2DIVsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 17:48:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09541650B;
	Mon,  9 Apr 2012 17:48:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w4f3JniYkz8AGRzMMJ8wUwetbXQ=; b=fKTNXt
	04b25mDxYocpRFk+8WtK+5MxUvTi6cpB4SoWOs3WDPU50wqOjAQg1mvM1tzbvRU/
	GmgDfovGdy653jlIXoPyM4zfBMyMya0pRuZshP26VUAv7335ijgMAmliUzgJIAER
	naB/xsoiG5Y97w///UjULU0uRr0VG6Q8s8IHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SZ+zyry9mTJxrdOWbn5yU3gYjPJT8ysV
	gtDFWR/EFLgjHOqynoeogB04deP5L8MDYggDxCQ/E0hF6fptj4Sk3t58E0JjP/KZ
	V5tYqsYiKnc28lXn0GK22bkc7EX3PC7NSuBm4VpNnNd3vtF00mrVY9NtDghwMQH5
	WxSQi2yBzIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3238650A;
	Mon,  9 Apr 2012 17:48:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8349F6509; Mon,  9 Apr 2012
 17:48:50 -0400 (EDT)
In-Reply-To: <m2vcl8bon4.fsf@igel.home> (Andreas Schwab's message of "Mon, 09
 Apr 2012 23:07:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAFE5C78-828D-11E1-B0D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195042>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Ben Walton <bwalton@artsci.utoronto.ca> writes:
>
>> +	# Note: The extra [^/] is to work around a bug in Solairs'
>
> s/Solairs/Solaris/

True, but we do not have to single out the bug.  The resulting code is
easier to understand as it always expect at least one letter between
slashes, which holds true because we are handling output from pwd.

I'd rewrite it to:

	# Turn each leading "*/" component into "../"

or something like that.
