Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5047E208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbdH3GrI (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:47:08 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35010 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdH3GrG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:47:06 -0400
Received: by mail-pg0-f54.google.com with SMTP id 63so17492188pgc.2
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TIJlz/gNPNyw82lrEZ6da3PMwj5nxzEf/cYM939gLZM=;
        b=Y53mj/dufi5sJtpA5WuwxGECuIIMdwMSL0xQu9QPaGOLZ2kfibPH7AOMdtDnJO6kvi
         PCLrq4N8dTTs2pJDze9qb3SDUwS3HV2zVK3KSWWV9oWjNry7mXiBfpDlu29d1RRdLAJt
         pdem+b5fy7C0ynnrAjhRTHE5vL5r1/Vsz2SBX2vfd8i1ehIxD7lfPBlWJ6qvg/Jn5O0I
         svNFOCWWme3UR2ndlEg7zNbdiIl5y0RqOhLWCfDsaoCRYcWWbKmj5TglvAkPekiz5pYa
         1Gz/2D3v7chSJOfPjejbiP8Yvz2RvPNZSzQavwjKtO47+mjh3f8jMwON48bgIqGF/jG4
         yR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TIJlz/gNPNyw82lrEZ6da3PMwj5nxzEf/cYM939gLZM=;
        b=GZQFS0F0N1daw490zIsoxVtgPmZG5sqAf+xhOa74qtj7N0HFcyU8zoBV0RthDeHIuU
         5XMRnLFcebTB5hntb3OesRVsHRD+ixI/Fa9l82ZthB4D3kzdQcNLZ5I0KWGQf57rmK3C
         HPVxQfFnEQAQGRH3erbOWssP/P0RPQCN1l6iVrSE8OU0y0gn0UnFlFY6qUpthlv4vGo3
         1eGQw9XQscfdvBGPn6f6f7xwZ2glapoyoYmQIva0DWIwVwCGp3I6CT9ZgkT3YCNiJ7jD
         MONXQXIC+dUSK7/6DmcarsocPBUvoMWVssU1GJR0RLpCmN9pHKqRDXKMffS6xbBBvRgY
         rscg==
X-Gm-Message-State: AHYfb5hB16lYxb1mcphHi0gQp0oBPp9uQqZm1KcR1GihP8h1Xx71XHzt
        Xz6M4g6WlmeY7rU+b0I=
X-Received: by 10.99.120.194 with SMTP id t185mr609194pgc.246.1504075626013;
        Tue, 29 Aug 2017 23:47:06 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id 62sm7269178pfw.34.2017.08.29.23.47.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:47:05 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:46:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 00/39] per-repository object store, part 1
Message-ID: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Most of the credit for this series should go to Stefan Beller.  I just
decided to pull the trigger on sending out what we have so far.

This series is about API.  It makes no functional change yet.

Today, when a git command wants to operate on some objects from another
repository (e.g., a submodule), it has two choices:

 A. Use run_command to operate on that repository in a separate process.

 B. Use add_to_alternates_memory to pretend the repository is an
    alternate.  This has a number of downsides.  Aside from aesthetics,
    one particularly painful consequence is that as alternates
    accumulate, the number of packs git has to check for objects
    increases, which can cause significant slowdowns.

Brandon Williams's recent work to introduce "struct repository" points
to a better way.  Encapsulating object access in struct repository
would mean:

  i. The API for accessing objects in another repository becomes more
     simple and familiar (instead of using the CLI or abusing alternates).

  ii. Operations on one repository do not interfere with another,
      neither in semantics (e.g. replace objects do not work correctly
      with the approach (B) above) nor performance (already described
      above).

 iii. Resources associated with access to a repository could be freed
      when done with that repo.

  iv. Thread-safe multiple readers to a single repository also become
      straightforward, by using multiple repository objects for the same
      repo.

This series is a small step in that direction.

At the end of this series, sha1_loose_object_info takes a repository
argument and can be independently called for multiple repositories.
Not incredibly useful on its own, but a future series will do the same
for sha1_object_info, which will be enough to migrate a caller in
submodule.c (which uses the object store for commit existence checks).

This series has a few phases:

 1. Patch 1 is a cleanup that made some of the later patches easier.

 2. Patches 2-6 create a struct object_store field inside struct
    repository and move some globals to it.

 3. Patches 7-24 are mechanical changes that update some functions to
    accept a repository argument. The only goal is to make the later
    patches that teach these functions to actual handle a repository
    other than the_repository easier to review.  The patches enforce
    at compile time that no caller passes a repository other than
    the_repository --- see patch 7 in particular for details on how
    that works.

 4. Patches 25-39 update the implementations of those functions to
    handle a repository other than the_repository.  This means the
    safety check introduced in phase 3 goes away completely --- all
    functions that gained a repository argument are safe to use with
    a repository argument other than the_repository.

