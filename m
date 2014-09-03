From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Wed, 03 Sep 2014 08:27:59 +0200
Message-ID: <5406B4EF.3050301@kdbg.org>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonas 'Sortie' Termansen <sortie@maxsi.org>,
	Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 08:28:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP439-00069a-MY
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 08:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbaICG2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 02:28:07 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:5257 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753760AbaICG2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 02:28:06 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DBD42130087;
	Wed,  3 Sep 2014 08:28:01 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6063319F49E;
	Wed,  3 Sep 2014 08:28:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256381>

Am 03.09.2014 00:06, schrieb Junio C Hamano:
> * jt/timer-settime (2014-08-29) 9 commits
>  - use timer_settime() for new platforms
>  - autoconf: check for timer_settime()
>  - autoconf: check for struct itimerspec
>  - autoconf: check for struct sigevent
>  - autoconf: check for struct timespec
>  - autoconf: check for timer_t
>  - autoconf: check for setitimer()
>  - autoconf: check for struct itimerval
>  - git-compat-util.h: add missing semicolon after struct itimerval
> 
>  Need a rerolled one.

Yes. Please mark the MinGW build as not having timer_settime. Better
yet, implement it in compat/mingw.c to replace its setitimer()
implementation.

As a bug report, currently, I get

    CC progress.o
progress.c: In function 'set_progress_signal':
progress.c:66: error: 'CLOCK_MONOTONIC' undeclared (first use in this
function)

even though I have NO_TIMER_SETTIME set in my config.mak (but no other
of new configuration options that this series introduces).

But IMHO, this topic goes in a wrong direction. "Avoid deprecated
interfaces" is way overrated. It would be preferable (IMHO) to implement
setitimer() in compat/ for systems that don't have it.

-- Hannes
