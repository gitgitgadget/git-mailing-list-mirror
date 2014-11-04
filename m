From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Tue, 04 Nov 2014 21:22:10 +0100
Message-ID: <54593572.3080805@web.de>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>	<xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>	<5457E7DF.5070500@web.de>	<xmqqbnooq863.fsf@gitster.dls.corp.google.com>	<87k33bao7w.fsf@steelpick.2x.cz> <xmqq7fzbriew.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:22:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlkcT-00025C-HE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 21:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbaKDUWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Nov 2014 15:22:22 -0500
Received: from mout.web.de ([212.227.17.11]:61196 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbaKDUWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 15:22:21 -0500
Received: from [192.168.178.41] ([79.211.99.175]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Ljrq1-1YIcSl0ZnV-00bunw; Tue, 04 Nov 2014 21:22:14
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq7fzbriew.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:+wdqXOgjd4JTA8iqTdp856Td3QIKaPfRBJXbULq23HiJHBp1L4Z
 dSa59sB8OR615Z/XPQJ6gGLHS5Oz4KxEl7PMXoA+vNpFzGcpNsDP+sLlzVKHI8Ya7usx2iW
 Gv2V5IrvZcCiiGkN9PKUwuyMNXpzaJeW5yVEq5zxKx5j+rSOxcoN/rsxcqWu8DeFRx7C38z
 wNxED1XIeqi9gP68kXXHg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.11.2014 um 00:08 schrieb Junio C Hamano:
> Michal Sojka <sojkam1@fel.cvut.cz> writes:
>>> Or something perhaps?  Or the detailed description of
>>> submodule.$name.update should be dropped from here and refer the
>>> reader to config.txt instead?
>>
>> I guess you mean gitmodules.txt.
>
> Actually, I do mean the configuration.  .gitmodules is just a
> template to help the user populate .git/config, and the latter of
> which should be the sole source of truth.  This is an important
> principle, and it becomes even more important once we start talking
> about security sensitive possiblity like allowing !command as the
> value.

Not quite. You're definitely right about the !command value for
the 'update' setting; this should never be taken from .gitmodules
but only from .git/config. But apart from that following this
principle would hurt submodule users a lot. The only thing that
should be set in stone in .git/config is the 'url' setting,
because an older url might not even exist anmore. But e.g. the
'branch' setting must be taken from .gitmodules. Otherwise we
could not change it on a per-superproject-branch basis. And if
the 'path' setting would only be taken from .git/config instead
of .gitmodules, we wouldn't even be able to rename submodules
(which is exactly what this setting was added for in the first
place). The same applies to 'ignore' and 'fetch'.

So I believe that gitmodules.txt should describe all =C4=87onfig
options that can be provided by upstream (and e.g. mention that
the 'url' and 'update' values are copied into .git/config on
init), while all settings that can be overridden locally should
be documented in config.txt (which will be a subset of those
documented in gitmodules.txt).

>> The `!command` form is not documented in gitmodules.txt. Maybe it wo=
uld
>> be best to fully document .update in gitmodules.txt and just refer t=
o
>> there. Having documentation at two places seems to be confusing not =
only
>> for users, but also for those who send patches :)
>>
>> I'm no longer able to formulate my proposal properly as a patch toni=
ght,
>> but if needed I'll try it later.
>
> That is fine.  People have lived with the current text for more than
> two years without problems, so we are obviously not in a hurry.

Yup.
