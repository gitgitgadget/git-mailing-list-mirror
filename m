Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu46gnU9"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A736DD7E
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50abb83866bso1404556e87.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700761453; x=1701366253; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYf5HOvxzIIEU0VsptTaeM75T1DhYCIY3Ox5+Aluhyo=;
        b=Hu46gnU9T3udvyyE/OV9eNESbP6/+clL/a1sTweK6tYUVzD41Jfh/L6s9CtMsXXRKs
         2kPUWlRitLzYHhN4mUiNMKqI00q0bk6GZb1fWuw78VIxuWaP/MizdaZ63PTHqPb6KJWG
         m58DFrUGLiMpKl/u8E+UIqkrmluib1Y4hDdG2f8YdTRq1POZ7Oqlp07VKjipmP5b5gey
         qHqThQAk5BGP8E1EFN+xqLcwzREEQoA1bwEHthlAaC76z+aR0XKzRAk5TbcXrPUb/DgC
         tYzYUEZfImoeUDIIn6BvsyD7/RzUo68niyVYbL/3v8bLJXZb5h9QVJWXjZn0N0Y1t3wd
         mLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700761453; x=1701366253;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYf5HOvxzIIEU0VsptTaeM75T1DhYCIY3Ox5+Aluhyo=;
        b=PWjMw0wynXltQ5Vk6DfdnxZnyq40dEEiG/N7628GTNM7dsbfGQqezAa3XbYEx883WZ
         q+4cdXSnSpsFbZYkozOU1FyhlUY7ldMPd4KFtqMgcUp43xLsB8zSskjWutOQ6v8iRIFW
         rrkrESE0HqYBgxQCU46Yk83lcUcMa+jp4BO3N4aFVjXvvdhVfg/meZoudplX0DdoViE0
         /3dcTE/e1Ip48ZGpKGrxukljouy3eHQVqBafmrJkbe8TC79w2QL9uqz8DfZkkQVxc9kQ
         0PInDC5IlrsBK+UBJy1LoN3ecEo2DAMp+1L2V0+Y1bi/0mhCf8Pr+oOaGdCe8ZddBN1a
         ZrZA==
X-Gm-Message-State: AOJu0YxTFZWNZJ6jRITLP5haZNmQnQhY3NUUf0kA4dvLSFYGXlM39VnN
	fbV08ThxRqkrLaoCTDIu34XSDh9NhLQ=
X-Google-Smtp-Source: AGHT+IFouscYUf1WrGpmNZMBsVFqbnirqvJQ6APY3t4l70iAZJerAp0y5hv3gQXasBFQrtIdf+7Yww==
X-Received: by 2002:ac2:4466:0:b0:50a:9f35:4fc7 with SMTP id y6-20020ac24466000000b0050a9f354fc7mr3981584lfl.2.1700761453036;
        Thu, 23 Nov 2023 09:44:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b003fc0505be19sm2684890wmo.37.2023.11.23.09.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:44:12 -0800 (PST)
Message-ID: <fe8669a3f4f05c186e497f870c7e7ba9a94ac63f.1700761448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Nov 2023 17:44:08 +0000
Subject: [PATCH 4/4] completion: avoid user confusion in non-cone mode
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

It is tempting to think of "files and directories" of the current
directory as valid inputs to the add and set subcommands of git
sparse-checkout.  However, in non-cone mode, they often aren't and using
them as potential completions leads to *many* forms of confusion:

Issue #1. It provides the *wrong* files and directories.

For
    git sparse-checkout add
we always want to add files and directories not currently in our sparse
checkout, which means we want file and directories not currently present
in the current working tree.  Providing the files and directories
currently present is thus always wrong.

For
    git sparse-checkout set
we have a similar problem except in the subset of cases where we are
trying to narrow our checkout to a strict subset of what we already
have.  That is not a very common scenario, especially since it often
does not even happen to be true for the first use of the command; for
years we required users to create a sparse-checkout via
    git sparse-checkout init
    git sparse-checkout set <args...>
(or use a clone option that did the init step for you at clone time).
The init command creates a minimal sparse-checkout with just the
top-level directory present, meaning the set command has to be used to
expand the checkout.  Thus, only in a special and perhaps unusual cases
would any of the suggestions from normal file and directory completion
be appropriate.

Issue #2: Suggesting patterns that lead to warnings is unfriendly.

If the user specifies any regular file and omits the leading '/', then
the sparse-checkout command will warn the user that their command is
problematic and suggest they use a leading slash instead.

