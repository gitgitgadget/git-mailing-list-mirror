From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/13] Add a validation script
Date: Wed,  7 Jul 2010 02:14:53 +0200
Message-ID: <1278461693-3828-14-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: dev-return-4823-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 02:14:24 2010
Return-path: <dev-return-4823-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4823-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWIHP-00053Z-0B
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 02:14:23 +0200
Received: (qmail 99344 invoked by uid 500); 7 Jul 2010 00:14:21 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 99336 invoked by uid 99); 7 Jul 2010 00:14:21 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:21 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.43 as permitted sender)
Received: from [209.85.215.43] (HELO mail-ew0-f43.google.com) (209.85.215.43)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:13 +0000
Received: by ewy1 with SMTP id 1so2219933ewy.16
        for <dev@subversion.apache.org>; Tue, 06 Jul 2010 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zZ+sE92fyj8OUbF37gfExuMekPYQHTpowByU4G7qEuU=;
        b=prQS2IdYmbyKV4pfMzE/P3rHJU6A9OJcko780qxX1S6iA6AWvZXoo+X7ARSGWB6PfX
         2IYHQJK1W4NOs/QzZ0XxEpYkUbGKUIbS6V0hJoYsw1Ge6tCUJsvMQjvS63eT6FKUTULX
         GhpBXbKSO3D3IidcMJQvfaBJ4bsNrDrA97Jhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vdxYROhCuOGE4fRvGfr/fLZgAUZKg2XJb4HM+bHxoc8/73I31ECpDpzRf+AS6Njs0C
         vbL/Y8h8mJOZ8XOMkv0As4HnBd+OZJ+ZhZImQFZeVO5u1WxSN8W/KLSDheSlpi3I+VWi
         HIQK3ekz71lsIFTNBmP5JnbMp5ClmI+pRDwbs=
Received: by 10.213.15.206 with SMTP id l14mr3911642eba.56.1278461632856;
        Tue, 06 Jul 2010 17:13:52 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm55905762eei.0.2010.07.06.17.13.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150432>

Add a validation script along with a .gitignore. Using an existing
dump known to be correct (possibly generated using `svnsync` and
`svnadmin dump --deltas`), it compares the outputs produced by
`svnadmin load` when fed with this dump and the dump from the program.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 .gitignore  |    4 ++++
 validate.sh |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
 create mode 100755 validate.sh

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..3e9b906
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,4 @@
+*~
+t/
+svndumpr
+svndumpr_bench
diff --git a/validate.sh b/validate.sh
new file mode 100755
index 0000000..7b25db6
--- /dev/null
+++ b/validate.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# asf.dump must exist in t/
+# Compile the program with end_revision = $2 when using the second branch
+
+case $1 in
+    generate)
+	[ -z $2 ] && { echo "Usage: $0 $1 <revision>"; exit 1; } || echo "Starting generation ...";
+	if test -e "t/asf.dump"
+	    then :;
+	else
+	    echo "Need t/asf.dump (dumpfile v3) first. Generate it yourself or steal it from someone.";
+	    exit 1;
+	fi
+	rm -rf t/repo;
+	mkdir t/repo;
+	svnadmin create t/repo;
+	gawk "/Revision-number: $(($2 + 1))/ { exit 1 }; { print \$0 };" t/asf.dump > "t/asf-$2.dump";
+	[ $? = 1 ] && echo "Cut $2 succeeded!" || { echo "Cut $2 failed. Check t/asf.dump and validate.sh."; exit 1; }
+	svnadmin load t/repo < "t/asf-$2.dump" 1>"t/asf-$2-import.log" 2>"t/asf-$2-import.error";
+	[ $? = 0 ] && echo "Load $2 succeeded!" || { echo "Load $2 failed. See t/asf-$2-import.debug for details."; exit 1; }
+	echo "Successfully generated asf-$2.dump and asf-$2-import.log. You can now run validate.sh validate $2"
+	exit 0;;
+    validate)
+	[ -z $2 ] && { echo "Usage: $0 $1 <revision>"; exit 1; } || echo "Starting validation ...";
+	if test -e "t/asf-$2.dump" && test -e "t/asf-$2-import.log"
+	    then :;
+	else
+	    echo "Run validate.sh genereate $2 first.";
+	    exit 1;
+	fi
+	rm -rf /tmp/svn-fe;
+	mkdir /tmp/svn-fe;
+	rm -rf t/repo;
+	mkdir t/repo;
+	svnadmin create t/repo;
+	make svndumpr > /dev/null;
+	[ $? = 0 ] && echo "Make succeeded!" || { echo "Make failed. Check the program."; exit 1; }
+	./svndumpr 1>t/asf-mine.dump;
+	[ $? = 0 ] && echo "Run succeeded!" || { echo "Run failed. See t/asf.debug for details."; exit 1; }
+	diff -au "t/asf-$2.dump" t/asf-mine.dump > t/dump-diff.error;
+	gawk '$0 !~ "Prop-delta: true|Text-delta-base-|sha1|Text-copy-source-|^-$" && $0 ~ "^+|^-" { print; }' t/dump-diff.error > t/dump-diff-filtered.error;
+	svnadmin load t/repo < t/asf-mine.dump 1>t/asf-mine-import.log 2>t/asf-mine-import.error;
+	[ $? = 0 ] && echo "Load $2 succeeded!" || { echo "Load failed. See t/asf-mine-import.error, t/dump-diff.error, and t/dump-diff-filtered.error for details."; exit 1; }
+	diff -au "t/asf-$2-import.log" t/asf-mine-import.log > t/import-diff.error;
+	[ $? = 0 ] && echo "Validation $2 succeeded!" || { echo "Validation failed. See t/import-diff.error for details."; exit 1; }
+	exit 0;;
+    *)
+	echo "Usage: $0 <operation> <revision>";
+	exit 1;;
+esac
-- 
1.7.1
