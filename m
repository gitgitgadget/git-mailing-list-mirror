From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Thu, 05 May 2011 09:17:42 -0700
Message-ID: <7vy62l9l5l.fsf@alter.siamese.dyndns.org>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net> <7v4o5afht7.fsf@alter.siamese.dyndns.org>
 <7vwri5c27e.fsf@alter.siamese.dyndns.org> <4DC23C80.6020401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <kornet@camk.edu.pl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 05 18:18:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1Fb-00089a-06
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab1EEQRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:17:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1EEQRy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:17:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02BA952D2;
	Thu,  5 May 2011 12:19:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kZjcKRVHwDVbtOO2pDaq1aeOlto=; b=fDzl5i
	3DmU7s5JlQr178mr7245A4t4X09tBK4fQLjASmXVnvvEhr+sqQCrg6/wPwiQY9CF
	+OlucdZaNO2B3fASVfW5nD0nzPsrc3A2bmzA7DoAeBRjKWNO+dPJJChHRov8Ervn
	kK1XmFoGwWgIeCGr33yXOF5cqLQQzGWsGOLVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6ZbElmh5ZlAV0RGGm8eIZBBvZn9e7eR
	O/Q4xvKBR4pVR6Adf0oVuHvzAVFQuxy5glum8IFJrKwAu6R1JnmHKvVkTUnY7k8S
	8KGrrGTGDnjfYX5L6Hf2G15M2LovDlrEzQbEcNgq8Tjq4Pd/dBG45hrKlzo4otfB
	HPylS5/NuPI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C636D52D1;
	Thu,  5 May 2011 12:19:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A4BB852C3; Thu,  5 May 2011
 12:19:48 -0400 (EDT)
In-Reply-To: <4DC23C80.6020401@viscovery.net> (Johannes Sixt's message of
 "Thu, 05 May 2011 07:58:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81E34A82-7733-11E0-B91D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172844>

Johannes Sixt <j.sixt@viscovery.net> writes:

> No, that's not sufficient. Notice that $(sysconfdir) is used for ETC_GIT*
> variables *only* if $(prefix) == /usr (both before and after Kacper's
> patch). Therefore, you won't gain a lot of configurability via sysconfdir;
> you have to change ETC_GIT* variables directly.

Huh?  You lost me.

The point of this approach is to make a progress without regressing, and
the (minimum) progress needed to be made that comes from the beginning of
this discussion is that setting $(prefix) from the command line of make
works but it does not when it is set in config.mak (or config.mak.autogen
which in turn is added by running "./configure --prefix=...").

As the "relocatable installation" topic wants to make everything relative
to prefix, I do not know if it is even worth trying to support a build
that has prefix set to anything other than /usr to set ETC_GIT* variables
to an arbitrary absolute path via --sysconfdir. I suspect that would
defeat the whole "relocatable" concept. More importantly, since I do not
care too much about "relocatable", I do not want to even have to worry
about it.

So the only thing my suggested approach tries to fix on top of Kacper's
patch is not to regress use of "sysconfdir = /some/where" when prefix is
set to /usr.

If you really care about being able to use sysconfdir together with the
relocate logic, I think you first have to rethink "if $(prefix) == /usr"
and change it into a new "RELOCATABLE_GIT = YesPlease/NoThanks".  After
all, even when you set prefix to /usr/local, you may want the installed
binaries know where to look without the "let's find everything relative
to /usr/local/bin/git" logic.
