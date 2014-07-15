From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 15 Jul 2014 13:58:03 -0700
Message-ID: <CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
	<20140715180424.GJ12427@google.com>
	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 22:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X79nf-0007JW-H9
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 22:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbaGOU6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 16:58:06 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:59432 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbaGOU6E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 16:58:04 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so4759378vcb.37
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N53C30HDc1CLv0I051riMWW5QDLsiWVLtV1S2lJgeGo=;
        b=DCfJo6Cc2N8vJJUp4v2kWgXRHCeZ6ixoKLtcup4RXI0/c7Xq8m9wXxEHc+cfOIy5mr
         FoA0rziw6R02uAelPF/Huael9YAqxj/Qi7fX8vUPm4fAV4GlALXOu9N9+/NOLJpnhInL
         BwtBlHbUXGVL+MreF55mEqhuOB0nQlbHKmnd4+KVUZP4WqKxNeZL/FFtEiVq/kjCWqb0
         IlCpfIQ9d9zsR2iDpPjAq1NEMMi1MaZAfYsBMEMTUxaqtgUhMKaleW6a46AQigRmuK+f
         q/+BampA7yFpN0a+qYVpWEXJLt3WsGoGhBzylgc2NiG6WZCyzTsvphGFYF3YYvGzUVlc
         R5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N53C30HDc1CLv0I051riMWW5QDLsiWVLtV1S2lJgeGo=;
        b=Z0msfo9k7V+T+IVpC4tQST6Du1nDfkF3kfUqg0nAI0Vu0GUwNZhYwF+z1sg/jEI5eZ
         sX67gfo1+75C5lgg8hoMEwjzhn0AUWxnZpj5MtF2oMLAhfFZQih6PpOefzx0I8dfmVmE
         bJczbMy4xiGxQufLpoYgAbqqb761lkaozzFZZfoW/wDNRo0Lg69SCSIoOf1TYxR14xKo
         WdS2QAHKsqjNoRaXaDHmh1CK6r1t/0w1c4Pj3fxcNgF7uvVkdLHYQGZ52mn97Gvd5ijn
         ioUabMzGwUEK5y+75wMz8/oK8djjeBQ3yorl8FeIU+t+ijn+YuiiTfhfevkDdLnA6HYw
         iY0A==
X-Gm-Message-State: ALoCoQlzVKdp6A+1UIj0CFX3NTzVxkPuEuTTKvC6HdzVzqy/9S1fyUEPV+Crs+DOJDL8sHDcd+la
X-Received: by 10.220.196.207 with SMTP id eh15mr761311vcb.78.1405457883182;
 Tue, 15 Jul 2014 13:58:03 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 15 Jul 2014 13:58:03 -0700 (PDT)
In-Reply-To: <CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253601>

On Tue, Jul 15, 2014 at 12:34 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Tue, Jul 15, 2014 at 11:04 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Michael Haggerty wrote:
>>
>>> So...I like the idea of enforcing refname checks at the lowest level
>>> possible, but I think that the change you propose is too abrupt.  I
>>> think it needs either more careful analysis showing that it won't hurt
>>> anybody, or some kind of tooling or non-strict mode that people can use
>>> to fix their repositories.
>>
>> The recovery code has been broken for a while, so I don't see harm
>> in this change.
>>
>> How to take care of the recovery use case is another question.  FWIW I
>> also would prefer if "git update-ref -d" or "git branch -D" could be
>> used to delete corrupt refs instead of having to use fsck (since a
>> fsck run can take a while), but that's a question for a later series.
>>
>> In an ideal world, the low-level functions would allow *reading* and
>> *deleting* poorly named refs (even without any special flag) but not
>> creating them.  Is that doable?
>
> That should be doable. Ill add these repairs as 3-4 new patches at the
> end of the current patch series.
>
>> The main complication I can see is
>> iteration: would iteration skip poorly named refs and warn, or would
>> something more complicated be needed?
>
> Right now,  "git branch"  will error and abort right away when it
> finds the first bad ref. I haven't checked the exact spot it does this
> yet but I suspect it is when building the ref-cache.
> I will solve the cases for create and delete for now.
>
>
> What/how to handle iterables will require more thought.
> Right now, since these refs will be filtered out and never end up in
> ref-cache, either from loose refs or from packed refs
> it does mean that anyone that uses an iterator is guaranteed to only
> get refs with valid names passed back to them.
> We would need to audit all code that uses iterators and make sure it
> can handle the case where the callback is suddenly
> invoked with a bad refname.
>
>>
>> Thanks,
>> Jonathan

