From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Thu, 28 Aug 2014 17:21:31 +0200
Message-ID: <7AD881F3-DDD0-4094-90F3-C3E2F81DF664@zib.de>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de> <1409066605-4851-3-git-send-email-prohaska@zib.de> <20140826182125.GC17546@peff.net> <xmqq38cjhuje.fsf@gitster.dls.corp.google.com> <20140826203158.GA30651@peff.net> <xmqq38cihq7w.fsf@gitster.dls.corp.google.com> <20140827044621.GA32141@peff.net> <xmqqtx4yf0r2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:22:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN1Wi-0003FW-ER
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 17:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaH1PWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 11:22:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:61358 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbaH1PWK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 11:22:10 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7SFLdHK012007;
	Thu, 28 Aug 2014 17:21:39 +0200 (CEST)
Received: from [192.168.1.200] (ip5f5bd082.dynamic.kabel-deutschland.de [95.91.208.130] (may be forged))
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7SFLaen011993
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2014 17:21:37 +0200 (CEST)
In-Reply-To: <xmqqtx4yf0r2.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53FF4903.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FF4903.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FF4903.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256096>


On Aug 27, 2014, at 4:47 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Aug 26, 2014 at 02:54:11PM -0700, Junio C Hamano wrote:
>> 
>>> A worse position is to have git_env_bool() that says "empty is
>>> false" and add a new git_env_ulong() that says "empty is unset".
>>> 
>>> We should pick one or the other and use it for both.
>> 
>> Yeah, I agree they should probably behave the same.
>> 
>>>> The middle ground would be to die(). That does not seem super-friendly, but
>>>> then we would also die with GIT_SMART_HTTP=foobar, so perhaps it is not
>>>> unreasonable to just consider it a syntax error.
>>> 
>>> Hmm, I am not sure if dying is better.  Unless we decide to make
>>> empty string no longer false everywhere and warn now and then later
>>> die as part of a 3.0 transition plan or something, that is.
>> 
>> I think it is better in the sense that while it may be unexpected, it
>> does not unexpectedly do something that the user cannot easily undo.
>> 
>> I really do not think this topic is worth the effort of a long-term
>> deprecation scheme (which I agree _is_ required for a change to the
>> config behavior). Let's just leave it as-is. We've seen zero real-world
>> complaints, only my own surprise after reading the code (and Steffen's
>> patch should be tweaked to match).
> 
> OK, then let's do that at least for now and move on.

Ok.  I saw that you tweaked my patch on pu.  Maybe remove the outdated
comment above the function completely:

diff --git a/config.c b/config.c
index 87db755..010bcd0 100644
--- a/config.c
+++ b/config.c
@@ -1122,9 +1122,6 @@ int git_env_bool(const char *k, int def)
        return v ? git_config_bool(k, v) : def;
 }

-/*
- * Use default if environment variable is unset or empty string.
- */
 unsigned long git_env_ulong(const char *k, unsigned long val)
 {
        const char *v = getenv(k);

	Steffen