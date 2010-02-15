From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 6/6] tests: Add tests for automatic use of pager
Date: Sun, 14 Feb 2010 23:35:21 -0600
Message-ID: <20100215053521.GA22121@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214121300.GF3499@progeny.tock>
 <20100215051016.GF3336@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:35:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgtcE-0003NX-N7
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab0BOFfV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 00:35:21 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:45935 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0BOFfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:35:20 -0500
Received: by iwn39 with SMTP id 39so1863311iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 21:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=B2vTYGnjAPjiePvP95uKzySO5BvAwBqb/wDLhvMMhbE=;
        b=KT+ECrLlJDqA9tKLwxcIgGkCKq+HH5LdeKCzSnfDIlRrY72AvllHT14dOCfDL6CSJ4
         XvyXFFwv2mxerkBDU+HxBlVAP6EQYRHwtNqfavR7np3HLaikB3iXLslGQagrGE60gjmx
         DxCdwf3naGcEHJqWh4cs1v6mE5s3/ZDNS5coY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tjdfvKmqOEkOwCvZ3vFMLV2f9QaYQp+2A931Rc8RUCpKjXLIlTBUEJlv+oNLbo/MMZ
         xKJHS+F3yWvTSCc+lGZD1e1TZY/6mhpfGTyAcaodiMGjjuCB7KkTqiWEoG7XKUHmBXYZ
         fHyjFAL+bKIYbRfpEkkPZakSZIP2UdDPsOHnU=
Received: by 10.231.152.75 with SMTP id f11mr2635529ibw.50.1266212120105;
        Sun, 14 Feb 2010 21:35:20 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5998615iwn.9.2010.02.14.21.35.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 21:35:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100215051016.GF3336@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139982>

Git=E2=80=99s automatic pagination support has some subtleties; add som=
e tests
to make sure they don=E2=80=99t break again.

These test:

 - when git will use a pager by default;
 - the effect of the --paginate and --no-pager options;
 - the effect of pagination on use of color;
 - how the choice of pager is configured.

They does not yet test:

 - use of pager by scripted commands (git svn and git am);
 - effect of the pager.* configuration variables;
 - setting of the LESS variable.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> I am a little lukewarm on tests that require --verbose, since they wi=
ll
> not be caught by 99% of the runs of the test suite.

Makes sense.

> Still, perhaps something is better than nothing. I wonder if we can d=
o
> better, though, with something like:
[...]
>     if (fake[fd] =3D=3D -1) {
>       const char *x =3D getenv("GIT_PRETEND_TTY");
>       if (x && strchr(x, '0' + fd))
>         fake[fd] =3D 1;
>       else
>         fake[fd] =3D isatty(fd);

How about this?  It seems a little simpler, though it might be less
reliable.

 t/t7006-pager.sh |  156 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 156 insertions(+), 0 deletions(-)
 create mode 100644 t/t7006-pager.sh

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
new file mode 100644
index 0000000..458a754
--- /dev/null
+++ b/t/t7006-pager.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+
+test_description=3D'Test automatic use of a pager.'
+
+. ./test-lib.sh
+
+if eval "exec 8>/dev/tty" 2>/dev/null && test -t 8
+then
+	test_set_prereq TTY
+else
+	say no usable /dev/tty, so skipping some tests.
+	exec 8>&-
+fi
+
+unset GIT_PAGER GIT_PAGER_IN_USE
+git config --unset core.pager
+PAGER=3D'cat > paginated.out'
+export PAGER
+
+test_expect_success 'setup' '
+	test_commit initial
+'
+
+rm -f paginated.out
+test_expect_success TTY 'some commands use a pager' '
+	git log -0 >&8 &&
+	test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success TTY 'some commands do not use a pager' '
+	git rev-list -0 HEAD >&8 &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success 'no pager when stdout is a pipe' '
+	git log | cat &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success 'no pager when stdout is a regular file' '
+	git log > file &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success TTY 'git --paginate rev-list uses a pager' '
+	git --paginate rev-list -0 HEAD >&8 &&
+	test -e paginated.out
+'
+
+rm -f file paginated.out
+test_expect_success 'no pager even with --paginate when stdout is a pi=
pe' '
+	git --paginate log | cat &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success TTY 'no pager with --no-pager' '
+	git --no-pager log -0 >&8 &&
+	! test -e paginated.out
+'
+
+# A colored commit log will begin with an appropriate ANSI escape
+# for the first color; the text "commit" comes later.
+colorful() {
+	read firstline < $1
+	! expr "$firstline" : "^[a-zA-Z]" >/dev/null
+}
+
+rm -f colorful.log colorless.log
+test_expect_success 'tests can detect color' '
+	git log --no-color > colorless.log &&
+	git log --color > colorful.log &&
+	! colorful colorless.log &&
+	colorful colorful.log
+'
+
+rm -f colorless.log
+git config color.ui auto
+test_expect_success 'no color when stdout is a regular file' '
+	git log > colorless.log &&
+	! colorful colorless.log
+'
+
+rm -f paginated.out
+git config color.ui auto
+test_expect_success TTY 'color when writing to a pager' '
+	TERM=3Dvt100 git log >&8 &&
+	colorful paginated.out
+'
+
+rm -f colorful.log
+git config color.ui auto
+test_expect_success 'color when writing to a file intended for a pager=
' '
+	TERM=3Dvt100 GIT_PAGER_IN_USE=3Dtrue git log > colorful.log &&
+	colorful colorful.log
+'
+
+unset PAGER GIT_PAGER
+git config --unset core.pager
+test_expect_success 'determine default pager' '
+	less=3D$(git var GIT_PAGER) &&
+	test -n "$less"
+'
+
+if expr "$less" : '^[a-z]*$' > /dev/null && test_have_prereq TTY
+then
+	test_set_prereq SIMPLEPAGER
+fi
+
+unset PAGER GIT_PAGER
+git config --unset core.pager
+rm -f default_pager_used
+test_expect_success SIMPLEPAGER 'default pager is used by default' '
+	cat > $less <<-EOF &&
+	#!$SHELL_PATH
+	: > default_pager_used
+	EOF
+	chmod +x $less &&
+	PATH=3D.:$PATH git log -0 >&8 &&
+	test -e default_pager_used
+'
+
+unset GIT_PAGER
+git config --unset core.pager
+rm -f PAGER_used
+test_expect_success TTY 'PAGER overrides default pager' '
+	PAGER=3D": > PAGER_used" &&
+	export PAGER &&
+	git log -0 >&8 &&
+	test -e PAGER_used
+'
+
+unset GIT_PAGER
+rm -f core.pager_used
+test_expect_success TTY 'core.pager overrides PAGER' '
+	PAGER=3D: &&
+	export PAGER &&
+	git config core.pager ": > core.pager_used" &&
+	git log -0 >&8 &&
+	test -e core.pager_used
+'
+
+rm -f GIT_PAGER_used
+test_expect_success TTY 'GIT_PAGER overrides core.pager' '
+	git config core.pager : &&
+	GIT_PAGER=3D": > GIT_PAGER_used" &&
+	export GIT_PAGER &&
+	git log -0 >&8 &&
+	test -e GIT_PAGER_used
+'
+
+test_done
--=20
1.7.0
