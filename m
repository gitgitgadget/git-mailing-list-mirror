Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1F61F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfBSAFl (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730731AbfBSAFl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D99F603C6;
        Tue, 19 Feb 2019 00:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534737;
        bh=mdlZi+BqdRRP0OPJ6EPRNpSB4NuMzSRxAV+iSiTGK5A=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=SV9GNsgjHEXncICbK9J6YCfMYIT3bdLdJml75pwquEMEf6XGCkfWCXZ9gDqhDK1zi
         g/55tWKw4iwfYncVAmxjeQrOYFQOkgHfF9OPADDD9rKM954Bnd2Fk+rCHIXh5dUgPz
         kEMRhj3KjkC/vqtgee/un+f6EuxGvX3B9yxLbqcqFgD7ECKWVxep1jevTgOzegEbks
         sfFcvbET7fX+S/I3miWFDN8+fBQP52CK9HdsRNoxyqXeR01odhnoq9zl+c5KH1SFI+
         I5Tt+ut2tlQmHh+mSCFubHTEux/ZIcDHhRby8L04Q00MItbro+nPZMAj4iuTCEXULG
         z6nwLAV+UblgyzaNP316FNFL1C+8HWzB3qG+nwxRwY1AjaPI2C3d9jdMs2DOgMMxab
         THmTvLQ6KPo7RB+e4JvEy+pqXBIVJH+10NVYqw4NgeL9IYdEGOYFxVuGToUosyf7ni
         wMOF5TZu+ppGV/xBfxSSqQUs3JzRVvHvs1r+lN1fP4tuhUkvT3i
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 00/35] Hash function transition part 16
Date:   Tue, 19 Feb 2019 00:04:51 +0000
Message-Id: <20190219000526.476553-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the sixteenth series of hash function transition patches.

Note that the patches khash patches use a different name (kh_oid_map_t)
than the SHA-1 type (kh_sha1_t). The _oid names are already used by the
oidset code, which uses a set approach, not a map approach.

This series has slightly more patches than before, but it also does a
little more conversion than before.

Changes from v1:
* Add support for object_id khash maps.
* Use this support in the pack bitmap code.
* Improve comments in notes code.
* Fix mistranslation of fast-import code.
* Provide more descriptive values and comments in fast-import code.
* Fix miscapitalization in commit message.
* Add code to look up a hash algorithm by length.
* Use this code, along with René's patch, to restructure the archive
  patches.
* Fix a preexisting off-by-one issue on error in builtin/difftool.
* Adopt Ævar's suggested changes to Gitweb.

René Scharfe (1):
  get-tar-commit-id: parse comment record

