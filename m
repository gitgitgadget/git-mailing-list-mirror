Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611451C27
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324317; cv=none; b=QHK7muePRqYLmtTakxGXbeZ5sq66SrUbldlYO504WTO1Kj7hviB2cq54RqItHdvarkqNFm6Ve4eO2fOIYfJc23z2JUY6Ov3Qxo+bXyKGPO5ZOY5eWu5rXKcvj/swcdqXArmuasDXlWCcGqwbW4I5Wh8RVfrSXOsSSNuy5yzDS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324317; c=relaxed/simple;
	bh=5euu4+mRtFbThnSLb1M0Wgkt+KGJY5gNtaCJzWWSoDE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPB2iASacwkkQ0FC67JTKCn6G9hiLkgi8tvS4/D97anoi4XDWfQVJgA7aE9BechQL5qTPtjn7fmTT+6khl2LnsgnoxKDKwHIcyIMuTGjFBiOyP22jDufusbdxhKG8Txc1833TpA6u29cpPl8LxwOwXnyWo1ElXey6OQNZaQftZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NQm+OBki; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NQm+OBki"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F7D431617;
	Tue, 21 May 2024 16:45:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=5euu4+mRtFbThnSLb1M0Wgkt+
	KGJY5gNtaCJzWWSoDE=; b=NQm+OBkiZP67N4SCF8Tgt8NaPNW6nwLhyRYVyN0V3
	GOifpNr99WyIrLZlT3Dc0xrUVS9LYDo2VJScwfKMetoiz6K1MDiD8GwqaBMcPqTC
	/Z/V6YToj8UIJk94HfPgn8grUqZx9Uur/k19p/5zq0FbSCkqX4XzV7FR46Oy06XI
	/E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 06F6E31616;
	Tue, 21 May 2024 16:45:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79D1D31613;
	Tue, 21 May 2024 16:45:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [rPATCH 14/12] Merge branch 'jc/fix-aggressive-protection-2.40'
Date: Tue, 21 May 2024 13:45:07 -0700
Message-ID: <20240521204507.1288528-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 03FAAB18-17B3-11EF-997A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

With patches 01/12 - 12/12 applied on top of maint-2.39 (the result of
which is called jc/fix-aggressive-protection-2.39), and then the result
merged to maint-2.40 with conflict resolutions shown in 13/12, I've
prepared jc/fix-aggressive-protection-2.40.

This is "git show --remerge-diff" of the result of adjusting the
jc/fix-aggressive-protection-2.40 topic to maint-2.41 track. =20
The result is called jc/fix-aggressive-protection-2.41.

It is not for direct consumption by "git am".

The only tricky part is an evil merge to copy.h that was made
necessarily due to recent header file shuffling.

diff --git a/builtin/clone.c b/builtin/clone.c
remerge CONFLICT (content): Merge conflict in builtin/clone.c
index 85ecda8e6f..b7db074b7e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -958,15 +958,7 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 	int err =3D 0, complete_refs_before_fetch =3D 1;
 	int submodule_progress;
 	int filter_submodules =3D 0;
-<<<<<<< 0f15832059 (Git 2.41.1)
 	int hash_algo;
-	const char *template_dir;
-	char *template_dir_dup =3D NULL;
-||||||| b9b439e0e3
-	const char *template_dir;
-	char *template_dir_dup =3D NULL;
-=3D=3D=3D=3D=3D=3D=3D
->>>>>>> 1b2b92753e (Merge branch 'jc/fix-aggressive-protection-2.39' int=
o HEAD)
=20
 	struct transport_ls_refs_options transport_ls_refs_options =3D
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
diff --git a/cache.h b/cache.h
remerge CONFLICT (content): Merge conflict in cache.h
index 534e983b90..bdedb87e83 100644
--- a/cache.h
+++ b/cache.h
@@ -555,1301 +555,7 @@ extern int verify_ce_order;
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
=20
-<<<<<<< 0f15832059 (Git 2.41.1)
 int cmp_cache_name_compare(const void *a_, const void *b_);
