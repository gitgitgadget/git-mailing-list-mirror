Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6976DC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiBIClR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbiBICKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:10:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C322DC06157B
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:10:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so1467382wrc.6
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GYLeYxeB9iv6OPu+nus91iRygcXpxfKTGo4gFyHO3uY=;
        b=Jg2dlqzySVm+n2pLb5RDzoXwRAJ6kva7JvHoz/aBxH9e7PJHnNdbZIMu/Bslna7pHg
         +8yXXW8Da8SrppkzU3fONAiPcnBeIfQJ0tIfwqXS4LYjJxTrhuWwmJK9ifB4pDHjarmh
         uBVvFhSsxzenfFSpimsFUubuLKbG7ZaX4FB+yxUUmaMolW5vtpt6D9KOvLHXQ7logwu1
         gqeFYggIDZIn5SIbT77qFhMxoR5D1xnblvMalvqDvyyC/94+tP4mvsBq5bK0mLef3Fzb
         hlVh170qDDKvHk+FqBJ01HUTI4XehI4aXqx4kiUKKzZyVB1ixg/WwiXdRSlGcgDcUJyX
         rH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GYLeYxeB9iv6OPu+nus91iRygcXpxfKTGo4gFyHO3uY=;
        b=st06jq1Hd0BeyWUWZwV4tTcmnu8O7RTH8+wPJIbQlTlp6+fwf4e3rAGoPpo2pR+JH0
         ejh2CHytVUmAttw4Wnej9O8m1hMP+5Akti2GmOj0a4TXeGJCF66knuB2JW9XUL+uu+VX
         4kS8/wXGOVC3hYt82xoUWMVORX6RsbHznz/7DJx7u4svXONZcmJcEywkdu7/NMKEAZnO
         R5pG9u7BRWYMmNq2exBd9mb855yjc7h5wOuTOXygoT7jkDfutarLKGD+D59tIlS38aU+
         GwivJ5ajOXPExHyTIoThQ6T/uf7NPsGSwZPINwIzjbguAYTm/SjxLcA+OFyqLBLHDDYj
         pHqA==
X-Gm-Message-State: AOAM531ORGPp2+tMmGdldGJOaBTf28vzOZ376sNlDumV3FYjklMHc4Y0
        LL5E2TqouKPdBbwc2RCy1gYM8LvFNdU=
X-Google-Smtp-Source: ABdhPJyKjm7tpEo40Og2xMQig1VaYKVjcdQCizI3ZTu70WMv3ic9HpbFH6vmLVfIW8EfTomUwA5oww==
X-Received: by 2002:a5d:410c:: with SMTP id l12mr158619wrp.597.1644372608069;
        Tue, 08 Feb 2022 18:10:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm1035162wmq.8.2022.02.08.18.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:10:07 -0800 (PST)
Message-Id: <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 02:10:02 +0000
Subject: [PATCH v2 0/4] [RFC] repack: add --filter=
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes partial clone more useful by making it possible to
run repack to remove objects from a repository (replacing it with promisor
objects). This is useful when we want to offload large blobs from a git
server onto another git server, or even use an http server through a remote
helper.

In [A], a --refilter option on fetch and fetch-pack is being discussed where
either a less restrictive or more restrictive filter can be used. In the
more restrictive case, the objects that already exist will not be deleted.
But, one can imagine that users might want the ability to delete objects
when they apply a more restrictive filter in order to save space, and this
patch series would also allow that.

There are a couple of things we need to adjust to make this possible. This
patch has three parts.

 1. Allow --filter in pack-objects without --stdout
 2. Add a --filter flag for repack
 3. Allow missing promisor objects in upload-pack
 4. Tests that demonstrate the ability to offload objects onto an http
    remote

cc: Christian Couder christian.couder@gmail.com cc: Derrick Stolee
stolee@gmail.com cc: Robert Coup robert@coup.net.nz

A.
https://lore.kernel.org/git/pull.1138.git.1643730593.gitgitgadget@gmail.com/

John Cai (4):
  pack-objects: allow --filter without --stdout
  repack: add --filter=<filter-spec> option
  upload-pack: allow missing promisor objects
  tests for repack --filter mode

 Documentation/git-repack.txt   |   5 +
 builtin/pack-objects.c         |   2 -
 builtin/repack.c               |  22 +++--
 t/lib-httpd.sh                 |   2 +
 t/lib-httpd/apache.conf        |   8 ++
 t/lib-httpd/list.sh            |  43 +++++++++
 t/lib-httpd/upload.sh          |  46 +++++++++
 t/t0410-partial-clone.sh       |  81 ++++++++++++++++
 t/t0410/git-remote-testhttpgit | 170 +++++++++++++++++++++++++++++++++
 t/t7700-repack.sh              |  20 ++++
 upload-pack.c                  |   5 +
 11 files changed, 395 insertions(+), 9 deletions(-)
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0410/git-remote-testhttpgit


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1206%2Fjohn-cai%2Fjc-repack-filter-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1206/john-cai/jc-repack-filter-v2
Pull-Request: https://github.com/git/git/pull/1206