The following seems to do the trick to allow deleting a bad ref. We
would need something for the iterator too.
Since this touches the same areas that my ~100 other ref transaction
patches that are queued up do, I
would like to wait applying this patch until once the next few series
are finished and merged.
(to avoid having to do a lot of rebases and fix legio of merge
conflicts that this would introduce in my branches).


Treat this as an approximation on what the fix to repair git branch -D
will look like once the time comes.

regards
ronnie sahlberg



===

commit a2514213999a192c9995a3a5e1479d7d09e2c083
Author: Ronnie Sahlberg <sahlberg@google.com>
Date:   Tue Jul 15 12:59:36 2014 -0700

    refs.c: fix handling of badly named refs

    We currently do not handle badly named refs well :
    $ cp .git/refs/heads/master .git/refs/heads/master.....@\*@\\.
    $ git branch
       fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'
    $ git branch -D master.....@\*@\\.
      error: branch 'master.....@*@\.' not found.

    But we can not really recover from a badly named ref with less than
    manually deleting the .git/refs/heads/<refname> file.

    Change resolve_ref_unsafe to take a flags field instead of a 'reading'
    boolean and update all callers that used a non-zero value for reading
    to pass the flag RESOLVE_REF_READING instead.
    Add another flag RESOLVE_REF_ALLOW_BAD_NAME that will make
    resolve_ref_unsafe skip checking the refname for sanity and use this
    from branch.c so that we will be able to call resolve_ref_unsafe on such
    refs when trying to delete it.
    Add checks for refname sanity when updating (not deleting) a ref in
    ref_transaction_update and in ref_transaction_create to make the transaction
    fail if an attempt is made to create/update a badly named ref.
    Since all ref changes will later go through the transaction layer this means
    we no longer need to check for and fail for bad refnames in
    lock_ref_sha1_basic.

    Change lock_ref_sha1_basic to not fail for bad refnames. Just check the
    refname, and print an error, and remember that the refname is bad so that
    we can skip calling verify_lock().

    Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

diff --git a/builtin/blame.c b/builtin/blame.c
index 662e3fe..76340e2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2278,7 +2278,7 @@ static struct commit
*fake_working_tree_commit(struct diff_options *opt,
  commit->object.type = OBJ_COMMIT;
  parent_tail = &commit->parents;

- if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+ if (!resolve_ref_unsafe("HEAD", head_sha1, RESOLVE_REF_READING, NULL))
  die("no such ref: HEAD");

  parent_tail = append_parent(parent_tail, head_sha1);
diff --git a/builtin/branch.c b/builtin/branch.c
index 652b1d2..5c95656 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -129,7 +129,8 @@ static int branch_merged(int kind, const char *name,
     branch->merge[0] &&
     branch->merge[0]->dst &&
     (reference_name = reference_name_to_free =
-     resolve_refdup(branch->merge[0]->dst, sha1, 1, NULL)) != NULL)
+     resolve_refdup(branch->merge[0]->dst, sha1,
+    RESOLVE_REF_READING, NULL)) != NULL)
  reference_rev = lookup_commit_reference(sha1);
  }
  if (!reference_rev)
@@ -233,7 +234,8 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds,
  free(name);

  name = mkpathdup(fmt, bname.buf);
