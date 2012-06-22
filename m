From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/4 v8] Git configuration directory
Date: Fri, 22 Jun 2012 11:03:22 +0200
Message-ID: <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
Cc: Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 22 11:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShzmM-00089Z-H5
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 11:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761760Ab2FVJDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 05:03:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60530 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761753Ab2FVJDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 05:03:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5M9353H001326
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 11:03:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Shzm8-0003gV-4s; Fri, 22 Jun 2012 11:03:32 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Shzm8-0001nn-1o; Fri, 22 Jun 2012 11:03:32 +0200
X-Mailer: git-send-email 1.7.11.rc3.235.gd0d1d08
In-Reply-To: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 Jun 2012 11:03:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5M9353H001326
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340960590.29192@oCSW54rDeqo3uUMeqe+M3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200424>

This is a resend of a serie already discussed here:

  http://thread.gmane.org/gmane.comp.version-control.git/198837

I took the liberty of rewording the commit messages, and change a few
words in the documentation (changed some "will be used" to "is used
instead", which sounded more consistant with the context).

A reminder of the context and objectives of the serie:

Git currently stores its configuration file in ~/.gitconfig, which is
nice and customary on Unix, as long as one has only one configuration
file.

But a typical user may want to store not only the config file, but
also the files pointed to by core.excludesfile and
core.attributesfile, which currently have no default values. To store
several configuration files, it makes sense to have a configuration
_directory_ instead of a set of configuration files, all right into
$HOME. Calling this configuration directory ~/.git or ~/.gitconfig is
not an option, since these paths already have another meaning. Using
the XDG specification (in short: ~/.config/git) doesn't have this
drawback, and allows the user to store his configuration files right
next to files from other applications following the XDG standard.

The first 3 patches add read support for this "configuration
directory", and the last one gives opt-in write support, allowing
users to make this "configuration directory" their way of life, and
never hear again about ~/.gitconfig if (and only if) they do not want to.

None of the patches change the behavior for people who do not create
the new configuration files.

Huynh Khoi Nguyen Nguyen (4):
  config: read (but not write) from $XDG_CONFIG_HOME/git/config file
  Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
  Let core.attributesfile default to $XDG_CONFIG_HOME/git/ignore
  config: write to $XDG_CONFIG_HOME/git/config file if appropriate

 Documentation/config.txt        |   8 +-
 Documentation/git-config.txt    |  15 +++-
 Documentation/gitattributes.txt |   2 +
 Documentation/gitignore.txt     |   4 +-
 attr.c                          |  17 +++--
 builtin/config.c                |  25 ++++---
 cache.h                         |   3 +
 config.c                        |  23 +++---
 dir.c                           |   7 +-
 path.c                          |  41 +++++++++++
 t/t1306-xdg-files.sh            | 158 ++++++++++++++++++++++++++++++++++++++++
 11 files changed, 270 insertions(+), 33 deletions(-)
 create mode 100755 t/t1306-xdg-files.sh

-- 
1.7.11.rc3.235.gd0d1d08