brian m. carlson (34):
  t/lib-submodule-update: use appropriate length constant
  khash: move oid hash table definition
  pack-bitmap: make bitmap header handling hash agnostic
  pack-bitmap: convert struct stored_bitmap to object_id
  pack-bitmap: replace sha1_to_hex
  pack-bitmap: switch hard-coded constants to the_hash_algo
  pack-bitmap: switch hash tables to use struct object_id
  submodule: avoid hard-coded constants
  notes-merge: switch to use the_hash_algo
  notes: make hash size independent
  notes: replace sha1_to_hex
  object-store: rename and expand packed_git's sha1 member
  builtin/name-rev: make hash-size independent
  fast-import: make hash-size independent
  fast-import: replace sha1_to_hex
  builtin/am: make hash size independent
  builtin/pull: make hash-size independent
  http-push: convert to use the_hash_algo
  http-backend: allow 64-character hex names
  http-push: remove remaining uses of sha1_to_hex
  http-walker: replace sha1_to_hex
  http: replace hard-coded constant with the_hash_algo
  http: compute hash of downloaded objects using the_hash_algo
  http: replace sha1_to_hex
  remote-curl: make hash size independent
  hash: add a function to lookup hash algorithm by length
  builtin/get-tar-commit-id: make hash size independent
  archive: convert struct archiver_args to object_id
  refspec: make hash size independent
  builtin/difftool: use parse_oid_hex
  dir: make untracked cache extension hash size independent
  read-cache: read data in a hash-independent way
  Git.pm: make hash size independent
  gitweb: make hash size independent

 archive-tar.c               |  7 +--
 archive-zip.c               | 10 ++--
 archive.c                   |  8 +--
 archive.h                   |  2 +-
 builtin/am.c                |  9 ++--
 builtin/difftool.c          | 10 ++--
 builtin/get-tar-commit-id.c | 14 +++++-
 builtin/name-rev.c          | 14 +++---
 builtin/pack-objects.c      |  6 +--
 builtin/pack-redundant.c    |  2 +-
 builtin/pull.c              | 11 +++--
 dir.c                       | 28 +++++------
 fast-import.c               | 66 +++++++++++++++----------
 gitweb/gitweb.perl          | 97 +++++++++++++++++++++++++------------
 hash.h                      |  2 +
 http-backend.c              |  3 ++
 http-push.c                 | 29 +++++------
 http-walker.c               | 18 +++----
 http.c                      | 33 +++++++------
 http.h                      |  2 +-
 khash.h                     | 18 +++++++
 merge-recursive.c           |  2 +-
 notes-merge.c               |  6 +--
 notes.c                     | 44 +++++++++--------
 object-store.h              |  2 +-
 oidset.h                    | 12 -----
 pack-bitmap-write.c         |  8 +--
 pack-bitmap.c               | 76 ++++++++++++++---------------
 pack-bitmap.h               |  4 +-
 packfile.c                  |  6 +--
 perl/Git.pm                 |  2 +-
 read-cache.c                | 74 +++++++++++-----------------
 refspec.c                   |  2 +-
 remote-curl.c               | 11 +++--
 sha1-file.c                 |  8 +++
 submodule.c                 |  2 +-
 t/lib-submodule-update.sh   |  3 +-
 37 files changed, 362 insertions(+), 289 deletions(-)