-||||||| b9b439e0e3
-/*
- * Return an abbreviated sha1 unique within this repository's object dat=
abase.
- * The result will be at least `len` characters long, and will be NUL
- * terminated.
- *
- * The non-`_r` version returns a static buffer which remains valid unti=
l 4
- * more calls to find_unique_abbrev are made.
- *
- * The `_r` variant writes to a buffer supplied by the caller, which mus=
t be at
- * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of by=
tes
- * written (excluding the NUL terminator).
- *
- * Note that while this version avoids the static buffer, it is not full=
y
- * reentrant, as it calls into other non-reentrant git code.
- */
-const char *repo_find_unique_abbrev(struct repository *r, const struct o=
bject_id *oid, int len);
-#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_reposit=
ory, oid, len)
-int repo_find_unique_abbrev_r(struct repository *r, char *hex, const str=
uct object_id *oid, int len);
-#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(th=
e_repository, hex, oid, len)
-
-/* set default permissions by passing mode arguments to open(2) */
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
-int git_mkstemp_mode(char *pattern, int mode);
-
-/*
- * NOTE NOTE NOTE!!
- *
- * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
- * not be changed. Old repositories have core.sharedrepository written i=
n
- * numeric format, and therefore these values are preserved for compatib=
ility
- * reasons.
- */
-enum sharedrepo {
-	PERM_UMASK          =3D 0,
-	OLD_PERM_GROUP      =3D 1,
-	OLD_PERM_EVERYBODY  =3D 2,
-	PERM_GROUP          =3D 0660,
-	PERM_EVERYBODY      =3D 0664
-};
-int git_config_perm(const char *var, const char *value);
-int adjust_shared_perm(const char *path);
-
-/*
- * Create the directory containing the named path, using care to be
- * somewhat safe against races. Return one of the scld_error values to
- * indicate success/failure. On error, set errno to describe the
- * problem.
- *
- * SCLD_VANISHED indicates that one of the ancestor directories of the
- * path existed at one point during the function call and then
- * suddenly vanished, probably because another process pruned the
- * directory while we were working.  To be robust against this kind of
- * race, callers might want to try invoking the function again when it
- * returns SCLD_VANISHED.
- *
- * safe_create_leading_directories() temporarily changes path while it
- * is working but restores it before returning.
- * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily. Both these variants adjust the permissions of the
- * created directories to honor core.sharedRepository, so they are best
- * suited for files inside the git dir. For working tree files, use
- * safe_create_leading_directories_no_share() instead, as it ignores
- * the core.sharedRepository setting.
- */
-enum scld_error {
-	SCLD_OK =3D 0,
-	SCLD_FAILED =3D -1,
-	SCLD_PERMS =3D -2,
-	SCLD_EXISTS =3D -3,
-	SCLD_VANISHED =3D -4
-};
-enum scld_error safe_create_leading_directories(char *path);
-enum scld_error safe_create_leading_directories_const(const char *path);
-enum scld_error safe_create_leading_directories_no_share(char *path);
-
-int mkdir_in_gitdir(const char *path);
-char *interpolate_path(const char *path, int real_home);
-/* NEEDSWORK: remove this synonym once in-flight topics have migrated */
-#define expand_user_path interpolate_path
-const char *enter_repo(const char *path, int strict);
-static inline int is_absolute_path(const char *path)
-{
-	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
-}
-int is_directory(const char *);
-char *strbuf_realpath(struct strbuf *resolved, const char *path,
-		      int die_on_error);
-char *strbuf_realpath_forgiving(struct strbuf *resolved, const char *pat=
h,
-				int die_on_error);
-char *real_pathdup(const char *path, int die_on_error);
-const char *absolute_path(const char *path);
-char *absolute_pathdup(const char *path);
-const char *remove_leading_path(const char *in, const char *prefix);
-const char *relative_path(const char *in, const char *prefix, struct str=
buf *sb);
-int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)=
;
-int normalize_path_copy(char *dst, const char *src);
-int longest_ancestor_length(const char *path, struct string_list *prefix=
es);
-char *strip_path_suffix(const char *path, const char *suffix);
-int daemon_avoid_alias(const char *path);
-
-/*
- * These functions match their is_hfs_dotgit() counterparts; see utf8.h =
for
- * details.
- */
-int is_ntfs_dotgit(const char *name);
-int is_ntfs_dotgitmodules(const char *name);
-int is_ntfs_dotgitignore(const char *name);
-int is_ntfs_dotgitattributes(const char *name);
-int is_ntfs_dotmailmap(const char *name);
-
-/*
- * Returns true iff "str" could be confused as a command-line option whe=
n
- * passed to a sub-program like "ssh". Note that this has nothing to do =
with
- * shell-quoting, which should be handled separately; we're assuming her=
e that
- * the string makes it verbatim to the sub-program.
- */
-int looks_like_command_line_option(const char *str);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CONFIG_HOME/$subdir/$filename" if $XDG_CONFIG_HOME is non-empty=
, otherwise
- * "$HOME/.config/$subdir/$filename". Return NULL upon error.
- */
-char *xdg_config_home_for(const char *subdir, const char *filename);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, ot=
herwise
- * "$HOME/.config/git/$filename". Return NULL upon error.
- */
-char *xdg_config_home(const char *filename);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, othe=
rwise
- * "$HOME/.cache/git/$filename". Return NULL upon error.
- */
-char *xdg_cache_home(const char *filename);
-
-int git_open_cloexec(const char *name, int flags);
-#define git_open(name) git_open_cloexec(name, O_RDONLY)
-
-/**
- * unpack_loose_header() initializes the data stream needed to unpack
- * a loose object header.
- *
- * Returns:
- *
- * - ULHR_OK on success
- * - ULHR_BAD on error
- * - ULHR_TOO_LONG if the header was too long
- *
- * It will only parse up to MAX_HEADER_LEN bytes unless an optional
- * "hdrbuf" argument is non-NULL. This is intended for use with
- * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
- * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header(), ULHR_TOO_LONG will still be returned
- * from this function to indicate that the header was too long.
- */
-enum unpack_loose_header_result {
-	ULHR_OK,
-	ULHR_BAD,
-	ULHR_TOO_LONG,
-};
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz,
-						    struct strbuf *hdrbuf);
-
-/**
- * parse_loose_header() parses the starting "<type> <len>\0" of an
- * object. If it doesn't follow that format -1 is returned. To check
- * the validity of the <type> populate the "typep" in the "struct
- * object_info". It will be OBJ_BAD if the object type is unknown. The
- * parsed <len> can be retrieved via "oi->sizep", and from there
- * passed to unpack_loose_rest().
- */
-struct object_info;
-int parse_loose_header(const char *hdr, struct object_info *oi);
-
-/**
- * With in-core object data in "buf", rehash it to make sure the
- * object name actually matches "oid" to detect object corruption.
- *
- * A negative value indicates an error, usually that the OID is not
- * what we expected, but it might also indicate another error.
- */
-int check_object_signature(struct repository *r, const struct object_id =
*oid,
-			   void *map, unsigned long size,
-			   enum object_type type);
-
-/**
- * A streaming version of check_object_signature().
- * Try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
- */
-int stream_object_signature(struct repository *r, const struct object_id=
 *oid);
-
-int finalize_object_file(const char *tmpfile, const char *filename);
-
-/* Helper to check and "touch" a file */
-int check_and_freshen_file(const char *fn, int freshen);
-
-extern const signed char hexval_table[256];
-static inline unsigned int hexval(unsigned char c)
-{
-	return hexval_table[c];
-}
-
-/*
- * Convert two consecutive hexadecimal digits into a char.  Return a
- * negative value on error.  Don't run over the end of short strings.
- */
-static inline int hex2chr(const char *s)
-{
-	unsigned int val =3D hexval(s[0]);
-	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
-}
-
-/* Convert to/from hex/sha1 representation */
-#define MINIMUM_ABBREV minimum_abbrev
-#define DEFAULT_ABBREV default_abbrev
-
-/* used when the code does not know or care what the default abbrev is *=
/
-#define FALLBACK_DEFAULT_ABBREV 7
-
-struct object_context {
-	unsigned short mode;
-	/*
-	 * symlink_path is only used by get_tree_entry_follow_symlinks,
-	 * and only for symlinks that point outside the repository.
-	 */
-	struct strbuf symlink_path;
-	/*
-	 * If GET_OID_RECORD_PATH is set, this will record path (if any)
-	 * found when resolving the name. The caller is responsible for
-	 * releasing the memory.
-	 */
-	char *path;
-};
-
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
-
-#define GET_OID_DISAMBIGUATORS \
-	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
-	GET_OID_TREE | GET_OID_TREEISH | \
-	GET_OID_BLOB)
-
-enum get_oid_result {
-	FOUND =3D 0,
-	MISSING_OBJECT =3D -1, /* The requested object is missing */
-	SHORT_NAME_AMBIGUOUS =3D -2,
-	/* The following only apply when symlinks are followed */
-	DANGLING_SYMLINK =3D -4, /*
-				* The initial symlink is there, but
-				* (transitively) points to a missing
-				* in-tree file
-				*/
-	SYMLINK_LOOP =3D -5,
-	NOT_DIR =3D -6, /*
-		       * Somewhere along the symlink chain, a path is
-		       * requested which contains a file as a
-		       * non-final element.
-		       */
-};
-
-int repo_get_oid(struct repository *r, const char *str, struct object_id=
 *oid);
