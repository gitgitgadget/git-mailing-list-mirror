From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 13/39] i18n: git-sh-setup.sh: mark strings for translation
Date: Wed, 01 Jun 2016 11:20:41 -0700
Message-ID: <xmqqvb1sydmu.fsf@gitster.mtv.corp.google.com>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
	<1464799289-7639-14-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed Jun 01 20:20:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Al9-0002oq-MT
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbcFASUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 14:20:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbcFASUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 14:20:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C4731EC23;
	Wed,  1 Jun 2016 14:20:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2dD6eSnndXLDDSjZEx/mAX1RQys=; b=JPxtVm
	9EF4xp1aGdJKBPgEtGnows5oHHaDXx6MOrxYmKGjuu/yuUggtImXLZKoIM+s1tUH
	4a46U015Zk6CEbXkUBoJHA/gOC9KGkXfTSMaVGQcI2GAnIwhGZ+IOWWrrGmKd1Nx
	ahfGOqItzMQTQrzIr3lixrpGYznr5i34KnKwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P59DB9yAWXmhpxSX2FX3gFq2nd8/f57Z
	nzYC/SoL8+YJNYHqIvOx1LaQA/DmZW3Nm1R5ycO9YnaK7XJjoL8KSnoke8YA+jBd
	BFoch7RJXc6eHZoYQ4PcvURbYW/WSc8UxTZ4VlTq6HbkKk1yxc3ZdrLNqvwWoIYU
	B64aGMBycpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 745B61EC22;
	Wed,  1 Jun 2016 14:20:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0114D1EC21;
	Wed,  1 Jun 2016 14:20:42 -0400 (EDT)
In-Reply-To: <1464799289-7639-14-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Wed, 1 Jun 2016 16:41:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D419692-2825-11E6-93D9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296146>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Positional arguments, such as $0, $1, etc, need to be stored on shell
> variables for use in translatable strings, according to gettext manual
> [1].
>
> Add git-sh-setup.sh to LOCALIZED_SH variable in Makefile to enable
> extraction of string marked for translation by xgettext.
>
> Although git-sh-setup.sh is a shell library to be sourced by other shell
> scripts, it is necessary to source git-sh-i18n at this point, because
> some scripts don't do it themselves. Not sourcing git-sh-i18n would lead
> to failure due to, for instance, gettextln not being found.

That is correct, but doesn't that hint that the current users of
git-sh-i18n no longer have to (and they probably do not want to)
dot-source it, as they are already dot-sourcing git-sh-setup?

Otherwise they will waste cycles reading the same thing twice
(assuming that git-sh-i18n is safely read twice, that is).

> Source "$(git --exec-path)"/git-sh-i18n instead of simply git-sh-i18n,

That is somewhat strange.  "git-rebase.sh" dot-sources both
git-sh-setup and git-sh-i18n with just ". $name".  What is so
special about sh-setup dot-sourcing sh-i18n your patch adds?

> because latter case would fail test t2300-cd-to-toplevel.sh.

What is the real cause of this?

". git-sh-setup" is supposed to work because we prepend the
$GIT_EXEC_PATH in "git" itself and git-sh-setup is installed there.
". git-sh-i18n" in "git-rebase.sh" works the same way.  If it is
because is t2300 doing something strange, then we should fix that,
not adding $(git --exec-path) on the dot-source line to paper things
over.
