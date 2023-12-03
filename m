Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqoBoFKb"
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F911A
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 21:57:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b4d9e81deso35599065e9.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 21:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583028; x=1702187828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsoD7IRCHR+HJJL5qEUmaFKp8KbiCRqofZBD3iOLaxE=;
        b=nqoBoFKbQVAE8E39rhNXogLED1DgqknSf+WDGYMa0LisHhDy2DUB4S+jLXkTgxFAU6
         AvZn6DrJskEZlCrX1CA5dTpEau+PrBRWhfpKa1b5MwKSHIY0CKtVCx1eh84iwArTBPEl
         oYI7JH6VqfIkvLC9lEr7WltIe6RhdQSDlqO2qt8CylQJ7hTiar+Yops/meXGkz8afSr/
         c0bznnltk3SYi3EIH9duSNHbOu++iNUIpt5G35cqfoB6aoYYNQYegL5+8rs/mxT2zjnc
         /bt5BFrx0yRyf9bY951aLzA75VR01DdKSbK4Q/h0LQ/OoloKAvMOtitWD4aiHvoBSSUv
         81MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583028; x=1702187828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsoD7IRCHR+HJJL5qEUmaFKp8KbiCRqofZBD3iOLaxE=;
        b=ftSS1IgS1V/hWz2EYa9yUw5OxZhMxYJO5OTVu4dVCZFqZwVwtXWK1KyGyNl+m19nPR
         FNGIdB2FiOW6Z/4yGDmZVQH6eKNi4MUMM4Enw3anOICWXHc2OJ8lJMgNqls9Zsx2v9Bv
         ULff7IjS3oRjikXFfkpJhmnPlHkNxkCPYnws+OpbaE32hi1HWz2ITruoVB7mngPP57Jd
         ooHgJePia4zffqy/peKGxp2dvOVHewBA6/o52hY7zHnaztwuEdych2G1nhcWRHzdA1l6
         B/jVH61sdG7mshIa+bwutkg1YL5VxzAZL9PT6CGppXjT6zqUP5W6OIYqH5dow84zYi54
         HINw==
X-Gm-Message-State: AOJu0YxQ9O4bqtHwdjEmvCypgZdGPgN0nGc5Rdj/Ot1Dnnxsf1fEcYuv
	2HCnllKUbRJKlF7nucFEM9NuGitUOMI=
X-Google-Smtp-Source: AGHT+IGWm40ON9Eguf2Bke6mV/r3O3ZozH/rTAq8hwtfR0gyXwQpq+B/xX6yiiBTwIz2NA3yJgFA9A==
X-Received: by 2002:a5d:58d9:0:b0:333:2fd2:51ff with SMTP id o25-20020a5d58d9000000b003332fd251ffmr2350082wrf.120.1701583028225;
        Sat, 02 Dec 2023 21:57:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b003333a6b9b27sm3045465wrt.106.2023.12.02.21.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 21:57:08 -0800 (PST)
Message-ID: <89501b366ff0476c1b3d36ff9b6b7c80fa6fc98f.1701583024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
References: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
	<pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 05:57:04 +0000
Subject: [PATCH v3 4/4] completion: avoid user confusion in non-cone mode
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
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Elijah Newren <newren@gmail.com>,
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

However, despite the first four issues, we can note that _if_ users are
using tab completion, then they are probably trying to specify a path in
the index.  As such, we transform their argument into a top-level-rooted
pattern that matches such a file.  For example, if they type:
   git sparse-checkout add Make<TAB>
we could "complete" to
   git sparse-checkout add /Makefile
or, if they ran from the Documentation/technical/ subdirectory:
   git sparse-checkout add m<TAB>
we could "complete" it to:
   git sparse-checkout add /Documentation/technical/multi-pack-index.txt
Note in both cases I use "complete" in quotes, because we actually add
characters both before and after the argument in question, so we are
kind of abusing "bash completions" to be "bash completions AND
beginnings".

The fifth issue is a bit stickier, especially when you consider that we
not only need to deal with escaping issues because of special meanings
of patterns in sparse-checkout & gitignore files, but also that we need
to consider escaping issues due to ls-files needing to sometimes quote
or escape characters, and because the shell needs to escape some
characters.  The multiple interacting forms of escaping could get ugly;
this patch makes no attempt to do so and simply documents that we
decided to not deal with those corner cases for now but at least get the
common cases right.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 89 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  9 ++-
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c614e5d4f07..185b47d802f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3113,6 +3113,93 @@ __gitcomp_directories ()
 	fi
 }
 
