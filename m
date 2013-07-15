From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] templates: Use heredoc in pre-commit hook
Date: Mon, 15 Jul 2013 09:49:41 -0700
Message-ID: <7vli57bwey.fsf@alter.siamese.dyndns.org>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
	<1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
	<1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
	<7v1u71gd7r.fsf@alter.siamese.dyndns.org>
	<CAD77+gSE5GnTcrpoWO0bb2UysDE9t51EWJo3shdeffnaLxASfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 18:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UylyL-0003cK-8H
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 18:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab3GOQtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 12:49:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757985Ab3GOQtw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 12:49:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBCED31D34;
	Mon, 15 Jul 2013 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=srXqjdem2oMcqZZFFPxMTZ2Z4hA=; b=b7ysTA
	YmNZmUuiMSacqonoDuxCzKPv5bnMekbJiuJ5VuiCSh99X9xYHTV+Fgalbb8tmfRQ
	Jckzkt3PONFFlzLnlH7kHVv+Z/Hr6eHDb7NzT2o5mBw9h13/si5GGiu59nzjUvfB
	0UpKA6fNbdEFp34ZhOKEcKaUp+3OZ7RDt40ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCEmNN2N4f7JDaJvYCE7lIfedS851/r4
	Bpjjx6pOnri61mUgyvML70NC6haqSLrKVEFV53+ewHO1MYTuOUnya6e5nva3MyLY
	CQw6iQEhvxh4HCsqgv758ekaJ8Yge/ku/cs6Qi/DKwq9Ky7SnLMaiUmVTP9KyE+X
	uP97dMC+634=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C03C131D33;
	Mon, 15 Jul 2013 16:49:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4FF331D2F;
	Mon, 15 Jul 2013 16:49:42 +0000 (UTC)
In-Reply-To: <CAD77+gSE5GnTcrpoWO0bb2UysDE9t51EWJo3shdeffnaLxASfw@mail.gmail.com>
	(Richard Hartmann's message of "Sun, 14 Jul 2013 22:12:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C328A3A-ED6E-11E2-B64E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230488>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> On Sun, Jul 14, 2013 at 9:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Shells on modern distros and platforms have "echo" built-in, so this
>> patch replaces series of writes internal to the shell with a fork to
>> cat with heredoc (which often is implemented with a temporary file).
>
> True; fwiw, I replaced my one single echo with heredoc as you
> suggested I do that. I don't mind undoing that, or I can drop it from
> this series altogether.

The _real_ reason you wanted to do this change in the context of
this series is to make it easier to reword the messages and also
have the messages span the full width of the source line, to match
the expected output better, isn't it?  Git is not _only_ about
performance, so even if using "cat <<here" might make things slower
(I do not think it is measurable), that reason "this way, it is
easier to see how the output given to the users would look like" may
well justify this change.

I just wanted to see the proposed log message state the real reason,
not a performance justification that can be invalidated.

Thanks.
