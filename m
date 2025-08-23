Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BB21CA10
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956670; cv=none; b=Bks1O3FRCvNhFI7pX6MYUrnMJ5/F8ZkUkwc6WmMwM5C59RDRw8KSYykyPyJZxzP6FanpRJhhAL/05gOwB7RpIuS+HzviGlowA+/2/s3a90Muf00KMdBwuSbd24Q/ydUJR0ew+KN+i5pxtDvmCqSTOpE/0VS/U26SYT8AnzlW0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956670; c=relaxed/simple;
	bh=PnAbHMGMwzbLuMiGA3is2NHUKHy1vxAc3nH+8g1egJc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=J9v1W097pfRtsgf9TaU+E6wAqDfsuzOZpNWKyjtDqG0WGWPuC8its2BkKvOzvyKa73QEdZ36BJUQTYlneCarjqO7qCHHZ9WnHkeFvY8982U2So8t3t3fhhr41LFEevxfEYDbdCSBGzwHI7J396w/ZilrR5sopHZIf2kx/E3RmME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57NDhYVU3391376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Aug 2025 13:43:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ezekiel Newren via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
Cc: "'Elijah Newren'" <newren@gmail.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Christian Brabandt'" <cb@256bit.org>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Eli Schwartz'" <eschwartz@gentoo.org>,
        "'Haelwenn \(lanodan\) Monnier'" <contact@hacktivis.me>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?utf-8?Q?'Matthias_A=C3=9Fhauer'?=" <mha1993@live.de>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'Sam James'" <sam@gentoo.org>,
        "'Collin Funk'" <collin.funk1@gmail.com>,
        "'Mike Hommey'" <mh@glandium.org>,
        "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
        "'Ben Knoble'" <ben.knoble@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Sat, 23 Aug 2025 09:43:29 -0400
Organization: Nexbridge Inc.
Message-ID: <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHKaANAdlFqcOHeZ+UNw9ZV5fNZlgJjoZaSAeK73o60cWSXAA==
X-Antivirus: Norton (VPS 250823-6, 8/23/2025), Outbound message
X-Antivirus-Status: Clean

