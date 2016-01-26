From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/19] mingw: do not bother to test funny file names
Date: Tue, 26 Jan 2016 12:24:32 -0800
Message-ID: <xmqq1t94ccn3.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
	<47914e4ceb3ea51636dd5ae308679c9c92fcbef0.1453818790.git.johannes.schindelin@gmx.de>
	<CAPig+cQXVwfyaEzf9fR2tFNon-Jq93iPCMwW9gsB8BnUVv5p3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:25:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOAAO-00043H-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 21:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbcAZUYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 15:24:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750756AbcAZUYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 15:24:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8C223F6D6;
	Tue, 26 Jan 2016 15:24:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqyPypnk+j9MY0FZ9aRzlK+DnSY=; b=g8S+D9
	kkhFeRDimG0jRG13oCDuL0j90TVt2AT9jMGA2pj8DLzFlpW0qPze5QUc2abgvEMi
	mgagua6rO8uD3LTs7TcJ0OLnbrupeUAjuHz5xEOMG4kldCf91mfsx0cQjikjF/Xp
	g+smuEhiQocwLDUXuSCcKdxI5jkN/ywywk7xY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUBqxH0X2WiQjhBozLqhqnkIG77JRDot
	ctX0l5S6ZjKXpi+QInzzqAgeFG+pwofFdCekhgEqRltCGARwHs3zPAwG4LJT9IL1
	yyEqOu7qXet/hLphW8HUx34qXsm5hHerz2hfB/gFB/Etx/9CGxE+OD2sckO6tJNf
	CSrF7UmCvZ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A053E3F6D5;
	Tue, 26 Jan 2016 15:24:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1573C3F6D4;
	Tue, 26 Jan 2016 15:24:34 -0500 (EST)
In-Reply-To: <CAPig+cQXVwfyaEzf9fR2tFNon-Jq93iPCMwW9gsB8BnUVv5p3A@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 26 Jan 2016 15:03:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D010C32C-C46A-11E5-BE49-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284852>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +if ! test_have_prereq MINGW && touch -- 'tab   embedded' 'newline
>> [...]
>> +test_have_prereq !MINGW &&
>
> Where negation is concerned, is there a non-obvious reason that this
> patch sometimes says:
>
>     ! test_have_prereq MINGW
>
> and sometimes:
>
>     test_have_prereq !MINGW
>
> ? Is one form preferred over the other?

The latter may be preferrable as it can be extended more easily,
e.g.

	test_have_prereq !MINGW,SANITY

without having to cascade "&& test_have_prereq ANOTHER_PREREQ" in a
verbose way.

It is a minor thing that is not worth bothering to "fix" from one to
the other style once it is committed to my tree, but it may be worth
sticking to one style in new code.
