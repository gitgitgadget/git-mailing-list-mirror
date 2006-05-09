From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 18:09:55 -0400
Message-ID: <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	<BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
	<e3p5om$djs$1@sea.gmane.org>
	<Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
	<BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 00:15:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdaU5-0001bv-83
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWEIWPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWEIWPH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:15:07 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:11982 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751215AbWEIWPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 18:15:06 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 15:15:05 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0D671644C28;
	Tue,  9 May 2006 18:15:04 -0400 (EDT)
To: torvalds@osdl.org
Message-Id: <20060509180955.373a2c1d.seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 22:15:05.0574 (UTC) FILETIME=[066DD060:01C673B6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 9 May 2006 15:44:59 -0400
sean <seanlkml@sympatico.ca> wrote:

> On Tue, 9 May 2006 12:24:02 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > NOTE! This patch could be applied right now, and to all the branches (to
> > make 1.x, 1.2.x and 1.3.x all support the _syntax_). Even if nothing 
> > actually uses it.
> > 
> > It just makes the syntax be
> > 
> > 	[section<space>+"<randomstring>"]
> > 
> > where the only rule for "randomstring" is that it can't contain a newline, 
> > and if you really want to insert a double-quote, you do it with \".
> 
> Lightly tested here.  Looks good.
> 

Linus,

I really tried to like your patch ;o)  But it breaks the repo-config command
line and causes mixing of some branches using old style [branch.xyz] and new
style [branch "XYZ"] which just doesn't seem to be the right thing to do.

The following patch produced for sake of discussion just allows section
headers to contain whatever characters are needed to get the job done.

git-repo-config works properly with no further need of change.  Section
headers become case sensitive but key identifiers within sections do not.
AFAIK there should be no backward compatibility issues with regard to
case sensitivity.  All tests pass after having been fixed up to remove
the assumption that section names are case insensitive.

The syntax is:

  [<random string>]

Here's how your example would look in this style:

  [email.torvalds@osdl.org]
        name = Linus Torvalds

And there's no strange syntax needed with repo-config to set and get it:

  $ git repo-config email.torvalds@osdl.org.name
  Linus Torvalds

and just to show that key names are still case insensitive:

  $ git repo-config email.torvalds@osdl.org.NAME
  Linus Torvalds

Setting new sections is unambiguous from the command line and
doesn't have to decide whether to use the [branch "<string>"] or
[branch.section.name] format.

  $ git repo-config branch.branch.x y
  $ git repo-config branch.WonkKY.x y
  $ git repo-config --get-regexp branch.\*
  branch.branch.x y
  branch.WonkKY.x y

  [email.torvalds@osdl.org]
        name = Linus Torvalds
  [branch.branch]
        x = y
  [branch.WonkKY]
        x = y

Sean
---

 config.c               |   11 +++++++----
 repo-config.c          |    8 ++++----
 t/t1300-repo-config.sh |   38 ++++++++++++++++++++++----------------
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/config.c b/config.c
index 0f518c9..5d19ae9 100644
--- a/config.c
+++ b/config.c
@@ -144,11 +144,14 @@ static int get_base_var(char *name)
 			return -1;
 		if (c == ']')
 			return baselen;
-		if (!isalnum(c) && c != '.')
-			return -1;
+		if (c == '\\') {
+			c = get_next_char();
+			if (c == '\n')
+				return -1;
+		}
 		if (baselen > MAXNAME / 2)
 			return -1;
-		name[baselen++] = tolower(c);
+		name[baselen++] = c;
 	}
 }
 
@@ -455,7 +458,7 @@ int git_config_set_multivar(const char* 
 			ret = 1;
 			goto out_free;
 		} else
