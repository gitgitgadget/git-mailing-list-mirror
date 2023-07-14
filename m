Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD6FEB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 19:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjGNTnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbjGNTnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 15:43:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40303AAE
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-263121cd04eso1219033a91.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689363785; x=1691955785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3g3YsyN6c++mqzbf7CaKM97L4GJ3jflsKPmQSi6Tgg=;
        b=ChOfwsKhLNKuM9MXGGuVRBUhw+t8qMJdFcU4O66117vZV3vlDTJwbMwFJEhc6TK1/B
         /3oVK1uiXiAxcaXeM5zMwF+BZ2VWcB7CbCYjt+CVL6C3sLTxbQA7I2vUY/5Erorc5Zuw
         UnQDcERRURA/RYIUz3tYg7mpEoABJD7nIxTQxHEk3UfpTSWDaFK1cDEBRg4ZNcJ0+w0K
         YNVpYSfChjcgn93h18lJhuGopRIQY0BsHY5x8Kup1Q46qdwtPPhXttZjfRK3R6IulFJs
         Go0CMPudXeLpMWp51MRiJX+Q8qtugIBQ7guuhHW8qZy9rrPfIOCVDf8uUKFy9asWhA3L
         Z8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363785; x=1691955785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3g3YsyN6c++mqzbf7CaKM97L4GJ3jflsKPmQSi6Tgg=;
        b=GIUVv0bw/UKX5pTtJfy8bc3J3s7Ta79wTZkRlgknmpi9E1F0F7bmXcXAkkD/ucADTK
         uVxm87IX8ji1NrjcLRl5OfKI0lHl+s7EdoR1tQqY+kT4/DARKEkukSaF6GkbyD31ufpu
         N2PR3RYJUnz7aQ24/+C8z76F3mYXdMBNhU/ohYCj9g0Qn7M4QKy+jkbXqfn1CH29mjdQ
         nSSXdfvZK5ST/z3MMKYQAABnugpBz01dHZvyfgUuS1Qeb4PrbUvyjiAGDU+xjNr+Nq1G
         707rINr6+vgdQE5lf4Vrj8abolJNOY5kmkVyRiva06NiBp1/hrMsjZJW2F5z/3muHNL/
         yt7g==
X-Gm-Message-State: ABy/qLbWML+8iaxI05nalqPO0A+Rg3h+FVjvcZ0bhLRQbPOg1yO+FRj1
        18XPcbBsAo7xzORZcBGJ2n6vYpRM0ys=
X-Google-Smtp-Source: APBJJlFvxEnS08xyL/D/6qCuuatcdAD+emTIz0eq7oiSWryuiIzwnrYC9OpN3Dxuhf3Ln3Ekr8SMgw==
X-Received: by 2002:a17:90b:905:b0:262:f06a:13e0 with SMTP id bo5-20020a17090b090500b00262f06a13e0mr4247570pjb.5.1689363784674;
        Fri, 14 Jul 2023 12:43:04 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.128])
        by smtp.gmail.com with ESMTPSA id u63-20020a17090a51c500b00260a5ecd273sm1514820pjh.1.2023.07.14.12.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:43:04 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 0/3] Add new "describe" atom
Date:   Sat, 15 Jul 2023 00:50:25 +0530
Message-ID: <20230714194249.66862-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
In-Reply-To: <20230705175942.21090-1-five231003@gmail.com>
References: <20230705175942.21090-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
This patch series addresses the previous comments and so now we can do
for example

	git for-each-ref --format="%(describe:tags=yes,abbrev=14)"

PATCH 1/3 - This is a new commit which introduces two new functions for
	    handling multiple options in ref-filter.

	    There are two ways to do this
	    - We change the functions in pretty so that they can be used
	      generally and not only for placeholders.
	    - We introduce corresponding functions in ref-filter for
	      handling atoms.

	    This patch follows the second approach but the first
	    approach is also good because we don't duplicate the code.
	    Or maybe there is a much better approach that I don't see.

PATCH 2/3 - Changes are made so that we can handle multiple options and
	    also the related docs are a nested description list.

PATCH 3/3 - This commit is left unchanged.

