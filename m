From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 30 Sep 2014 15:35:26 -0700
Message-ID: <xmqq7g0krb2p.fsf@gitster.dls.corp.google.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>
	<542B1623.2070109@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Julien Carsique <julien.carsique@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 00:35:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ619-0001Bt-Bu
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 00:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbaI3Wfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 18:35:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51184 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaI3Wfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 18:35:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC2283FDBD;
	Tue, 30 Sep 2014 18:35:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gvYHMvSyJVFSHJDW0PZW/dbexTk=; b=YT6R0a
	q/f+0zIQNH7wwSDlF18xC/6PtBSHiyJeWoK6w6aB9L8L8jALbexqRneD2r6flHS1
	dqbkqS/voz7TylN3MjBljW83T4kKcvvZV9moc0vnqAlsYE74WIwVSAEo50OL36rc
	qJX7vZtkGxxPOws41OZj+ynSsWGhksQlKRQ7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jIJ0rg7U5xlkWlCvh6t9mNM8bh1jSp6+
	ANTNuZ4fXenN4b9/d/JplN1VZwshViWrUX5YAFZB3JbVjLszQ3COpFqsMJ0LEfOH
	kGXQaazJj5a8jqfdgTcTIsrBA0fs/8QVP9cGR0iqWKUxcjX4t8M91xfQYGT9SL23
	3nM4d3G8ldw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5ED4D3FDBA;
	Tue, 30 Sep 2014 18:35:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15D5D3FDB8;
	Tue, 30 Sep 2014 18:35:28 -0400 (EDT)
In-Reply-To: <542B1623.2070109@bbn.com> (Richard Hansen's message of "Tue, 30
	Sep 2014 16:44:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13F486D2-48F2-11E4-9726-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257687>

Richard Hansen <rhansen@bbn.com> writes:

> Additional cases could be added to handle git-svn if needed.

Thanks for a review (everything I omitted above looked good to me).

>> +				__git_ps1_upstream_name=${__git_ps1_upstream_name/$__head/=}
>
>   * This could break if ${__head} contains any pattern-special
>     characters.

... but I do not think refnames can have *, ? and such so it may not
be relevant ;-).

>   * While this syntax works in both Bash and Zsh (assuming no
>     pattern-special characters), my preference is to stick to POSIX[1]
>     when possible.

Nah.  The existing script is full of bash-isms like local you
suggested to add (and other constructs like shell arrays and [[ ]]
tests, I suspect), and there is no hope to "fix" them to stick to
the bare-minimum POSIX, and there is no need to do so (isn't this
bash-prompt script after all?)

>   * I don't think the CodingGuidelines explicitly prohibit long lines
>     for shell code, and this file already contains plenty of long
>     lines, but I really dislike lines longer than 80 characters.

Yes, I dislike overlong lines, too.  But I also dislike lines that
are artificially chopped into
shorter pieces without
good reason ;-).
