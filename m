Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19167C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E0C2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2vj8wdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKZBRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:17:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40756 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBRr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:17:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id i187so4127810pfc.7
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YJgrt5bdtWy2fFmATm9TFee8YjwBLDhf7/eu6n74aKk=;
        b=j2vj8wdg//OHG/6+QaSKTEya50rIWfGSpQD+lNlRo+YjZI0Fio8kRRC3N9Jxl/l4q8
         0tHmmwAc4mQ2w7ylMIEsrHkRoOaYi5oCPJeYmSw5M+HF51tMBa9W/xnL2d9zvLNGmPQi
         30iUfQE1ivFtyxqpsZxEGAF29L48/E2Np7FJDDkqqDMNyKK90o7GlNf+01nEuToXJZNP
         CK9TVoeA++3V+Y0jyFuzzZLeNQvc/PZGly1Nbun3MVCpeuOfmpwq/uMHdt0CICDj0ccq
         r/i1zucCao4v7j87OwdpX7Zdoyo3+3qyknvyXJtURppzkzqP+H1GbiS8dfOrzeww1hSM
         LXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJgrt5bdtWy2fFmATm9TFee8YjwBLDhf7/eu6n74aKk=;
        b=aMG7rtrG6abbKz8rkSX98ywcHkxhbmoepU8hJ+coXdQ+/04XqlPKI667ct4qiioZ+N
         GP9IDgnahRpRRJPq9jUmWXy++OFuBgKIJbd4NuWvlgjj/Ftnwt6lbXwMzRANPjI/RGJa
         cN9BS0Q0UpDn+pujmeeXb8byH6/mRJCsdyajnvB6hjs6G+2ilQJHiXyaJaeuUAv1nnAD
         RgfZ/8JGY15oJ9sQNUKqixaOM0iMyyhSrFi8E95kgqJlMtSvqR/skO2QpO5OvJBzaGQp
         xgK2aEmBazK2mUtSdlK4I6ID9VscIa3iD4yEmhIv0h8LQYZBdru5BiMpeJtk9z57+ejm
         dpzA==
X-Gm-Message-State: APjAAAVDz733icaiN14ehf4DJogsmSNdD/nsfvzrH0DWim4fD/A79vQQ
        UCXDusSqDxjafYPporZP0H0JAp1Z
X-Google-Smtp-Source: APXvYqwWNVo6e6jv3b8xUKbAcyQj3AZrby3WapbeXVKU/ZK5q10AYcGlsEhuzDcH4LJ10JF8IBQUfw==
X-Received: by 2002:a63:ed58:: with SMTP id m24mr1844543pgk.111.1574731066283;
        Mon, 25 Nov 2019 17:17:46 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id x10sm10241594pfn.36.2019.11.25.17.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:17:45 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:17:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 00/27] t: test cleanup stemming from experimentally
 enabling pipefail
Message-ID: <cover.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches perform some general test cleanup to modernise the style.
They should be relatively uncontroversial. The reason these tests were
identified for cleanup was because they failed under `set -o pipefail`.

I've gotten rid of the RFC part that actually enables `set -o pipefail`
on supported platforms. As Peff pointed out, there are a lot of
opportunities for racy SIGPIPE failures so that part still needs a lot
of work to be ironed out.

Those changes shouldn't hold back the first part of the series, however.
Let's try to get this test cleanup merged in sooner than later so that
any new test cases done by copy-paste will have their changes
represented.

Changes since v3:

* More commit message update

* Clean up "apply-one-time-sed.sh: modernize style" more according to
  Junio's suggestions

* Clean up the t7700 leftover bits

Changes since v2:

* Update commit messages according to Eric's suggestions

* Add "apply-one-time-sed.sh: modernize style"

Changes since v1:

* Removed the `set -o pipefail` changes

* Addressed Junio and Eric's comments on the first part of the series

Denton Liu (27):
  lib-bash.sh: move `then` onto its own line
  apply-one-time-sed.sh: modernize style
  t0014: remove git command upstream of pipe
  t0090: stop losing return codes of git commands
  t3301: stop losing return codes of git commands
  t3600: use test_line_count() where possible
  t3600: stop losing return codes of git commands
  t3600: comment on inducing SIGPIPE in `git rm`
  t4015: stop losing return codes of git commands
  t4015: use test_write_lines()
  t4138: stop losing return codes of git commands
  t5317: stop losing return codes of git commands
  t5317: use ! grep to check for no matching lines
  t5703: simplify one-time-sed generation logic
  t5703: stop losing return codes of git commands
  t7501: remove spaces after redirect operators
  t7501: stop losing return codes of git commands
  t7700: drop redirections to /dev/null
  t7700: remove spaces after redirect operators
  t7700: move keywords onto their own line
  t7700: s/test -f/test_path_is_file/
  t7700: consolidate code into test_no_missing_in_packs()
  squash! t7700: consolidate code into test_no_missing_in_packs()
  t7700: consolidate code into test_has_duplicate_object()
  t7700: replace egrep with grep
  t7700: make references to SHA-1 generic
  t7700: stop losing return codes of git commands

 t/lib-bash.sh                          |   6 +-
 t/lib-httpd/apply-one-time-sed.sh      |   8 +-
 t/t0014-alias.sh                       |   4 +-
 t/t0090-cache-tree.sh                  |   5 +-
 t/t3301-notes.sh                       | 230 ++++++++++++++++++-------
 t/t3600-rm.sh                          |  14 +-
 t/t4015-diff-whitespace.sh             | 123 +++++++------
 t/t4138-apply-ws-expansion.sh          |  16 +-
 t/t5317-pack-objects-filter-objects.sh |  34 ++--
 t/t5703-upload-pack-ref-in-want.sh     |  53 +++---
 t/t7501-commit-basic-functionality.sh  |  83 +++++----
 t/t7700-repack.sh                      | 172 ++++++++----------
 12 files changed, 425 insertions(+), 323 deletions(-)