+# In non-cone mode, the arguments to {set,add} are supposed to be
+# patterns, relative to the toplevel directory.  These can be any kind
+# of general pattern, like 'subdir/*.c' and we can't complete on all
+# of those.  However, if the user presses Tab to get tab completion, we
+# presume that they are trying to provide a pattern that names a specific
+# path.
+__gitcomp_slash_leading_paths ()
+{
+	local dequoted_word pfx="" cur_ toplevel
+
+	# Since we are dealing with a sparse-checkout, subdirectories may not
+	# exist in the local working copy.  Therefore, we want to run all
+	# ls-files commands relative to the repository toplevel.
+	toplevel="$(git rev-parse --show-toplevel)/"
+
+	__git_dequote "$cur"
+
+	# If the paths provided by the user already start with '/', then
+	# they are considered relative to the toplevel of the repository
+	# already.  If they do not start with /, then we need to adjust
+	# them to start with the appropriate prefix.
+	case "$cur" in
+	/*)
+		cur="${cur:1}"
+		;;
+	*)
+		pfx="$(__git rev-parse --show-prefix)"
+	esac
+
+	# Since sparse-index is limited to cone-mode, in non-cone-mode the
+	# list of valid paths is precisely the cached files in the index.
+	#
+	# NEEDSWORK:
+	#   1) We probably need to take care of cases where ls-files
+	#      responds with special quoting.
+	#   2) We probably need to take care of cases where ${cur} has
+	#      some kind of special quoting.
+	#   3) On top of any quoting from 1 & 2, we have to provide an extra
+	#      level of quoting for any paths that contain a '*', '?', '\',
+	#      '[', ']', or leading '#' or '!' since those will be
+	#      interpreted by sparse-checkout as something other than a
+	#      literal path character.
+	# Since there are two types of quoting here, this might get really
+	# complex.  For now, just punt on all of this...
+	completions="$(__git -C "${toplevel}" -c core.quotePath=false \
+			 ls-files --cached -- "${pfx}${cur}*" \
+			 | sed -e s%^%/% -e 's%$% %')"
+	# Note, above, though that we needed all of the completions to be
+	# prefixed with a '/', and we want to add a space so that bash
+	# completion will actually complete an entry and let us move on to
+	# the next one.
+
+	# Return what we've found.
+	if test -n "$completions"; then
+		# We found some completions; return them
+		local IFS=$'\n'
+		COMPREPLY=($completions)
+	else
+		# Do NOT fall back to bash-style all-local-files-and-dirs
+		# when we find no match.  Such options are worse than
+		# useless:
+		#     1. "git sparse-checkout add" needs paths that are NOT
+		#        currently in the working copy.  "git
+		#        sparse-checkout set" does as well, except in the
+		#        special cases when users are only trying to narrow
+		#        their sparse checkout to a subset of what they
+		#        already have.
+		#
+		#     2. A path like '.config' is ambiguous as to whether
+		#        the user wants all '.config' files throughout the
+		#        tree, or just the one under the current directory.
+		#        It would result in a warning from the
+		#        sparse-checkout command due to this.  As such, all
+		#        completions of paths should be prefixed with a
+		#        '/'.
+		#
+		#     3. We don't want paths prefixed with a '/' to
+		#        complete files in the system root directory, we
+		#        want it to complete on files relative to the
+		#        repository root.
+		#
+		# As such, make sure that NO completions are offered rather
+		# than falling back to bash's default completions.
+		COMPREPLY=( "" )
+	fi
+}
+
 _git_sparse_checkout ()
 {
 	local subcommands="list init set disable add reapply"
@@ -3138,6 +3225,8 @@ _git_sparse_checkout ()
 		fi
 		if [[ "$using_cone" == "true" ]]; then
 			__gitcomp_directories
+		else
+			 __gitcomp_slash_leading_paths
 		fi
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a7c3b4eb63a..bbd17f296e4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1571,7 +1571,7 @@ test_expect_success FUNNYNAMES,!CYGWIN 'cone mode sparse-checkout completes dire
 	)
 '
 
-test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
+test_expect_success 'non-cone mode sparse-checkout gives rooted paths' '
 	# reset sparse-checkout repo to non-cone mode
 	git -C sparse-checkout sparse-checkout disable &&
 	git -C sparse-checkout sparse-checkout set --no-cone &&
@@ -1581,7 +1581,12 @@ test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
 		# expected to be empty since we have not configured
 		# custom completion for non-cone mode
 		test_completion "git sparse-checkout set f" <<-\EOF
-
+		/folder1/0/1/t.txt 
+		/folder1/expected 
+		/folder1/out 
+		/folder1/out_sorted 
+		/folder2/0/t.txt 
+		/folder3/t.txt 
 		EOF
 	)
 '
-- 
gitgitgadget
