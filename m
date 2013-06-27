From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Thu, 27 Jun 2013 13:49:42 -0700
Message-ID: <7vzjubqnx5.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130627201142.GC27497@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 22:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsJ8Y-00084c-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 22:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab3F0Utr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 16:49:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab3F0Utq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 16:49:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A0982974F;
	Thu, 27 Jun 2013 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vck2wM4u9ACCcutMB+zmgtdRXe0=; b=ZouQSi
	UxvKdn/RNRnz1+mBWr8Uhr0/T5DPv7sMBTvWjDia7B9lbV4WTrr8jhA/un4AYf7N
	bOs2nWrbqNROZ6B8amiDDAii8j6usApIb0Z6/ag4Ptr7fEBhYiz33FgYL+2uC6H7
	T1ZPmu6NdXIPbsCC8GakVb4eqNkcVZ3bIYbAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=of9/9HISZrMakDt/bIAbgH2XxOfEBzzj
	d9FDVE592TImD9PeC07u6NpWttRyqkpQ3LEaP0sjM4s8dO+tjZCP7AZZbCoG2Tqg
	5K2MJLFDbyWVb+7r6ymR4dPfNPdZJkBcc7c6TwAO5w2ZgS8HvbUmIa+n7cS8HJYx
	kXYwvH4WLD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0EC32974E;
	Thu, 27 Jun 2013 20:49:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52CC32974C;
	Thu, 27 Jun 2013 20:49:44 +0000 (UTC)
In-Reply-To: <20130627201142.GC27497@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Thu, 27 Jun 2013 22:11:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18B468AA-DF6B-11E2-855B-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229154>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
> <snip>
>> +# See if we are configured to rebase by default.
>> +# The value $rebase is, throughout the main part of the code:
>> +#    (empty) - the user did not have any preference
>> +#    true    - the user told us to integrate by rebasing
>> +#    flase   - the user told us to integrate by merging
>
> s/flase/false

Thanks.

> And isn't all config settings documented somewhere?

Yes, but the above does not have anything to do with it.  It is how
the variable in this script gets used---it may come from the config,
but it will be overridden by command line option.

If you do "git config pull.rebase false", it is an explicit show of
preference to do "pull --merge".

If you do not have any pull.rebase in your configuration, *and* if
your command line does not say "pull --merge" nor "pull --rebase",
then $rebase will be empty, and that is how we detect that you
haven't given us any explicit preference (yet) and fail the command.