Diff-intervalle contre v1 :
 -:  ---------- >  1:  a8262704bf khash: move oid hash table definition
 1:  78b7a887d1 =  2:  6ea91e43bb pack-bitmap: make bitmap header handling hash agnostic
 2:  307dd4d7f3 =  3:  2c1e7d56b4 pack-bitmap: convert struct stored_bitmap to object_id
 3:  7b31ed912b =  4:  cc74a66e9c pack-bitmap: replace sha1_to_hex
 4:  90a2cbba90 =  5:  a6d0161ade pack-bitmap: switch hard-coded constants to the_hash_algo
 -:  ---------- >  6:  55db506411 pack-bitmap: switch hash tables to use struct object_id
 5:  869587b01d =  7:  e8ed86d773 submodule: avoid hard-coded constants
 6:  ce253521c0 =  8:  3f7e1da6d2 notes-merge: switch to use the_hash_algo
 7:  36da40abe0 !  9:  f367ddef94 notes: make hash size independent
    @@ -82,7 +82,7 @@
      
     -/* hex SHA1 + 19 * '/' + NUL */
     -#define FANOUT_PATH_MAX GIT_SHA1_HEXSZ + FANOUT_PATH_SEPARATORS + 1
    -+/* hex oid + one slash between each pair + NUL */
    ++/* hex oid + '/' between each pair of hex digits + NUL */
     +#define FANOUT_PATH_MAX GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS_MAX + 1
      
      static void construct_path_with_fanout(const unsigned char *sha1,
 8:  91829a63e3 ! 10:  8e3508e891 notes: replace sha1_to_hex
    @@ -12,7 +12,7 @@
      --- a/notes.c
      +++ b/notes.c
     @@
    - /* hex oid + one slash between each pair + NUL */
    + /* hex oid + '/' between each pair of hex digits + NUL */
      #define FANOUT_PATH_MAX GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS_MAX + 1
      
     -static void construct_path_with_fanout(const unsigned char *sha1,
 9:  0b049ec2b0 = 11:  a3d1f218dd object-store: rename and expand packed_git's sha1 member
10:  3b3a389040 = 12:  7d9a9a5c12 builtin/name-rev: make hash-size independent
11:  f6cf848d3e ! 13:  fe457d42f0 fast-import: make hash-size independent
    @@ -11,6 +11,44 @@
      diff --git a/fast-import.c b/fast-import.c
      --- a/fast-import.c
      +++ b/fast-import.c
    +@@
    +  */
    + #define NO_DELTA S_ISUID
    + 
    ++/*
    ++ * The amount of additional space required in order to write an object into the
    ++ * current pack. This is the hash lengths at the end of the pack, plus the
    ++ * length of one object ID.
    ++ */
    ++#define PACK_SIZE_THRESHOLD (the_hash_algo->rawsz * 3)
    ++
    + struct object_entry {
    + 	struct pack_idx_entry idx;
    + 	struct object_entry *next;
    +@@
    + 	git_deflate_end(&s);
    + 
    + 	/* Determine if we should auto-checkpoint. */
    +-	if ((max_packsize && (pack_size + 60 + s.total_out) > max_packsize)
    +-		|| (pack_size + 60 + s.total_out) < pack_size) {
    ++	if ((max_packsize
    ++		&& (pack_size + PACK_SIZE_THRESHOLD + s.total_out) > max_packsize)
    ++		|| (pack_size + PACK_SIZE_THRESHOLD + s.total_out) < pack_size) {
    + 
    + 		/* This new object needs to *not* have the current pack_id. */
    + 		e->pack_id = pack_id + 1;
    +@@
    + 	int status = Z_OK;
    + 
    + 	/* Determine if we should auto-checkpoint. */
    +-	if ((max_packsize && (pack_size + 60 + len) > max_packsize)
    +-		|| (pack_size + 60 + len) < pack_size)
    ++	if ((max_packsize
    ++		&& (pack_size + PACK_SIZE_THRESHOLD + len) > max_packsize)
    ++		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
    + 		cycle_packfile();
    + 
    + 	hashfile_checkpoint(pack_file, &checkpoint);
     @@
      		c += e->name->str_len + 1;
      		hashcpy(e->versions[0].oid.hash, (unsigned char *)c);
    @@ -34,7 +72,8 @@
      	uintmax_t num_notes = 0;
      	struct object_id oid;
     -	char realpath[60];
    -+	char realpath[GIT_MAX_RAWSZ * 3];
    ++	/* hex oid + '/' between each pair of hex digits + NUL */
    ++	char realpath[GIT_MAX_HEXSZ + ((GIT_MAX_HEXSZ / 2) - 1) + 1];
     +	const unsigned hexsz = the_hash_algo->hexsz;
      
      	if (!root->tree)
    @@ -71,7 +110,7 @@
      						       commit_type, &size,
      						       &commit_oid);
     -		if (!buf || size < 46)
    -+		if (!buf || size < the_hash_algo->hexsz)
    ++		if (!buf || size < the_hash_algo->hexsz + 6)
      			die("Not a valid commit: %s", p);
      		free(buf);
      	} else
    @@ -89,7 +128,7 @@
      							       commit_type,
      							       &size, &n->oid);
     -			if (!buf || size < 46)
    -+			if (!buf || size < the_hash_algo->hexsz)
    ++			if (!buf || size < the_hash_algo->hexsz + 6)
      				die("Not a valid commit: %s", from);
      			free(buf);
      		} else
12:  366df3eeb4 = 14:  66999cae86 fast-import: replace sha1_to_hex
13:  3d3b79cbed = 15:  8dd1749b3d builtin/am: make hash size independent
14:  3a3f8ddd55 <  -:  ---------- builtin/pull: make hash-size independent
 -:  ---------- > 16:  253a42571e builtin/pull: make hash-size independent
15:  fc22aed0ad = 17:  16c417edda http-push: convert to use the_hash_algo
16:  a2da549b64 = 18:  6d867f375d http-backend: allow 64-character hex names
17:  c7481c69d8 = 19:  9e53e3be47 http-push: remove remaining uses of sha1_to_hex
18:  dbb3840e5c ! 20:  0124870940 http-walker: replace sha1_to_hex
    @@ -3,7 +3,7 @@
         http-walker: replace sha1_to_hex
     
         Since sha1_to_hex is limited to SHA-1, replace the uses of it in this
    -    file with hasH_to_hex.  Rename several variables accordingly to reflect
    +    file with hash_to_hex.  Rename several variables accordingly to reflect
         that they are no longer limited to SHA-1.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
19:  9b0a16a9d9 = 21:  d9107144c0 http: replace hard-coded constant with the_hash_algo
20:  bf433661da = 22:  f8d7da7253 http: compute hash of downloaded objects using the_hash_algo
21:  a66eb80a2f = 23:  f0e47aa063 http: replace sha1_to_hex
22:  423b42feca = 24:  26f115ab3f remote-curl: make hash size independent
23:  4b15d67a24 <  -:  ---------- archive-tar: make hash size independent
 -:  ---------- > 25:  b22c25095c hash: add a function to lookup hash algorithm by length
 -:  ---------- > 26:  89d15c7609 get-tar-commit-id: parse comment record
 -:  ---------- > 27:  5ccbfd2ff1 builtin/get-tar-commit-id: make hash size independent
24:  ee52d16b11 ! 28:  ede9b2c9b9 archive: convert struct archiver_args to object_id
    @@ -3,8 +3,8 @@
         archive: convert struct archiver_args to object_id
     
         Change the commit_sha1 member to be called "commit_oid" and change it to
    -    be a pointer to struct object_id.  Additionally, update two uses of
    -    GIT_SHA1_HEXSZ to use the_hash_algo instead.
    +    be a pointer to struct object_id.  Additionally, update some uses of
    +    GIT_SHA1_HEXSZ and hard-coded values to use the_hash_algo instead.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ -15,20 +15,21 @@
      
      static void write_global_extended_header(struct archiver_args *args)
      {
    --	const unsigned char *hash = args->commit_sha1;
    +-	const unsigned char *sha1 = args->commit_sha1;
     +	const struct object_id *oid = args->commit_oid;
      	struct strbuf ext_header = STRBUF_INIT;
      	struct ustar_header header;
      	unsigned int mode;
      
    --	if (hash)
    +-	if (sha1)
     +	if (oid)
      		strbuf_append_ext_header(&ext_header, "comment",
    --					 hash_to_hex(hash),
    +-					 sha1_to_hex(sha1), 40);
     +					 oid_to_hex(oid),
    - 					 the_hash_algo->hexsz);
    ++					 the_hash_algo->hexsz);
      	if (args->time > USTAR_MAX_MTIME) {
      		strbuf_append_ext_header_uint(&ext_header, "mtime",
    + 					      args->time);
     
      diff --git a/archive-zip.c b/archive-zip.c
      --- a/archive-zip.c
25:  47ddaca720 = 29:  4334a5d833 refspec: make hash size independent
26:  8f2437f0ef ! 30:  c74bb05533 builtin/difftool: use parse_oid_hex
    @@ -5,6 +5,11 @@
         Instead of using get_oid_hex and adding constants to the result, use
         parse_oid_hex to make this code independent of the hash size.
     
    +    Additionally, correct a typo that would cause us to print one too few
    +    characters on error, since we will already have incremented the pointer
    +    to point to the beginning of the object ID before we get to printing the
    +    error message.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      diff --git a/builtin/difftool.c b/builtin/difftool.c
    @@ -15,15 +20,17 @@
      	if (*p != ' ')
      		return error("expected ' ', got '%c'", *p);
     -	if (get_oid_hex(++p, oid1))
    -+	if (parse_oid_hex(++p, oid1, (const char **)&p))
    - 		return error("expected object ID, got '%s'", p + 1);
    +-		return error("expected object ID, got '%s'", p + 1);
     -	p += GIT_SHA1_HEXSZ;
    ++	if (parse_oid_hex(++p, oid1, (const char **)&p))
    ++		return error("expected object ID, got '%s'", p);
      	if (*p != ' ')
      		return error("expected ' ', got '%c'", *p);
     -	if (get_oid_hex(++p, oid2))
    -+	if (parse_oid_hex(++p, oid2, (const char **)&p))
    - 		return error("expected object ID, got '%s'", p + 1);
    +-		return error("expected object ID, got '%s'", p + 1);
     -	p += GIT_SHA1_HEXSZ;
    ++	if (parse_oid_hex(++p, oid2, (const char **)&p))
    ++		return error("expected object ID, got '%s'", p);
      	if (*p != ' ')
      		return error("expected ' ', got '%c'", *p);
      	*status = *++p;
27:  bf2f8ae68b = 31:  d7618969e2 dir: make untracked cache extension hash size independent
28:  0465f487fd = 32:  faa9e37821 read-cache: read data in a hash-independent way
29:  7396961044 = 33:  0086840da3 Git.pm: make hash size independent
30:  8777c5e1f3 ! 34:  c91abe5eb7 gitweb: make hash size independent
    @@ -8,11 +8,15 @@
         hex characters, and use this variable anywhere we would have previously
         hard-coded a 40 in a regex.
     
    +    Add some helper functions which allow us to write tighter regexes that
    +    match exactly the number of hex characters we're expecting.
    +
         Similarly, switch the code that looks for deleted diffinfo information
         to look for either 40 or 64 zeros, and update one piece of code to use
         this function.  Finally, when formatting a log line, allow an
         abbreviated describe output to contain up to 64 characters.
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
    @@ -22,8 +26,37 @@
      # ======================================================================
      # input validation and dispatch
      
    ++# Various hash size-related values.
    ++my $sha1_len = 40;
    ++my $sha256_extra_len = 24;
    ++my $sha256_len = $sha1_len + $sha256_extra_len;
    ++
    ++# A regex matching $len hex characters. $len may be a range (e.g. 7,64).
    ++sub oid_nlen_regex {
    ++	my $len = shift;
    ++	my $hchr = qr/[0-9a-fA-F]/;
    ++	return qr/(?:(?:$hchr){$len})/;
    ++}
    ++
    ++# A regex matching two sets of $nlen hex characters, prefixed by the literal
    ++# string $prefix and with the literal string $infix between them.
    ++sub oid_nlen_prefix_infix_regex {
    ++	my $nlen = shift;
    ++	my $prefix = shift;
    ++	my $infix = shift;
    ++
    ++	my $rx = oid_nlen_regex($nlen);
    ++
    ++	return qr/^\Q$prefix\E$rx\Q$infix\E$rx$/;
    ++}
    ++
     +# A regex matching a valid object ID.
    -+our $oid_regex = qr/(?:[0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?)/;
    ++our $oid_regex;
    ++{
    ++	my $x = oid_nlen_regex($sha1_len);
    ++	my $y = oid_nlen_regex($sha256_extra_len);
    ++	$oid_regex = qr/(?:$x(?:$y)?)/;
    ++}
     +
      # input parameters can be collected from a variety of sources (presently, CGI
      # and PATH_INFO), so we define an %input_params hash that collects them all
    @@ -37,16 +70,26 @@
      		return 1;
      	}
      	# it must be correct pathname
    +@@
    + sub format_log_line_html {
    + 	my $line = shift;
    + 
    ++	# Potentially abbreviated OID.
    ++	my $regex = oid_nlen_regex("7,64");
    ++
    + 	$line = esc_html($line, -nbsp=>1);
    + 	$line =~ s{
    +         \b
     @@
                  (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
                  [A-Za-z0-9.-]+
                  (?!\.) # refs can't end with ".", see check_refname_format()
     -            -g[0-9a-fA-F]{7,40}
    -+            -g[0-9a-fA-F]{7,64}
    ++            -g$regex
                  |
                  # Just a normal looking Git SHA1
     -            [0-9a-fA-F]{7,40}
    -+            [0-9a-fA-F]{7,64}
    ++	    $regex
              )
              \b
          }{
    @@ -55,7 +98,8 @@
      	}
      	# match <hash>
     -	if ($line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
    -+	if ($line =~ m/^index $oid_regex,$oid_regex/) {
    ++	if ($line =~ oid_nlen_prefix_infix_regex($sha1_len, "index ", ",") |
    ++	    $line =~ oid_nlen_prefix_infix_regex($sha256_len, "index ", ",")) {
      		# can match only for combined diff
      		$line = 'index ';
      		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
    @@ -64,7 +108,8 @@
      		}
      
     -	} elsif ($line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
    -+	} elsif ($line =~ m/^index $oid_regex..$oid_regex/) {
    ++	} elsif ($line =~ oid_nlen_prefix_infix_regex($sha1_len, "index ", "..") |
    ++		 $line =~ oid_nlen_prefix_infix_regex($sha256_len, "index ", "..")) {
      		# can match only for ordinary diff
      		my ($from_link, $to_link);
      		if ($from->{'href'}) {
