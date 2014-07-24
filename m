From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Thu, 24 Jul 2014 20:47:45 +0200
Message-ID: <vpqegxa386m.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>
	<53D15188.2010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:48:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAO3e-0005kH-SA
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934483AbaGXSry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:47:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35134 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934456AbaGXSrx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:47:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OIlhip012866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2014 20:47:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OIlj29009664;
	Thu, 24 Jul 2014 20:47:45 +0200
In-Reply-To: <53D15188.2010209@gmail.com> (Tanay Abhra's message of "Fri, 25
	Jul 2014 00:03:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Jul 2014 20:47:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6OIlhip012866
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406832465.64624@uS0/ZvrUgLUH/NOdZGprtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254178>

Tanay Abhra <tanayabh@gmail.com> writes:

> For core the only test failing was xfuncname vs funcname,

Being a little pessimistic: there may be other cases where the hashtable
magically gives the right order for existing tests, but that would fail
for untested use-cases.

But I can't think of any such case.

> so the situation is not as bad as you think. One course of action
> would be leave git_config() as it is, so that third party apps
> may not be broken. Provide a function like git_config_cache(),
> then rename all the git_config() calls in core to git_config_cache(),
> fallback to git_config() where it is not applicable (for example,
> git config -l).

I think Junio's point about "git config -l" is correct: we should just
keep git_config_raw there.

OTOH, renaming git_config to git_config_cache seems a lot of code churn,
so I'd keep the name git_config. Perhaps git_config_raw is no longer a
good name and it could be called git_config_ordered.

If we keep one call to git_config_raw there, then maybe we can use it
for xfuncname/funcname too, and keep the behavior unchanged.

> Also can you name any third party apps that use the git_config()
> system on which I can test the patches.

There are probably tons of. I can think of git-multimail.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