On August 22, 2025 11:56 PM, Ezekiel Newren wrote:
>From: Ezekiel Newren <ezekielnewren@gmail.com>
>
>Upcoming patches will simplify xdiff, while also porting parts of it to =
Rust. In
>preparation, add some stubs and setup the Rust build. For now, it is =
easier to let
>cargo build rust and have make or meson merely link against the static =
library that
>cargo builds. In line with ongoing libification efforts, use multiple =
crates to allow
>more modularity on the Rust side. xdiff is the crate that this series =
will focus on, but
>we also introduce the interop crate for future patch series.
>
>In order to facilitate interoperability between C and Rust, introduce C =
definitions for
>Rust primitive types in git-compat-util.h.
>
>Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>---
> .gitignore              |  3 +++
> Makefile                | 53 ++++++++++++++++++++++++++++----------
> build_rust.sh           | 57 +++++++++++++++++++++++++++++++++++++++++
> git-compat-util.h       | 17 ++++++++++++
> meson.build             | 52 +++++++++++++++++++++++++++++++------
> rust/Cargo.toml         |  6 +++++
> rust/interop/Cargo.toml | 14 ++++++++++  rust/interop/src/lib.rs |  0
> rust/xdiff/Cargo.toml   | 15 +++++++++++
> rust/xdiff/src/lib.rs   |  0
> 10 files changed, 196 insertions(+), 21 deletions(-)  create mode =
100755
>build_rust.sh  create mode 100644 rust/Cargo.toml  create mode 100644
>rust/interop/Cargo.toml  create mode 100644 rust/interop/src/lib.rs  =
create mode
>100644 rust/xdiff/Cargo.toml  create mode 100644 rust/xdiff/src/lib.rs
>
>diff --git a/.gitignore b/.gitignore
>index 04c444404e4b..ff81e3580c4e 100644
>--- a/.gitignore
>+++ b/.gitignore
>@@ -254,3 +254,6 @@ Release/
> /contrib/buildsystems/out
> /contrib/libgit-rs/target
> /contrib/libgit-sys/target
>+/.idea/
>+/rust/target/
>+/rust/Cargo.lock
>diff --git a/Makefile b/Makefile
>index 70d1543b6b86..1ec0c1ee6603 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -919,6 +919,29 @@ TEST_SHELL_PATH =3D $(SHELL_PATH)
>
> LIB_FILE =3D libgit.a
> XDIFF_LIB =3D xdiff/lib.a
>+
>+EXTLIBS =3D
>+
>+ifeq ($(DEBUG), 1)
>+  RUST_BUILD_MODE =3D debug
>+else
>+  RUST_BUILD_MODE =3D release
>+endif
>+
>+RUST_TARGET_DIR =3D rust/target/$(RUST_BUILD_MODE) RUST_FLAGS_FOR_C =
=3D
>+-L$(RUST_TARGET_DIR)
>+
>+.PHONY: compile_rust
>+compile_rust:
>+	./build_rust.sh . $(RUST_BUILD_MODE) xdiff
>+
>+EXTLIBS +=3D ./$(RUST_TARGET_DIR)/libxdiff.a
>+
>+UNAME_S :=3D $(shell uname -s)
>+ifeq ($(UNAME_S),Linux)
>+  EXTLIBS +=3D -ldl
>+endif
>+
> REFTABLE_LIB =3D reftable/libreftable.a
>
> GENERATED_H +=3D command-list.h
>@@ -1390,7 +1413,7 @@ UNIT_TEST_OBJS +=3D =
$(UNIT_TEST_DIR)/lib-reftable.o
>
> # xdiff and reftable libs may in turn depend on what is in libgit.a  =
GITLIBS =3D
>common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE) =
-EXTLIBS =3D
>+
>
> GIT_USER_AGENT =3D git/$(GIT_VERSION)
>
>@@ -2541,7 +2564,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS =3D \
> 	'-DGIT_MAN_PATH=3D"$(mandir_relative_SQ)"' \
> 	'-DGIT_INFO_PATH=3D"$(infodir_relative_SQ)"'
>
>-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS) compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> 		$(filter %.o,$^) $(LIBS)
>
>@@ -2891,17 +2914,17 @@ headless-git.o: compat/win32/headless.c GIT-
>CFLAGS
> headless-git$X: headless-git.o git.res GIT-LDFLAGS
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -mwindows -o $@
>$< git.res
>
>-git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
>+git-%$X: %.o GIT-LDFLAGS $(GITLIBS) compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
>%.o,$^) $(LIBS)
>
>-git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS
>$(GITLIBS)
>+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS
>+$(GITLIBS) compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
>%.o,$^) \
> 		$(IMAP_SEND_LDFLAGS) $(LIBS)
>
>-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS =
$(GITLIBS)
>+git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS
>+$(GITLIBS) compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
>%.o,$^) \
> 		$(CURL_LIBCURL) $(LIBS)
>-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
>+git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS) =
compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
>%.o,$^) \
> 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>
>@@ -2911,11 +2934,11 @@ $(REMOTE_CURL_ALIASES):
>$(REMOTE_CURL_PRIMARY)
> 	ln -s $< $@ 2>/dev/null || \
> 	cp $< $@
>
>-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS
>$(GITLIBS)
>+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS
>+$(GITLIBS) compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
>%.o,$^) \
> 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>
>-scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
>+scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS) compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> 		$(filter %.o,$^) $(LIBS)
>
>@@ -2925,6 +2948,7 @@ $(LIB_FILE): $(LIB_OBJS)
> $(XDIFF_LIB): $(XDIFF_OBJS)
> 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
>+
> $(REFTABLE_LIB): $(REFTABLE_OBJS)
> 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
>@@ -3294,7 +3318,7 @@ perf: all
>
> t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
>$(UNIT_TEST_DIR)/test-lib.o
>
>-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
>+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
>+compile_rust
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
>%.o,$^) $(filter %.a,$^) $(LIBS)
>
> check-sha1:: t/helper/test-tool$X
>@@ -3756,7 +3780,10 @@ cocciclean:
> 	$(RM) -r .build/contrib/coccinelle
> 	$(RM) contrib/coccinelle/*.cocci.patch
>
>-clean: profile-clean coverage-clean cocciclean
>+rustclean:
>+	cd rust && cargo clean
>+
>+clean: profile-clean coverage-clean cocciclean rustclean
> 	$(RM) -r .build $(UNIT_TEST_BIN)
> 	$(RM) GIT-TEST-SUITES
> 	$(RM) po/git.pot po/git-core.pot
>@@ -3911,13 +3938,13 @@ FUZZ_CXXFLAGS ?=3D $(ALL_CFLAGS)
> .PHONY: fuzz-all
> fuzz-all: $(FUZZ_PROGRAMS)
>
>-$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-
>LDFLAGS
>+$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS)
>+GIT-LDFLAGS compile_rust
> 	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
> 		-Wl,--allow-multiple-definition \
> 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
>
> $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o
>$(UNIT_TEST_OBJS) \
>-	$(GITLIBS) GIT-LDFLAGS
>+	$(GITLIBS) GIT-LDFLAGS compile_rust
> 	$(call mkdir_p_parent_template)
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) @@ -3936,7 +3963,7 @@
>$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
>$(UNIT_TEST_DIR)/gene
> $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
> $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
> $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS =3D -I$(UNIT_TEST_DIR)
>-$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) =
$(GITLIBS)
>GIT-LDFLAGS
>+$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS)
>+$(GITLIBS) GIT-LDFLAGS compile_rust
> 	$(call mkdir_p_parent_template)
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter
>%.o,$^) $(LIBS)
>
>diff --git a/build_rust.sh b/build_rust.sh new file mode 100755 index
>000000000000..192385a1d961
>--- /dev/null
>+++ b/build_rust.sh
>@@ -0,0 +1,57 @@
>+#!/bin/sh
>+
>+
>+rustc -vV || exit $?
>+cargo --version || exit $?
>+
>+dir_git_root=3D${0%/*}
>+dir_build=3D$1
>+rust_build_profile=3D$2
>+crate=3D$3
>+
>+dir_rust=3D$dir_git_root/rust
>+
>+if [ "$dir_git_root" =3D "" ]; then
>+  echo "did not specify the directory for the root of git"
>+  exit 1
>+fi
>+
>+if [ "$dir_build" =3D "" ]; then
>+  echo "did not specify the build directory"
>+  exit 1
>+fi
>+
>+if [ "$rust_build_profile" =3D "" ]; then
>+  echo "did not specify the rust_build_profile"
>+  exit 1
>+fi
>+
>+if [ "$rust_build_profile" =3D "release" ]; then
>+  rust_args=3D"--release"
>+  export RUSTFLAGS=3D''
>+elif [ "$rust_build_profile" =3D "debug" ]; then
>+  rust_args=3D""
>+  export RUSTFLAGS=3D'-C debuginfo=3D2 -C opt-level=3D1 -C =
force-frame-pointers=3Dyes'
>+else
>+  echo "illegal rust_build_profile value $rust_build_profile"
>+  exit 1
>+fi
>+
>+cd $dir_rust && cargo clean && pwd && cargo build -p $crate =
$rust_args;
>+cd $dir_git_root
>+
>+libfile=3D"lib${crate}.a"
>+if rustup show active-toolchain | grep windows-msvc; then
>+  libfile=3D"${crate}.lib"
>+fi
>+dst=3D$dir_build/$libfile
>+
>+if [ "$dir_git_root" !=3D "$dir_build" ]; then
>+  src=3D$dir_rust/target/$rust_build_profile/$libfile
>+  if [ ! -f $src ]; then
>+    echo >&2 "::error:: cannot find path of static library $src is not =
a file or does not
>exist"
>+    exit 5
>+  fi
>+
>+  rm $dst 2>/dev/null
>+  mv $src $dst
>+fi
>diff --git a/git-compat-util.h b/git-compat-util.h index
>4678e21c4cb8..82dc99764ac0 100644
>--- a/git-compat-util.h
>+++ b/git-compat-util.h
>@@ -196,6 +196,23 @@ static inline int is_xplatform_dir_sep(int c)  =
#include
>"compat/msvc.h"
> #endif
>
>+/* rust types */
>+typedef uint8_t   u8;
>+typedef uint16_t  u16;
>+typedef uint32_t  u32;
>+typedef uint64_t  u64;
>+
>+typedef int8_t    i8;
>+typedef int16_t   i16;
>+typedef int32_t   i32;
>+typedef int64_t   i64;
>+
>+typedef float     f32;
>+typedef double    f64;
>+
>+typedef size_t    usize;
>+typedef ptrdiff_t isize;
>+
> /* used on Mac OS X */
> #ifdef PRECOMPOSE_UNICODE
> #include "compat/precompose_utf8.h"
>diff --git a/meson.build b/meson.build
>index 596f5ac7110e..324f968338b9 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -267,6 +267,40 @@ version_gen_environment.set('GIT_DATE',
>get_option('build_date'))  =
version_gen_environment.set('GIT_USER_AGENT',
>get_option('user_agent'))  version_gen_environment.set('GIT_VERSION',
>get_option('version'))
>
>+if get_option('optimization') in ['2', '3', 's', 'z']
>+  rust_build_profile =3D 'release'
>+else
>+  rust_build_profile =3D 'debug'
>+endif
>+
>+# Run `rustup show active-toolchain` and capture output rustup_out =3D
>+run_command('rustup', 'show', 'active-toolchain',
>+                         check: true).stdout().strip()
>+
>+rust_crates =3D ['xdiff']
>+rust_builds =3D []
>+
>+foreach crate : rust_crates
>+  if rustup_out.contains('windows-msvc')
>+    libfile =3D crate + '.lib'
>+  else
>+    libfile =3D 'lib' + crate + '.a'
>+  endif
>+
>+  rust_builds +=3D custom_target(
>+    'rust_build_'+crate,
>+    output: libfile,
>+    build_by_default: true,
>+    build_always_stale: true,
>+    command: [
>+      meson.project_source_root() / 'build_rust.sh',
>+      meson.current_build_dir(), rust_build_profile, crate,
>+    ],
>+    install: false,
>+  )
>+endforeach
>+
>+
> compiler =3D meson.get_compiler('c')
>
> libgit_sources =3D [
>@@ -1678,14 +1712,16 @@ version_def_h =3D custom_target(  =
libgit_sources +=3D
>version_def_h
>
> libgit =3D declare_dependency(
>-  link_with: static_library('git',
>-    sources: libgit_sources,
>-    c_args: libgit_c_args + [
>-      '-DGIT_VERSION_H=3D"' + version_def_h.full_path() + '"',
>-    ],
>-    dependencies: libgit_dependencies,
>-    include_directories: libgit_include_directories,
>-  ),
>+  link_with: [
>+    static_library('git',
>+      sources: libgit_sources,
>+      c_args: libgit_c_args + [
>+        '-DGIT_VERSION_H=3D"' + version_def_h.full_path() + '"',
>+      ],
>+      dependencies: libgit_dependencies,
>+      include_directories: libgit_include_directories,
>+    ),
>+  ] + rust_builds,
>   compile_args: libgit_c_args,
>   dependencies: libgit_dependencies,
>   include_directories: libgit_include_directories, diff --git =
a/rust/Cargo.toml
>b/rust/Cargo.toml new file mode 100644 index 000000000000..ed3d79d7f827
>--- /dev/null
>+++ b/rust/Cargo.toml
>@@ -0,0 +1,6 @@
>+[workspace]
>+members =3D [
>+    "xdiff",
>+    "interop",
>+]
>+resolver =3D "2"
>diff --git a/rust/interop/Cargo.toml b/rust/interop/Cargo.toml new file =
mode
>100644 index 000000000000..045e3b01cfad
>--- /dev/null
>+++ b/rust/interop/Cargo.toml
>@@ -0,0 +1,14 @@
>+[package]
>+name =3D "interop"
>+version =3D "0.1.0"
>+edition =3D "2021"
>+
>+[lib]
>+name =3D "interop"
>+path =3D "src/lib.rs"
>+## staticlib to generate xdiff.a for use by gcc ## cdylib (optional) =
to
>+generate xdiff.so for use by gcc ## rlib is required by the rust unit
>+tests crate-type =3D ["staticlib", "rlib"]
>+
>+[dependencies]
>diff --git a/rust/interop/src/lib.rs b/rust/interop/src/lib.rs new file =
mode 100644
>index 000000000000..e69de29bb2d1 diff --git a/rust/xdiff/Cargo.toml
>b/rust/xdiff/Cargo.toml new file mode 100644 index
>000000000000..eb7966aada64
>--- /dev/null
>+++ b/rust/xdiff/Cargo.toml
>@@ -0,0 +1,15 @@
>+[package]
>+name =3D "xdiff"
>+version =3D "0.1.0"
>+edition =3D "2021"
>+
>+[lib]
>+name =3D "xdiff"
>+path =3D "src/lib.rs"
>+## staticlib to generate xdiff.a for use by gcc ## cdylib (optional) =
to
>+generate xdiff.so for use by gcc ## rlib is required by the rust unit
>+tests crate-type =3D ["staticlib", "rlib"]
>+
>+[dependencies]
>+interop =3D { path =3D "../interop" }
>diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs new file =
mode 100644 index
>000000000000..e69de29bb2d1

Does this introduce Rust as a mandatory dependency for git? If so, it =
cuts out
numerous platforms.

