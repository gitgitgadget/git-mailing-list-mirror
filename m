From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4] t7601: test for pull.ff=true overrides merge.ff=false
Date: Thu, 14 May 2015 10:06:57 -0700
Message-ID: <xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
	<1431510740-9710-2-git-send-email-pyokagan@gmail.com>
	<2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
	<xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
	<81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 19:07:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswbD-0002tQ-Rd
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933007AbbENRHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:07:00 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33633 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbbENRG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:06:59 -0400
Received: by iebgx4 with SMTP id gx4so65830475ieb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7fIAX5LY+yMvh0CwUXLkhRd6MJukBh0Vp+vtUxqm6LY=;
        b=OYTN0czz5Tbw9JG0LxMpki3uOBhM5IlSfOwAskIl4XtFc8fkTQ9TS5u6rXnfK1UEYh
         IqGOAjIFGWRjByciz5uiDJjs18/tkQQW2cHOGvxeCwn1ZEEQkEDjfj9yqx/Z6e81fHfb
         H/mdKK4vtYCa9oLE+N5HQf0fBuIo3t0MyE0P14fet2DjY2GOk5NUETisp/oRCzQHmNiD
         PQcJyWkFDAbPIswUweYObbksE97sjxpq6ihAoWgVlwQhEj04fP2TPMP/2mqb85edcZ68
         usM2yvMn/gB9QWLIcR8pfQqzXsi81t3wAFkqF11pEhQhEDWu235/lGsBGLB2SBCUvCbk
         gT5A==
X-Received: by 10.107.46.39 with SMTP id i39mr6607032ioo.8.1431623218951;
        Thu, 14 May 2015 10:06:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id k74sm16864194iok.30.2015.05.14.10.06.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 10:06:58 -0700 (PDT)
In-Reply-To: <81926313e0a131cd7224f0f6f8984dd2@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 14 May 2015 18:53:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269045>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Asketh and ye shall be given: without running the tests in parallel,
> our Jenkins would take *even longer* than the three hours per test
> suite run (which is really painful, still, by the way). And as you
> know, running the tests with "-v -x" is awfully useless if you run the
> test suite in parallel.
>
> Come to think of it, the proposed "verbose test" will not help this
> use case one bit, neither would test_eq.

Yeah, I'd agree.  So let's forget about adding a way to make the
test output more verbose for CI's sake.

And I would say that "verbose test" is not a useful way to make the
test output more verbose for Human's sake; GIT_TEST_OPTS="-v -x -i"
on the other hand is.

I am very tempted to suggest doing this ;-)

 t/test-lib-functions.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0698ce7..c6c67e8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -638,8 +638,14 @@ test_cmp_bin() {
 }
 
 # Call any command "$@" but be more verbose about its
-# failure. This is handy for commands like "test" which do
-# not output anything when they fail.
+# failure. This may seem handy for commands like "test" which do
+# not output anything when they fail, but in practice not
+# very useful for things like 'test "$actual" = "$expect"',
+# as this only shows the actual values (i.e. after $actual and
+# $expect are turned into the values in these variables).
+#
+# In short, do not add use of this; this is kept only to
+# avoid having to remove its use (for now).
 verbose () {
 	"$@" && return 0
 	echo >&2 "command failed: $(git rev-parse --sq-quote "$@")"