-__attribute__((format (printf, 2, 3)))
-int get_oidf(struct object_id *oid, const char *fmt, ...);
-int repo_get_oid_commit(struct repository *r, const char *str, struct ob=
ject_id *oid);
-int repo_get_oid_committish(struct repository *r, const char *str, struc=
t object_id *oid);
-int repo_get_oid_tree(struct repository *r, const char *str, struct obje=
ct_id *oid);
-int repo_get_oid_treeish(struct repository *r, const char *str, struct o=
bject_id *oid);
-int repo_get_oid_blob(struct repository *r, const char *str, struct obje=
ct_id *oid);
-int repo_get_oid_mb(struct repository *r, const char *str, struct object=
_id *oid);
-void maybe_die_on_misspelt_object_name(struct repository *repo,
-				       const char *name,
-				       const char *prefix);
-enum get_oid_result get_oid_with_context(struct repository *repo, const =
char *str,
-					 unsigned flags, struct object_id *oid,
-					 struct object_context *oc);
-
-#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
-#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, str=
, oid)
-#define get_oid_committish(str, oid)	repo_get_oid_committish(the_reposit=
ory, str, oid)
-#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, o=
id)
-#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, s=
tr, oid)
-#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, o=
id)
-#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid)
-
-typedef int each_abbrev_fn(const struct object_id *oid, void *);
-int repo_for_each_abbrev(struct repository *r, const char *prefix, each_=
abbrev_fn, void *);
-#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repos=
itory, prefix, fn, data)
-
-int set_disambiguate_hint_config(const char *var, const char *value);
-
-/*
- * Try to read a SHA1 in hexadecimal format from the 40 characters
- * starting at hex.  Write the 20-byte result to sha1 in binary form.
- * Return 0 on success.  Reading stops if a NUL is encountered in the
- * input, so it is safe to pass this function an arbitrary
- * null-terminated string.
- */
-int get_sha1_hex(const char *hex, unsigned char *sha1);
-int get_oid_hex(const char *hex, struct object_id *sha1);
-
-/* Like get_oid_hex, but for an arbitrary hash algorithm. */
-int get_oid_hex_algop(const char *hex, struct object_id *oid, const stru=
ct git_hash_algo *algop);
-
-/*
- * Read `len` pairs of hexadecimal digits from `hex` and write the
- * values to `binary` as `len` bytes. Return 0 on success, or -1 if
- * the input does not consist of hex digits).
- */
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
-
-/*
- * Convert a binary hash in "unsigned char []" or an object name in
- * "struct object_id *" to its hex equivalent. The `_r` variant is reent=
rant,
- * and writes the NUL-terminated output to the buffer `out`, which must =
be at
- * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
- * convenience.
- *
- * The non-`_r` variant returns a static buffer, but uses a ring of 4
- * buffers, making it safe to make multiple calls for a single statement=
, like:
- *
- *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
- *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
- */
-char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const=
 struct git_hash_algo *);
-char *oid_to_hex_r(char *out, const struct object_id *oid);
-char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash=
_algo *);	/* static buffer result! */
-char *hash_to_hex(const unsigned char *hash);						/* same static buffer=
 */
-char *oid_to_hex(const struct object_id *oid);						/* same static buffe=
r */
-
-/*
- * Parse a 40-character hexadecimal object ID starting from hex, updatin=
g the
- * pointer specified by end when parsing stops.  The resulting object ID=
 is
- * stored in oid.  Returns 0 on success.  Parsing will stop on the first=
 NUL or
- * other invalid character.  end is only updated on success; otherwise, =
it is
- * unmodified.
- */
-int parse_oid_hex(const char *hex, struct object_id *oid, const char **e=
nd);
-
-/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
-int parse_oid_hex_algop(const char *hex, struct object_id *oid, const ch=
ar **end,
-			const struct git_hash_algo *algo);
-
-
-/*
- * These functions work like get_oid_hex and parse_oid_hex, but they wil=
l parse
- * a hex value for any algorithm. The algorithm is detected based on the=
 length
- * and the algorithm in use is returned. If this is not a hex object ID =
in any
- * algorithm, returns GIT_HASH_UNKNOWN.
- */
-int get_oid_hex_any(const char *hex, struct object_id *oid);
-int parse_oid_hex_any(const char *hex, struct object_id *oid, const char=
 **end);
