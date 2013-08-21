From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Wed, 21 Aug 2013 23:52:15 +0200
Message-ID: <vpqr4dm67ao.fsf@anie.imag.fr>
References: <5214F816.3010303@googlemail.com>
	<1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
	<xmqqfvu2u5io.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com, pclouds@gmail.com,
	iveqy@iveqy.com, mackyle@gmail.com, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 23:52:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCGKX-0001LV-GM
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 23:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab3HUVwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 17:52:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49194 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3HUVwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 17:52:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7LLqDsg031982
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 23:52:13 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VCGK7-00026Z-JK; Wed, 21 Aug 2013 23:52:15 +0200
In-Reply-To: <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 21 Aug 2013 13:56:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Aug 2013 23:52:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7LLqDsg031982
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377726737.89712@LxwxdDd6SSI0MSb92hzK6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232740>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> The motivation of this patch is to get closer to a goal of being
>> able to have a core subset of git functionality built in to git.
>> That would mean
>>
>>  * people on Windows could get a copy of at least the core parts
>>    of Git without having to install a Unix-style shell
>>
>>  * people deploying to servers don't have to rewrite the #! line
>>    or worry about the PATH and quality of installed POSIX
>>    utilities, if they are only using the built-in part written
>>    in C
>
> I am not sure what is meant by the latter.  Rewriting #! is part of
> any scripted Porcelain done by the top-level Makefile, and I do not
> think we have seen any problem reports on it.

I think the case of a server with exotic OS and totally broken /bin/sh
would also benefit from this (the user won't have to find a non-broken
sh and point SHELL_PATH to it). I have no concrete example though.

>> +		size_t len = strlen(e->d_name) - strlen(".pack");
>
> decl-after-stmt.

Stefan: you can make sure this does not happen again by adding

CFLAGS += -Wdeclaration-after-statement

in config.mak.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
