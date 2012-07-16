From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/8] git-remote-mediawiki: get rid of O(N^2) loop
Date: Mon, 16 Jul 2012 21:31:57 +0200
Message-ID: <vpqhat7v6xe.fsf@bauges.imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
	<1342440053-3058-5-git-send-email-Matthieu.Moy@imag.fr>
	<7v394r36ws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:32:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqr1i-0002wt-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab2GPTcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:32:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60950 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab2GPTcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:32:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJU9Ve013066
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:30:09 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sqr1S-0001Kb-1B; Mon, 16 Jul 2012 21:31:58 +0200
In-Reply-To: <7v394r36ws.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 16 Jul 2012 11:19:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 21:30:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJU9Ve013066
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343071812.45926@lJL18GfkMqgwEgTylYB6ig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201553>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The algorithm to find a path from the local revision to the remote one
>> was calling "git rev-list" and parsing its output N times. Run rev-list
>> only once, and fill a hashtable with the result to optimize the body of
>> the loop.
>
> Good thinking.  I wonder if it would further reduce the overhead if
> you stop using --children and do this using --parents instead, as
> you will be reading the parsed_sha1..local range either way yourself
> anyway.

It is possible, yes. I'll resend a version with --parents, but this
probably doesn't change the performance much: what we really need is for
Git to prune dead-ends in the subgraph, to make sure we find a path
without having to backtrack (i.e. we need parent rewriting history
simplification), so Git has to do something a bit clever anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