-
-/*
- * This reads short-hand syntax that not only evaluates to a commit
- * object name, but also can act as if the end user spelled the name
- * of the branch from the command line.
- *
- * - "@{-N}" finds the name of the Nth previous branch we were on, and
- *   places the name of the branch in the given buf and returns the
- *   number of characters parsed if successful.
- *
- * - "<branch>@{upstream}" finds the name of the other ref that
- *   <branch> is configured to merge with (missing <branch> defaults
- *   to the current branch), and places the name of the branch in the
- *   given buf and returns the number of characters parsed if
- *   successful.
- *
- * If the input is not of the accepted format, it returns a negative
- * number to signal an error.
- *
- * If the input was ok but there are not N branch switches in the
- * reflog, it returns 0.
- */
-#define INTERPRET_BRANCH_LOCAL (1<<0)
-#define INTERPRET_BRANCH_REMOTE (1<<1)
-#define INTERPRET_BRANCH_HEAD (1<<2)
-struct interpret_branch_name_options {
-	/*
-	 * If "allowed" is non-zero, it is a treated as a bitfield of allowable
-	 * expansions: local branches ("refs/heads/"), remote branches
-	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expa=
nsion is
-	 * allowed, even ones to refs outside of those namespaces.
-	 */
-	unsigned allowed;
-
-	/*
-	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
-	 * branch in question does not have such a reference, return -1 instead
-	 * of die()-ing.
-	 */
-	unsigned nonfatal_dangling_mark : 1;
-};
-int repo_interpret_branch_name(struct repository *r,
-			       const char *str, int len,
-			       struct strbuf *buf,
-			       const struct interpret_branch_name_options *options);
-#define interpret_branch_name(str, len, buf, options) \
-	repo_interpret_branch_name(the_repository, str, len, buf, options)
-
-int validate_headref(const char *ref);
-
-int base_name_compare(const char *name1, size_t len1, int mode1,
-		      const char *name2, size_t len2, int mode2);
-int df_name_compare(const char *name1, size_t len1, int mode1,
-		    const char *name2, size_t len2, int mode2);
-int name_compare(const char *name1, size_t len1, const char *name2, size=
_t len2);
-int cache_name_stage_compare(const char *name1, int len1, int stage1, co=
nst char *name2, int len2, int stage2);
-
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *oid_ret);
-
-struct object *repo_peel_to_type(struct repository *r,
-				 const char *name, int namelen,
-				 struct object *o, enum object_type);
-#define peel_to_type(name, namelen, obj, type) \
-	repo_peel_to_type(the_repository, name, namelen, obj, type)
-
-#define IDENT_STRICT	       1
-#define IDENT_NO_DATE	       2
-#define IDENT_NO_NAME	       4
-
-enum want_ident {
-	WANT_BLANK_IDENT,
-	WANT_AUTHOR_IDENT,
-	WANT_COMMITTER_IDENT
-};
-
-const char *git_author_info(int);
-const char *git_committer_info(int);
-const char *fmt_ident(const char *name, const char *email,
-		      enum want_ident whose_ident,
-		      const char *date_str, int);
-const char *fmt_name(enum want_ident);
-const char *ident_default_name(void);
-const char *ident_default_email(void);
-const char *git_editor(void);
-const char *git_sequence_editor(void);
-const char *git_pager(int stdout_is_tty);
-int is_terminal_dumb(void);
-int git_ident_config(const char *, const char *, void *);
-/*
- * Prepare an ident to fall back on if the user didn't configure it.
- */
-void prepare_fallback_ident(const char *name, const char *email);
-void reset_ident_date(void);
-
-struct ident_split {
-	const char *name_begin;
-	const char *name_end;
-	const char *mail_begin;
-	const char *mail_end;
-	const char *date_begin;
-	const char *date_end;
-	const char *tz_begin;
-	const char *tz_end;
-};
-/*
- * Signals an success with 0, but time part of the result may be NULL
- * if the input lacks timestamp and zone
- */
-int split_ident_line(struct ident_split *, const char *, int);
-
-/*
- * Given a commit or tag object buffer and the commit or tag headers, re=
places
- * the idents in the headers with their canonical versions using the mai=
lmap mechanism.
- */
-void apply_mailmap_to_header(struct strbuf *, const char **, struct stri=
ng_list *);
-
-/*
- * Compare split idents for equality or strict ordering. Note that we
- * compare only the ident part of the line, ignoring any timestamp.
- *
- * Because there are two fields, we must choose one as the primary key; =
we
- * currently arbitrarily pick the email.
- */
-int ident_cmp(const struct ident_split *, const struct ident_split *);
-
-struct cache_def {
-	struct strbuf path;
-	int flags;
-	int track_flags;
-	int prefix_len_stat_func;
-};
-#define CACHE_DEF_INIT { \
-	.path =3D STRBUF_INIT, \
-}
-static inline void cache_def_clear(struct cache_def *cache)
-{
-	strbuf_release(&cache->path);
-}
-
-int has_symlink_leading_path(const char *name, int len);
-int threaded_has_symlink_leading_path(struct cache_def *, const char *, =
int);
-int check_leading_path(const char *name, int len, int warn_on_lstat_err)=
;
-int has_dirs_only_path(const char *name, int len, int prefix_len);
-void invalidate_lstat_cache(void);
-void schedule_dir_for_removal(const char *name, int len);
-void remove_scheduled_dirs(void);
-
-struct pack_window {
-	struct pack_window *next;
-	unsigned char *base;
-	off_t offset;
-	size_t len;
-	unsigned int last_used;
-	unsigned int inuse_cnt;
-};
-
-struct pack_entry {
-	off_t offset;
-	struct packed_git *p;
-};
-
-/*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should ha=
ve the
- * usual "XXXXXX" trailer, and the resulting filename is written into th=
e
- * "template" buffer. Returns the open descriptor.
- */
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
-
-/*
- * Create a pack .keep file named "name" (which should generally be the =
output
- * of odb_pack_name). Returns a file descriptor opened for writing, or -=
1 on
- * error.
- */
-int odb_pack_keep(const char *name);
-
-/*
- * Set this to 0 to prevent oid_object_info_extended() from fetching mis=
sing
- * blobs. This has a difference only if extensions.partialClone is set.
- *
- * Its default value is 1.
- */
-extern int fetch_if_missing;
-
-/* Dumb servers support */
-int update_server_info(int);
-
-const char *get_log_output_encoding(void);
-const char *get_commit_output_encoding(void);
-
-int committer_ident_sufficiently_given(void);
-int author_ident_sufficiently_given(void);
-
-extern const char *git_commit_encoding;
-extern const char *git_log_output_encoding;
-extern const char *git_mailmap_file;
-extern const char *git_mailmap_blob;
-
-/* IO helper functions */
-void maybe_flush_or_die(FILE *, const char *);
-__attribute__((format (printf, 2, 3)))
-void fprintf_or_die(FILE *, const char *fmt, ...);
-void fwrite_or_die(FILE *f, const void *buf, size_t count);
-void fflush_or_die(FILE *f);
-
-#define COPY_READ_ERROR (-2)
-#define COPY_WRITE_ERROR (-3)
-int copy_fd(int ifd, int ofd);
-int copy_file(const char *dst, const char *src, int mode);
-int copy_file_with_time(const char *dst, const char *src, int mode);
-
-/*
- * Compare the file mode and contents of two given files.
- *
- * If both files are actually symbolic links, the function returns 1 if =
the link
- * targets are identical or 0 if they are not.
- *
- * If any of the two files cannot be accessed or in case of read failure=
s, this
- * function returns 0.
- *
- * If the file modes and contents are identical, the function returns 1,
- * otherwise it returns 0.
- */
-int do_files_match(const char *path1, const char *path2);
-
-void write_or_die(int fd, const void *buf, size_t count);
-void fsync_or_die(int fd, const char *);
-int fsync_component(enum fsync_component component, int fd);
-void fsync_component_or_die(enum fsync_component component, int fd, cons=
t char *msg);
-
-static inline int batch_fsync_enabled(enum fsync_component component)
-{
-	return (fsync_components & component) && (fsync_method =3D=3D FSYNC_MET=
HOD_BATCH);
-}
-
-ssize_t read_in_full(int fd, void *buf, size_t count);
-ssize_t write_in_full(int fd, const void *buf, size_t count);
-ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
-
-static inline ssize_t write_str_in_full(int fd, const char *str)
-{
-	return write_in_full(fd, str, strlen(str));
-}
-
-/**
- * Open (and truncate) the file at path, write the contents of buf to it=
,
- * and close it. Dies if any errors are encountered.
- */
-void write_file_buf(const char *path, const char *buf, size_t len);
-
-/**
- * Like write_file_buf(), but format the contents into a buffer first.
- * Additionally, write_file() will append a newline if one is not alread=
y
- * present, making it convenient to write text files:
- *
- *   write_file(path, "counter: %d", ctr);
- */
-__attribute__((format (printf, 2, 3)))
-void write_file(const char *path, const char *fmt, ...);
-
-/* pager.c */
-void setup_pager(void);
-int pager_in_use(void);
-extern int pager_use_color;
-int term_columns(void);
-void term_clear_line(void);
-int decimal_width(uintmax_t);
-int check_pager_config(const char *cmd);
-void prepare_pager_args(struct child_process *, const char *pager);
-
-extern const char *editor_program;
-extern const char *askpass_program;
-extern const char *excludes_file;
-
-/* base85 */
-int decode_85(char *dst, const char *line, int linelen);
-void encode_85(char *buf, const unsigned char *data, int bytes);
-
-/* pkt-line.c */
-void packet_trace_identity(const char *prog);
-=3D=3D=3D=3D=3D=3D=3D
-/*
- * Return an abbreviated sha1 unique within this repository's object dat=
abase.
- * The result will be at least `len` characters long, and will be NUL
- * terminated.
- *
- * The non-`_r` version returns a static buffer which remains valid unti=
l 4
- * more calls to find_unique_abbrev are made.
- *
- * The `_r` variant writes to a buffer supplied by the caller, which mus=
t be at
- * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of by=
tes
- * written (excluding the NUL terminator).
- *
- * Note that while this version avoids the static buffer, it is not full=
y
- * reentrant, as it calls into other non-reentrant git code.
- */
-const char *repo_find_unique_abbrev(struct repository *r, const struct o=
bject_id *oid, int len);
-#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_reposit=
ory, oid, len)
-int repo_find_unique_abbrev_r(struct repository *r, char *hex, const str=
uct object_id *oid, int len);
-#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(th=
e_repository, hex, oid, len)
-
-/* set default permissions by passing mode arguments to open(2) */
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
-int git_mkstemp_mode(char *pattern, int mode);
-
-/*
- * NOTE NOTE NOTE!!
- *
- * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
- * not be changed. Old repositories have core.sharedrepository written i=
n
- * numeric format, and therefore these values are preserved for compatib=
ility
- * reasons.
- */
-enum sharedrepo {
-	PERM_UMASK          =3D 0,
-	OLD_PERM_GROUP      =3D 1,
-	OLD_PERM_EVERYBODY  =3D 2,
-	PERM_GROUP          =3D 0660,
-	PERM_EVERYBODY      =3D 0664
-};
-int git_config_perm(const char *var, const char *value);
-int adjust_shared_perm(const char *path);
-
-/*
- * Create the directory containing the named path, using care to be
- * somewhat safe against races. Return one of the scld_error values to
- * indicate success/failure. On error, set errno to describe the
- * problem.
- *
- * SCLD_VANISHED indicates that one of the ancestor directories of the
- * path existed at one point during the function call and then
- * suddenly vanished, probably because another process pruned the
- * directory while we were working.  To be robust against this kind of
- * race, callers might want to try invoking the function again when it
- * returns SCLD_VANISHED.
- *
- * safe_create_leading_directories() temporarily changes path while it
- * is working but restores it before returning.
- * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily. Both these variants adjust the permissions of the
- * created directories to honor core.sharedRepository, so they are best
- * suited for files inside the git dir. For working tree files, use
- * safe_create_leading_directories_no_share() instead, as it ignores
- * the core.sharedRepository setting.
- */
-enum scld_error {
-	SCLD_OK =3D 0,
-	SCLD_FAILED =3D -1,
-	SCLD_PERMS =3D -2,
-	SCLD_EXISTS =3D -3,
-	SCLD_VANISHED =3D -4
-};
-enum scld_error safe_create_leading_directories(char *path);
-enum scld_error safe_create_leading_directories_const(const char *path);
-enum scld_error safe_create_leading_directories_no_share(char *path);
-
-int mkdir_in_gitdir(const char *path);
-char *interpolate_path(const char *path, int real_home);
-/* NEEDSWORK: remove this synonym once in-flight topics have migrated */
-#define expand_user_path interpolate_path
-const char *enter_repo(const char *path, int strict);
-static inline int is_absolute_path(const char *path)
-{
-	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
-}
-int is_directory(const char *);
-char *strbuf_realpath(struct strbuf *resolved, const char *path,
-		      int die_on_error);
-char *strbuf_realpath_forgiving(struct strbuf *resolved, const char *pat=
h,
-				int die_on_error);
-char *real_pathdup(const char *path, int die_on_error);
-const char *absolute_path(const char *path);
-char *absolute_pathdup(const char *path);
-const char *remove_leading_path(const char *in, const char *prefix);
-const char *relative_path(const char *in, const char *prefix, struct str=
buf *sb);
-int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)=
;
-int normalize_path_copy(char *dst, const char *src);
-int longest_ancestor_length(const char *path, struct string_list *prefix=
es);
-char *strip_path_suffix(const char *path, const char *suffix);
-int daemon_avoid_alias(const char *path);
-
-/*
- * These functions match their is_hfs_dotgit() counterparts; see utf8.h =
for
- * details.
- */
-int is_ntfs_dotgit(const char *name);
-int is_ntfs_dotgitmodules(const char *name);
-int is_ntfs_dotgitignore(const char *name);
-int is_ntfs_dotgitattributes(const char *name);
-int is_ntfs_dotmailmap(const char *name);
-
-/*
- * Returns true iff "str" could be confused as a command-line option whe=
n
- * passed to a sub-program like "ssh". Note that this has nothing to do =
with
- * shell-quoting, which should be handled separately; we're assuming her=
e that
- * the string makes it verbatim to the sub-program.
- */
-int looks_like_command_line_option(const char *str);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CONFIG_HOME/$subdir/$filename" if $XDG_CONFIG_HOME is non-empty=
, otherwise
- * "$HOME/.config/$subdir/$filename". Return NULL upon error.
- */
-char *xdg_config_home_for(const char *subdir, const char *filename);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, ot=
herwise
- * "$HOME/.config/git/$filename". Return NULL upon error.
- */
-char *xdg_config_home(const char *filename);
-
-/**
- * Return a newly allocated string with the evaluation of
- * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, othe=
rwise
- * "$HOME/.cache/git/$filename". Return NULL upon error.
- */
-char *xdg_cache_home(const char *filename);
-
-int git_open_cloexec(const char *name, int flags);
-#define git_open(name) git_open_cloexec(name, O_RDONLY)
-
-/**
- * unpack_loose_header() initializes the data stream needed to unpack
- * a loose object header.
- *
- * Returns:
- *
- * - ULHR_OK on success
- * - ULHR_BAD on error
- * - ULHR_TOO_LONG if the header was too long
- *
- * It will only parse up to MAX_HEADER_LEN bytes unless an optional
- * "hdrbuf" argument is non-NULL. This is intended for use with
- * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
- * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header(), ULHR_TOO_LONG will still be returned
- * from this function to indicate that the header was too long.
- */
-enum unpack_loose_header_result {
-	ULHR_OK,
-	ULHR_BAD,
-	ULHR_TOO_LONG,
-};
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz,
-						    struct strbuf *hdrbuf);
-
-/**
- * parse_loose_header() parses the starting "<type> <len>\0" of an
- * object. If it doesn't follow that format -1 is returned. To check
- * the validity of the <type> populate the "typep" in the "struct
- * object_info". It will be OBJ_BAD if the object type is unknown. The
- * parsed <len> can be retrieved via "oi->sizep", and from there
- * passed to unpack_loose_rest().
- */
-struct object_info;
-int parse_loose_header(const char *hdr, struct object_info *oi);
-
-/**
- * With in-core object data in "buf", rehash it to make sure the
- * object name actually matches "oid" to detect object corruption.
- *
- * A negative value indicates an error, usually that the OID is not
- * what we expected, but it might also indicate another error.
- */
-int check_object_signature(struct repository *r, const struct object_id =
*oid,
-			   void *map, unsigned long size,
-			   enum object_type type);
-
-/**
- * A streaming version of check_object_signature().
- * Try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
- */
-int stream_object_signature(struct repository *r, const struct object_id=
 *oid);
