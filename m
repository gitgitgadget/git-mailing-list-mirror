From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] tests: make test_expect_code quieter on success
Date: Sat, 21 May 2011 14:40:32 -0500
Message-ID: <20110521194032.GH10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 21:40:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNs2V-0004ZU-Vb
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 21:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab1EUTkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 15:40:39 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65150 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757145Ab1EUTkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 15:40:36 -0400
Received: by iyb14 with SMTP id 14so3676322iyb.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xsQ82zm23XZdsgRk6bDd5gvHIR8EEhT4rHFec3GzRtc=;
        b=V08DmHclIZHt6yTJy7v3aOZ7n34a/BxsezgXB85dOcFcdsj6TNSvIuhHPOhRCvqhoF
         rFoEF7rs8gpzfnKsO62Fdm8PEK8LBHxDdI6+cF19x7f514c1/KOhTJaDMKdbD3LqDrN/
         9FkFHrLzOPIC+8UjTL4NkZgVgKD4MYMMhUy7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Fb5n8lleVS4L/cAYKwzbOvXOMwYfc+nnXo7m7acnyYajahqfXw34ITVhPJjmXnE1Og
         Cv1prHHURU8iktyo+D0ctdKFDvYVkuS7MA38gNSOe+rQVGbY7j2AawLEmemgOA4+G3SM
         XpFqFvF9x1uF8M8rJGygz2oOsw9fG96Po1aAU=
Received: by 10.231.117.93 with SMTP id p29mr659451ibq.126.1306006836303;
        Sat, 21 May 2011 12:40:36 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.sbcglobal.net [69.209.78.180])
        by mx.google.com with ESMTPS id 10sm2076691ibc.45.2011.05.21.12.40.34
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 12:40:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521185314.GA10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174174>

A command exiting with the expected status is not particularly
notable.

While the indication of progress might be useful when tracking down
where in a test a failure has happened, the same applies to most other
test helpers, which are quiet about success, so this single helper's
output stands out in an unpleasant way.  An alternative method for
showing progress information might to invent a --progress option that
runs tests with "set -x", or until that is available, to run tests
using commands like

	prove -v -j2 --shuffle --exec='sh -x' t2202-add-addremove.sh

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  This last one should probably have
been called 7/6 or sent separately as an RFC, since it's more a
matter of taste.  It was just something I ran into while trying out
the tests.

Hopefully the series wasn't too boring.  Thanks for reading.

 t/test-lib.sh |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8a274fb..a174f66 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -731,12 +731,11 @@ test_expect_code () {
 	exit_code=$?
 	if test $exit_code = $want_code
 	then
-		echo >&2 "test_expect_code: command exited with $exit_code: $*"
 		return 0
-	else
-		echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
-		return 1
 	fi
+
+	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
+	return 1
 }
 
 # test_cmp is a helper function to compare actual and expected output.
-- 
1.7.5.1
