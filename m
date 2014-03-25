From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git push race condition?
Date: Tue, 25 Mar 2014 15:03:29 +0100
Message-ID: <vpqvbv2pe8e.fsf@anie.imag.fr>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<20140324225434.GB17080@sigill.intra.peff.net>
	<557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
	<CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nasser Grainawi <nasser@codeaurora.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 15:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRxD-0004Wc-Uu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 15:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbaCYODn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 10:03:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40038 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaCYODm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 10:03:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2PE3SZ1017016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2014 15:03:28 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2PE3Tu5028150;
	Tue, 25 Mar 2014 15:03:29 +0100
In-Reply-To: <CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
	(Scott Sandler's message of "Tue, 25 Mar 2014 09:45:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Mar 2014 15:03:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2PE3SZ1017016
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396361013.46431@U19K8Q1QO0Gfhm0C81rUcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245037>

Scott Sandler <scott.m.sandler@gmail.com> writes:

> Is there a hook or cron job that updates or gcs this repository or any
> refs? No. No cron jobs touching the repo at all, and all the hooks are
> read-only.

If you activated the reflog, you can double-check that. Running git
reflog on the server should give you something like this:

$ git reflog show master
bf40764 (HEAD, master) master@{0}: push
2c4fc6d master@{1}: push
e72211a master@{2}: push
...

It should be possible to check the reflog for non-fast forward. I don't
find an obvious way, but a script going through the sha1 list and
checking that each line is an ancestor of the previous should be easy.

I can't exclude the hypothesis of a bug in Git, but my feeling is that
there's an issue with your setup.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