-
-int finalize_object_file(const char *tmpfile, const char *filename);
-
-/* Helper to check and "touch" a file */
-int check_and_freshen_file(const char *fn, int freshen);
-
-extern const signed char hexval_table[256];
-static inline unsigned int hexval(unsigned char c)
-{
-	return hexval_table[c];
-}
-
-/*
- * Convert two consecutive hexadecimal digits into a char.  Return a
- * negative value on error.  Don't run over the end of short strings.
- */
-static inline int hex2chr(const char *s)
-{
-	unsigned int val =3D hexval(s[0]);
-	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
-}
-
-/* Convert to/from hex/sha1 representation */
-#define MINIMUM_ABBREV minimum_abbrev
-#define DEFAULT_ABBREV default_abbrev
-
-/* used when the code does not know or care what the default abbrev is *=
/
-#define FALLBACK_DEFAULT_ABBREV 7
-
-struct object_context {
-	unsigned short mode;
-	/*
-	 * symlink_path is only used by get_tree_entry_follow_symlinks,
-	 * and only for symlinks that point outside the repository.
-	 */
-	struct strbuf symlink_path;
-	/*
-	 * If GET_OID_RECORD_PATH is set, this will record path (if any)
-	 * found when resolving the name. The caller is responsible for
-	 * releasing the memory.
-	 */
-	char *path;
-};
-
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
-
-#define GET_OID_DISAMBIGUATORS \
-	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
-	GET_OID_TREE | GET_OID_TREEISH | \
-	GET_OID_BLOB)
-
-enum get_oid_result {
-	FOUND =3D 0,
-	MISSING_OBJECT =3D -1, /* The requested object is missing */
-	SHORT_NAME_AMBIGUOUS =3D -2,
-	/* The following only apply when symlinks are followed */
-	DANGLING_SYMLINK =3D -4, /*
-				* The initial symlink is there, but
-				* (transitively) points to a missing
-				* in-tree file
-				*/
-	SYMLINK_LOOP =3D -5,
-	NOT_DIR =3D -6, /*
-		       * Somewhere along the symlink chain, a path is
-		       * requested which contains a file as a
-		       * non-final element.
-		       */
-};
-
-int repo_get_oid(struct repository *r, const char *str, struct object_id=
 *oid);
