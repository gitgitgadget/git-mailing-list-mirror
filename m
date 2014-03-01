From: Lee Hopkins <leerhop@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Sat, 1 Mar 2014 14:38:47 -0500
Message-ID: <CAJHY66G9WkL7sk99GhiyxjWCTkX_ip7Qb8P5gF9ovgQ-A+Yjyw@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de>
	<530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net>
	<5310959D.709@gmail.com>
	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com>
	<CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
	<53118436.5080507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 01 20:38:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJpkL-0004IA-1g
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 20:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbaCATit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 14:38:49 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:64223 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbaCATis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 14:38:48 -0500
Received: by mail-qa0-f45.google.com with SMTP id hw13so2059667qab.32
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=44epjRwiOFEjWWecodoUZkKHt9ud3oO9uCDCWkaR9qs=;
        b=wkQVl4FJ2vlofF2KLmOFBxTNhAczUJ++rsBEiZALfYiUm5q6nxZuuPTr3XhQj5NrAa
         OpCVXwCGNomQWs517inCsRdSKW0ruDsAkCFxmo65auuR67zMNR9eHrdPTbIAQ//eKp++
         4wtfwDQczkaQENhOrpoA1Ghruhn2th3FDnge1/l9i+GNfc/puVU92DJe/f3uDKF3tuyM
         AVj83p9cxfLglSKJas0NvXz7ezEGrIzRQmFbxoC1hAwNP9pvQhIPDALg4qzw3vXXYeId
         JUP4jmVbB/geZv+9MjhCEys13bucNuB4HoxLpBaJPhh0kbxWMnMATtDs6W1tj3r0RZ3m
         Knwg==
X-Received: by 10.224.113.204 with SMTP id b12mr12719011qaq.35.1393702727435;
 Sat, 01 Mar 2014 11:38:47 -0800 (PST)
Received: by 10.140.106.69 with HTTP; Sat, 1 Mar 2014 11:38:47 -0800 (PST)
In-Reply-To: <53118436.5080507@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243108>

Incorporating Torsten suggestions and some documentation:

---
 Documentation/config.txt |   12 ++++++++++++
 builtin/init-db.c        |    4 +++-
 config.c                 |    5 +++++
 environment.c            |    1 +
 refs.c                   |   26 +++++++++++++++++++++++---
 5 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 040197b..c0a6c5c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2077,6 +2077,18 @@ receive.shallowupdate::
  If set to true, .git/shallow can be updated when new refs
  require new shallow roots. Otherwise those refs are rejected.

+refs.ignorecase::
+ If true, this option prevents the creation of ref names
+ that differ in case only. For example, if a branch Foo exists,
+ `git checkout -b foo` would fail. This is the case
+ across ref hierarchies, so `git tag foo` would also fail.
+ This option is useful on filesystems that are not case
+ sensitive.
++
+The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set refs.ignorecase true if appropriate when the repository
+is created. refs.ignorecase will also be true if core.ignorecase is true.
+
 remote.pushdefault::
  The remote to push to by default.  Overrides
  `branch.<name>.remote` for all branches, and is overridden by
diff --git a/builtin/init-db.c b/builtin/init-db.c
index c7c76bb..7c6931b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -288,8 +288,10 @@ static int create_default_files(const char *template_path)
  /* Check if the filesystem is case-insensitive */
  path[len] = 0;
  strcpy(path + len, "CoNfIg");
- if (!access(path, F_OK))
+ if (!access(path, F_OK)) {
  git_config_set("core.ignorecase", "true");
+ git_config_set("refs.ignorecase", "true");
+ }
  probe_utf8_pathname_composition(path, len);
  }

diff --git a/config.c b/config.c
index 314d8ee..797391a 100644
--- a/config.c
+++ b/config.c
@@ -702,6 +702,11 @@ static int git_default_core_config(const char
*var, const char *value)
  return 0;
  }

+ if (!strcmp(var, "refs.ignorecase")) {
+ refs_ignore_case = git_config_bool(var, value);
+ return 0;
+ }
+
  if (!strcmp(var, "core.attributesfile"))
  return git_config_pathname(&git_attributes_file, var, value);

diff --git a/environment.c b/environment.c
index 4a3437d..2eced48 100644
--- a/environment.c
+++ b/environment.c
@@ -18,6 +18,7 @@ int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
+int refs_ignore_case = -1;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
diff --git a/refs.c b/refs.c
index 89228e2..1915ec2 100644
--- a/refs.c
+++ b/refs.c
@@ -359,16 +359,26 @@ struct string_slice {
  const char *str;
 };

-static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
+static int ref_entry_ncmp(const void *key_, const void *ent_, int
(*cmp_fn)(const char *, const char *, size_t))
 {
  const struct string_slice *key = key_;
  const struct ref_entry *ent = *(const struct ref_entry * const *)ent_;
- int cmp = strncmp(key->str, ent->name, key->len);
+ int cmp = cmp_fn(key->str, ent->name, key->len);
  if (cmp)
  return cmp;
  return '\0' - (unsigned char)ent->name[key->len];
 }

+static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
+{
+ return ref_entry_ncmp(key_, ent_, strncmp);
+}
+
+static int ref_entry_casecmp_sslice(const void *key_, const void *ent_)
+{
+ return ref_entry_ncmp(key_, ent_, strncasecmp);
+}
+
 /*
  * Return the index of the entry with the given refname from the
  * ref_dir (non-recursively), sorting dir if necessary.  Return -1 if
@@ -378,6 +388,7 @@ static int search_ref_dir(struct ref_dir *dir,
const char *refname, size_t len)
 {
  struct ref_entry **r;
  struct string_slice key;
+ int (*cmp_fn)(const void *, const void *);

  if (refname == NULL || !dir->nr)
  return -1;
@@ -385,8 +396,17 @@ static int search_ref_dir(struct ref_dir *dir,
const char *refname, size_t len)
  sort_ref_dir(dir);
  key.len = len;
  key.str = refname;
+
+ if(refs_ignore_case < 0)
+ refs_ignore_case  = ignore_case;
+
+ if(ignore_case)
+ cmp_fn = ref_entry_casecmp_sslice;
+ else
+ cmp_fn = ref_entry_cmp_sslice;
+
  r = bsearch(&key, dir->entries, dir->nr, sizeof(*dir->entries),
-    ref_entry_cmp_sslice);
+ cmp_fn);

  if (r == NULL)
  return -1;
--
