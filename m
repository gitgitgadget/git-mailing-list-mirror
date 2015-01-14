From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 broken under Mac OS X
Date: Wed, 14 Jan 2015 10:37:41 -0800
Message-ID: <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
References: <54B68D99.2040906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBSpF-0002Su-L4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 19:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbbANSht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2015 13:37:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753551AbbANShq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2015 13:37:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CCBD2CA48;
	Wed, 14 Jan 2015 13:37:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6+8Mapn5MRXM
	eN+qs7lcCReWzN8=; b=Jqd6a5X8/ygvS542rQREWMCdjZfiXjBOfoISiLZJkA46
	NeLyQy+SwuT7QSEtacJN6fVb74Br03VaDnzk8k7GyU8mVZBz7t7ocUrTw5kbJBqY
	iPqEu6tyMKnCxkmfpIr6QDcf6YX5hftO6BpvnXExpVefujn8q4kYy/AuU4VOtC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x+Ikp3
	B8VKglt7WNUhBTvF3wKdFhGcvgEajU4srVpvl/sC/gGuOtSAQ41pO9KK3Uosnvbg
	oZc+samI8L9Z5EOyJEz3Q6LKQi3BbZgh4crjSsoPt1IztlssLIQGyGwwWsldovZY
	jbXRAqL8kQPzd9LreNeyZ/9oeyUKvHVcjJQ2Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 725092CA46;
	Wed, 14 Jan 2015 13:37:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD8562CA42;
	Wed, 14 Jan 2015 13:37:42 -0500 (EST)
In-Reply-To: <54B68D99.2040906@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 14 Jan 2015 16:39:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D002C7C-9C1C-11E4-B60A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262406>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> t5539 doesn't seem to work as expected under Mac OX X 10.6
> (10.9 is OK)
>
> I am not root.
> Are there any ideas how we can improve the situation, or how to debug=
 ?

As to "how to debug", the first step is to grep for that message and
notice that it comes from here:

t/lib-httpd.sh:

    if ! test_have_prereq SANITY; then
            test_skip_or_die $GIT_TEST_HTTPD \
                    "Cannot run httpd tests as root"
    fi

and then grep for SANITY to find:

t/test-lib.sh:

    # When the tests are run as root, permission tests will report that
    # things are writable when they shouldn't be.
    test -w / || test_set_prereq SANITY

It appears that the check in lib-httpd.sh thinks you lack SANITY; is
the root directory of your system somehow writable by you?


>
>
> t>
> t> ./t5539-fetch-http-shallow.sh ; echo $?
>
> 1..0 # SKIP Cannot run httpd tests as root
> 0
> t>
> t> GIT_TEST_HTTPD=3Dt ./t5539-fetch-http-shallow.sh ; echo $?
> error: Cannot run httpd tests as root
> 1
> t>
