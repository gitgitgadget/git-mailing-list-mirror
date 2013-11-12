From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Tue, 12 Nov 2013 15:54:28 -0800
Message-ID: <xmqqob5pfa6j.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
	<CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
	<5281DB46.2010004@bbn.com> <5282977b2ecd_3b98795e785e@nysa.notmuch>
	<xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 00:54:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgNnF-000311-P5
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 00:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722Ab3KLXyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 18:54:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169Ab3KLXyb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 18:54:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A32155273A;
	Tue, 12 Nov 2013 18:54:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VYwa4tSJi1XIYd2CKIkJNFoc17M=; b=yc5QN/
	1tf17o7L8fC3u+z1wDF/8RgmPnVxa46lA0BdUh09ho/2oCn4+a3oK9fFfsKgFrn0
	eXtzc0+YjXHSaXhlKNAFmLvqwqzLngilMj7zXBQ1poOcoDCTo/finZ1HNmue/kky
	tKMGUYN+k311TVM/saOm+Qrbbj2WaQwi5FHV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNOxaoPwvXYykeqjnU8J8TzQZBHEgwsi
	qx6FWb64r9MBMQ5HS5KucODagLRUh05t/aXVlU+6pIDPiuStxEp0TQOYKUfnnuZj
	eYKoK181xcyllH4gKah1NyGWLujJvxKqZaxkrYzjxz47Vj+wev5jGDb2C44kdWIO
	wcQokaQr/Gk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93F1F52739;
	Tue, 12 Nov 2013 18:54:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D741552735;
	Tue, 12 Nov 2013 18:54:29 -0500 (EST)
In-Reply-To: <xmqq38n1guo8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Nov 2013 13:46:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C535316C-4BF5-11E3-BDBE-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237765>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Does it?
>>
>>  % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
>>  % git fetch origin master
>>  From /home/felipec/dev/git
>>   * branch            master     -> FETCH_HEAD
>>   * [new branch]      master     -> refs/remotes-test/origin/master
>>
>> In this case remote.origin.fetch is determining how to translate ref names, not
>> what gets transferred, *exactly* the same as we are doing with --refspec. And
>> as far as I know, remote.origin.fetch is a refspec.
>
> If you had 'next' and 'pu' branches at the remote, do they get
> fetched with that command line?

More interestingly, if you have

	[remote "mothership"]
		push = +refs/heads/*:refs/remotes/satellite/*

in your configuration and then said

	$ git push mothership master

then configured remote.mothership.push is not even used (I bring
this up because "export" is more closely related to "push" than
"fetch").

This (and why 'next' and 'pu' are not fetched in the "fetch"
example) is because traditionally, refspecs that are explicitly
given on the command line overrides configured ones (in other words,
configured ones are used as a fallback default).

This is a bit of tangent, but since the recent discussion on the
triangular workflows, I've been wondering if we may want to have a
new way to configure things so that we can say "When I push to
mothership any one of my local branches, I want it to go to the ref
with the same name at the mothership under refs/remotes/satellite/
hierarchy (because I am emulating 'git fetch' that is run on the
mothership to get updates from this satellite)", somewhat similar to
what you added to "fast-export" via the option in question.

But we cannot achieve that mapping by changing the meaning of the
configured refspecs remote.mothership.push without having to worry
about breaking existing practices of people.  When they say "git
push mothership master", they do mean to push refs/heads/master to
refs/heads/master, and it will break the expectation in their
existing repositories if we change the semantics under them.

A possible way to achieve that mapping "When I push to mothership
any one of my local branches,..." could be to introduce a _new_
configuration (so that existing repositories will not suddenly
change their behaviour):

	[remote "mothership"]
		pushmap = +refs/heads/*:refs/remotes/satellite/*

And then we can allow this command line

	$ git push mothership master

to be affected by the mapping when expanding the short-hand refspecs
given on the command line.  Traditionally, anything without colon
stood as a short-hand for "push to the same name", e.g. 'master' is
for 'refs/heads/master:refs/heads/master' in this example, and
'v1.0' would be for 'refs/tags/v1.0:refs/tags/v1.0'.

But it does not have to stay that way.  In order to move things
forward in that direction, this new configuration has to be
distinguishable from the traditional "refspec", as it embodies a
different concept.
