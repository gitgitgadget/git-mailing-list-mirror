From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] worktree: allow "-" short-hand for @{-1} in add command
Date: Fri, 27 May 2016 11:18:43 +0200
Message-ID: <vpqvb1zrh8s.fsf@anie.imag.fr>
References: <vpqshx5cb51.fsf@anie.imag.fr>
	<1464263662-1290-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<xmqqshx4vedr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 11:19:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Dv9-0006kx-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 11:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbcE0JTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 05:19:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33122 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbcE0JTB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 05:19:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4R9Ih85017425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 27 May 2016 11:18:43 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4R9IhNt003491;
	Fri, 27 May 2016 11:18:43 +0200
In-Reply-To: <xmqqshx4vedr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 May 2016 11:54:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 27 May 2016 11:18:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4R9Ih85017425
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464945525.9253@eh6WiDym3U5lrD3a3elkBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295744>

Junio C Hamano <gitster@pobox.com> writes:

> Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:
>
>> +	branch=$(cd short-hand && git rev-parse --symbolic-full-name HEAD) &&
>> +	test "$branch" = refs/heads/newbranch &&
>> +	cd ..
>
> If any of the command between "cd short-hand" and "cd .." failed,
> after correcting the broken &&-chain, the next test will end up
> running in short-hand directory, which it is not expecting.  A
> canonical way to avoid this problem is to replace the above with:
>
> 	...
>         git worktree add short-hand - &&
>         (
> 		cd short-hand &&
>                 ...
>                 test "$branch" = refs/heads/newbranch
> 	)

Actually, $(...) implicitly does a subshell, so the "cd .." was just
useless.

> 	git -C short-hand rev-parse --symbolic-full-name HEAD >actual &&

Indeed, git -C is an even better way to say "cd .. && git ..."

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