-__attribute__((format (printf, 2, 3)))
-int get_oidf(struct object_id *oid, const char *fmt, ...);
-int repo_get_oid_commit(struct repository *r, const char *str, struct ob=
ject_id *oid);
-int repo_get_oid_committish(struct repository *r, const char *str, struc=
t object_id *oid);
-int repo_get_oid_tree(struct repository *r, const char *str, struct obje=
ct_id *oid);
-int repo_get_oid_treeish(struct repository *r, const char *str, struct o=
bject_id *oid);
-int repo_get_oid_blob(struct repository *r, const char *str, struct obje=
ct_id *oid);
-int repo_get_oid_mb(struct repository *r, const char *str, struct object=
_id *oid);
-void maybe_die_on_misspelt_object_name(struct repository *repo,
-				       const char *name,
-				       const char *prefix);
-enum get_oid_result get_oid_with_context(struct repository *repo, const =
char *str,
-					 unsigned flags, struct object_id *oid,
-					 struct object_context *oc);
-
-#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
-#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, str=
, oid)
-#define get_oid_committish(str, oid)	repo_get_oid_committish(the_reposit=
ory, str, oid)
-#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, o=
id)
-#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, s=
tr, oid)
-#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, o=
id)
-#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid)
-
-typedef int each_abbrev_fn(const struct object_id *oid, void *);
-int repo_for_each_abbrev(struct repository *r, const char *prefix, each_=
abbrev_fn, void *);
-#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repos=
itory, prefix, fn, data)
-
-int set_disambiguate_hint_config(const char *var, const char *value);
-
-/*
- * Try to read a SHA1 in hexadecimal format from the 40 characters
- * starting at hex.  Write the 20-byte result to sha1 in binary form.
- * Return 0 on success.  Reading stops if a NUL is encountered in the
- * input, so it is safe to pass this function an arbitrary
- * null-terminated string.
- */
-int get_sha1_hex(const char *hex, unsigned char *sha1);
-int get_oid_hex(const char *hex, struct object_id *sha1);
-
-/* Like get_oid_hex, but for an arbitrary hash algorithm. */
-int get_oid_hex_algop(const char *hex, struct object_id *oid, const stru=
ct git_hash_algo *algop);
-
-/*
- * Read `len` pairs of hexadecimal digits from `hex` and write the
- * values to `binary` as `len` bytes. Return 0 on success, or -1 if
- * the input does not consist of hex digits).
- */
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
-
-/*
- * Convert a binary hash in "unsigned char []" or an object name in
- * "struct object_id *" to its hex equivalent. The `_r` variant is reent=
rant,
- * and writes the NUL-terminated output to the buffer `out`, which must =
be at
- * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
- * convenience.
- *
- * The non-`_r` variant returns a static buffer, but uses a ring of 4
- * buffers, making it safe to make multiple calls for a single statement=
, like:
- *
- *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
- *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
- */
-char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const=
 struct git_hash_algo *);
