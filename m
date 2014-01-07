From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: Support 'checkout' as a valid update command
Date: Tue, 07 Jan 2014 08:12:31 -0800
Message-ID: <xmqqlhyrg49c.fsf@gitster.dls.corp.google.com>
References: <1389034726-8744-1-git-send-email-ceztko@gmail.com>
	<xmqqtxdgfz8a.fsf@gitster.dls.corp.google.com>
	<CALas-ijrD1VnyUcr2yQw_1Je4K3eEdXtxqDNDKdGPZE=1=Nm3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 17:12:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ZGm-0008Gc-Jx
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 17:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbaAGQMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 11:12:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbaAGQMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 11:12:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 156495F1A7;
	Tue,  7 Jan 2014 11:12:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HY6g7QU3yXU2XcC6bat0eIsLCoE=; b=J4kQNj
	EtK/fMVhZoozargMF60nf10fk0P3VKC+nkdm8L0OVWWW8fPxTz49GCYpzgdVfSwX
	wv+YhkuUum8PUKZIG9MLnQ2CORoYRp3WKqhHXG9VlQsPtRVEoM/rl2nDvNpB7mFd
	/+Gri6mOTHT7SLFvA6cV5APAiluI/AZD4T0zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UiOhk7nUuELoWrcKsdGQC27HMV83bMEA
	V7WJQhoE0E9EUtrzbwKjRMT48VovJ9snlU/ktD3HocC042esSfCTBQbdAMpYL1wF
	YqLBc29coMYIfRiXSDWzu03fuZQW6WAk7uHcfwcCi4yEY5fG9w6TX8MMd5h1bdFW
	0kSOccqAlGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA9FD5F1A6;
	Tue,  7 Jan 2014 11:12:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DC8F5F1A2;
	Tue,  7 Jan 2014 11:12:36 -0500 (EST)
In-Reply-To: <CALas-ijrD1VnyUcr2yQw_1Je4K3eEdXtxqDNDKdGPZE=1=Nm3A@mail.gmail.com>
	(Francesco Pretto's message of "Tue, 7 Jan 2014 01:05:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85E2ED50-77B6-11E3-B090-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240108>

Francesco Pretto <ceztko@gmail.com> writes:

> Like you said, "it already refers to checkout and handles it
> correctly". I think the use of the simple present tense here is
> correct: it's a fact. Feel free to advice another wording if you
> prefer.

It is not about preference but what we want to convey to the
readers.  When you start the sentence with "Oh, it already works
correctly", the readers need to see this sentence finished: "It
already works, it is handled correctly, but we change the code
nevertheless because ...?".

Here is my attempt to fill that "because ..." part:

	Subject: git-submodule.sh: 'checkout' is a valid update mode

	'checkout' is documented as one of the valid values for
	'submodule.<name>.update' variable, and in a repository with
	the variable set to 'checkout', "git submodule update"
	command do update using the 'checkout' mode.

	However, it has been an accident that the implementation
	works this way; any unknown value would trigger the same
	codepath and update using the 'checkout' mode.

        Tighten the codepath and explicitly list 'checkout' as one
	of the known update modes, and error out when an unknown
	update mode is used.

	Also, teach the codepath that initializes the configuration
	variable from in-tree .gitmodules that 'checkout' is one of
	the valid values---the code since ac1fbbda (submodule: do
	not copy unknown update mode from .gitmodules, 2013-12-02)
	used to treat the value 'checkout' as unknown and mapped it
	to 'none', which made little sense.