-			store.key[i] = tolower(key[i]);
+			store.key[i] = key[i];
 	store.key[i] = 0;
 
 	/*
diff --git a/repo-config.c b/repo-config.c
index 63eda1b..ba5fbd6 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -65,11 +65,11 @@ static int show_config(const char* key_,
 static int get_value(const char* key_, const char* regex_)
 {
 	int i;
+	char *tl;
 
-	key = malloc(strlen(key_)+1);
-	for (i = 0; key_[i]; i++)
-		key[i] = tolower(key_[i]);
-	key[i] = 0;
+	key = strdup(key_);
+	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
+		*tl = tolower(*tl);
 
 	if (use_key_regexp) {
 		key_regexp = (regex_t*)malloc(sizeof(regex_t));
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 7090ea9..f341206 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -23,6 +23,7 @@ git-repo-config Core.Movie BadPhysics
 cat > expect << EOF
 [core]
 	penguin = little blue
+[Core]
 	Movie = BadPhysics
 EOF
 
@@ -33,6 +34,7 @@ git-repo-config Cores.WhatEver Second
 cat > expect << EOF
 [core]
 	penguin = little blue
+[Core]
 	Movie = BadPhysics
 [Cores]
 	WhatEver = Second
@@ -45,10 +47,12 @@ git-repo-config CORE.UPPERCASE true
 cat > expect << EOF
 [core]
 	penguin = little blue
+[Core]
 	Movie = BadPhysics
-	UPPERCASE = true
 [Cores]
 	WhatEver = Second
+[CORE]
+	UPPERCASE = true
 EOF
 
 test_expect_success 'similar section' 'cmp .git/config expect'
@@ -62,11 +66,13 @@ test_expect_success 'replace with non-ma
 cat > expect << EOF
 [core]
 	penguin = very blue
-	Movie = BadPhysics
-	UPPERCASE = true
 	penguin = kingpin
+[Core]
+	Movie = BadPhysics
 [Cores]
 	WhatEver = Second
+[CORE]
+	UPPERCASE = true
 EOF
 
 test_expect_success 'non-match result' 'cmp .git/config expect'
@@ -130,7 +136,7 @@ EOF
 
 test_expect_success 'really mean test' 'cmp .git/config expect'
 
-git-repo-config nextsection.nonewline wow
+git-repo-config nextSection.nonewline wow
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -160,7 +166,7 @@ EOF
 
 test_expect_success 'unset' 'cmp .git/config expect'
 
-git-repo-config nextsection.NoNewLine "wow2 for me" "for me$"
+git-repo-config nextSection.NoNewLine "wow2 for me" "for me$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -176,18 +182,18 @@ EOF
 test_expect_success 'multivar' 'cmp .git/config expect'
 
 test_expect_success 'non-match' \
-	'git-repo-config --get nextsection.nonewline !for'
+	'git-repo-config --get nextSection.nonewline !for'
 
 test_expect_success 'non-match value' \
-	'test wow = $(git-repo-config --get nextsection.nonewline !for)'
+	'test wow = $(git-repo-config --get nextSection.nonewline !for)'
 
 test_expect_failure 'ambiguous get' \
-	'git-repo-config --get nextsection.nonewline'
+	'git-repo-config --get nextSection.nonewline'
 
 test_expect_success 'get multivar' \
-	'git-repo-config --get-all nextsection.nonewline'
+	'git-repo-config --get-all nextSection.nonewline'
 
-git-repo-config nextsection.nonewline "wow3" "wow$"
+git-repo-config nextSection.nonewline "wow3" "wow$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -202,15 +208,15 @@ EOF
 
 test_expect_success 'multivar replace' 'cmp .git/config expect'
 
-test_expect_failure 'ambiguous value' 'git-repo-config nextsection.nonewline'
+test_expect_failure 'ambiguous value' 'git-repo-config nextSection.nonewline'
 
 test_expect_failure 'ambiguous unset' \
-	'git-repo-config --unset nextsection.nonewline'
+	'git-repo-config --unset nextSection.nonewline'
 
 test_expect_failure 'invalid unset' \
-	'git-repo-config --unset somesection.nonewline'
+	'git-repo-config --unset someSection.nonewline'
 
-git-repo-config --unset nextsection.nonewline "wow3$"
+git-repo-config --unset nextSection.nonewline "wow3$"
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -249,7 +255,7 @@ test_expect_success 'hierarchical sectio
 
 cat > expect << EOF
 beta.noindent=sillyValue
-nextsection.nonewline=wow2 for me
+nextSection.nonewline=wow2 for me
 123456.a123=987
 1.2.3.alpha=beta
 EOF
@@ -259,7 +265,7 @@ test_expect_success 'working --list' \
 
 cat > expect << EOF
 beta.noindent sillyValue
-nextsection.nonewline wow2 for me
+nextSection.nonewline wow2 for me
 EOF
 
 test_expect_success '--get-regexp' \
