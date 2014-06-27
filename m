From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Fri, 27 Jun 2014 21:19:05 +0200
Message-ID: <vpqmwcyw47q.fsf@anie.imag.fr>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-6-git-send-email-tanayabh@gmail.com>
	<CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
	<53AC6A7B.3040602@gmail.com> <vpqr42afty5.fsf@anie.imag.fr>
	<53ADA26E.8030801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 21:19:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0bg9-0007Lr-G1
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbaF0TTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 15:19:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:32785 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbaF0TTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 15:19:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5RJJ46W025846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Jun 2014 21:19:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5RJJ565031295;
	Fri, 27 Jun 2014 21:19:05 +0200
In-Reply-To: <53ADA26E.8030801@gmail.com> (Karsten Blees's message of "Fri, 27
	Jun 2014 18:57:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 27 Jun 2014 21:19:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5RJJ46W025846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404501548.8567@uRJSr0HYQun74fkKZ1+kXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252573>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 27.06.2014 13:55, schrieb Matthieu Moy:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>> 
>>> If for some reason a config string is accessed after config_cache_free()
>>> (which would be a bug), you won't notice if strings are xstrdup()ed (i.e. git
>>> will continue to run with some invalid configuration). This is IMO much worse
>>> than failing with segfault.
>> 
>> I disagree. In most case, continuing to use the old config value is the
>> right thing.
>> 
>> First, config_cache_free() is called whenever _any_ configuration
>> variable is set.
>
> This is illogical. An API should do the right thing, and if the
> right thing is to keep the old values, as you pointed out, then
> setting a config value shouldn't invalidate the cache (at least
> not automatically).

The reason for which setting any config value invalidates the cache is
that it is _much_ simpler to implement. Less complexity, less
corner-cases, less bugs.

>> So, setting "core.foo" also invalidates "core.bar" in
>> the cache, while a user of "core.bar" could continue working with the
>> old, unchanged value.
>
> But a user of an xstrdup()ed copy of "core.foo" would also continue
> to work with the old value.

Exactly like the current code does. Has it ever been even close to being
a problem?

What you're suggesting brings a lot more complexity in the code, and I
can't imagine a case where it would have a real benefit. So, why bother?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