Kousik Sanagavarapu (3):
  ref-filter: add multiple-option parsing functions
  ref-filter: add new "describe" atom
  t6300: run describe atom tests on a different repo

 Documentation/git-for-each-ref.txt |  23 ++++
 ref-filter.c                       | 206 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  98 ++++++++++++++
 3 files changed, 327 insertions(+)

Range-diff against v1:

-:  ---------- > 1:  50497067a3 ref-filter: add multiple-option parsing
functions
1:  9e3e652659 ! 2:  f6f882884c ref-filter: add new "describe" atom
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
        commits ahead and behind, respectively, when comparing the
output
        ref to the `<committish>` specified in the format.
      
    -+describe[:options]:: human-readable name, like
    ++describe[:options]:: Human-readable name, like
     +               link-git:git-describe[1]; empty string for
     +               undescribable commits. The `describe` string may be
     +               followed by a colon and zero or more
comma-separated
     +               options. Descriptions can be inconsistent when tags
     +               are added or removed at the same time.
     ++
    -+** tags=<bool-value>: Instead of only considering annotated tags,
consider
    -+                lightweight tags as well.
    -+** abbrev=<number>: Instead of using the default number of
hexadecimal digits
    -+              (which will vary according to the number of objects
in the
    -+              repository with a default of 7) of the abbreviated
    -+              object name, use <number> digits, or as many digits
as
    -+              needed to form a unique object name.
    -+** match=<pattern>: Only consider tags matching the given
`glob(7)` pattern,
    -+              excluding the "refs/tags/" prefix.
    -+** exclude=<pattern>: Do not consider tags matching the given
`glob(7)`
    -+                pattern,excluding the "refs/tags/" prefix.
    ++--
    ++tags=<bool-value>;; Instead of only considering annotated tags,
consider
    ++              lightweight tags as well; see the corresponding
option
    ++              in linkgit:git-describe[1] for details.
    ++abbrev=<number>;; Use at least <number> hexadecimal digits; see
    ++            the corresponding option in linkgit:git-describe[1]
    ++            for details.
    ++match=<pattern>;; Only consider tags matching the given `glob(7)`
pattern,
    ++            excluding the "refs/tags/" prefix; see the
corresponding
    ++            option in linkgit:git-describe[1] for details.
    ++exclude=<pattern>;; Do not consider tags matching the given
