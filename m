From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Introduce the GIT_HOME environment variable
Date: Sat, 19 Dec 2009 18:10:41 +0100
Message-ID: <vpqeimq51pq.fsf@bauges.imag.fr>
References: <4B2C0828.4010505@signalbeam.net>
	<20091219013246.GD25474@genesis.frugalware.org>
	<7vhbrnodd9.fsf@alter.siamese.dyndns.org>
	<4B2C5A1A.8000201@signalbeam.net>
	<7vzl5fik3o.fsf@alter.siamese.dyndns.org>
	<20091219153046.GG25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Moe <moe@signalbeam.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 18:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2pp-0005qX-Ep
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 18:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbZLSRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 12:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbZLSRLM
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 12:11:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51501 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbZLSRLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 12:11:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nBJHAEXF000907
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 19 Dec 2009 18:10:14 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NM2pG-00077f-6r; Sat, 19 Dec 2009 18:10:42 +0100
In-Reply-To: <20091219153046.GG25474@genesis.frugalware.org> (Miklos Vajna's message of "Sat\, 19 Dec 2009 16\:30\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 19 Dec 2009 18:10:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nBJHAEXF000907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1261847419.09746@VX6yX/WxgqS+19NruOP6SQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135495>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Honor $GIT_HOME that is favoured over $HOME,

I'd personally prefer obeying $XDG_CONFIG_HOME, and read
$XDG_CONFIG_HOME/git/config (defaulting to $HOME/.config/git/config)
or something like this :

http://standards.freedesktop.org/basedir-spec/basedir-spec-0.6.html

It solves the same problem ("set on environment variable, and change
my whole Git config"), but

* It's a standard. It's really nice to be able to

cd ~/.config
ls

to see a user's configuration for many applications at a time, and

cd ~/.config
git init

to version-control it.

* It avoids hidden files. With $GIT_CONFIG, a user doing

cd $GIT_HOME
ls

sees nothing. I understand why $HOME/something config files are
hidden, but a config file stored in a separate directory shouldn't be
hidden (just like $GIT_DIR/config is not hidden).

> -		const char *home = getenv("HOME");
> +		const char *home = getenv("GIT_HOME");
> +		if (!home)
> +			home = getenv("HOME");

If you go this way, why not define

const char *getenv_home()
{
	const char *home = getenv("GIT_HOME");
	if (!home)
		home = getenv("HOME");
	return home;
}

?

(probably in git-compat-util.h)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