- target = resolve_ref_unsafe(name, sha1, 0, &flags);
+ target = resolve_ref_unsafe(name, sha1,
+    RESOLVE_REF_ALLOW_BAD_NAME, &flags);
  if (!target ||
     (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
  error(remote_branch
diff --git a/builtin/clone.c b/builtin/clone.c
index b12989d..f7307e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -622,7 +622,7 @@ static int checkout(void)
  if (option_no_checkout)
  return 0;

- head = resolve_refdup("HEAD", sha1, 1, NULL);
+ head = resolve_refdup("HEAD", sha1, RESOLVE_REF_READING, NULL);
  if (!head) {
  warning(_("remote HEAD refers to nonexistent ref, "
   "unable to checkout.\n"));
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..d8ab177 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -602,7 +602,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,

  /* get current branch */
  current_branch = current_branch_to_free =
- resolve_refdup("HEAD", head_sha1, 1, NULL);
+ resolve_refdup("HEAD", head_sha1, RESOLVE_REF_READING, NULL);
  if (!current_branch)
  die("No current branch");
  if (starts_with(current_branch, "refs/heads/"))
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4135980..a5833fd 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -649,7 +649,8 @@ static void populate_value(struct refinfo *ref)

  if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
  unsigned char unused1[20];
- ref->symref = resolve_refdup(ref->refname, unused1, 1, NULL);
+ ref->symref = resolve_refdup(ref->refname, unused1,
+     RESOLVE_REF_READING, NULL);
  if (!ref->symref)
  ref->symref = "";
  }
@@ -707,7 +708,8 @@ static void populate_value(struct refinfo *ref)
  const char *head;
  unsigned char sha1[20];

- head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+ head = resolve_ref_unsafe("HEAD", sha1,
+  RESOLVE_REF_READING, NULL);
  if (!strcmp(ref->refname, head))
  v->s = "*";
  else
diff --git a/builtin/log.c b/builtin/log.c
index a7ba211..92db809 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1395,7 +1395,8 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
  if (check_head) {
  unsigned char sha1[20];
  const char *ref;
- ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+ ref = resolve_ref_unsafe("HEAD", sha1,
+ RESOLVE_REF_READING, NULL);
  if (ref && starts_with(ref, "refs/heads/"))
  branch_name = xstrdup(ref + strlen("refs/heads/"));
  else
diff --git a/builtin/remote.c b/builtin/remote.c
index 401feb3..be8ebac 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -568,7 +568,8 @@ static int read_remote_branches(const char *refname,
  strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
  if (starts_with(refname, buf.buf)) {
  item = string_list_append(rename->remote_branches, xstrdup(refname));
- symref = resolve_ref_unsafe(refname, orig_sha1, 1, &flag);
+ symref = resolve_ref_unsafe(refname, orig_sha1,
+    RESOLVE_REF_READING, &flag);
  if (flag & REF_ISSYMREF)
  item->util = xstrdup(symref);
  else
@@ -704,7 +705,7 @@ static int mv(int argc, const char **argv)
  int flag = 0;
  unsigned char sha1[20];

- read_ref_full(item->string, sha1, 1, &flag);
+ read_ref_full(item->string, sha1, RESOLVE_REF_READING, &flag);
  if (!(flag & REF_ISSYMREF))
  continue;
  if (delete_ref(item->string, NULL, REF_NODEREF))
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d873172..a9a5eb3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -727,7 +727,8 @@ int cmd_show_branch(int ac, const char **av, const
char *prefix)
  if (ac == 0) {
  static const char *fake_av[2];

- fake_av[0] = resolve_refdup("HEAD", sha1, 1, NULL);
+ fake_av[0] = resolve_refdup("HEAD", sha1,
+    RESOLVE_REF_READING, NULL);
  fake_av[1] = NULL;
  av = fake_av;
  ac = 1;
@@ -789,7 +790,8 @@ int cmd_show_branch(int ac, const char **av, const
char *prefix)
  }
  }

- head_p = resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
+ head_p = resolve_ref_unsafe("HEAD", head_sha1,
+    RESOLVE_REF_READING, NULL);
  if (head_p) {
  head_len = strlen(head_p);
  memcpy(head, head_p, head_len + 1);
diff --git a/bundle.c b/bundle.c
index 1222952..8aaf5f8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -311,7 +311,7 @@ int create_bundle(struct bundle_header *header,
const char *path,
  continue;
  if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
  continue;
- if (read_ref_full(e->name, sha1, 1, &flag))
+ if (read_ref_full(e->name, sha1, RESOLVE_REF_READING, &flag))
  flag = 0;
  display_ref = (flag & REF_ISSYMREF) ? e->name : ref;

diff --git a/cache.h b/cache.h
index 4ca4583..aab246d 100644
--- a/cache.h
+++ b/cache.h
@@ -948,7 +948,7 @@ extern int get_sha1_hex(const char *hex, unsigned
char *sha1);

 extern char *sha1_to_hex(const unsigned char *sha1); /* static buffer
result! */
 extern int read_ref_full(const char *refname, unsigned char *sha1,
- int reading, int *flags);
+ int flags, int *ref_flag);
 extern int read_ref(const char *refname, unsigned char *sha1);

 /*
@@ -960,17 +960,17 @@ extern int read_ref(const char *refname,
unsigned char *sha1);
  * or the input ref.
  *
  * If the reference cannot be resolved to an object, the behavior
- * depends on the "reading" argument:
+ * depends on the RESOLVE_REF_READING flag:
  *
- * - If reading is set, return NULL.
+ * - If RESOLVE_REF_READING is set, return NULL.
  *
- * - If reading is not set, clear sha1 and return the name of the last
- *   reference name in the chain, which will either be a non-symbolic
+ * - If RESOLVE_REF_READING is not set, clear sha1 and return the name of
+ *   the last reference name in the chain, which will either be a non-symbolic
  *   reference or an undefined reference.  If this is a prelude to
  *   "writing" to the ref, the return value is the name of the ref
  *   that will actually be created or changed.
  *
- * If flag is non-NULL, set the value that it points to the
+ * If ref_flag is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
  * packed references) and REF_ISSYMREF (if the initial reference was a
  * symbolic reference).
@@ -981,8 +981,10 @@ extern int read_ref(const char *refname, unsigned
char *sha1);
  *
  * errno is set to something meaningful on error.
  */
-extern const char *resolve_ref_unsafe(const char *ref, unsigned char
*sha1, int reading, int *flag);
-extern char *resolve_refdup(const char *ref, unsigned char *sha1, int
reading, int *flag);
+#define RESOLVE_REF_READING        0x01
+#define RESOLVE_REF_ALLOW_BAD_NAME 0x02
+extern const char *resolve_ref_unsafe(const char *ref, unsigned char
*sha1, int flags, int *ref_flag);
+extern char *resolve_refdup(const char *ref, unsigned char *sha1, int
flags, int *ref_flag);

 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
diff --git a/http-backend.c b/http-backend.c
index d2c0a62..059f790 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -417,7 +417,8 @@ static int show_head_ref(const char *refname,
const unsigned char *sha1,

  if (flag & REF_ISSYMREF) {
  unsigned char unused[20];
- const char *target = resolve_ref_unsafe(refname, unused, 1, NULL);
+ const char *target = resolve_ref_unsafe(refname, unused,
+ RESOLVE_REF_READING, NULL);
  const char *target_nons = strip_namespace(target);

  strbuf_addf(buf, "ref: %s\n", target_nons);
diff --git a/reflog-walk.c b/reflog-walk.c
index 9ce8b53..d80a42a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -48,7 +48,8 @@ static struct complete_reflogs
*read_complete_reflog(const char *ref)
  unsigned char sha1[20];
  const char *name;
  void *name_to_free;
- name = name_to_free = resolve_refdup(ref, sha1, 1, NULL);
+ name = name_to_free = resolve_refdup(ref, sha1,
+     RESOLVE_REF_READING, NULL);
  if (name) {
  for_each_reflog_ent(name, read_one_reflog, reflogs);
  free(name_to_free);
diff --git a/refs.c b/refs.c
index 221d8a7..dd9d61d 100644
--- a/refs.c
+++ b/refs.c
@@ -1194,7 +1194,8 @@ static void read_loose_refs(const char *dirname,
struct ref_dir *dir)
  hashclr(sha1);
  flag |= REF_ISBROKEN;
  }
- } else if (read_ref_full(refname.buf, sha1, 1, &flag)) {
+ } else if (read_ref_full(refname.buf, sha1,
+ RESOLVE_REF_READING, &flag)) {
  hashclr(sha1);
  flag |= REF_ISBROKEN;
  }
@@ -1346,21 +1347,21 @@ static const char
*handle_missing_loose_ref(const char *refname,
 }

 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char
*sha1, int reading, int *flag)
+const char *resolve_ref_unsafe(const char *refname, unsigned char
*sha1, int flags, int *ref_flag)
 {
  int depth = MAXDEPTH;
  ssize_t len;
  char buffer[256];
  static char refname_buffer[256];

- if (flag)
- *flag = 0;
+ if (ref_flag)
+ *ref_flag = 0;

- if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+ if (!(flags & RESOLVE_REF_ALLOW_BAD_NAME) &&
+    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
  errno = EINVAL;
  return NULL;
  }
-
  for (;;) {
  char path[PATH_MAX];
  struct stat st;
@@ -1387,7 +1388,8 @@ const char *resolve_ref_unsafe(const char
*refname, unsigned char *sha1, int rea
  if (lstat(path, &st) < 0) {
  if (errno == ENOENT)
  return handle_missing_loose_ref(refname, sha1,
- reading, flag);
+ flags & RESOLVE_REF_READING,
+ ref_flag);
  else
  return NULL;
  }
@@ -1407,8 +1409,8 @@ const char *resolve_ref_unsafe(const char
*refname, unsigned char *sha1, int rea
  !check_refname_format(buffer, 0)) {
  strcpy(refname_buffer, buffer);
  refname = refname_buffer;
- if (flag)
- *flag |= REF_ISSYMREF;
+ if (ref_flag)
+ *ref_flag |= REF_ISSYMREF;
  continue;
  }
  }
@@ -1453,21 +1455,21 @@ const char *resolve_ref_unsafe(const char
*refname, unsigned char *sha1, int rea
  */
  if (get_sha1_hex(buffer, sha1) ||
     (buffer[40] != '\0' && !isspace(buffer[40]))) {
- if (flag)
- *flag |= REF_ISBROKEN;
+ if (ref_flag)
+ *ref_flag |= REF_ISBROKEN;
  errno = EINVAL;
  return NULL;
  }
  return refname;
  }
- if (flag)
- *flag |= REF_ISSYMREF;
+ if (ref_flag)
+ *ref_flag |= REF_ISSYMREF;
  buf = buffer + 4;
  while (isspace(*buf))
  buf++;
  if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
- if (flag)
- *flag |= REF_ISBROKEN;
+ if (ref_flag)
+ *ref_flag |= REF_ISBROKEN;
  errno = EINVAL;
  return NULL;
  }
@@ -1475,9 +1477,9 @@ const char *resolve_ref_unsafe(const char
*refname, unsigned char *sha1, int rea
  }
 }

-char *resolve_refdup(const char *ref, unsigned char *sha1, int
reading, int *flag)
+char *resolve_refdup(const char *ref, unsigned char *sha1, int flags,
int *ref_flag)
 {
- const char *ret = resolve_ref_unsafe(ref, sha1, reading, flag);
+ const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
  return ret ? xstrdup(ret) : NULL;
 }

@@ -1488,22 +1490,22 @@ struct ref_filter {
  void *cb_data;
 };

-int read_ref_full(const char *refname, unsigned char *sha1, int
reading, int *flags)
+int read_ref_full(const char *refname, unsigned char *sha1, int
flags, int *ref_flag)
 {
- if (resolve_ref_unsafe(refname, sha1, reading, flags))
+ if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
  return 0;
  return -1;
 }

 int read_ref(const char *refname, unsigned char *sha1)
 {
- return read_ref_full(refname, sha1, 1, NULL);
+ return read_ref_full(refname, sha1, RESOLVE_REF_READING, NULL);
 }

 int ref_exists(const char *refname)
 {
  unsigned char sha1[20];
- return !!resolve_ref_unsafe(refname, sha1, 1, NULL);
+ return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
 }

 static int filter_refs(const char *refname, const unsigned char
*sha1, int flags,
@@ -1617,7 +1619,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
  return 0;
  }

- if (read_ref_full(refname, base, 1, &flag))
+ if (read_ref_full(refname, base, RESOLVE_REF_READING, &flag))
  return -1;

  /*
@@ -1783,7 +1785,7 @@ static int do_head_ref(const char *submodule,
each_ref_fn fn, void *cb_data)
  return 0;
  }

- if (!read_ref_full("HEAD", sha1, 1, &flag))
+ if (!read_ref_full("HEAD", sha1, RESOLVE_REF_READING, &flag))
  return fn("HEAD", sha1, flag, cb_data);

  return 0;
@@ -1863,7 +1865,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
  int flag;

  strbuf_addf(&buf, "%sHEAD", get_git_namespace());
- if (!read_ref_full(buf.buf, sha1, 1, &flag))
+ if (!read_ref_full(buf.buf, sha1, RESOLVE_REF_READING, &flag))
  ret = fn(buf.buf, sha1, flag, cb_data);
  strbuf_release(&buf);

@@ -1958,7 +1960,8 @@ int refname_match(const char *abbrev_name, const
char *full_name)
 static struct ref_lock *verify_lock(struct ref_lock *lock,
  const unsigned char *old_sha1, int mustexist)
 {
- if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+ if (read_ref_full(lock->ref_name, lock->old_sha1,
+  mustexist ? RESOLVE_REF_READING : 0, NULL)) {
  int save_errno = errno;
  error("Can't verify ref %s", lock->ref_name);
  unlock_ref(lock);
@@ -2031,7 +2034,8 @@ int dwim_ref(const char *str, int len, unsigned
char *sha1, char **ref)

  this_result = refs_found ? sha1_from_ref : sha1;
  mksnpath(fullref, sizeof(fullref), *p, len, str);
- r = resolve_ref_unsafe(fullref, this_result, 1, &flag);
+ r = resolve_ref_unsafe(fullref, this_result,
+       RESOLVE_REF_READING, &flag);
  if (r) {
  if (!refs_found++)
  *ref = xstrdup(r);
@@ -2060,7 +2064,7 @@ int dwim_log(const char *str, int len, unsigned
char *sha1, char **log)
  const char *ref, *it;

  mksnpath(path, sizeof(path), *p, len, str);
- ref = resolve_ref_unsafe(path, hash, 1, NULL);
+ ref = resolve_ref_unsafe(path, hash, RESOLVE_REF_READING, NULL);
  if (!ref)
  continue;
  if (reflog_exists(path))
@@ -2092,18 +2096,22 @@ static struct ref_lock
*lock_ref_sha1_basic(const char *refname,
  int last_errno = 0;
  int type, lflags;
  int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
+ int resolve_flags;
  int missing = 0;
  int attempts_remaining = 3;
-
- if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
- errno = EINVAL;
- return NULL;
- }
+ int bad_refname;

  lock = xcalloc(1, sizeof(struct ref_lock));
  lock->lock_fd = -1;

- refname = resolve_ref_unsafe(refname, lock->old_sha1, mustexist, &type);
+ bad_refname = check_refname_format(refname, REFNAME_ALLOW_ONELEVEL);
+
+ resolve_flags = RESOLVE_REF_ALLOW_BAD_NAME;
+ if (mustexist)
+ resolve_flags |= RESOLVE_REF_READING;
+
+ refname = resolve_ref_unsafe(refname, lock->old_sha1, resolve_flags,
+     &type);
  if (!refname && errno == EISDIR) {
  /* we are trying to lock foo but we used to
  * have foo/bar which now does not exist;
@@ -2116,7 +2124,8 @@ static struct ref_lock
*lock_ref_sha1_basic(const char *refname,
  error("there are still refs under '%s'", orig_refname);
  goto error_return;
  }
- refname = resolve_ref_unsafe(orig_refname, lock->old_sha1, mustexist, &type);
+ refname = resolve_ref_unsafe(orig_refname, lock->old_sha1,
+     resolve_flags, &type);
  }
  if (type_p)
     *type_p = type;
@@ -2180,6 +2189,8 @@ static struct ref_lock
*lock_ref_sha1_basic(const char *refname,
  else
  unable_to_lock_index_die(ref_file, errno);
  }
+ if (bad_refname)
+ return lock;
  return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;

  error_return:
@@ -2680,7 +2691,8 @@ int rename_ref(const char *oldrefname, const
char *newrefname, const char *logms
  if (log && S_ISLNK(loginfo.st_mode))
  return error("reflog for %s is a symlink", oldrefname);

- symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+ symref = resolve_ref_unsafe(oldrefname, orig_sha1,
+    RESOLVE_REF_READING, &flag);
  if (flag & REF_ISSYMREF)
  return error("refname %s is a symbolic ref, renaming it is not supported",
  oldrefname);
@@ -2704,7 +2716,7 @@ int rename_ref(const char *oldrefname, const
char *newrefname, const char *logms
  goto rollback;
  }

- if (!read_ref_full(newrefname, sha1, 1, NULL) &&
+ if (!read_ref_full(newrefname, sha1, RESOLVE_REF_READING, NULL) &&
     delete_ref(newrefname, sha1, REF_NODEREF)) {
  if (errno==EISDIR) {
  if (remove_empty_directories(git_path("%s", newrefname))) {
@@ -2982,7 +2994,8 @@ static int write_ref_sha1(struct ref_lock *lock,
  unsigned char head_sha1[20];
  int head_flag;
  const char *head_ref;
- head_ref = resolve_ref_unsafe("HEAD", head_sha1, 1, &head_flag);
+ head_ref = resolve_ref_unsafe("HEAD", head_sha1,
+      RESOLVE_REF_READING, &head_flag);
  if (head_ref && (head_flag & REF_ISSYMREF) &&
     !strcmp(head_ref, lock->ref_name))
  log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
@@ -3468,6 +3481,12 @@ int ref_transaction_update(struct
ref_transaction *transaction,
  if (have_old && !old_sha1)
  die("BUG: have_old is true but old_sha1 is NULL");

+ if (!is_null_sha1(new_sha1) &&
+    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+ strbuf_addf(err, "Bad refname: %s", refname);
+ return -1;
+ }
+
  update = add_update(transaction, refname);
  hashcpy(update->new_sha1, new_sha1);
  update->flags = flags;
@@ -3493,6 +3512,11 @@ int ref_transaction_create(struct
ref_transaction *transaction,
  if (!new_sha1 || is_null_sha1(new_sha1))
  die("BUG: create ref with null new_sha1");

+ if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+ strbuf_addf(err, "Bad refname: %s", refname);
+ return -1;
+ }
+
  update = add_update(transaction, refname);

  hashcpy(update->new_sha1, new_sha1);
diff --git a/remote.c b/remote.c
index ae04043..de84ac3 100644
--- a/remote.c
+++ b/remote.c
@@ -1121,7 +1121,8 @@ static char *guess_ref(const char *name, struct ref *peer)
  struct strbuf buf = STRBUF_INIT;
  unsigned char sha1[20];

- const char *r = resolve_ref_unsafe(peer->name, sha1, 1, NULL);
+ const char *r = resolve_ref_unsafe(peer->name, sha1,
+   RESOLVE_REF_READING, NULL);
  if (!r)
  return NULL;

@@ -1182,7 +1183,8 @@ static int match_explicit(struct ref *src,
struct ref *dst,
  unsigned char sha1[20];
  int flag;

- dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);
+ dst_value = resolve_ref_unsafe(matched_src->name, sha1,
+       RESOLVE_REF_READING, &flag);
  if (!dst_value ||
     ((flag & REF_ISSYMREF) &&
      !starts_with(dst_value, "refs/heads/")))
diff --git a/sequencer.c b/sequencer.c
index 284059b..e1419bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -365,7 +365,7 @@ static int is_index_unchanged(void)
  unsigned char head_sha1[20];
  struct commit *head_commit;

- if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+ if (!resolve_ref_unsafe("HEAD", head_sha1, RESOLVE_REF_READING, NULL))
  return error(_("Could not resolve HEAD commit\n"));

  head_commit = lookup_commit(head_sha1);
diff --git a/transport-helper.c b/transport-helper.c
index 84c616f..270ae28 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -889,7 +889,7 @@ static int push_refs_with_export(struct transport
*transport,
  int flag;

  /* Follow symbolic refs (mainly for HEAD). */
- name = resolve_ref_unsafe(ref->peer_ref->name, sha1, 1, &flag);
+ name = resolve_ref_unsafe(ref->peer_ref->name, sha1,
RESOLVE_REF_READING, &flag);
  if (!name || !(flag & REF_ISSYMREF))
  name = ref->peer_ref->name;

diff --git a/transport.c b/transport.c
index 325f03e..f40e950 100644
--- a/transport.c
+++ b/transport.c
@@ -168,7 +168,8 @@ static void set_upstreams(struct transport
*transport, struct ref *refs,
  /* Follow symbolic refs (mainly for HEAD). */
  localname = ref->peer_ref->name;
  remotename = ref->name;
- tmp = resolve_ref_unsafe(localname, sha, 1, &flag);
+ tmp = resolve_ref_unsafe(localname, sha,
+ RESOLVE_REF_READING, &flag);
  if (tmp && flag & REF_ISSYMREF &&
  starts_with(tmp, "refs/heads/"))
  localname = tmp;
@@ -753,7 +754,7 @@ void transport_print_push_status(const char *dest,
struct ref *refs,
  unsigned char head_sha1[20];
  char *head;

- head = resolve_refdup("HEAD", head_sha1, 1, NULL);
+ head = resolve_refdup("HEAD", head_sha1, RESOLVE_REF_READING, NULL);

  if (verbose) {
  for (ref = refs; ref; ref = ref->next)
