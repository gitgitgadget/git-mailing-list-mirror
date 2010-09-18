From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Sat, 18 Sep 2010 21:26:29 +0200
Message-ID: <vpq8w2yvonu.fsf@bauges.imag.fr>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<000c991c7a0673e26ee3ecc19ea3c8a7b437fecf.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sat Sep 18 21:28:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox34r-0005Gh-9Y
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 21:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408Ab0IRT1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 15:27:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36959 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757393Ab0IRT1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 15:27:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o8IJDiAR006485
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Sep 2010 21:13:44 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ox33O-0007u2-0i; Sat, 18 Sep 2010 21:26:30 +0200
In-Reply-To: <000c991c7a0673e26ee3ecc19ea3c8a7b437fecf.1284830388.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Sat\, 18 Sep 2010 21\:25\:05 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 18 Sep 2010 21:13:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8IJDiAR006485
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285442028.4832@mKBKjLzBp5gB2Tjc4w7JoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156472>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> Subject: Re: [PATCH 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks

We try to keep the subject lines short (<80 chars, and as much as
possible less so that "git log --oneline" be pretty).

How about

blame,cat-file: add failing tests for --textconv on symlinks

> Because as described in previous patch - it should not.

Since the actual problem is exhibited here, I think it is the best
place to actually describe it.

> +test_expect_success 'make another new commit' '
> +	echo "bin: test number 2" >three.bin &&
> +	echo "bin: test number 2 version 2" >>three.bin &&
> +	echo "bin: test number 2 version 3" >>three.bin &&
> +	echo "bin: test number 3" >>three.bin &&

cat >three.bin <<EOF
bin: test number 2
bin: test number 2 version 2
bin: test number 2 version 3
bin: test number 3
EOF

?

> +cat >expected <<EOF
> +(Number1 2010-01-01 18:00:00 +0000 1) converted: test number 2
> +(Number2 2010-01-01 20:00:00 +0000 2) converted: test number 2 version 2
> +(Number3 2010-01-01 22:00:00 +0000 3) converted: test number 2 version 3
> +(Number4 2010-01-01 23:00:00 +0000 4) converted: test number 3
> +EOF

These days, it's recommanded to put this kind of code within the
test_expect_success/test_expect_failure.

> +
> +echo -n "one.bin" >expected

echo -n is not very portable (and doesn't seem to be used in git's t/
directory). Better use

printf "%s" "one.bin" >expected

(again, within text_expect_failure if possible)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