-char *oid_to_hex_r(char *out, const struct object_id *oid);
-char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash=
_algo *);	/* static buffer result! */
-char *hash_to_hex(const unsigned char *hash);						/* same static buffer=
 */
-char *oid_to_hex(const struct object_id *oid);						/* same static buffe=
r */
-
-/*
- * Parse a 40-character hexadecimal object ID starting from hex, updatin=
g the
- * pointer specified by end when parsing stops.  The resulting object ID=
 is
- * stored in oid.  Returns 0 on success.  Parsing will stop on the first=
 NUL or
- * other invalid character.  end is only updated on success; otherwise, =
it is
- * unmodified.
- */
-int parse_oid_hex(const char *hex, struct object_id *oid, const char **e=
nd);
-
-/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
-int parse_oid_hex_algop(const char *hex, struct object_id *oid, const ch=
ar **end,
-			const struct git_hash_algo *algo);
-
-
-/*
- * These functions work like get_oid_hex and parse_oid_hex, but they wil=
l parse
- * a hex value for any algorithm. The algorithm is detected based on the=
 length
- * and the algorithm in use is returned. If this is not a hex object ID =
in any
- * algorithm, returns GIT_HASH_UNKNOWN.
- */
-int get_oid_hex_any(const char *hex, struct object_id *oid);
-int parse_oid_hex_any(const char *hex, struct object_id *oid, const char=
 **end);
