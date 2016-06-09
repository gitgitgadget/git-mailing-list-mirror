From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Thu, 09 Jun 2016 07:51:26 +0200
Message-ID: <vpqporqyko1.fsf@anie.imag.fr>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160607140148.23242-2-tom.russello@grenoble-inp.org>
	<xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, e@80x24.org, aaron@schrab.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 07:51:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAssc-0004xq-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 07:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423120AbcFIFvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 01:51:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55095 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934052AbcFIFvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 01:51:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u595pQBg030504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 07:51:26 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u595pQli026111;
	Thu, 9 Jun 2016 07:51:26 +0200
In-Reply-To: <xmqqziqwmqth.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Jun 2016 18:07:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 09 Jun 2016 07:51:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u595pQBg030504
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466056288.12107@DmBlNQTc35s4ASoduaJfnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296868>

Junio C Hamano <gitster@pobox.com> writes:

> Tom Russello <tom.russello@grenoble-inp.org> writes:
>
>> +# Check if two files have the same content, non-order sensitive
>> +test_cmp_noorder () {
>> +	sort $1 >$1;
>
> Here is what I think happens:
>
>     0) the shell parses this command line;
>     1) the shell notices that the output has to go to $1;
>     2) the shell does open(2) of $1,
>     3) the shell spawns "sort" with a single argument, with its
>        output connected to the file descriptor obtained in 2).
>
> Because "$1" becomes an empty file at 2), "sort" reads nothing and
> writes nothing.

Tom: in case you're not convinced, try this:

$ (echo b; echo a) >f
$ sort f
a
b
$ sort f >f
$ cat f
$

Also, useless ';' and missing double-quotes around "$1" to avoid bad
surprises ifever test_cmp_noorder is called on file names with special
characters.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
