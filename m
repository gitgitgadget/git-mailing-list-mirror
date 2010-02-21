From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 6/7] tests: Add tests for automatic use of pager
Date: Sat, 20 Feb 2010 20:03:18 -0600
Message-ID: <20100221020317.GA7651@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
 <20100219071857.GF29916@progeny.tock>
 <7v8wanq0c3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 03:15:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj19u-0000ic-TL
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 03:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455Ab0BUCCx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2010 21:02:53 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:48665 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab0BUCCx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 21:02:53 -0500
Received: by gxk27 with SMTP id 27so7686gxk.1
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 18:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8vcPUnKR+0olPFgY5QHH3V6fhEi2v6IgqRiIR5012gA=;
        b=CSyhkcNGr7wW3zoha24Mh3z1dlmLOmrYok0Bw0/1pTVX7QnxrB766YnAWls47y3aT6
         dImrhiLQ2qg5Rh4RQavA7MtqQM4j6sRaMyxCNKI1z+8wjx9PwZUasQnAnfD9sBV0qHqW
         ZDf0rYdpEbix4vbQgXPoYXWJG3dwb3o8WTIVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V1+d2jN5JDNgCvPL0doXJn5kxs0ESiEKULXMyQkKPUzFSAKgxTI3fcn+Skv7AYyDwp
         44+vgmvhU35GAgrllRRnHHiXOkXt3RB9OQsq/G59EvGXgXI38fkJDDVOnmdMBhMLV8V+
         yN2ldVL6gbnkBgwIHjgxYuBbkslTKPmKhGi8w=
Received: by 10.101.156.25 with SMTP id i25mr2613354ano.149.1266717772295;
        Sat, 20 Feb 2010 18:02:52 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 4sm909034yxd.34.2010.02.20.18.02.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 18:02:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v8wanq0c3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140578>

Git=E2=80=99s automatic pagination support has some subtleties.  Add so=
me
tests to make sure we don=E2=80=99t break:

 - when git will use a pager by default;
 - the effect of the --paginate and --no-pager options;
 - the effect of pagination on use of color;
 - how the choice of pager is configured.

This does not yet test:

 - use of the pager by scripted commands (git svn and git am);
 - effect of the pager.* configuration variables;
 - setting of the LESS variable.

Some features involve checking whether stdout is a terminal, so many
of these tests are skipped unless output is passed through to the
terminal (i.e., unless $GIT_TEST_OPTS includes --verbose).

The immediate purpose for these tests was to avoid making things worse
after the breakage from my jn/editor-pager series (see commit 376f39,
2009-11-20).  Thanks to Sebastian Celis <sebastian@sebastiancelis.com>
for the report.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
On Sat, Feb 20, 2010 at 09:33:00AM -0800, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	TERM=3Dvt100 test_terminal git log &&
>=20
> I didn't see test_terminal defined up to this point.  Am I missing
> something?

Good catch, thanks.

 t/t7006-pager.sh |  163 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 t/t7006-pager.sh

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
new file mode 100644
index 0000000..4f52ea5
--- /dev/null
+++ b/t/t7006-pager.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+
+test_description=3D'Test automatic use of a pager.'
+
+. ./test-lib.sh
+
+rm -f stdout_is_tty
+test_expect_success 'is stdout a terminal?' '
+	if test -t 1
+	then
+		: > stdout_is_tty
+	fi
+'
+
+if test -e stdout_is_tty
+then
+	test_set_prereq TTY
+else
+	say stdout is not a terminal, so skipping some tests.
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
+	git log &&
+	test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success TTY 'some commands do not use a pager' '
+	git rev-list HEAD &&
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
+	git --paginate rev-list HEAD  &&
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
+	git --no-pager log &&
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
+	TERM=3Dvt100 git log &&
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
+	PATH=3D.:$PATH git log &&
+	test -e default_pager_used
+'
+
+unset GIT_PAGER
+git config --unset core.pager
+rm -f PAGER_used
+test_expect_success TTY 'PAGER overrides default pager' '
+	PAGER=3D": > PAGER_used" &&
+	export PAGER &&
+	git log &&
+	test -e PAGER_used
+'
+
+unset GIT_PAGER
+rm -f core.pager_used
+test_expect_success TTY 'core.pager overrides PAGER' '
+	PAGER=3D: &&
+	export PAGER &&
+	git config core.pager ": > core.pager_used" &&
+	git log &&
+	test -e core.pager_used
+'
+
+rm -f GIT_PAGER_used
+test_expect_success TTY 'GIT_PAGER overrides core.pager' '
+	git config core.pager : &&
+	GIT_PAGER=3D": > GIT_PAGER_used" &&
+	export GIT_PAGER &&
+	git log &&
+	test -e GIT_PAGER_used
+'
+
+test_done
--=20
1.7.0
