From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Fri, 15 May 2015 12:22:00 -0700
Message-ID: <xmqqzj55fxyf.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	<xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
	<CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
	<xmqq7fs9hekc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 21:22:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtLBR-0001cr-F2
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 21:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933313AbbEOTWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 15:22:04 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36066 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbEOTWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 15:22:03 -0400
Received: by igbpi8 with SMTP id pi8so2140390igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4HVKRxTRjwFMrmqNCAH2sn79sKfsgkXm6qsyGoM9jdY=;
        b=Be6vZ1ZQY8dZf4lL0zzHluXgYq0np2WJQps86C848Ww9kzULFrpvR0PLnCTgK5zucD
         ByW45ovSLMOFh80PhcBC7NGr6XjWiKrkllL77OIySsMl2bWQz7rVv2T5xBguvY1U0SoZ
         DTf5HnotoboRA7mhbfwrFO+5zIAKFSKN5w29HwUWZ1LrTMohnoKwSpIB+hBhzuOYqPJh
         4QdwU1ObtbebVhJ1+bGaqT2RufB1zm1zXTrwgSeNhc5A+YDQoGZQdALYJPQwn3hjQ9mI
         2aJsiloMhYKopUAxEWmLt/zrOGTu5FTXj4QgmPjENewijgtEuXxgnS11icB3M89KV1i5
         lCuQ==
X-Received: by 10.43.58.201 with SMTP id wl9mr22749571icb.37.1431717722376;
        Fri, 15 May 2015 12:22:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id m36sm1764231iod.3.2015.05.15.12.22.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 12:22:01 -0700 (PDT)
In-Reply-To: <xmqq7fs9hekc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 May 2015 11:37:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269175>

Junio C Hamano <gitster@pobox.com> writes:

> You might have noticed, while adding them, there were something
> common that we currently do with a bare 'test' only because we
> haven't identified common needs....
> ...
> in t/test-lib-functions.sh and convert them to say
>
> 	test_file_contents file expected_string
>
> That would be an improvement (and that is the remaining 2/3 ;-).

I haven't made up my mind on this other example, but since I started
writing it...

It may be that counting the number of lines in output, "cmd | wc -l",
is a common pattern.  We already have test_line_count to check the
number of lines in a file, but having test_output_count may help.

 t/test-lib-functions.sh | 11 +++++++++++
 t/t0000-basic.sh        |  3 +--
 t/t0030-stripspace.sh   | 11 +++++------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0d93e33..624a8c5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -538,6 +538,17 @@ test_line_count () {
 	fi
 }
 
+test_output_count () {
+	if test $# != 3
+	then
+		error "bug in the test script: not 3 parameters to test_output_count"
+	elif ! test $(eval "$2" | wc -l) "$1" "$3"
+	then
+		echo "test_output_count: line count for output from '$2' !$1 $3"
+		return 1
+	fi
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f10ba4a..bd5930d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1039,8 +1039,7 @@ test_expect_success 'update-index D/F conflict' '
 	mv path2 path0 &&
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
-	numpath0=$(git ls-files path0 | wc -l) &&
-	test $numpath0 = 1
+	test_output_count = "git ls-files path0" 1
 '
 
 test_expect_success 'very long name in the index handled sanely' '
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 0333dd9..9502938 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -223,12 +223,11 @@ test_expect_success \
     test_cmp expect actual
 '
 
-test_expect_success \
-    'text without newline at end should end with newline' '
-    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
+test_expect_success 'text without newline at end should end with newline' '
+	test_output_count -gt '\''printf "$ttt" | git stripspace'\'' 0 &&
+	test_output_count -gt '\''printf "$ttt$ttt" | git stripspace'\'' 0 &&
+	test_output_count -gt '\''printf "$ttt$ttt$ttt" | git stripspace'\'' 0 &&
+	test_output_count -gt '\''printf "$ttt$ttt$ttt$ttt" | git stripspace'\'' 0
 '
 
 # text plus spaces at the end:
