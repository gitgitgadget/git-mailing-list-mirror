From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: use test_i18ncmp in t2020 (checkout --detach)
Date: Sat, 14 Apr 2012 00:02:34 -0500
Message-ID: <20120414050234.GE1791@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
 <20120414022452.GA17535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 07:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIv8J-0004lO-0z
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 07:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab2DNFCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 01:02:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34989 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2DNFCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 01:02:41 -0400
Received: by iagz16 with SMTP id z16so5115405iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 22:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zB7TsY44C+oqDfdVY1PbvfBB/lGH+K+VtNlnca/0A84=;
        b=Ru7/1D2Pwy1Xkf0jvgv0MSxdqb9mVB7jCKNZbuZn/GgA4hv9u8ayBcVeLDpHVjwGus
         47gzk27kNqQ0v1VHvmD7DAr7O3HEuDO+SyXUNhuYfDDm1Xg9JOoICvNcKiB9BKvx4V7W
         iy7DWe3cqemX6JAxIEY/vhKxLF4SUpfuxLxQAwQMPGn9mUa0pucP6qxiVNnsiRPI6BhH
         GURPGos+pZeG1qG99VjHGktQef6Mds98BTFzgwLiJE+EWZZmu+uXjGkYzF7V2HYljruV
         dll40LELG9xrejnRnEFLf67L8AZJbQYnsnah4mcu8MLMVNOQJH+t0hG1ksRoR5Lovqb/
         m+qQ==
Received: by 10.50.179.104 with SMTP id df8mr469548igc.11.1334379761313;
        Fri, 13 Apr 2012 22:02:41 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a10sm1102643igj.10.2012.04.13.22.02.39
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 22:02:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120414022452.GA17535@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195470>

Jeff King wrote:

> Yes, but this wasn't gettext-ed at all until 2012-02-02, and then it
> didn't get merged into master until the week after. How often do you
> run GETTEXT_POISON tests? I know I don't, and obviously Junio does not
> include them as part of his process before pushing out master.

The theory is that it should be convenient to run them when we are
considering a "gettextize" patch.

Maybe something like the following would make it easier for some
people to always build with GETTEXT_POISON and run tests with
GIT_GETTEXT_POISON only occasionally.  I'd rather have a real poison
locale since this would not require any runtime support in the git
binary, though.  Does the value of LC_MESSAGES have to be a valid
locale?  Would something like en_US@poison work?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git i/t/test-lib.sh w/t/test-lib.sh
index b7d7100c..83f7362a 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -51,6 +51,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $(perl -e '
 	my $ok = join("|", qw(
 		TRACE
 		DEBUG
+		GETTEXT_POISON
 		USE_LOOKUP
 		TEST
 		.*_TEST
@@ -621,10 +622,8 @@ test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-if test -n "$GETTEXT_POISON"
+if test -n "$GIT_GETTEXT_POISON"
 then
-	GIT_GETTEXT_POISON=YesPlease
-	export GIT_GETTEXT_POISON
 	test_set_prereq GETTEXT_POISON
 else
 	test_set_prereq C_LOCALE_OUTPUT
@@ -635,7 +634,7 @@ fi
 # under GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ncmp () {
-	test -n "$GETTEXT_POISON" || test_cmp "$@"
+	test -n "$GIT_GETTEXT_POISON" || test_cmp "$@"
 }
 
 # Use this instead of "grep expected-string actual" to see if the
@@ -644,7 +643,7 @@ test_i18ncmp () {
 # under GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ngrep () {
-	if test -n "$GETTEXT_POISON"
+	if test -n "$GIT_GETTEXT_POISON"
 	then
 	    : # pretend success
 	elif test "x!" = "x$1"
