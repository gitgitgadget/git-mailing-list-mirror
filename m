From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: none
Date: Mon, 11 Apr 2016 21:18:00 +0200
Message-ID: <vpq37qsosyf.fsf@anie.imag.fr>
References: <001a11492f107354a305303a369a@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: miwilliams@google.com
X-From: git-owner@vger.kernel.org Mon Apr 11 21:18:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aphLs-0000kE-Ix
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 21:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbcDKTSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 15:18:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52216 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbcDKTST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 15:18:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3BJHwA2020608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 11 Apr 2016 21:17:58 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3BJI0S5006834;
	Mon, 11 Apr 2016 21:18:00 +0200
In-Reply-To: <001a11492f107354a305303a369a@google.com>
	(miwilliams@google.com's message of "Mon, 11 Apr 2016 19:04:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 11 Apr 2016 21:17:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3BJHwA2020608
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461007082.18903@uhBVKgNMWuOwOcogoG+Oqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291228>

miwilliams@google.com writes:

> From 7201fe08ede76e502211a781250c9a0b702a78b2 Mon Sep 17 00:00:00 2001
> From: Mike Williams <miwilliams@google.com>
> Date: Mon, 11 Apr 2016 14:18:39 -0400
> Subject: [PATCH 1/1] wt-status: Remove '!!' from
> wt_status_collect_changed_cb
>
> The wt_status_collect_changed_cb function uses an extraneous double
> negation (!!)
> when determining whether or not a submodule has new commits.

It's not just a double negation, it's a way to ensure that the value is
0 or 1 (it's a relatively common idiom in C at least in Git's codebase).

new_submodule_commits is a 1-bit bitfield, and you don't want to assign
anything other than 1 or 0 (or you'll get modulo 2^n semantics, with
n==1).

So the old code is correct and your patch would introduce a bug.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
