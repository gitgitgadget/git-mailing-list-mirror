From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: clean up temp files when aborted
Date: Thu, 24 Jan 2013 13:41:57 -0800
Message-ID: <7vy5fi8di2.fsf@alter.siamese.dyndns.org>
References: <1359051829-21331-1-git-send-email-hordp@cisco.com>
 <7vbocebblo.fsf@alter.siamese.dyndns.org>
 <CABURp0qxj0HVHbYOR1Enfx_A1-ALPDGhLriGp=gab-LBigwt8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:42:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyUYx-0000Cn-2s
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 22:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab3AXVmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 16:42:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab3AXVmA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 16:42:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76022CAF8;
	Thu, 24 Jan 2013 16:41:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mX96haTT0qahivz+ekOUa77yZak=; b=P8gX8t
	2eTa+4kPyDG/rsi6jQeK9O9JUaMBZqbt5tbecOKRrzz4o48JOot1No4hyebWzzEK
	JbyLjAICORkUaz6HB57kk5rC8EwMRRLu/8xRd06wVyjZ3PJYc92kPjFwjlqu7vW7
	OUxyoZBM4Uw13a/cgLn9rjWga2eS2wRAGApuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LIKu1JrY29kE6ItWW3UJdeqNtE39t4L+
	XIvn/pSIlXMXqVFUBBe5+v2HKe891NGzApwOKJLWOOdg4UHUbaavdA4u5lLcdY6D
	1rwMZVEuJePT/aiLNWBIVnaulASLKUKSQaFAypBOS+hFTO3Yz7jFt8Fg52BA1vK+
	zz0++cLycUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69998CAF7;
	Thu, 24 Jan 2013 16:41:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED7F4CAF6; Thu, 24 Jan 2013
 16:41:58 -0500 (EST)
In-Reply-To: <CABURp0qxj0HVHbYOR1Enfx_A1-ALPDGhLriGp=gab-LBigwt8g@mail.gmail.com> (Phil
 Hord's message of "Thu, 24 Jan 2013 16:16:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E17992C2-666E-11E2-8DF7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214461>

Phil Hord <phil.hord@gmail.com> writes:

> On Thu, Jan 24, 2013 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Phil Hord <hordp@cisco.com> writes:
>> ...
>>> These temporary files should not remain after the mergetool operation is
>>> completed.
>>
>> Aren't there cases where people "abort" so that they can have a
>> chance inspect them outside mergetool program?  If there are no such
>> cases, then I would agree with your claim "should not remain", but
>> the proposed log message does not explay why it is sure that there
>> are no such use cases.
>
> You may be right about other people's workflows which I forgot to
> consider.  I have noticed a lot of inconsistency in this tool wrt to
> mergetool.keepBackup and mergetool.keepTemporaries.  Perhaps this
> change should hinge on the latter.
>
> Would you agree with this rephrased statement (accompanied by matching logic)?
>
>     When mergetool.keepTemporaries is false or not set, these temporary files
>     should not remain when the mergetool operation is aborted.

That is perfectly sensible (and should apply equally to non-"abort"
cases, I think).

Thanks.
