From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/19] reset [--mixed] --quiet: don't refresh index
Date: Wed, 09 Jan 2013 11:12:37 -0800
Message-ID: <7v7gnm6uhm.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-17-git-send-email-martinvonz@gmail.com>
 <20130109170119.GA5332@sigill.intra.peff.net>
 <CANiSa6joBuAJVHkMfNbVMHFJ6BFOh7sGRw_txRO81CKudRwsfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt15A-0002jb-T7
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390Ab3AITMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:12:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302Ab3AITMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:12:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1FACAF5C;
	Wed,  9 Jan 2013 14:12:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xCG2fcSlJBDtbyzogMbwHdjdbuE=; b=PJJAnq
	2ShVgt0yrDBU+Z2j5ASURaFR8QCOJWU/rkOtFoRkyHfcB+ya/juWfcbC2s1T0/gB
	sKqs4KbotlDilMvkWzTVSAGNwYCYKrE6LDLxg2dFBPQGfr1YFgqEU+JgMy8VqpYE
	MIOtUsOscS/YtJ4e6WB86SjdWEXQ2osD4DUrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DZXXVNnXJY243F9Hn+Nx5bu+jKeCem9w
	ZD0ETtBZLlqD2jvFK1uM0FTkExa7PK5RSjRg9z8VDesC1gq/Pg/J8zTnJAVbxK//
	I/f8OJXRM07gLXwZuigq6jZoexdujzssqNoSXtyeHyhzhXo6CVDw368d7p7qQgIU
	7VKjPOLReCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94CBBAF5B;
	Wed,  9 Jan 2013 14:12:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F154FAF52; Wed,  9 Jan 2013
 14:12:38 -0500 (EST)
In-Reply-To: <CANiSa6joBuAJVHkMfNbVMHFJ6BFOh7sGRw_txRO81CKudRwsfA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Wed, 9 Jan 2013 10:43:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88B6402A-5A90-11E2-A12A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213079>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

>> We have never been very clear about which commands refresh the index.
>
> Yes, git-reset's documentation doesn't mention it.
>
>> Since "reset" is about manipulating the index, I'd expect it to be
>> refreshed afterwards. On the other hand, since we have never guaranteed
>> anything, perhaps a careful script should always use "git update-index
>> --refresh".
>
> Since "git diff-files" is a plumbing command, users of it to a
> hopefully a bit more careful than regular users, but you never know.
>
>> I would not be too surprised if some of our own scripts are
>> not that careful, though.
>
> I didn't find any, but I might have missed something.

contrib/examples/ have some, but looking at it makes me realize that
we have been fairly careful to avoid using "git reset" which is a
Porcelain.

And as a Porcelain, I would rather expect it to leave the resulting
index refreshed.