-
-/*
- * This reads short-hand syntax that not only evaluates to a commit
- * object name, but also can act as if the end user spelled the name
- * of the branch from the command line.
- *
- * - "@{-N}" finds the name of the Nth previous branch we were on, and
- *   places the name of the branch in the given buf and returns the
- *   number of characters parsed if successful.
- *
- * - "<branch>@{upstream}" finds the name of the other ref that
- *   <branch> is configured to merge with (missing <branch> defaults
- *   to the current branch), and places the name of the branch in the
- *   given buf and returns the number of characters parsed if
- *   successful.
- *
- * If the input is not of the accepted format, it returns a negative
- * number to signal an error.
- *
- * If the input was ok but there are not N branch switches in the
- * reflog, it returns 0.
- */
-#define INTERPRET_BRANCH_LOCAL (1<<0)
-#define INTERPRET_BRANCH_REMOTE (1<<1)
-#define INTERPRET_BRANCH_HEAD (1<<2)
-struct interpret_branch_name_options {
-	/*
-	 * If "allowed" is non-zero, it is a treated as a bitfield of allowable
-	 * expansions: local branches ("refs/heads/"), remote branches
-	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expa=
nsion is
-	 * allowed, even ones to refs outside of those namespaces.
-	 */
-	unsigned allowed;
-
-	/*
-	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
-	 * branch in question does not have such a reference, return -1 instead
-	 * of die()-ing.
-	 */
-	unsigned nonfatal_dangling_mark : 1;
-};
-int repo_interpret_branch_name(struct repository *r,
-			       const char *str, int len,
-			       struct strbuf *buf,
-			       const struct interpret_branch_name_options *options);
-#define interpret_branch_name(str, len, buf, options) \
-	repo_interpret_branch_name(the_repository, str, len, buf, options)
-
-int validate_headref(const char *ref);
-
-int base_name_compare(const char *name1, size_t len1, int mode1,
-		      const char *name2, size_t len2, int mode2);
-int df_name_compare(const char *name1, size_t len1, int mode1,
-		    const char *name2, size_t len2, int mode2);
-int name_compare(const char *name1, size_t len1, const char *name2, size=
_t len2);
-int cache_name_stage_compare(const char *name1, int len1, int stage1, co=
nst char *name2, int len2, int stage2);
-
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *oid_ret);
-
-struct object *repo_peel_to_type(struct repository *r,
-				 const char *name, int namelen,
-				 struct object *o, enum object_type);
-#define peel_to_type(name, namelen, obj, type) \
-	repo_peel_to_type(the_repository, name, namelen, obj, type)
-
-#define IDENT_STRICT	       1
-#define IDENT_NO_DATE	       2
-#define IDENT_NO_NAME	       4
-
-enum want_ident {
-	WANT_BLANK_IDENT,
-	WANT_AUTHOR_IDENT,
-	WANT_COMMITTER_IDENT
-};
-
-const char *git_author_info(int);
-const char *git_committer_info(int);
-const char *fmt_ident(const char *name, const char *email,
-		      enum want_ident whose_ident,
-		      const char *date_str, int);
-const char *fmt_name(enum want_ident);
-const char *ident_default_name(void);
-const char *ident_default_email(void);
-const char *git_editor(void);
-const char *git_sequence_editor(void);
-const char *git_pager(int stdout_is_tty);
-int is_terminal_dumb(void);
-int git_ident_config(const char *, const char *, void *);
-/*
- * Prepare an ident to fall back on if the user didn't configure it.
- */
-void prepare_fallback_ident(const char *name, const char *email);
-void reset_ident_date(void);
-
-struct ident_split {
-	const char *name_begin;
-	const char *name_end;
-	const char *mail_begin;
-	const char *mail_end;
-	const char *date_begin;
-	const char *date_end;
-	const char *tz_begin;
-	const char *tz_end;
-};
-/*
- * Signals an success with 0, but time part of the result may be NULL
- * if the input lacks timestamp and zone
- */
-int split_ident_line(struct ident_split *, const char *, int);
-
-/*
- * Given a commit or tag object buffer and the commit or tag headers, re=
places
- * the idents in the headers with their canonical versions using the mai=
lmap mechanism.
- */
-void apply_mailmap_to_header(struct strbuf *, const char **, struct stri=
ng_list *);
-
-/*
- * Compare split idents for equality or strict ordering. Note that we
- * compare only the ident part of the line, ignoring any timestamp.
- *
- * Because there are two fields, we must choose one as the primary key; =
we
- * currently arbitrarily pick the email.
- */
-int ident_cmp(const struct ident_split *, const struct ident_split *);
-
-struct cache_def {
-	struct strbuf path;
-	int flags;
-	int track_flags;
-	int prefix_len_stat_func;
-};
-#define CACHE_DEF_INIT { \
-	.path =3D STRBUF_INIT, \
-}
-static inline void cache_def_clear(struct cache_def *cache)
-{
-	strbuf_release(&cache->path);
-}
-
-int has_symlink_leading_path(const char *name, int len);
-int threaded_has_symlink_leading_path(struct cache_def *, const char *, =
int);
-int check_leading_path(const char *name, int len, int warn_on_lstat_err)=
;
-int has_dirs_only_path(const char *name, int len, int prefix_len);
-void invalidate_lstat_cache(void);
-void schedule_dir_for_removal(const char *name, int len);
-void remove_scheduled_dirs(void);
-
-struct pack_window {
-	struct pack_window *next;
-	unsigned char *base;
-	off_t offset;
-	size_t len;
-	unsigned int last_used;
-	unsigned int inuse_cnt;
-};
-
-struct pack_entry {
-	off_t offset;
-	struct packed_git *p;
-};
-
-/*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should ha=
ve the
- * usual "XXXXXX" trailer, and the resulting filename is written into th=
e
- * "template" buffer. Returns the open descriptor.
- */
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
-
-/*
- * Create a pack .keep file named "name" (which should generally be the =
output
- * of odb_pack_name). Returns a file descriptor opened for writing, or -=
1 on
- * error.
- */
-int odb_pack_keep(const char *name);
-
-/*
- * Set this to 0 to prevent oid_object_info_extended() from fetching mis=
sing
- * blobs. This has a difference only if extensions.partialClone is set.
- *
- * Its default value is 1.
- */
-extern int fetch_if_missing;
-
-/* Dumb servers support */
-int update_server_info(int);
-
-const char *get_log_output_encoding(void);
-const char *get_commit_output_encoding(void);
-
-int committer_ident_sufficiently_given(void);
-int author_ident_sufficiently_given(void);
-
-extern const char *git_commit_encoding;
-extern const char *git_log_output_encoding;
-extern const char *git_mailmap_file;
-extern const char *git_mailmap_blob;
-
-/* IO helper functions */
-void maybe_flush_or_die(FILE *, const char *);
-__attribute__((format (printf, 2, 3)))
-void fprintf_or_die(FILE *, const char *fmt, ...);
-void fwrite_or_die(FILE *f, const void *buf, size_t count);
-void fflush_or_die(FILE *f);
-
-#define COPY_READ_ERROR (-2)
-#define COPY_WRITE_ERROR (-3)
-int copy_fd(int ifd, int ofd);
-int copy_file(const char *dst, const char *src, int mode);
-int copy_file_with_time(const char *dst, const char *src, int mode);
-
-void write_or_die(int fd, const void *buf, size_t count);
-void fsync_or_die(int fd, const char *);
-int fsync_component(enum fsync_component component, int fd);
-void fsync_component_or_die(enum fsync_component component, int fd, cons=
t char *msg);
-
-static inline int batch_fsync_enabled(enum fsync_component component)
-{
-	return (fsync_components & component) && (fsync_method =3D=3D FSYNC_MET=
HOD_BATCH);
-}
-
-ssize_t read_in_full(int fd, void *buf, size_t count);
-ssize_t write_in_full(int fd, const void *buf, size_t count);
-ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
-
-static inline ssize_t write_str_in_full(int fd, const char *str)
-{
-	return write_in_full(fd, str, strlen(str));
-}
-
-/**
- * Open (and truncate) the file at path, write the contents of buf to it=
,
- * and close it. Dies if any errors are encountered.
- */
-void write_file_buf(const char *path, const char *buf, size_t len);
-
-/**
- * Like write_file_buf(), but format the contents into a buffer first.
- * Additionally, write_file() will append a newline if one is not alread=
y
- * present, making it convenient to write text files:
- *
- *   write_file(path, "counter: %d", ctr);
- */
-__attribute__((format (printf, 2, 3)))
-void write_file(const char *path, const char *fmt, ...);
-
-/* pager.c */
-void setup_pager(void);
-int pager_in_use(void);
-extern int pager_use_color;
-int term_columns(void);
-void term_clear_line(void);
-int decimal_width(uintmax_t);
-int check_pager_config(const char *cmd);
-void prepare_pager_args(struct child_process *, const char *pager);
-
-extern const char *editor_program;
-extern const char *askpass_program;
-extern const char *excludes_file;
-
-/* base85 */
-int decode_85(char *dst, const char *line, int linelen);
-void encode_85(char *buf, const unsigned char *data, int bytes);
-
-/* pkt-line.c */
-void packet_trace_identity(const char *prog);
->>>>>>> 1b2b92753e (Merge branch 'jc/fix-aggressive-protection-2.39' int=
o HEAD)
=20
 /* add */
 /*
diff --git a/copy.h b/copy.h
index 057259a3a7..2af77cba86 100644
--- a/copy.h
+++ b/copy.h
@@ -7,18 +7,4 @@ int copy_fd(int ifd, int ofd);
 int copy_file(const char *dst, const char *src, int mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
=20
-/*
- * Compare the file mode and contents of two given files.
- *
- * If both files are actually symbolic links, the function returns 1 if =
the link
- * targets are identical or 0 if they are not.
- *
- * If any of the two files cannot be accessed or in case of read failure=
s, this
- * function returns 0.
- *
- * If the file modes and contents are identical, the function returns 1,
- * otherwise it returns 0.
- */
-int do_files_match(const char *path1, const char *path2);
-
 #endif /* COPY_H */