Range-diff vs v1:

 1:  0eec9b117da = 1:  f43b76ca650 pack-objects: allow --filter without --stdout
 -:  ----------- > 2:  6e7c8410b8d repack: add --filter=<filter-spec> option
 -:  ----------- > 3:  40612b9663b upload-pack: allow missing promisor objects
 2:  a3166381572 ! 4:  d76faa1f16e repack: add --filter=<filter-spec> option
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    repack: add --filter=<filter-spec> option
     +    tests for repack --filter mode
      
     -    Currently, repack does not work with partial clones. When repack is run
     -    on a partially cloned repository, it grabs all missing objects from
     -    promisor remotes. This also means that when gc is run for repository
     -    maintenance on a partially cloned repository, it will end up getting
     -    missing objects, which is not what we want.
     -
     -    In order to make repack work with partial clone, teach repack a new
     -    option --filter, which takes a <filter-spec> argument. repack will skip
     -    any objects that are matched by <filter-spec> similar to how the clone
     -    command will skip fetching certain objects.
     -
     -    The final goal of this feature, is to be able to store objects on a
     -    server other than the regular git server itself.
     +    This patch adds tests to test both repack --filter functionality in
     +    isolation (in t7700-repack.sh) as well as how it can be used to offload
     +    large blobs (in t0410-partial-clone.sh)
      
          There are several scripts added so we can test the process of using a
     -    remote helper to upload blobs to an http server:
     +    remote helper to upload blobs to an http server.
      
          - t/lib-httpd/list.sh lists blobs uploaded to the http server.
          - t/lib-httpd/upload.sh uploads blobs to the http server.
     @@ Commit message
          Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     - ## Documentation/git-repack.txt ##
     -@@ Documentation/git-repack.txt: depth is 4095.
     - 	a larger and slower repository; see the discussion in
     - 	`pack.packSizeLimit`.
     - 
     -+--filter=<filter-spec>::
     -+	Omits certain objects (usually blobs) from the resulting
     -+	packfile. See linkgit:git-rev-list[1] for valid
     -+	`<filter-spec>` forms.
     -+
     - -b::
     - --write-bitmap-index::
     - 	Write a reachability bitmap index as part of the repack. This
     -
     - ## builtin/repack.c ##
     -@@ builtin/repack.c: struct pack_objects_args {
     - 	const char *depth;
     - 	const char *threads;
     - 	const char *max_pack_size;
     -+	const char *filter;
     - 	int no_reuse_delta;
     - 	int no_reuse_object;
     - 	int quiet;
     -@@ builtin/repack.c: static void prepare_pack_objects(struct child_process *cmd,
     - 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
     - 	if (args->max_pack_size)
     - 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
     -+	if (args->filter)
     -+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
     - 	if (args->no_reuse_delta)
     - 		strvec_pushf(&cmd->args, "--no-reuse-delta");
     - 	if (args->no_reuse_object)
     -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
     - 				N_("limits the maximum number of threads")),
     - 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
     - 				N_("maximum size of each packfile")),
     -+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
     -+				N_("object filtering")),
     - 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
     - 				N_("repack objects in packs marked with .keep")),
     - 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
     -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
     - 		if (line.len != the_hash_algo->hexsz)
     - 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
     - 		string_list_append(&names, line.buf);
     -+		if (po_args.filter) {
     -+			char *promisor_name = mkpathdup("%s-%s.promisor", packtmp,
     -+							line.buf);
     -+			write_promisor_file(promisor_name, NULL, 0);
     -+		}
     - 	}
     - 	fclose(out);
     - 	ret = finish_command(&cmd);
     -
       ## t/lib-httpd.sh ##
      @@ t/lib-httpd.sh: prepare_httpd() {
       	install_script error-smart-http.sh
     @@ t/t0410-partial-clone.sh: test_expect_success 'fetching of missing objects from
      +	git -C server rev-list --objects --all --missing=print >objects &&
      +	grep "$sha" objects
      +'
     ++
     ++test_expect_success 'fetch does not cause server to fetch missing objects' '
     ++	rm -rf origin server client &&
     ++	test_create_repo origin &&
     ++	dd if=/dev/zero of=origin/file1 bs=801k count=1 &&
     ++	git -C origin add file1 &&
     ++	git -C origin commit -m "large blob" &&
     ++	sha="$(git -C origin rev-parse :file1)" &&
     ++	expected="?$(git -C origin rev-parse :file1)" &&
     ++	git clone --bare --no-local origin server &&
     ++	git -C server remote add httpremote "testhttpgit::${PWD}/server" &&
     ++	git -C server config remote.httpremote.promisor true &&
     ++	git -C server config --remove-section remote.origin &&
     ++	git -C server rev-list --all --objects --filter-print-omitted \
     ++		--filter=blob:limit=800k | perl -ne "print if s/^[~]//" \
     ++		>large_blobs.txt &&
     ++	upload_blobs_from_stdin server <large_blobs.txt &&
     ++	git -C server -c repack.writebitmaps=false repack -a -d \
     ++		--filter=blob:limit=800k &&
     ++	git -C server config uploadpack.allowmissingpromisor true &&
     ++	git clone -c remote.httpremote.url="testhttpgit::${PWD}/server" \
     ++	-c remote.httpremote.fetch='+refs/heads/*:refs/remotes/httpremote/*' \
     ++	-c remote.httpremote.promisor=true --bare --no-local \
     ++	--filter=blob:limit=800k server client &&
     ++	git -C client rev-list --objects --all --missing=print >client_objects &&
     ++	grep "$expected" client_objects &&
     ++	git -C server rev-list --objects --all --missing=print >server_objects &&
     ++	grep "$expected" server_objects
     ++'
      +
       # DO NOT add non-httpd-specific tests here, because the last part of this
       # test script is only executed when httpd is available and enabled.

-- 
gitgitgadget
