From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 00/48] i18n: mark core shell programs for translation
Date: Sat, 21 May 2011 18:43:41 +0000
Message-ID: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrAW-0008Tt-Mu
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab1EUSov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:44:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45234 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab1EUSou (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:44:50 -0400
Received: by ewy4 with SMTP id 4so1451059ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=/NLxQeJdyfEHgi7gReikitgDdmPPiQmCfSEVMf5a8j8=;
        b=HdG+LDCDYw35jv3XMmQKdM7TdwR8CcUr5yW4Dqb1X6R0GFYlZOah6RBsSYAlay4Wsb
         sAkF49DW4RBSrWnEZWtHgnF81cug0WKK87f05XiIbq35E2DP+abZ4me1GjbgAGlaQVxk
         ujke3/3KTs+jbChK7nXORjhy44tzEnZCOy0sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=lcHsGH6EEXVj2PKIXSR7puMe+b/n6jZu5SkQElHazUAG/nnqs8EjuI36fhurg+G5qa
         jZpEK6GCeGd24CQgVLJN8GBGOPUHy/7jn1nLmehVGEbf18du9iSyhb5gQERFh/o00BsY
         cBDFKgzhNDUw+APGijjDQW66f8whIRuXgaHDI=
Received: by 10.213.103.72 with SMTP id j8mr277479ebo.137.1306003488482;
        Sat, 21 May 2011 11:44:48 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.44.47
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:44:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174117>

This is v2 of the patch series that marks strings in our core shell
programs for translation. I did not have time to fix everything for
this iteration, help welcome. The way my schedule is going this
weekend I probably won't get to this before next weekend, if then.

Stuff fixed:

 * Changed stuff like:

    echo >&2 "$(gettext "hello there")"
 =20
   to:

    (
        gettext "hello there" &&
        echo
    ) >&2

   It was mentioned that something like:

    gettext_nl "hello_there" >&2

   Would me more elegant. I agree, but didn't have time to change it
   (or care that much about the style). If someone wants to change
   this to whatever is the consensus that would be great.

 * Better TRANSLATORS comment for git-stash.sh

   As pointed out by Motiejus Jak=C5=A1tys. Actually someone going thro=
ugh
   this and adding *more* comments would improve things a lot. But
   it's not strictly needed, just nice to have.

What I *didn't* fix:

 * Change the eval_gettext variable names to work on win32.
   =20
       This means, to quote a previous E-Mail of mine:
   =20
    I'm now mostly done solving all the bugs noted in this series, asid=
e
    from the case insensitive env vars on win32 issue.
   =20
    I know how to fix these, but some people may have issues with my st=
yle
    of doing so, so I'd like to ask in advance to save me extra work.
   =20
    Basically for code like this:
   =20
           while [ $# -gt 0 ]; do
               arg=3D"$1"
               case "$arg" in
               --)
                   shift
                   break
                   ;;
               *)
                   rev=3D$(git rev-parse -q --verify "$arg^{commit}") |=
| {
                       test $has_double_dash -eq 1 &&
                           die "$(eval_gettext "'\$arg' does not appear
    to be a valid revision")"
                       break
   =20
    I was thinking of just doing:
   =20
       WHATEVER_arg=3D$arg
       die "$(eval_gettext "'\$WHATEVER_arg' does not appear to be a
    valid revision")"
   =20
    Where WHATEVER is a sufficiently unique prefix. E.g.:
   =20
       WINDOWS_ME_HARDER
       GIT_I18N_VARIABLE
       YOUR_MOM
       DUDE_WHERES_MY_POSIX_COMPLIANCE

This series can be retrieved from:

    git://github.com/avar/git.git ab/i18n-sh-only

As explained above I didn't have time to fix all the blockers. Help
would be *great* and very appreciated.

(quickly hits "send" before having to run off)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (48):
  i18n: git-am add git-sh-i18n
  i18n: git-am one-line gettext $msg; echo
  i18n: git-am multi-line getttext $msg; echo
  i18n: git-am eval_gettext messages
  i18n: git-am gettext + gettext to stderr message
  i18n: git-am die messages
  i18n: git-am cannot_fallback messages
  i18n: git-am clean_abort messages
  i18n: git-am "Apply?" message
  i18n: git-am "Falling back" say message
  i18n: git-am core say messages
  i18n: git-am printf(1) message to eval_gettext
  i18n: git-pull add git-sh-i18n
  i18n: git-pull die messages
  i18n: git-pull eval_gettext + die message
  i18n: git-pull eval_gettext + warning message
  i18n: git-submodule add git-sh-i18n
  i18n: git-submodule echo + eval_gettext messages
  i18n: git-submodule say + eval_gettext messages
  i18n: git-submodule die + eval_gettext messages
  i18n: git-submodule $update_module say + die messages
  i18n: git-submodule "cached cannot be used" message
  i18n: git-submodule "Submodule change[...]" messages
  i18n: git-submodule $errmsg messages
  i18n: git-submodule "Entering [...]" message
  i18n: git-submodule "[...] path is ignored" message
  i18n: git-submodule "path not initialized" message
  i18n: git-submodule "blob" and "submodule" messages
  i18n: git-stash add git-sh-i18n
  i18n: git-stash echo + gettext message
  i18n: git-stash say + gettext messages
  i18n: git-stash die + gettext messages
  i18n: git-stash die + eval_gettext messages
  i18n: git-stash die + eval_gettext $* messages
  i18n: git-stash die + eval_gettext $1 messages
  i18n: git-stash "unknown option" message
  i18n: git-stash drop_stash say/die messages
  i18n: git-bisect add git-sh-i18n
  i18n: git-bisect gettext + echo message
  i18n: git-bisect echo + gettext messages
  i18n: git-bisect echo + eval_gettext message
  i18n: git-bisect die + gettext messages
  i18n: git-bisect die + eval_gettext messages
  i18n: git-bisect bisect_run + $@ messages
  i18n: git-bisect bisect_reset + $1 messages
  i18n: git-bisect bisect_replay + $1 messages
  i18n: git-bisect [Y/n] messages
  i18n: git-bisect bisect_next_check "You need to" message

 git-am.sh                    |   77 ++++++++++++++++-------------
 git-bisect.sh                |  113 +++++++++++++++++++++++++++-------=
--------
 git-pull.sh                  |   34 +++++++------
 git-stash.sh                 |   81 ++++++++++++++++++++----------
 git-submodule.sh             |   98 ++++++++++++++++++++--------------=
---
 t/t4150-am.sh                |    2 +-
 t/t4151-am-abort.sh          |    5 +-
 t/t7400-submodule-basic.sh   |    4 +-
 t/t7401-submodule-summary.sh |   12 ++--
 t/t7406-submodule-update.sh  |    2 +-
 t/t7407-submodule-foreach.sh |    4 +-
 11 files changed, 255 insertions(+), 177 deletions(-)

--=20
1.7.5.1
