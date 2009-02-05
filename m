From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: fix misdetection of relative pathnames
Date: Thu, 05 Feb 2009 13:27:07 +0100
Message-ID: <498ADB1B.7030300@viscovery.net>
References: <4985E8E1.90303@gmail.com> <7vhc39guv2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, Steffen Prohaska <prohaska@zib.de>,
	Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 13:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV3LW-0004CO-Dw
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 13:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbZBEM1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 07:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZBEM1P
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 07:27:15 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16429 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbZBEM1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 07:27:14 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LV3Jz-0002dx-UY; Thu, 05 Feb 2009 13:27:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9B8AB69F; Thu,  5 Feb 2009 13:27:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vhc39guv2.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108553>

Junio C Hamano schrieb:
> -ifeq ($(abspath $(template_dir)),$(template_dir))
> +ifneq ($(filter /%,$(firstword $(template_dir))),)

> -ifeq ($(abspath $(gitexecdir)),$(gitexecdir))
> +ifneq ($(filter /%,$(firstword $(gitexecdir))),)

No, this does not work on Windows for the use-case that this check is
intended for, namely when the user specifies an *absolute* path for
gitexecdir and/or template_dir in config.mak [*].

Neither does the version that uses $(abspath ...)! Because $(abspath ...)
does not work in our msysgit environment (that has GNU make 3.79.1).

That said, I don't think it's worth to cater for this use-case, precisely
because we want to *avoid* absolute paths on Windows anyway, and apply the
change that you proposed here.

[*] The reason it does not work is that we cannot use MSYS-style absolute
paths /c/Foo/Bar because the paths will be interpreted by git, which does
not understand them; the user must specify drive-letter absolute paths
c:/Foo/Bar, but the check does not catch them.

-- Hannes
