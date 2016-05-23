From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Mon, 23 May 2016 11:52:37 -0700
Message-ID: <xmqqeg8sa9oq.fsf@gitster.mtv.corp.google.com>
References: <nhlqd4$ekr$1@ger.gmane.org>
	<c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
	<c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
	<ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
	<xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
	<xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605231310190.4122@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 23 20:52:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4uy6-0003og-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbcEWSwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:52:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751310AbcEWSwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:52:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CB291CCBC;
	Mon, 23 May 2016 14:52:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ax0CwHnFkFdXbuKOryK5CeVl410=; b=EF7iwq
	LWGTu8YyPVzelzu9thAfczPd1UN9KtYaync5lZTFB5HgxWSppQ+6l8ugA2nGY+Po
	630tP+xfVZVGNVSWQa3Q1rCaBanKunX0yEo1/kxCYV8Nmx6kktX7CRNTjV5zE6NI
	KH5Yi3vrnP/Ez2rE/QDdtoZPHxmVxrY0cbLaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWGh/4k0R0ANGvtQlMiJ/FiRjwrD0KAN
	T64DfhE88zQv4PTo1IMSctQ/WSEjRSnSWNUPxEiHj2biNn1el4v7gOoKNWezKFHb
	2mus5iLw7OZIX8FldYAOvrqUy3aboq5fc+kp/956hdGi4rSnaPh0DdehYaOCAU7o
	jOAfjwJe7eo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 854791CCBB;
	Mon, 23 May 2016 14:52:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAC511CCBA;
	Mon, 23 May 2016 14:52:39 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605231310190.4122@virtualbox> (Johannes
	Schindelin's message of "Mon, 23 May 2016 13:12:07 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8622FD16-2117-11E6-A03C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295349>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Of course, if you are doing network mount between systems with and
>> without filemode support, the result would depend on where you did
>> the "git init", so that would not help.
>> 
>> Which means that other probed things like symlink support and case
>> sensitivity are likely to be wrong in the .git/config that the user
>> may want to fix.
>
> What we could do is to make the default config setting platform-dependent,
> a la CRLF_NATIVE.
>
> I imagine that we would want this for core.filemode, core.ignorecase and
> core.symlinks.
>
> What do you think?

The reason why we probe for filemode, icase, etc. at repository
creation time and record the result in the configuration is because
we do not to want to do the auto-probing at runtime, every time we
run any Git command.  You may be able to say "On this platform, no
matter what filesystem is in use, you will always get icase and you
will never have executable bit", and a build on such a platform can
hardcode these three values.  But on other platforms these may be
per-filesystem properties, and their binaries would not be able to
hardcode the choices, which would mean we would record these three
in .git/config on these platforms when a repository is created.

Git built for Windows may have core.filemode=false as "the default
config setting platform-dependent, a la CRLF_NATIVE"; how would that
interact with a configured core.filemode value in .git/config?

If a repository that is initialized on a non Windows system is
network mounted or rsynced and made available on Windows, its
.git/config would record values that are suitable for the origin
platform (and the filesystem the repository was originally on).  On
Windows where you can declare "no case sensitivity, no symlink and
no executable bits", a solution would be to ignore these three
configurable values and always use hardcoded values.  Everything
would work without the end user even having to know what is going
on.

But that would not be a good approach other platforms can follow to
solve the same issue.  A repository created on ext4 may be rsynced
into a case sensitive HFS+ or a case insensitive one.  MacOS X side
needs to have some way to tell what value for core.ignorecase to use
between these two cases, as its binary cannot hardcode "no case
sensitivity".

So,... I am not enthused.
