From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 12:02:56 -0700
Message-ID: <20151030190256.GI7881@google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <20151026191724.GE7881@google.com>
 <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info>
 <xmqqlhakky0e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:03:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEx8-00072M-1L
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759876AbbJ3TDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:03:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33925 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758935AbbJ3TC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:02:59 -0400
Received: by padhk11 with SMTP id hk11so82177155pad.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mmeyzLKrjaO26fPJ08iIG5VWdTbyl8+1bxcZkfzJ3qU=;
        b=AFmXh8s8JKv62UECimB3wrGfPEkP1KbegS83259FYhhxoQdmOv+HL+1hZCLM7DxRTy
         w/NU4Keb7z5xggIaNDTxEnCOn5gx760B10zsUpVgLsJMmR1qa0x38vHFze9XQjATTj3k
         MDJWQsRNCmzFBCmTGFWFocbsse4ojF4icoZyS2uwZQkz4EBw/N+dwkhkEySBOE8r1RZJ
         rlN9AJTibn75SuKBm559Y/h0lHDKMzaRvwuIcjQC1DX27Xq77Sv0Xco/fva3mlpaMThP
         XP9+8tEDR/yFB7I0y6ZA6kyxMBk9gXZLUFCKwAzh9hkYW910ZTZFfl2EwLQKLWd1p3Qg
         020Q==
X-Received: by 10.66.172.6 with SMTP id ay6mr10506181pac.44.1446231779369;
        Fri, 30 Oct 2015 12:02:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c1d3:800a:733a:d60a])
        by smtp.gmail.com with ESMTPSA id ey17sm9577835pac.26.2015.10.30.12.02.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Oct 2015 12:02:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqlhakky0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280521>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Tue, 27 Oct 2015, Junio C Hamano wrote:

>>> It can be called GDB=1, perhaps?
>>
>> No, this is way too generic. As I only test that the environment
>> variable's existence, even something like GDB=/usr/opt/gdb/bin/gdb would
>> trigger it.
>>
>> I could be talked into GDB_GIT=1, though.
>
> As I said in another message, I have no preference myself over the
> name of this variable (or making it a shell function like Duy
> mentioned, which incidentally may give us more visual pleasantness
> by losing '=').
>
> I'd just be happy as long as the feature becomes available, and I'd
> leave the choice of consistent and convenient naming to others who
> have stronger opinions ;-)

Here's a suggested patch.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Facilitate debugging Git executables in tests with gdb

When prefixing a Git call in the test suite with 'debug ', it will now
be run with GDB, allowing the developer to debug test failures more
conveniently.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/README                | 5 +++++
 t/test-lib-functions.sh | 8 ++++++++
 wrap-for-bin.sh         | 8 +++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 35438bc..1dc908e 100644
--- a/t/README
+++ b/t/README
@@ -563,6 +563,11 @@ library for your script to use.
    argument.  This is primarily meant for use during the
    development of a new test script.
 
+ - debug <git-command>
+
+   Run a git command inside a debugger. This is primarily meant for
+   use when debugging a failing test script.
+
  - test_done
 
    Your test script must have test_done at the end.  Its purpose
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6dffb8b..73e37a1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -145,6 +145,14 @@ test_pause () {
 	fi
 }
 
+# Wrap git in gdb. Adding this to a command can make it easier to
+# understand what is going on in a failing test.
+#
+# Example: "debug git checkout master".
+debug () {
+	 GIT_TEST_GDB=1 "$@"
+}
+
 # Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 701d233..db0ec6a 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -19,4 +19,10 @@ GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
-exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+if test -n "$GIT_TEST_GDB"
+then
+	unset GIT_TEST_GDB
+	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+else
+	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+fi
-- 
2.6.0.rc2.230.g3dd15c0
