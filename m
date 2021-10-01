Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A95C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6F761361
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbhJABjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbhJABjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 21:39:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202A8C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso2845802pjb.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0REs9HcdEanf9jvOyBZ8ki6qkWObAF2CN4myzvhTFV4=;
        b=Vs2NK+vj0rfe1T5Dh5xOMBvMQDImff1AyvlPp8aIitE32WOgPB+Z7LS3sP4Vc6JJK7
         r1+oXPXxVj+5X4L6khQknEBPp0IiPvXjMhcjs3JBFzUyrMKQSZJdLcgSlQrAf2XWWUq1
         CnMn1PEvRZ+YYkbKiyPI6K6ZUgRzEhlIYFBOBW5Pp0+ShMHNMqiZHSHyEHNz1hUQM573
         A45H3ZmH6cZTjWBuIBpXE9VlnstAYcfraZd6u2w0BHf+cCGOXjLDTF5s/lZlGZTFgRKF
         2pk7XDZf/r6P/Q+kalEFCoGHHZXFFPmRHTUF4oSj804usVXishkyxxExmjt+F6YFg546
         +duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0REs9HcdEanf9jvOyBZ8ki6qkWObAF2CN4myzvhTFV4=;
        b=X7kjPbW6BcVdlbT4U68M+cD07qVcJc+KtSMrE0zgCKCtaRA+fwHs1g3P8Fl9MGesKK
         rRbRMQYhtLfFlh1EBwLFk6M/mZldbiRRETQQu1DR+Ty1G6tmhUUW3TpgqSrBQxSmfLRw
         6/emA52B0a1PEby6J+fNzl1ArGJc/quYkD2gH9Y/qu4dBi3O9DegQT8lTTTElqECMQI+
         ztTYM88iJdBbX+V6fsp7QTXyfS3dSf3wzyUXsNM6swmJXa4NsO5GUtQLNiob3p6l/BXn
         krSw16u+IB8SaP8In3DRHQnH0/nOreejREf0Hh8ORNUNLsU9LrPPH934U7JqwV/bSHMy
         2FZQ==
X-Gm-Message-State: AOAM533D7lhWATRTtVESbhyT3F4m4a572OhQvwxQ1URQKIlsqJwDzdZD
        MYs9Eh1H4ZeVKLhbmupbHZ5+Lg4XXWM=
X-Google-Smtp-Source: ABdhPJxr/8va3QHljJ2khD4ZigEfEPDFVXo+QhtwGEkwHZ8ElnJ55T9Osfdt8gd4KeHhXPx1+iytlQ==
X-Received: by 2002:a17:902:780f:b0:13a:3919:e365 with SMTP id p15-20020a170902780f00b0013a3919e365mr8360257pll.63.1633052280159;
        Thu, 30 Sep 2021 18:38:00 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id c25sm4268199pfn.159.2021.09.30.18.37.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 18:37:59 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 0/4] difftool: dir-diff improvements and refactoring
Date:   Thu, 30 Sep 2021 18:37:52 -0700
Message-Id: <20211001013756.37586-1-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.886.g5b6dfe5e5c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v6:

- avoid returning -1 to cmd_main() by adjusting the return site in
  "create a tmpdir path without repeated slashes".

- "refactor dir-diff to write files using helper functions" was
  reworked to add two helper functions instead of one so that the
  common checks for *entry->{left,right} can be handled in a single place.

- write_entry() was renamed to write_file_in_directory() and its
  signature was adjusted to match how write_file() takes its parameters.

- write_file_in_directory() gets called from the newly added
  write_standin_files() helper which encompases the guts of
  the symlinks and submodules hashmap loops.

- Comments were added describing the purpose of the helper functions.

David Aguilar (4):
  difftool: create a tmpdir path without repeated slashes
  difftool: refactor dir-diff to write files using helper functions
  difftool: remove an unnecessary call to strbuf_release()
  difftool: add a missing space to the run_dir_diff() comments

 builtin/difftool.c  | 104 ++++++++++++++++++++++----------------------
 t/t7800-difftool.sh |   7 +++
 2 files changed, 60 insertions(+), 51 deletions(-)

