From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git.git as of tonight
Date: Tue, 03 Nov 2015 09:05:38 -0800
Message-ID: <xmqq37wndndp.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
	<5637D266.4060904@kdbg.org>
	<CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
	<56385587.1010601@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 18:05:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztf1n-0003GA-2J
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 18:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbbKCRFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 12:05:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753264AbbKCRFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 12:05:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1063282C3;
	Tue,  3 Nov 2015 12:05:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xZLG+sBXpZfsFRZmWJN6Nty2R7U=; b=b2a9BR
	j939bYLiIR+Kx8hXTak9280CszZwgTh7eKx/CYLV322wK0ygIMVvMYQrPXu2bM3Z
	72liHQVU02pINcoQoqtGSIN7CNyv+yHSIzc43kUHSAZmPk2A15jcpkQ4BmK85Da0
	VAyuJZZ24Bxhh7uOFCaCz2pZAQxmbYAkWTr/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q4jTETMEiKibvFxzePFZ+XI/zKYyg5L0
	lKEYw4l/94j2yg5UJXYO8Y2hRhTc2lPW0MUbfA3KJa/tMQUxKV/1pTukqdc7P44w
	gEoKLguG1yIDgCgEnTGbbjmdKgqoy/XnC0jpCDvEY2x33pjbbp5UkYL6A/1ONQ9Q
	Khc9Y1C1ttA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9785B282C2;
	Tue,  3 Nov 2015 12:05:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1AFCE282C1;
	Tue,  3 Nov 2015 12:05:40 -0500 (EST)
In-Reply-To: <56385587.1010601@kdbg.org> (Johannes Sixt's message of "Tue, 3
	Nov 2015 07:34:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C293420-824D-11E5-BC51-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280802>

Johannes Sixt <j6t@kdbg.org> writes:

> My findings so far are negative. The only short-term and mid-term
> solution I see so far is to opt-out from the framework during
> build-time.

Now, from where I sit, it seems that the way forward would be

 1. Make this an optional feature so that platforms can compile it
    out, if it is not already done.  My preference, even if we go
    that route, would be to see if we can find a way to preserve the
    overall code structure (e.g. instead of spawning multiple
    workers, which is why the code needs NONBLOCK to avoid getting
    stuck on reading from one while others are working, perhaps we
    can spawn only one and not do a nonblock read?).

 2. After that is done, the feature could graduate to 'master'.  As
    this is a bigger framework change than others, however, we do
    not necessarily want to rush it.  On the other hand, because
    this only affects submodules, which means it has fewer users and
    testers that would give us feedback while it is on 'next', we
    may want to push it to 'master' sooner to give it a larger
    exposure.  I dunno, and I do not want to decide this myself the
    week before I'll go offline for a few weeks (i.e. today).

 3. Then we would enlist help from folks who are more familiar with
    Windows platform (like you) to see how the "run parallel workers
    and collect from them" can be (re)done with a nice level of
    abstraction.  I am hoping that we can continue the tradition of
    the evolution of run-command.c API (I am specifically impressed
    by what you did for "async" that allows the callers not to worry
    about threads and processes) aroundt this area.  That is
    obviously a mid- to longer term goal.

Thanks for working together well, you two.