Patches 2-6 and 25-39 should be the most interesting to review.  I'd
particularly appreciate if people can look over 25-39 carefully.  We
were careful not to leave any calls to functions that assume they are
operating on the_repository, but a triple-check is always welcome.

Thanks as well to brian m. carlson, who showed us how such a long and
potentially tedius series can be made bearable for reviewers.

Thoughts of all kinds welcome, as always.

Thanks,
Jonathan Nieder (24):
  pack: make packed_git_mru global a value instead of a pointer
  object-store: move packed_git and packed_git_mru to object store
    struct
  pack: move prepare_packed_git_run_once to object store struct
  pack: move approximate object count to object store struct
  pack: add repository argument to install_packed_git
  pack: add repository argument to prepare_packed_git_one
  pack: add repository argument to rearrange_packed_git
  pack: add repository argument to prepare_packed_git_mru
  pack: add repository argument to prepare_packed_git
  pack: add repository argument to reprepare_packed_git
  pack: add repository argument to sha1_file_name
  pack: add repository argument to map_sha1_file
  pack: allow install_packed_git to handle arbitrary repositories
  pack: allow rearrange_packed_git to handle arbitrary repositories
  pack: allow prepare_packed_git_mru to handle arbitrary repositories
  pack: allow prepare_packed_git_one to handle arbitrary repositories
  pack: allow prepare_packed_git to handle arbitrary repositories
  pack: allow reprepare_packed_git to handle arbitrary repositories
  pack: allow sha1_file_name to handle arbitrary repositories
  pack: allow stat_sha1_file to handle arbitrary repositories
  pack: allow open_sha1_file to handle arbitrary repositories
  pack: allow map_sha1_file_1 to handle arbitrary repositories
  pack: allow map_sha1_file to handle arbitrary repositories
  pack: allow sha1_loose_object_info to handle arbitrary repositories

Stefan Beller (15):
  repository: introduce object store field
  object-store: move alt_odb_list and alt_odb_tail to object store
    struct
  sha1_file: add repository argument to alt_odb_usable
  sha1_file: add repository argument to link_alt_odb_entry
  sha1_file: add repository argument to read_info_alternates
  sha1_file: add repository argument to link_alt_odb_entries
  sha1_file: add repository argument to stat_sha1_file
  sha1_file: add repository argument to open_sha1_file
  sha1_file: add repository argument to map_sha1_file_1
  sha1_file: add repository argument to sha1_loose_object_info
  object-store: add repository argument to prepare_alt_odb
  object-store: add repository argument to foreach_alt_odb
  sha1_file: allow alt_odb_usable to handle arbitrary repositories
  object-store: allow prepare_alt_odb to handle arbitrary repositories
  object-store: allow foreach_alt_odb to handle arbitrary repositories

 builtin/count-objects.c             |  10 ++-
 builtin/fsck.c                      |  15 ++--
 builtin/gc.c                        |   8 +-
 builtin/index-pack.c                |   1 +
 builtin/pack-objects.c              |  23 +++--
 builtin/pack-redundant.c            |   8 +-
 builtin/receive-pack.c              |   4 +-
 builtin/submodule--helper.c         |   4 +-
 bulk-checkin.c                      |   3 +-
 cache.h                             |  50 ++---------
 contrib/coccinelle/packed_git.cocci |  15 ++++
 fast-import.c                       |  10 ++-
 fetch-pack.c                        |   3 +-
 http-backend.c                      |   8 +-
 http-push.c                         |   1 +
 http-walker.c                       |   4 +-
 http.c                              |   9 +-
 mru.h                               |   1 +
 object-store.h                      |  71 ++++++++++++++++
 pack-bitmap.c                       |   6 +-
 pack-check.c                        |   1 +
 pack-revindex.c                     |   1 +
 packfile.c                          |  94 ++++++++++----------
 packfile.h                          |   6 +-
 reachable.c                         |   1 +
 repository.c                        |   4 +-
 repository.h                        |   7 ++
 server-info.c                       |   8 +-
 sha1_file.c                         | 165 ++++++++++++++++++++----------------
 sha1_name.c                         |  11 ++-
 streaming.c                         |   5 +-
 transport.c                         |   4 +-
 32 files changed, 344 insertions(+), 217 deletions(-)
 create mode 100644 contrib/coccinelle/packed_git.cocci
 create mode 100644 object-store.h

-- 
2.14.1.581.gf28d330327

