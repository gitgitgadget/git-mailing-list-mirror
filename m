From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Sat, 28 Jun 2014 08:01:52 +0200
Message-ID: <vpqy4whshbj.fsf@anie.imag.fr>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-6-git-send-email-tanayabh@gmail.com>
	<CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
	<53AC6A7B.3040602@gmail.com> <vpqr42afty5.fsf@anie.imag.fr>
	<53ADA26E.8030801@gmail.com> <vpqmwcyw47q.fsf@anie.imag.fr>
	<53AE50A9.6010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 08:02:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0li7-00049n-1W
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 08:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbaF1GB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 02:01:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47326 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbaF1GB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 02:01:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5S61qAa017486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jun 2014 08:01:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5S61qDH002476;
	Sat, 28 Jun 2014 08:01:52 +0200
In-Reply-To: <53AE50A9.6010707@gmail.com> (Karsten Blees's message of "Sat, 28
	Jun 2014 07:20:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 28 Jun 2014 08:01:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5S61qAa017486
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404540113.39059@Athvuokbm2DJ9JJzSrKDOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252598>

Karsten Blees <karsten.blees@gmail.com> writes:

> I still don't like that the invalidation is done in git_config_set, though, as
> this is also used to write completely unrelated files.

I don't get it. It is used to write the config files. Yes, we trigger a
complete reload instead of just changing this particular value in the
hashmap, but I do not see "unrelated files" in the picture.

> Wouldn't it be better to have a 'git_config_refresh()' that could be
> used in place of (or before) current 'git_config(callback)' calls? The
> initial implementation could just invalidate the config cache. If
> there's time and energy to spare, a more advanced version could first
> check if any of the involved config files has changed.

That would not change the "xstrdup" vs "no xstrdup" issue, right?

> The xstrdup() problem could be solved by interning strings (see the
> attached patch for a trivial implementation). I.e. allocate each distinct
> string only once (and keep it allocated).

That's an option. We need to be carefull not to modify any string
in-place, but I guess that would considerably simplify memory management
for strings.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