Issue #3: Completion gets confused by leading '/', and provides wrong paths.

Users often want to anchor their patterns to the toplevel of the
repository, especially when listing individual files.  There are a
number of reasons for this, but notably even sparse-checkout encourages
them to do so (as noted above).  However, if users do so (via adding a
leading '/' to their pattern), then bash completion will interpret the
leading slash not as a request for a path at the toplevel of the
repository, but as a request for a path at the root of the filesytem.
That means at best that completion cannot help with such paths, and if
it does find any completions, they are almost guaranteed to be wrong.

Issue #4: Suggesting invalid patterns from subdirectories is unfriendly.

There is no per-directory equivalent to .gitignore with
sparse-checkouts.  There is only a single worktree-global
$GIT_DIR/info/sparse-checkout file.  As such, paths to files must be
specified relative to the toplevel of a repository.  Providing
suggestions of paths that are relative to the current working directory,
as bash completion defaults to, is wrong when the current working
directory is not the worktree toplevel directory.

Issue #5: Paths with special characters will be interpreted incorrectly

The entries in the sparse-checkout file are patterns, not paths.  While
most paths also qualify as patterns (though even in such cases it would
be better for users to not use them directly but prefix them with a
leading '/'), there are a variety of special characters that would need
special escaping beyond the normal shell escaping: '*', '?', '\', '[',
']', and any leading '#' or '!'.  If completion suggests any such paths,
users will likely expect them to be treated as an exact path rather than
as a pattern that might match some number of files other than 1.

Because of the combination of the above issues, turn completion off for
the `set` and `add` subcommands of `sparse-checkout` when in non-cone
mode, but leave a NEEDSWORK comment specifying what could theoretically
be done if someone wanted to provide completion rules that were more
helpful than harmful.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 136faeca1e9..7d460da2fab 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3068,6 +3068,67 @@ _git_sparse_checkout ()
 		fi
 		if [[ "$using_cone" == "true" ]]; then
 			__gitcomp_directories
+		else
+			# NEEDSWORK: It might be useful to provide a
+			# completion function which:
+			#
+			#     1. Provides completions based on
+			#        files/directories that exist in HEAD, not
+			#        just those currently present in the working
+			#        tree.  Bash's default file and directory
+			#        completion is totally useless for "git
+			#        sparse-checkout add" because of this.  It is
+			#        likewise problematic for "git
+			#        sparse-checkout set" except in those subset
+			#        of cases when trying to narrow scope to a
+			#        strict subset of what you already have
+			#        checked out.
+			#
+			#     2. Always provides file/directory completions
+			#        with a prepended leading '/', so that
+			#        files/directories are only searched at the
+			#        relevant level rather than throughout all
+			#        trees in the hierarchy.  Doing this also
+			#        avoids suggesting the user run a
+			#        sparse-checkout command that will result in
+			#        a warning be thrown at the user.
+			#
+			#     3. Does not accidentally search the root of
+			#        the filesystem when a path with a leading
+			#        slash is specified.  ("git sparse-checkout
+			#        add /ho<TAB>" should not complete to
+			#        "/home" but to e.g. "/hooks" if there is a
+			#        "hooks" in the top of the repository.)
+			#
+			#     4. Provides no completions when run from a
+			#        subdirectory of the repository root.  (If we
+			#        did provide file/directory completions, the
+			#        user would just get a "please run from the
+			#        toplevel directory" error message when they
+			#        ran it.  *Further*, if the user did rerun
+			#        the command from the toplevel, the
+			#        completions we previously provided would
+			#        likely be wrong as they'd be relative to the
+			#        subdirectory rather than the repository
+			#        root.  That could lead to users getting a
+			#        nasty surprise based on trying to use a
+			#        command we helped them create.)
+			#
+			#     5. Provides escaped completions for any paths
+			#        containing a '*', '?', '\', '[', ']', or
+			#        leading '#' or '!'.  (These characters might
+			#        already be escaped to protect from the
+			#        shell, but they need an *extra* layer of
+			#        escaping to prevent the pattern parsing in
+			#        Git from seeing them as special characters.)
+			#
+			# Of course, this would be a lot of work, so for now,
+			# just avoid the many forms of user confusion that
+			# could be caused by providing bad completions by
+			# providing a fake completion to avoid falling back to
+			# bash's normal file and directory completion.
+
+			COMPREPLY=( "" )
 		fi
 	esac
 }
-- 
gitgitgadget