`glob(7)`
    ++              pattern, excluding the "refs/tags/" prefix; see the
    ++              corresponding option in linkgit:git-describe[1] for
    ++              details.
    ++--
     +
      In addition to the above, for commit and tag objects, the header
      field names (`tree`, `parent`, `object`, `type`, and `tag`) can
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
     
      ## ref-filter.c ##
     @@
    + #include "alloc.h"
    + #include "environment.h"
    + #include "gettext.h"
    ++#include "config.h"
      #include "gpg-interface.h"
      #include "hex.h"
      #include "parse-options.h"
    @@ ref-filter.c: static struct used_atom {
                        enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
                } email_option;
     +          struct {
    -+                  enum { D_BARE, D_TAGS, D_ABBREV, D_EXCLUDE,
    -+                         D_MATCH } option;
    -+                  unsigned int tagbool;
    -+                  unsigned int length;
    -+                  char *pattern;
    ++                  enum { D_BARE, D_TAGS, D_ABBREV,
    ++                         D_EXCLUDE, D_MATCH } option;
    ++                  const char **args;
     +          } describe;
                struct refname_atom refname;
                char *head;
    @@ ref-filter.c: static int contents_atom_parser(struct ref_format
*format, struct
        return 0;
      }
      
    -+static int parse_describe_option(const char *arg)
    -+{
    -+  if (!arg)
    -+          return D_BARE;
    -+  else if (starts_with(arg, "tags"))
    -+          return D_TAGS;
    -+  else if (starts_with(arg, "abbrev"))
    -+          return D_ABBREV;
    -+  else if(starts_with(arg, "exclude"))
    -+          return D_EXCLUDE;
    -+  else if (starts_with(arg, "match"))
    -+          return D_MATCH;
    -+  return -1;
    -+}
    -+
     +static int describe_atom_parser(struct ref_format *format UNUSED,
     +                          struct used_atom *atom,
     +                          const char *arg, struct strbuf *err)
     +{
    -+  int opt = parse_describe_option(arg);
    ++  const char *describe_opts[] = {
    ++          "",
    ++          "tags",
    ++          "abbrev",
    ++          "match",
    ++          "exclude",
    ++          NULL
    ++  };
    ++
    ++  struct strvec args = STRVEC_INIT;
    ++  for (;;) {
    ++          int found = 0;
    ++          const char *argval;
    ++          size_t arglen = 0;
    ++          int optval = 0;
    ++          int opt;
    ++
    ++          if (!arg)
    ++                  break;
    ++
    ++          for (opt = D_BARE; !found && describe_opts[opt]; opt++)
{
    ++                  switch(opt) {
    ++                  case D_BARE:
    ++                          /*
    ++                           * Do nothing. This is the bare describe
    ++                           * atom and we already handle this
above.
    ++                           */
    ++                          break;
    ++                  case D_TAGS:
    ++                          if (match_atom_bool_arg(arg,
describe_opts[opt],
    ++                                                  &arg, &optval))
{
    ++                                  if (!optval)
    ++                                          strvec_pushf(&args,
"--no-%s",
    ++
describe_opts[opt]);
    ++                                  else
    ++                                          strvec_pushf(&args,
"--%s",
    ++
describe_opts[opt]);
    ++                                  found = 1;
    ++                          }
    ++                          break;
    ++                  case D_ABBREV:
    ++                          if (match_atom_arg_value(arg,
describe_opts[opt],
    ++                                                   &arg, &argval,
&arglen)) {
    ++                                  char *endptr;
    ++                                  int ret = 0;
     +
    -+  switch (opt) {
    -+  case D_BARE:
    -+          break;
    -+  case D_TAGS:
    -+          /*
    -+           * It is also possible to just use describe:tags, which
    -+           * is just treated as describe:tags=1
    -+           */
    -+          if (skip_prefix(arg, "tags=", &arg)) {
    -+                  if (strtoul_ui(arg, 10,
&atom->u.describe.tagbool))
    -+                          return strbuf_addf_ret(err, -1,
_("boolean value "
    -+                                          "expected
describe:tags=%s"), arg);
    ++                                  if (!arglen)
    ++                                          ret = -1;
    ++                                  if (strtol(argval, &endptr, 10)
< 0)
    ++                                          ret = -1;
    ++                                  if (endptr - argval != arglen)
    ++                                          ret = -1;
     +
    -+          } else {
    -+                  atom->u.describe.tagbool = 1;
    ++                                  if (ret)
    ++                                          return
strbuf_addf_ret(err, ret,
    ++
_("positive value expected describe:abbrev=%s"), argval);
    ++                                  strvec_pushf(&args, "--%s=%.*s",
    ++                                               describe_opts[opt],
    ++                                               (int)arglen,
argval);
    ++                                  found = 1;
    ++                          }
    ++                          break;
    ++                  case D_MATCH:
    ++                  case D_EXCLUDE:
    ++                          if (match_atom_arg_value(arg,
describe_opts[opt],
    ++                                                   &arg, &argval,
&arglen)) {
    ++                                  if (!arglen)
    ++                                          return
strbuf_addf_ret(err, -1,
    ++                                                          _("value
expected describe:%s="), describe_opts[opt]);
    ++                                  strvec_pushf(&args, "--%s=%.*s",
    ++                                               describe_opts[opt],
    ++                                               (int)arglen,
argval);
    ++                                  found = 1;
    ++                          }
    ++                          break;
    ++                  }
     +          }
    -+          break;
    -+  case D_ABBREV:
    -+          skip_prefix(arg, "abbrev=", &arg);
    -+          if (strtoul_ui(arg, 10, &atom->u.describe.length))
    -+                  return strbuf_addf_ret(err, -1, _("positive
value "
    -+                                         "expected
describe:abbrev=%s"), arg);
    -+          break;
    -+  case D_EXCLUDE:
    -+          skip_prefix(arg, "exclude=", &arg);
    -+          atom->u.describe.pattern = xstrdup(arg);
    -+          break;
    -+  case D_MATCH:
    -+          skip_prefix(arg, "match=", &arg);
    -+          atom->u.describe.pattern = xstrdup(arg);
    -+          break;
    -+  default:
    -+          return err_bad_arg(err, "describe", arg);
    -+          break;
    ++          if (!found)
    ++                  break;
     +  }
    -+  atom->u.describe.option = opt;
    ++  atom->u.describe.args = strvec_detach(&args);
     +  return 0;
     +}
     +
    @@ ref-filter.c: static void append_lines(struct strbuf *out, const
char *buf, unsi
     +
     +  for (i = 0; i < used_atom_cnt; i++) {
     +          struct used_atom *atom = &used_atom[i];
    ++          enum atom_type type = atom->atom_type;
     +          const char *name = atom->name;
     +          struct atom_value *v = &val[i];
    -+          int opt;
     +
     +          struct child_process cmd = CHILD_PROCESS_INIT;
     +          struct strbuf out = STRBUF_INIT;
     +          struct strbuf err = STRBUF_INIT;
     +
    ++          if (type != ATOM_DESCRIBE)
    ++                  continue;
    ++
     +          if (!!deref != (*name == '*'))
     +                  continue;
     +          if (deref)
    @@ ref-filter.c: static void append_lines(struct strbuf *out, const
char *buf, unsi
     +          else
     +                  name++;
     +
    -+          opt = parse_describe_option(name);
    -+          if (opt < 0)
    -+                  continue;
    -+
     +          cmd.git_cmd = 1;
     +          strvec_push(&cmd.args, "describe");
    -+
    -+          switch(opt) {
-:  ---------- > 1:  50497067a3 ref-filter: add multiple-option parsing
functions
1:  9e3e652659 ! 2:  f6f882884c ref-filter: add new "describe" atom
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
        commits ahead and behind, respectively, when comparing the
output
        ref to the `<committish>` specified in the format.
      
    -+describe[:options]:: human-readable name, like
    ++describe[:options]:: Human-readable name, like
     +               link-git:git-describe[1]; empty string for
     +               undescribable commits. The `describe` string may be
     +               followed by a colon and zero or more
comma-separated
     +               options. Descriptions can be inconsistent when tags
     +               are added or removed at the same time.
     ++
    -+** tags=<bool-value>: Instead of only considering annotated tags,
consider
    -+                lightweight tags as well.
    -+** abbrev=<number>: Instead of using the default number of
hexadecimal digits
    -+              (which will vary according to the number of objects
in the
    -+              repository with a default of 7) of the abbreviated
    -+              object name, use <number> digits, or as many digits
as
    -+              needed to form a unique object name.
    -+** match=<pattern>: Only consider tags matching the given
`glob(7)` pattern,
    -+              excluding the "refs/tags/" prefix.
    -+** exclude=<pattern>: Do not consider tags matching the given
`glob(7)`
    -+                pattern,excluding the "refs/tags/" prefix.
    ++--
    ++tags=<bool-value>;; Instead of only considering annotated tags,
consider
    ++              lightweight tags as well; see the corresponding
option
    ++              in linkgit:git-describe[1] for details.
    ++abbrev=<number>;; Use at least <number> hexadecimal digits; see
    ++            the corresponding option in linkgit:git-describe[1]
    ++            for details.
    ++match=<pattern>;; Only consider tags matching the given `glob(7)`
pattern,
    ++            excluding the "refs/tags/" prefix; see the
corresponding
    ++            option in linkgit:git-describe[1] for details.
    ++exclude=<pattern>;; Do not consider tags matching the given
`glob(7)`
    ++              pattern, excluding the "refs/tags/" prefix; see the
    ++              corresponding option in linkgit:git-describe[1] for
    ++              details.
    ++--
     +
      In addition to the above, for commit and tag objects, the header
      field names (`tree`, `parent`, `object`, `type`, and `tag`) can
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
     
      ## ref-filter.c ##
     @@
    + #include "alloc.h"
    + #include "environment.h"
    + #include "gettext.h"
    ++#include "config.h"
      #include "gpg-interface.h"
      #include "hex.h"
      #include "parse-options.h"
    @@ ref-filter.c: static struct used_atom {
                        enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
                } email_option;
     +          struct {
    -+                  enum { D_BARE, D_TAGS, D_ABBREV, D_EXCLUDE,
    -+                         D_MATCH } option;
    -+                  unsigned int tagbool;
    -+                  unsigned int length;
    -+                  char *pattern;
    ++                  enum { D_BARE, D_TAGS, D_ABBREV,
    ++                         D_EXCLUDE, D_MATCH } option;
    ++                  const char **args;
     +          } describe;
                struct refname_atom refname;
                char *head;
    @@ ref-filter.c: static int contents_atom_parser(struct ref_format
*format, struct
        return 0;
      }
      
    -+static int parse_describe_option(const char *arg)
    -+{
    -+  if (!arg)
    -+          return D_BARE;
    -+  else if (starts_with(arg, "tags"))
    -+          return D_TAGS;
    -+  else if (starts_with(arg, "abbrev"))
    -+          return D_ABBREV;
    -+  else if(starts_with(arg, "exclude"))
    -+          return D_EXCLUDE;
    -+  else if (starts_with(arg, "match"))
    -+          return D_MATCH;
    -+  return -1;
    -+}
    -+
     +static int describe_atom_parser(struct ref_format *format UNUSED,
     +                          struct used_atom *atom,
     +                          const char *arg, struct strbuf *err)
     +{
    -+  int opt = parse_describe_option(arg);
    ++  const char *describe_opts[] = {
    ++          "",
    ++          "tags",
    ++          "abbrev",
    ++          "match",
    ++          "exclude",
    ++          NULL
    ++  };
    ++
    ++  struct strvec args = STRVEC_INIT;
    ++  for (;;) {
    ++          int found = 0;
    ++          const char *argval;
    ++          size_t arglen = 0;
    ++          int optval = 0;
    ++          int opt;
    ++
    ++          if (!arg)
    ++                  break;
    ++
    ++          for (opt = D_BARE; !found && describe_opts[opt]; opt++)
{
    ++                  switch(opt) {
    ++                  case D_BARE:
    ++                          /*
    ++                           * Do nothing. This is the bare describe
    ++                           * atom and we already handle this
above.
    ++                           */
    ++                          break;
    ++                  case D_TAGS:
    ++                          if (match_atom_bool_arg(arg,
describe_opts[opt],
    ++                                                  &arg, &optval))
{
    ++                                  if (!optval)
    ++                                          strvec_pushf(&args,
"--no-%s",
    ++
describe_opts[opt]);
    ++                                  else
    ++                                          strvec_pushf(&args,
"--%s",
    ++
describe_opts[opt]);
    ++                                  found = 1;
    ++                          }
    ++                          break;
    ++                  case D_ABBREV:
    ++                          if (match_atom_arg_value(arg,
describe_opts[opt],
    ++                                                   &arg, &argval,
&arglen)) {
    ++                                  char *endptr;
    ++                                  int ret = 0;
     +
    -+  switch (opt) {
    -+  case D_BARE:
    -+          break;
    -+  case D_TAGS:
    -+          /*
    -+           * It is also possible to just use describe:tags, which
    -+           * is just treated as describe:tags=1
    -+           */
    -+          if (skip_prefix(arg, "tags=", &arg)) {
    -+                  if (strtoul_ui(arg, 10,
&atom->u.describe.tagbool))
    -+                          return strbuf_addf_ret(err, -1,
_("boolean value "
    -+                                          "expected
describe:tags=%s"), arg);
    ++                                  if (!arglen)
    ++                                          ret = -1;
    ++                                  if (strtol(argval, &endptr, 10)
< 0)
    ++                                          ret = -1;
    ++                                  if (endptr - argval != arglen)
    ++                                          ret = -1;
     +
    -+          } else {
    -+                  atom->u.describe.tagbool = 1;
    ++                                  if (ret)
    ++                                          return
strbuf_addf_ret(err, ret,
    ++
_("positive value expected describe:abbrev=%s"), argval);
    ++                                  strvec_pushf(&args, "--%s=%.*s",
    ++                                               describe_opts[opt],
    ++                                               (int)arglen,
argval);
    ++                                  found = 1;
    ++                          }
    ++                          break;
    ++                  case D_MATCH:
    ++                  case D_EXCLUDE:
    ++                          if (match_atom_arg_value(arg,
describe_opts[opt],
    ++                                                   &arg, &argval,
&arglen)) {
    ++                                  if (!arglen)
    ++                                          return
strbuf_addf_ret(err, -1,
...skipping...
    -+          case D_BARE:
    -+                  break;
    -+          case D_TAGS:
    -+                  if (atom->u.describe.tagbool)
    -+                          strvec_push(&cmd.args, "--tags");
    -+                  else
    -+                          strvec_push(&cmd.args, "--no-tags");
    -+                  break;
    -+          case D_ABBREV:
    -+                  strvec_pushf(&cmd.args, "--abbrev=%d",
    -+                               atom->u.describe.length);
    -+                  break;
    -+          case D_EXCLUDE:
    -+                  strvec_pushf(&cmd.args, "--exclude=%s",
    -+                               atom->u.describe.pattern);
    -+                  break;
    -+          case D_MATCH:
    -+                  strvec_pushf(&cmd.args, "--match=%s",
    -+                               atom->u.describe.pattern);
    -+                  break;
    -+          }
    -+
    ++          strvec_pushv(&cmd.args, atom->u.describe.args);
     +          strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
     +          if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
     +                  error(_("failed to run 'describe'"));
2:  43cd3eef3c = 3:  a5122bf5e2 t6300: run describe atom tests on a
different repo
 fivlite  BR describe4  ~ | Documents | git  git checkout master
Switched to branch 'master'
Your branch is up to date with 'upstream/master'.
 fivlite  BR master  ~ | Documents | git  git range-diff
9748a6820043..describe4 master..describe5
-:  ---------- > 1:  50497067a3 ref-filter: add multiple-option parsing
functions
1:  9e3e652659 ! 2:  f6f882884c ref-filter: add new "describe" atom
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
        commits ahead and behind, respectively, when comparing the
output
        ref to the `<committish>` specified in the format.
      
    -+describe[:options]:: human-readable name, like
    ++describe[:options]:: Human-readable name, like
     +               link-git:git-describe[1]; empty string for
     +               undescribable commits. The `describe` string may be
     +               followed by a colon and zero or more
comma-separated
     +               options. Descriptions can be inconsistent when tags
     +               are added or removed at the same time.
     ++
    -+** tags=<bool-value>: Instead of only considering annotated tags,
consider
    -+                lightweight tags as well.
    -+** abbrev=<number>: Instead of using the default number of
hexadecimal digits
    -+              (which will vary according to the number of objects
in the
    -+              repository with a default of 7) of the abbreviated
    -+              object name, use <number> digits, or as many digits
as
    -+              needed to form a unique object name.
    -+** match=<pattern>: Only consider tags matching the given
`glob(7)` pattern,
    -+              excluding the "refs/tags/" prefix.
    -+** exclude=<pattern>: Do not consider tags matching the given
`glob(7)`
    -+                pattern,excluding the "refs/tags/" prefix.
    ++--
    ++tags=<bool-value>;; Instead of only considering annotated tags,
consider
    ++              lightweight tags as well; see the corresponding
option
    ++              in linkgit:git-describe[1] for details.
    ++abbrev=<number>;; Use at least <number> hexadecimal digits; see
    ++            the corresponding option in linkgit:git-describe[1]
    ++            for details.
    ++match=<pattern>;; Only consider tags matching the given `glob(7)`
pattern,
    ++            excluding the "refs/tags/" prefix; see the
corresponding
...skipping...
    -+          case D_BARE:
    -+                  break;
    -+          case D_TAGS:
    -+                  if (atom->u.describe.tagbool)
    -+                          strvec_push(&cmd.args, "--tags");
    -+                  else
    -+                          strvec_push(&cmd.args, "--no-tags");
    -+                  break;
    -+          case D_ABBREV:
    -+                  strvec_pushf(&cmd.args, "--abbrev=%d",
    -+                               atom->u.describe.length);
    -+                  break;
    -+          case D_EXCLUDE:
    -+                  strvec_pushf(&cmd.args, "--exclude=%s",
    -+                               atom->u.describe.pattern);
    -+                  break;
    -+          case D_MATCH:
    -+                  strvec_pushf(&cmd.args, "--match=%s",
    -+                               atom->u.describe.pattern);
    -+                  break;
    -+          }
    -+
    ++          strvec_pushv(&cmd.args, atom->u.describe.args);
     +          strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
     +          if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
     +                  error(_("failed to run 'describe'"));
2:  43cd3eef3c = 3:  a5122bf5e2 t6300: run describe atom tests on a
different repo

-- 
2.41.0.321.g26b82700c0.dirty