Range-diff against v6:
1:  121186ca0f ! 1:  14b5618945 difftool: create a tmpdir path without repeated slashes
    @@ Commit message
         Strip trailing slashes from the value read from TMPDIR to avoid
         repeated slashes in the generated paths.
     
    -    Adjust the error handling to avoid leaking strbufs.
    +    Adjust the error handling to avoid leaking strbufs and to avoid
    +    returning -1 to cmd_main().
     
         Signed-off-by: David Aguilar <davvid@gmail.com>
     
    @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, co
      	strbuf_release(&buf);
     +	strbuf_release(&tmpdir);
      
    - 	return ret;
    +-	return ret;
    ++	return (ret < 0) ? 1 : ret;
      }
    + 
    + static int run_file_diff(int prompt, const char *prefix,
     
      ## t/t7800-difftool.sh ##
     @@ t/t7800-difftool.sh: run_dir_diff_test 'difftool --dir-diff' '
4:  8e7d54616f ! 2:  0824321eb9 difftool: refactor dir-diff to write files using a helper function
    @@ Metadata
     Author: David Aguilar <davvid@gmail.com>
     
      ## Commit message ##
    -    difftool: refactor dir-diff to write files using a helper function
    +    difftool: refactor dir-diff to write files using helper functions
     
    -    Add a write_entry() helper function to handle the unlinking and writing
    +    Add a helpers function to handle the unlinking and writing
         of the dir-diff submodule and symlink stand-in files.
     
    -    Use write_entry() inside of the hashmap loops to eliminate duplicate
    -    code and to safeguard the submodules hashmap loop against the
    -    symlink-chasing behavior that 5bafb3576a (difftool: fix symlink-file
    -    writing in dir-diff mode, 2021-09-22) addressed.
    +    Use the helpers to implement the guts of the hashmap loops.
    +    This eliminate duplicate code and safeguards the submodules
    +    hashmap loop against the symlink-chasing behavior that 5bafb3576a
    +    (difftool: fix symlink-file writing in dir-diff mode, 2021-09-22)
    +    addressed.
     
         The submodules loop should not strictly require the unlink() call that
         this is introducing to them, but it does not necessarily hurt them
    @@ builtin/difftool.c: static int checkout_path(unsigned mode, struct object_id *oi
      	return ret;
      }
      
    -+static void write_entry(const char *path, const char *content,
    -+			struct strbuf *buf, size_t len)
    ++static void write_file_in_directory(struct strbuf *dir, size_t dir_len,
    ++			const char *path, const char *content)
     +{
    -+	if (!*content)
    -+		return;
    -+	add_path(buf, len, path);
    -+	ensure_leading_directories(buf->buf);
    -+	unlink(buf->buf);
    -+	write_file(buf->buf, "%s", content);
    ++	add_path(dir, dir_len, path);
    ++	ensure_leading_directories(dir->buf);
    ++	unlink(dir->buf);
    ++	write_file(dir->buf, "%s", content);
    ++}
    ++
    ++/* Write the file contents for the left and right sides of the difftool
    ++ * dir-diff representation for submodules and symlinks. Symlinks and submodules
    ++ * are written as regular text files so that external diff tools can diff them
    ++ * as text files, resulting in behavior that is analogous to to what "git diff"
    ++ * displays for symlink and submodule diffs.
    ++ */
    ++static void write_standin_files(struct pair_entry *entry,
    ++			struct strbuf *ldir, size_t ldir_len,
    ++			struct strbuf *rdir, size_t rdir_len)
    ++{
    ++	if (*entry->left)
    ++		write_file_in_directory(ldir, ldir_len, entry->path, entry->left);
    ++	if (*entry->right)
    ++		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
     +}
     +
      static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
    @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, co
     -			ensure_leading_directories(rdir.buf);
     -			write_file(rdir.buf, "%s", entry->right);
     -		}
    -+		write_entry(entry->path, entry->left, &ldir, ldir_len);
    -+		write_entry(entry->path, entry->right, &rdir, rdir_len);
    ++		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
      	}
      
      	/*
    @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, co
     -			write_file(rdir.buf, "%s", entry->right);
     -		}
     +
    -+		write_entry(entry->path, entry->left, &ldir, ldir_len);
    -+		write_entry(entry->path, entry->right, &rdir, rdir_len);
    ++		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
      	}
      
      	strbuf_release(&buf);
5:  8db6ae3373 ! 3:  94ad86157e difftool: remove an unnecessary call to strbuf_release()
    @@ Commit message
     
      ## builtin/difftool.c ##
     @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
    - 		write_entry(entry->path, entry->right, &rdir, rdir_len);
    + 		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
      	}
      
     -	strbuf_release(&buf);
2:  080a113917 = 4:  5b6dfe5e5c difftool: add a missing space to the run_dir_diff() comments
3:  1fbc47a58d < -:  ---------- difftool: avoid returning -1 to cmd_main() from run_dir_diff()
-- 
2.33.0.886.g5b6dfe5e5c

