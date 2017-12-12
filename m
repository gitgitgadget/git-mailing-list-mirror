Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC6F1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 23:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbdLLXXo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 12 Dec 2017 18:23:44 -0500
Received: from elephants.elehost.com ([216.66.27.132]:42318 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbdLLXXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:23:43 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBCNNfo9025238
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Dec 2017 18:23:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com>        <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com>        <006301d372df$e82cf410$b886dc30$@nexbridge.com> <xmqqtvwvy1rh.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtvwvy1rh.fsf@gitster.mtv.corp.google.com>
Subject: RE: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
Date:   Tue, 12 Dec 2017 18:23:35 -0500
Message-ID: <004b01d373a0$3ec759d0$bc560d70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKyKGo4qh2sJ7CV4r7D/ydkuQ0kwQIINdwwAgXasQgB63y8y6FTIgbA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On December 12, 2017 6:18 PM Junio C Hamano wrote:
Subject: Re: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>> I can send you a pull request on github, if you want 😉
>I don't.  It's not that I can or cannot take a pull request.  I just do not want to queue anything that is not reviwed on list.
No worries.

>I however could queue this (typed to mimic what I saw in your message), but you'd need to say what you see here is OK (and preferably, you applied this version and it tested fine); I may have made a typo or two, and I would really prefer extra set of eyes.
Yes, needed. The lines wrapped om Documentation/Makefile - each change in quick-install-man/html should be exactly one line:

quick-install-man: require-manrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir) $(GIT_MAN_REF)
 
And here

 quick-install-html: require-htmlrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir) $(GIT_MAN_REF)

And otherwise please consider it signed off.

Signed-off-by: Randall S. Becker <randall.becker@nexbridge.ca>

-- >8 --
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Sat, 9 Dec 2017 17:07:57 -0500
Subject: [PATCH] install-doc-quick: allow specifying what ref to install

We allow the builders, who want to install the preformatted manpages and html documents, to specify where in their filesystem these two repositories are stored.  Let them also specify which ref (or even a
revision) to grab the preformatted material from.
---
 Documentation/Makefile             | 5 +++--
 Documentation/install-doc-quick.sh | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile index 2ab65561af..4ae9ba5c86 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -39,6 +39,7 @@ MAN7_TXT += gitworkflows.txt  MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)  MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))  MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
+GIT_MAN_REF = master
 
 OBSOLETE_HTML += everyday.html
 OBSOLETE_HTML += git-remote-helpers.html @@ -437,14 +438,14 @@ require-manrepo::
 	then echo "git-manpages repository must exist at $(MAN_REPO)"; exit 1; fi
 
 quick-install-man: require-manrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) 
+$(DESTDIR)$(mandir) $(GIT_MAN_REF)
 
 require-htmlrepo::
 	@if test ! -d $(HTML_REPO); \
 	then echo "git-htmldocs repository must exist at $(HTML_REPO)"; exit 1; fi
 
 quick-install-html: require-htmlrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) 
+$(DESTDIR)$(htmldir) $(GIT_MAN_REF)
 
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index 327f69bcf5..17231d8e59 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -3,11 +3,12 @@
 
 repository=${1?repository}
 destdir=${2?destination}
+GIT_MAN_REF=${3?master}
 
-head=master GIT_DIR=
+GIT_DIR=
 for d in "$repository/.git" "$repository"
 do
-	if GIT_DIR="$d" git rev-parse refs/heads/master >/dev/null 2>&1
+	if GIT_DIR="$d" git rev-parse "$GIT_MAN_REF" >/dev/null 2>&1
 	then
 		GIT_DIR="$d"
 		export GIT_DIR
@@ -27,12 +28,12 @@ export GIT_INDEX_FILE GIT_WORK_TREE  rm -f "$GIT_INDEX_FILE"
 trap 'rm -f "$GIT_INDEX_FILE"' 0
 
-git read-tree $head
+git read-tree "$GIT_MAN_REF"
 git checkout-index -a -f --prefix="$destdir"/
 
 if test -n "$GZ"
 then
-	git ls-tree -r --name-only $head |
+	git ls-tree -r --name-only "$GIT_MAN_REF" |
 	xargs printf "$destdir/%s\n" |
 	xargs gzip -f
 fi
--
2.15.1-525-g09180b8600

