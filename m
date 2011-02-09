From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] fast-import: introduce "feature notes" command
Date: Wed, 9 Feb 2011 16:43:57 -0600
Message-ID: <20110209224357.GB17128@elie>
References: <20110202045826.GC15285@elie>
 <20110202050735.GE15285@elie>
 <201102022047.55152.trast@student.ethz.ch>
 <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
 <20110209214638.GA16716@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 23:44:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnIlg-0005hb-JK
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 23:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab1BIWoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 17:44:07 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42028 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab1BIWoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 17:44:06 -0500
Received: by qyj19 with SMTP id 19so1824745qyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 14:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+VSII7yyT1INWu39nP4bAsaopwdsALXaoJ1YSmMUnJo=;
        b=HI+UBRrj97TmmLSeGCGrgZHjjO2yS069HDg9SNxemN1EwRBEiwoy/8L/kkWWy1qRrZ
         HKftb+n/IkCTa10rwPR7nB3m4deFYEg7et6DEnYIwHozVdcSk3b/QzGyExqpogMgk7HT
         PEmQCK+QCfONVXmjWU3Zp/TEPmkAm2b5UY3gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ej8CLe5lJxUlrunjsXKogKDKlX3i2+uiw64OBDhjy3+zYyGr4FhELLrlkb7PrV+GGB
         pU4FqQmK+q7TjYHPFa+2f3q0DwDqabnK55VOqANN+AbVoSPAvkyxuy9jcTX6qAzie35t
         qMrDeVjAw4CtAxSImmGIqp1/gig/Lv8Srn1dQ=
Received: by 10.224.6.149 with SMTP id 21mr16772607qaz.321.1297291444387;
        Wed, 09 Feb 2011 14:44:04 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id g32sm517771qck.22.2011.02.09.14.44.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 14:44:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110209214638.GA16716@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166452>

Here is a 'feature' command for streams to use to require support for
the notemodify (N) command.

When the 'feature' facility was introduced (v1.7.0-rc0~95^2~4,
2009-12-04), the notes import feature was old news (v1.6.6-rc0~21^2~8,
2009-10-09) and it was not obvious it deserved to be a named feature.
But now that is clear, since all major non-git fast-import backends
lack support for it.

Details: on git version with this patch applied, any "feature notes"
command in the features/options section at the beginning of a stream
will be treated as a no-op.  On fast-import implementations without
the feature (and older git versions), the command instead errors out
with a message like

	This version of fast-import does not support feature notes.

So by declaring use of notes at the beginning of a stream, frontends
can avoid wasting time and other resources when the backend does not
support notes.  (This would be especially important for backends that
do not support rewinding history after a botched import.)

Improved-by: Thomas Rast <trast@student.ethz.ch>
Improved-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |    6 ++++++
 fast-import.c                     |    2 ++
 t/t9301-fast-import-notes.sh      |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 3bf04e3..becee8b 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -898,6 +898,12 @@ import-marks::
 	second, an --import-marks= command-line option overrides
 	any "feature import-marks" command in the stream.
 
+notes::
+	Require that the backend support the 'notemodify' (N)
+	subcommand to the 'commit' command.
+	Versions of fast-import not supporting notes will exit
+	with a message indicating so.
+
 `option`
 ~~~~~~~~
 Processes the specified option so that git fast-import behaves in a
diff --git a/fast-import.c b/fast-import.c
index 74f08bd..ff56ea2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2821,6 +2821,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		relative_marks_paths = 0;
 	} else if (!prefixcmp(feature, "force")) {
 		force_update = 1;
+	} else if (!strcmp(feature, "notes")) {
+		; /* do nothing; we have the feature */
 	} else {
 		return 0;
 	}
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index a5c99d8..164edf0 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -120,6 +120,7 @@ test_expect_success 'add notes with simple M command' '
 
 test_tick
 cat >input <<INPUT_END
+feature notes
 commit refs/notes/test
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
-- 
1.7.4
