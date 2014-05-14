From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH] git format-patch --signature <string | file>
Date: Tue, 13 May 2014 18:53:56 -0700
Message-ID: <20140514015356.GA21893@hudson.localdomain>
References: <1399969296-31598-1-git-send-email-jmmahler@gmail.com>
 <20140513160712.GA30685@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 03:54:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkOOY-0000vW-00
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 03:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbaENByF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 21:54:05 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34026 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaENByB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 21:54:01 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so986212pab.34
        for <git@vger.kernel.org>; Tue, 13 May 2014 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TfOymRfan+9Yl8JbO1Wkh9mhF3YSwQGjr4jvFb4/68o=;
        b=QdA01BAKdaJqlWmCGKjVnHywZzvpsOGt1RgJGp4cbYeoKQxS0IfDSSYHy0o1WlwGX2
         dNQTtcEghSrHz/bycjkXRVO4mDOfxEUV3kDvwzQ+bSrr8mwEWpm2spvkcFHQXTuN619K
         PDpXwxymugwx1f+ob4dNBm+6oFcjymxXonWjYGspvcgpMkIhwfXkGxNJyLmnuZb4dV/T
         vUAWt61kOT88UUnVNRom3VlckLzQfU8dDtfbDjBMmOOmSz+3h8JUo8tH19YA2rOXiOog
         KLqqWMxwBUftt13zob7kXmPqwALtO8GBkQtdIxvOq1NmwGoR+RALeYRggpx5qDf9/6i8
         K6hg==
X-Received: by 10.67.4.138 with SMTP id ce10mr779383pad.12.1400032441347;
        Tue, 13 May 2014 18:54:01 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id nx12sm1340012pab.6.2014.05.13.18.53.57
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 18:53:59 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 13 May 2014 18:53:56 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140513160712.GA30685@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248893>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Tue, May 13, 2014 at 09:07:12AM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Jeremiah Mahler wrote:
> 
> >   # from a string
> >   $ git format-patch --signature "from a string" origin
> >
> >   # or from a file
> >   $ git format-patch --signature ~/.signature origin
> 
> Interesting.  But... what if I want my patch to end with
> 
> 	-- 
> 	/home/jrnieder/.signature
> 
> ?  It seems safer to introduce a separate --signature-file option.
> 

It is probably smarter to avoid that corner case entirely.
Good idea.

> [...]
> >  builtin/log.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> Tests?
> 

I added a test which checks that a valid patch is produced and that
the signature from the file appears in the output.

> Thanks and hope that helps,
> Jonathan

Attached is a revised patch.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler

--IJpNTDwzlM2Ie8A6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-format-patch-signature-file-file.patch"

>From e5cbeaf50d85236d6dd53e64f8f7cf466b1acecd Mon Sep 17 00:00:00 2001
From: Jeremiah Mahler <jmmahler@gmail.com>
Date: Tue, 13 May 2014 18:10:53 -0700
Subject: [PATCH] format-patch --signature-file <file>

Added feature that allows a signature file to be used with format-patch.

  $ git format-patch --signature-file ~/.signature origin

Now signatures with newlines and other special characters can
be easily included.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/log.c           | 24 ++++++++++++++++++++++++
 t/t4014-format-patch.sh | 13 +++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..1ec733b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1147,6 +1147,27 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int signature_file_callback(const struct option *opt, const char *arg,
+							int unset)
+{
+	const char **signature = opt->value;
+	static char buf[1024];
+	size_t sz;
+	FILE *fp;
+
+	fp = fopen(arg, "r");
+	if (fp) {
+		sz = sizeof(buf);
+		sz = fread(buf, 1, sz - 1, fp);
+		buf[sz] = '\0';
+		*signature = buf;
+		fclose(fp);
+	} else {
+		*signature = arg;
+	}
+	return 0;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1230,6 +1251,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		{ OPTION_CALLBACK, 0, "signature-file", &signature, N_("signature-file"),
+				N_("add a signature from contents of a file"),
+			    PARSE_OPT_NONEG, signature_file_callback },
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9c80633..19b67e3 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -762,6 +762,19 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
 	! grep "^-- \$" output
 '
 
+cat > expect << EOF
+Test User <test.email@kernel.org>
+http://git.kernel.org/cgit/git/git.git
+git.kernel.org/?p=git/git.git;a=summary
+EOF
+
+test_expect_success 'format-patch --signature-file file' '
+	git format-patch --stdout --signature-file expect -1 >output &&
+	check_patch output &&
+	fgrep -x -f output expect >output2 &&
+	diff expect output2
+'
+
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
 	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler



--IJpNTDwzlM2Ie8A6--
