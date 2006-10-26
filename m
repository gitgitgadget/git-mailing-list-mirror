X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] diff-format.txt: Combined diff format documentation supplement
Date: Thu, 26 Oct 2006 05:44:49 +0200
Message-ID: <200610260544.50614.jnareb@gmail.com>
References: <ehoo2k$1g6$1@sea.gmane.org> <7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 03:44:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nmZ2r/LON5MUJW/BIryYbbY7QLqYjrknsx/mYnDbcNUwGt6WE6do6uyhnwl0Jyn+AX8l9ZxJAlpjnQzQyYC2hU4zSh7tYoinAV7/fxVHRmv5Mf1tEKNzWXjBXUka0GcrQ7fPldwdpEv/xmaQx6YBADk873kEmUH/0e4D22NyymU=
User-Agent: KMail/1.9.3
In-Reply-To: <7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30136>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcwAK-0007ns-OK for gcvg-git@gmane.org; Thu, 26 Oct
 2006 05:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422916AbWJZDoR convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 23:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWJZDoR
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 23:44:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:58058 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1422916AbWJZDoQ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 23:44:16 -0400
Received: by ug-out-1314.google.com with SMTP id 32so280482ugm for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 20:44:15 -0700 (PDT)
Received: by 10.67.117.2 with SMTP id u2mr2046520ugm; Wed, 25 Oct 2006
 20:44:14 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id g30sm17953ugd.2006.10.25.20.44.14; Wed, 25 Oct
 2006 20:44:14 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Update example combined diff format to the current version
$ git diff-tree -p -c fec9ebf16c948bcb4a8b88d0173ee63584bcde76
and provide complete first chunk in example.

Document combined diff format headers: how "diff header" look like,
which of "extended diff headers" are used with combined diff and how
they look like, differences in two-line from-file/to-file header from
non-combined diff format, chunk header format.

It should be noted that combined diff format was designed for quick
_content_ inspection and renames would work correctly to pick which
blobs from each tree to compare but otherwise not reflected in the
output (the pathnames are not shown).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano napisa=B3:
> Patches to documentation would be easier to comment on and more
> productive, I guess.

So here you have. It should perhaps get review on validity by someone
well versed in the combined diff generation code. There are some guesse=
s
here...

It compiles, but the output was not inspected.


 Documentation/diff-format.txt |   70 +++++++++++++++++++++++++++++++++=
+++++---
 1 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.=
txt
index 617d8f5..0d04b03 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -156,18 +156,78 @@ to produce 'combined diff', which looks=20
=20
 ------------
 diff --combined describe.c
-@@@ +98,7 @@@
-   return (a_date > b_date) ? -1 : (a_date =3D=3D b_date) ? 0 : 1;
+index fabadb8,cc95eb0..4866510
+--- a/describe.c
++++ b/describe.c
+@@@ -98,20 -98,12 +98,20 @@@
+  	return (a_date > b_date) ? -1 : (a_date =3D=3D b_date) ? 0 : 1;
   }
-
+ =20
 - static void describe(char *arg)
  -static void describe(struct commit *cmit, int last_one)
 ++static void describe(char *arg, int last_one)
   {
- +     unsigned char sha1[20];
- +     struct commit *cmit;
+ +	unsigned char sha1[20];
+ +	struct commit *cmit;
+  	struct commit_list *list;
+  	static int initialized =3D 0;
+  	struct commit_name *n;
+ =20
+ +	if (get_sha1(arg, sha1) < 0)
+ +		usage(describe_usage);
+ +	cmit =3D lookup_commit_reference(sha1);
+ +	if (!cmit)
+ +		usage(describe_usage);
+ +
+  	if (!initialized) {
+  		initialized =3D 1;
+  		for_each_ref(get_name);
 ------------
=20
+1.   It is preceded with a "git diff" header, that looks like
+     this (when '-c' option is used):
+
+       diff --combined fileM
+
+     or like this (when '--cc' option is used):
+
+       diff --c fileM
+
+2.   It is followed by one or more extended header lines
+     (we assume here that we have merge with two parents):
+
+       index <hash>,<hash>..<hash>
+       mode <mode>,<mode>..<mode>
+       new file mode <mode>
+
+     The "mode <mode>,<mode>..<mode>" appears only if at least
+     one of the <mode> is diferent from the rest. Extended headers
+     with information about detected contents movement (renames
+     and copying detection) are designed to work with diff of two
+     <tree-ish> and are not used by combined diff format. Currently
+     combined diff format cannot show files which were removed
+     by merge, so "deleted file mode <mode>,<mode>" is never used.
+
+3.   It is followed by two-line from-file/to-file header
+
+       --- a/fileM
+       +++ b/fileM
+
+     Contrary to two-line header for traditional 'unified' diff
+     format, and similar to filenames in ordinary "diff header",
+     /dev/null is not used for creation combined diff.
+
+4.   Chunk header format is modified to prevent people from
+     accidentally feeding it to 'patch -p1'. Combined diff format
+     was created for review of merge commit changes, and was not
+     meant for apply. The change is similar to the change in the
+     extended 'index' header
+
+       @@@ <from-file-range> <from-file-range> <to-file-range> @@@
+
+     It might be not obvious that we have number of parents + 1
+     '@' characters in chunk header for combined diff format.
+
 Unlike the traditional 'unified' diff format, which shows two
 files A and B with a single column that has `-` (minus --
 appears in A but removed in B), `+` (plus -- missing in A but
--=20
1.4.2.1



--=20
Jakub Narebski
