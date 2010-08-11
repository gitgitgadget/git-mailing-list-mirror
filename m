From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Add global and system-wide gitattributes
Date: Wed, 11 Aug 2010 14:31:16 +0200
Message-ID: <vpq39uluy97.fsf@bauges.imag.fr>
References: <1281488646-7108-1-git-send-email-gsvick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Henrik Grubbstrm <grubba@grubba.org>
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 14:35:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjAWR-0003Eu-Ea
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 14:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab0HKMev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 08:34:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:54857 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab0HKMeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 08:34:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7BCVGot017908
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 14:31:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OjASi-000565-Qu; Wed, 11 Aug 2010 14:31:16 +0200
In-Reply-To: <1281488646-7108-1-git-send-email-gsvick@gmail.com> (Petr Onderka's message of "Wed\, 11 Aug 2010 01\:04\:06 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 11 Aug 2010 14:31:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153231>

Petr Onderka <gsvick@gmail.com> writes:

> Allow gitattributes to be set globally and system wide in ~/.giattributes
> and $(prefix)/etc/gitattributes files, respectively. This way, settings
> for particular file types can be set in one place and apply for all user's
> repositories.

The feature is definitely useful, and I'll use it as soon as it gets
into git.git ;-).

One point: we need to make sure the choice for the the user-wide
filename is the right one, since it's a pain to change it later.

We already have ~/.gitconfig, which often points to ~/.gitexcludes or
~/.gitignored (but this filename is specified with a config variable,
for which we didn't manage to agree on a default value). We're about
to add ~/.gitattributes. That makes 3 ~/.git* files, and I think it's
time to make it a directory (similar to $GIT_DIR/info/)

I think it should be done like this:

1) Default core.excludesfile to $CONF/exclude

2) Make your user-wide gitattribute $CONF/attributes

3) Optionally, read $CONF/config as well as ~/.gitconfig so that
   people can have all their git configuration in the same directory.

Now, we need to agree on $CONF. Some non-options are:

* CONF=~/.gitconfig would clash with the file ~/.gitconfig

* CONF=~/.git would prevent people from versionning their $HOME.

I'd be in favor of following the freedesktop standard (roughly,
defaulting to ~/.config/git):

  http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

because other applications start using it, and it allows one to easily
keep the configuration in a (typically git-versionned) ~/.config
directory. And if we are to choose a config directory, it doesn't harm
to chose one consistant with other applications and with a standard.

I never got time to implement this. If you're willing to do something
like that, that would be great. If not, I'd suggest having a config
variable to point to the user-wide gitattributes file (without a
default value), because it allows a future transition by giving a
default value to the variable.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