Range-diff against v3:
 1:  9085cc00af =  1:  9085cc00af lib-bash.sh: move `then` onto its own line
 2:  ac4164374d !  2:  86f625c65e apply-one-time-sed.sh: modernize style
    @@ Metadata
      ## Commit message ##
         apply-one-time-sed.sh: modernize style
     
    -    Convert `[ ... ]` to use `test`.
    +    Convert `[ ... ]` to use `test` and test for the existence of a regular
    +    file (`-f`) instead of any file (`-e`).
     
         Move the `then`s onto their own lines so that it conforms with the
         general test style.
     
         Instead of redirecting input into sed, allow it to open its own input.
     
    +    Use `cmp -s` instead of `diff` since we only care about whether the two
    +    files are equal and `diff` is overkill for this.
    +
      ## t/lib-httpd/apply-one-time-sed.sh ##
     @@
      #
      # This can be used to simulate the effects of the repository changing in
      # between HTTP request-response pairs.
     -if [ -e one-time-sed ]; then
    -+if test -e one-time-sed
    ++if test -f one-time-sed
     +then
      	"$GIT_EXEC_PATH/git-http-backend" >out
     -	sed "$(cat one-time-sed)" <out >out_modified
     +	sed "$(cat one-time-sed)" out >out_modified
      
     -	if diff out out_modified >/dev/null; then
    -+	if diff out out_modified >/dev/null
    ++	if cmp -s out out_modified
     +	then
      		cat out
      	else
 3:  b90d68829b =  3:  3844e00367 t0014: remove git command upstream of pipe
 4:  51eaffb283 =  4:  7d33586b21 t0090: stop losing return codes of git commands
 5:  3c6bb9b2f2 =  5:  df6b3393c4 t3301: stop losing return codes of git commands
 6:  7925fa3e43 =  6:  d541a8d4d4 t3600: use test_line_count() where possible
 7:  36be4d0ec1 =  7:  a8aeca6795 t3600: stop losing return codes of git commands
 8:  01fc8518bf =  8:  e3db06578d t3600: comment on inducing SIGPIPE in `git rm`
 9:  b6f6d47c00 =  9:  22ea5d736e t4015: stop losing return codes of git commands
10:  58a1ae76c0 = 10:  a44dd28b4d t4015: use test_write_lines()
11:  07822e3b4c = 11:  d512319be0 t4138: stop losing return codes of git commands
12:  d892a7b181 = 12:  1e08c2b68b t5317: stop losing return codes of git commands
13:  140de46f80 ! 13:  fa238be28b t5317: use ! grep to check for no matching lines
    @@ Commit message
         return code! Use `! grep` in the cases where we are ensuring that there
         are no matching lines.
     
    -    While at it, drop unnecessary invocations of 'awk' and 'sort' in each
    +    While at it, drop unnecessary invocations of `awk` and `sort` in each
         affected test since those commands do not influence the outcome. It's
         not clear why that extra work was being done in the first place, and the
         code's history doesn't shed any light on the matter since these tests
    -    were simply born this way[1], doing all the unnecessary work for no
    -    reason, probably due to copy/paste programming...
    +    were simply born this way[1], likely due to copy-paste programming. The
    +    unnecessary work wasn't noticed even when the code was later touched for
    +    various cleanups[2][3].
     
         [1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
    +    [2]: bdbc17e86a (tests: standardize pipe placement, 2018-10-05)
    +    [3]: 61de0ff695 (tests: don't swallow Git errors upstream of pipes, 2018-10-05)
     
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     
14:  6be0d0388d = 14:  291caf9bc1 t5703: simplify one-time-sed generation logic
15:  3844e7372c = 15:  edf7af76ae t5703: stop losing return codes of git commands
16:  d47bb4c9f6 = 16:  5eb7117fbe t7501: remove spaces after redirect operators
17:  9e5ede8eac = 17:  bad732adc8 t7501: stop losing return codes of git commands
18:  18031e67c7 = 18:  c50c192429 t7700: drop redirections to /dev/null
19:  40cd07a57a = 19:  58ae066d12 t7700: remove spaces after redirect operators
20:  049405b49d = 20:  82bf24d06a t7700: move keywords onto their own line
21:  133171522d = 21:  251de77677 t7700: s/test -f/test_path_is_file/
22:  d653869ead <  -:  ---------- t7700: stop losing return codes of git commands
 -:  ---------- > 22:  c98a2a1509 t7700: consolidate code into test_no_missing_in_packs()
 -:  ---------- > 23:  e4ba198483 squash! t7700: consolidate code into test_no_missing_in_packs()
 -:  ---------- > 24:  fa38d7e8f6 t7700: consolidate code into test_has_duplicate_object()
 -:  ---------- > 25:  4f02c00bd1 t7700: replace egrep with grep
 -:  ---------- > 26:  a747fbd08b t7700: make references to SHA-1 generic
 -:  ---------- > 27:  fb614f4385 t7700: stop losing return codes of git commands
-- 
2.24.0.504.g3cd56eb17d

