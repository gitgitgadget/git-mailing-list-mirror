From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [TOY PATCH] test-lib: &&-chaining tester
Date: Wed, 6 Oct 2010 00:31:18 -0500
Message-ID: <20101006053118.GA29289@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 07:35:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Mez-000826-DD
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 07:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab0JFFel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 01:34:41 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61175 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab0JFFel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 01:34:41 -0400
Received: by gxk9 with SMTP id 9so2299371gxk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DcuRnFD4s/a4AxaY7tbt1gLYRuDN9yX56gi0XNvO2Rg=;
        b=LtCwTaQd0I1wg6rpTU+M4K5EIg3Ud8fmyxG5QPHtP6pl9ZyHzq5BpBD+zQXrDRi774
         FCEFo41s1K2Dqw9+ANQd6xHcU1mpxp7NSoPP7kq8p8v2h/719khp38PBxqTqwc6KmtUo
         1e0pr+VD+ufiG0F7nChFklnN7QsUvMhIg5I+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M+Vm9Io7tL0xGkna7zeRMyaVWzwI+bbED3UJ5idZKj9ZoBux97F9a2+n6gIFZ6m1Wt
         LPbN5Cs10DLxHmSVX+MCIMWjz/SQMUU+aTOPPcTXal+V3LSxoeDWkvxs4R0pJOA7nMOH
         ORoJqDYMKPI88H5ghxWEsSCjxyYjG3jZ+Ar+Q=
Received: by 10.151.28.13 with SMTP id f13mr1347563ybj.234.1286343280478;
        Tue, 05 Oct 2010 22:34:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q41sm561724ybk.13.2010.10.05.22.34.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 22:34:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158265>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Elijah,

Elijah Newren wrote:

> This patch series fixes many of the missing &&s in the testsuite.

Thanks again.  Here's a little glimpse of a future without missing &&s
to play with.

 t/test-lib.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 932f45b..e3a0e68 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -393,7 +393,17 @@ test_debug () {
 	test "$debug" = "" || eval "$1"
 }
 
+check_command_chaining_ () {
+	eval >&3 2>&4 "(exit 189) && $1"
+	eval_chain_ret=$?
+	if test "$eval_chain_ret" != 189
+	then
+		error 'bug in the test script: missing "&&" in test commands'
+	fi
+}
+
 test_run_ () {
+	check_command_chaining_ "$1"
 	test_cleanup=:
 	eval >&3 2>&4 "$1"
 	eval_ret=$?
@@ -697,6 +707,7 @@ test_cmp() {
 # the test to pass.
 
 test_when_finished () {
+	check_command_chaining_ "$test_cleanup"
 	test_cleanup="{ $*
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
 }
-- 
1.7.2.3
