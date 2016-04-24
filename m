From: =?UTF-8?Q?Simon_Ponti=c3=a9?= <simon@le-huit.fr>
Subject: Re: [git-multimail] smtplib, check certificate
Date: Sun, 24 Apr 2016 20:20:51 +0200
Message-ID: <571D0E83.8010400@le-huit.fr>
References: <571949D2.10507@le-huit.fr> <vpqoa92rxew.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Simon P <simon.git@le-huit.fr>
X-From: git-owner@vger.kernel.org Sun Apr 24 20:23:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auOh8-0008Vk-RD
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 20:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbcDXSXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 14:23:43 -0400
Received: from mail.gnubox.eu ([212.129.16.229]:41374 "EHLO mail.gnubox.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbcDXSXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 14:23:42 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Apr 2016 14:23:42 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.gnubox.eu (Postfix) with ESMTP id 2D8B95A6BC2;
	Sun, 24 Apr 2016 20:17:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at gnubox.info
Received: from mail.gnubox.eu ([127.0.0.1])
	by localhost (mail.gnubox.eu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e49H9gfBUO_r; Sun, 24 Apr 2016 20:16:43 +0200 (CEST)
Received: from [192.168.0.112] (85-169-145-244.rev.numericable.fr [85.169.145.244])
	by mail.gnubox.eu (Postfix) with ESMTPSA id 346F15A60B1;
	Sun, 24 Apr 2016 20:16:43 +0200 (CEST)
Openpgp: id=E0275791E6CB63F284093FAF1BC5D2ED8EDF838D
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <vpqoa92rxew.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292424>

Le 22/04/2016 08:05, Matthieu Moy a =C3=A9crit :
> Hi, and thanks for the patch.

Hi.

Thanks for your tool, it is very useful!


> Please, add your sign-off and a proper commit message to your patch,
> see:

Done, I also signed my commit via PGP.

> I'm OK with patches by email, but you may prefer using a pull-request
> (among other things, creating a pull-request triggers a Travis-CI bui=
ld
> and would have noticed the absence of sign-off and a minor PEP8 issue=
 in
> your code.

I don't like github, but I understand your requirement. I submitted a
pull-request of a modified version of the patch:
  https://github.com/git-multimail/git-multimail/pull/150
I am not a python developer and I am not a Travis-CI user, so I cannot
understand failure messages at:
  https://travis-ci.org/git-multimail/git-multimail/builds/125406555

> The patch obviously lacks documentation

I have added a description in the README file.

> and some way to test it.
> Actually, the testsuite will fail if you document the configuration
> variable and they don't appear somewhere in the testsuite. A fully
> automatic test would be hard to write, but I have a semi-automated
> testsuite for smtp: some configurations in t/*.config.in
> test-email-config to run a test with each of the configurations (then=
 I
> check my mailbox). There should be one configuration with a valid
> certificate and another with a buggy one so that we can check that th=
e
> certificate is actually checked.

I have added some test: firstly, I renamed the file `smtp-tls.config.in=
`
to `smtp-tls-nocheckcert.config.in` because this configuration do not
check the server certificate. I also added to test files:
  - `smtp-tls-checkcert-unverifiedcert.config.in`
  - `smtp-tls-checkcert-verifiedcert.config.in`

The first one (unverifiedcert) uses a fake trusted CA list to check the
unverified server certificate detection (that can be tested with the
gmail server for example).

The second one (verifiedcert), assumes that your system have a file
`/etc/ssl/certs/ca-certificates.crt` with a list of all CA trusted by
your system (this file exist in Debian systems). It should succeed with
the gmail server.

> Do you need a default for smtpcheckcert if you already have one in
> config.get(smtpcheckcert)? In any case, I'd rather avoid having two
> hardcoded path in the code. If you need
> '/etc/ssl/certs/ca-certificates.crt' in two places, please define a
> constant elsewhere in the code and use it here.

I have modified the configuration, there is now only one configuration
var: smtpCACerts. If it is empty (default), the server certificate is
not verified (like before the patch) but a warning is emitted. If the
var is set, the targeted file is used to verify the server certificate.

=46or now, only the tls configuration is supported.

Simon P.
