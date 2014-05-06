From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Tue, 06 May 2014 13:53:31 -0700
Message-ID: <xmqqk39yeiic.fsf@gitster.dls.corp.google.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
	<1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
	<1398851444-2492-4-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:53:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhmMx-0005Ix-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbaEFUxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:53:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50802 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191AbaEFUxj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:53:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA36D152F9;
	Tue,  6 May 2014 16:53:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cOCZz3sUYl/EaJm66sLt6hA0DO4=; b=Nc94pn
	PcYJ+u8u2Y8zKlOQP8J1NelQZ1HxhS3K0To4zgmx/m6V0Et9/hptAFelQo9eg2ET
	tu83+ndhU5kL8hPrI1IJHel4dkaL31zJMyDkKh+TCMcL4sk1ZvapNkFZlYZAVdXm
	KM3gBi+JX5eNB1NKZ62o+9E2kERHlsMvO3XDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D0gnYZ1aC1lJqxn9fnxmWv5/TBgfCU8Q
	T9JXWdxrJnbPgQyTBA4h6zqz7o1pEeNDAppqjtF2A0bSUj41oud9e/JHeMrwN0yF
	gM0Qiildquryn6HlAu2IbiD4YlYsGUm9kFRyatGT0rn5mQ/aG3ShHKxpNh40llRJ
	XUJ0BnVlvNU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0A82152F8;
	Tue,  6 May 2014 16:53:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3194A152F2;
	Tue,  6 May 2014 16:53:33 -0400 (EDT)
In-Reply-To: <1398851444-2492-4-git-send-email-ilya.bobyr@gmail.com> (Ilya
	Bobyr's message of "Wed, 30 Apr 2014 02:50:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C6A6B6A-D560-11E3-A634-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248251>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> Allow better control of the set of tests that will be executed for a
> single test suite.  Mostly useful while debugging or developing as it
> allows to focus on a specific test.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
> A number of minor changes according to the review comments.

I think the interaction between multiple selectors, especially when
some of them are negated, are much better explained in this version,
compared to the previous round in the README.

But I still think that the negation a feature that is unnecessary
and having it makes it harder to understand for users, especially
after reading this part:

> +If --run starts with an unprefixed number or range the initial
> +set of tests to run is empty. If the first item starts with '!'
> +all the tests are added to the initial set.  After initial set is
> +determined every test number or range is added or excluded from
> +the set one by one, from left to right.
> ...
> +As noted above, the test set is built going though items left to
> +right, so this:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
> +
> +will run tests 1, 2, and 4.  Items that comes later have higher
> +precendence.  It means that this:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!3 1-4'
> +
> +would just run tests from 1 to 4, including 3.

The initial !3 means the same thing as "1-2,4-", and then 1-4 will
do what to that set?  The answer is "It is added"... wouldn't the
reader expect then that the result should be "1-", not "1-4"?  I
myself wondered what would happen to the fifth test from your
description.  Has the text told the reader that t9200 test has only
four tests?

The need to explain better with longer description will reduce the
likelyhood that the feature is understood and correctly used.  When
you can write "1-2,4-", why accept "1-4 !3" and force yourself to
explain to people why that is different from "!3 1-4"?
