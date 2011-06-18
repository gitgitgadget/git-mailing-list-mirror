From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/3] help.c: Fix detection of custom merge strategy on
 cygwin
Date: Sat, 18 Jun 2011 18:46:16 -0400
Message-ID: <4DFD2AB8.2050907@gmail.com>
References: <4DFA65F8.5010806@ramsay1.demon.co.uk> <7v1uyth0t9.fsf@alter.siamese.dyndns.org> <4DFCD8E1.3060102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 19 00:46:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY4HZ-0003Xp-PN
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 00:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab1FRWqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 18:46:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50566 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab1FRWqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 18:46:19 -0400
Received: by qwk3 with SMTP id 3so372744qwk.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Ymb28RxQDrfkiv/ugQe3RA+Sn1OlRrrM5rkTppLTn1s=;
        b=UMLkWZAnaZlgbIhBxaDD+fDdI/aXSXaMB6TEIS1vLsxXBVQWxC87DCJA65wZWTkgsQ
         tCz4n8b7I+/8RaVSykIrT/KiXC48aibIvO5dqxlA+l2a5bYCXgqNI/vWZAxjuFvEMa37
         PWoqgJC03l97+EFRXLH/PGr4MAHWERLwYY55o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=Y0KgYif28/84bqGQ6JjnjQvR0aoVzhxPqZ8eQ5MFgV7z2/yENUxP174tCyH4532zG2
         fria5hwFDibakvD8bkDoaWnfIDeET6AmgUIImkVvOzOuU5rPM61WLrEIToOi1usyatSO
         XaMPPwYBTfuVTmaynIM+E0czuEq9RcFtVWrjA=
Received: by 10.224.104.141 with SMTP id p13mr2982433qao.128.1308437178522;
        Sat, 18 Jun 2011 15:46:18 -0700 (PDT)
Received: from mark-laptop.lan (pool-96-240-137-121.washdc.fios.verizon.net [96.240.137.121])
        by mx.google.com with ESMTPS id u15sm2966043qcq.24.2011.06.18.15.46.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 15:46:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b2 Thunderbird/3.1.10
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4DFCD8E1.3060102@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175993>

On 06/18/2011 12:57 PM, Ramsay Jones wrote:
>
> Anyway, if you don't mind executing the "WIN32 code block" unnecessarily
> on cygwin (I don't think it would be too expensive) then we could simply
> reduce the patch to:
>
> -#ifdef WIN32
> +#if defined(WIN32) || defined(__CYGWIN__)
>   {	/* cannot trust the executable bit, peek into the file instead */
>
> (I've simply typed the above in my MUA, so not tested, obviously!)
>
> This is exactly what Johannes proposed last year. :)
>
> ATB,
> Ramsay Jones
>

Please, no. Cygwin's git is already slow enough, and adding yet another 
peek into a file *after* cygwin already did that is just making it worse.

(Muttering to self: Cygwin's goal is to replicate Linux / Posix behavior 
under Windows, why did git ever adopt code to make cygwin more like 
Windows rather than just treating cygwin as another Posix'y environment? 
Those who want more speed really should just be using the native win32 
port and deal with the lack of file modes, crlf issues, etc.)

Mark
