From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Fri, 11 Mar 2011 14:45:58 -0800
Message-ID: <7vvczpff89.fsf@alter.siamese.dyndns.org>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
 <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 23:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyB69-0005ZL-DM
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 23:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab1CKWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 17:46:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab1CKWqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 17:46:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A62724C47;
	Fri, 11 Mar 2011 17:47:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8anv12trIj8ZDB+VJ5Pc2mHIQUU=; b=uqouwR
	uWciX4PVtu52FdjoF0jqXy+MZv81c+uiEQ4DxtoS3IVtlHihAggJvSpGLmnQ3LyJ
	GgVq/V6CJOZp0lLJ6p0eT2Ya2aZ0DAoHZHkYIXjYxEnd62tneYETBl8LKx+Jc0oe
	kFx5yoch9B7l/olHLI2ExXcBVhQYqhBHfZBO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HY/7eoT8MrlAIsmG9ZRV+RV2U/jBxeSm
	Yqbu4tAnyeAkLyTjGGenAmJYKHopZXkexTeujrL05pmH5uwo2JKoBLR/5lHcBtIi
	28nKQZC+lBLR0CCqRcwqiMFq2oQrQ9hIlln1n00fZj0054jz8YVcuKLSliYNtcuv
	jyUJQTro/20=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 746CD4C43;
	Fri, 11 Mar 2011 17:47:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E56E34C41; Fri, 11 Mar 2011
 17:47:29 -0500 (EST)
In-Reply-To: <7vipvq1hpw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 10 Mar 2011 19:03:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E3381BC-4C31-11E0-A302-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168931>

Junio C Hamano <gitster@pobox.com> writes:

> So let's scrap the abbrevguard thing.  I somehow thought that I already
> took your "make DEFAULT_ABBREV tweakable" patch, but apparently I didn't.
> That one is the real fix to the issue of futureproofing.

In return for a free education last night, I now owe you your patch from
October last year, resurrected from the list archive, and here it is.

With a forged sign-off from you, as I know that everything you write is
supposed to be open source.

 - I do not think making minimum configurable is worth it, but I left it in
   (there is no UI to tweak it anyway).

 - I somewhat tweaked "describe" and "describe --abbrev" implementation.
   OPT__ABBREV() uses DEFAULT_ABBREV in its callback, so we need to read
   from the configuration before calling parse_options().  As it won't
   make any sense to call "git describe" outside repository where you
   cannot get to your configuration, I think it is safe to add a call to
   git_config() in this codepath. Other users of OPT__ABBREV() may need to
   be audited.

By the way, I've already reverted the abbrevguard thing away.

-- >8 --
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Oct 2010 11:28:04 -0700
Subject: [PATCH] Make the default abbrev length configurable

The default of 7 comes from fairly early in git development, when
seven hex digits was a lot (it covers about 250+ million hash
values). Back then I thought that 65k revisions was a lot (it was what
we were about to hit in BK), and each revision tends to be about 5-10
new objects or so, so a million objects was a big number.

These days, the kernel isn't even the largest git project, and even
the kernel has about 220k revisions (_much_ bigger than the BK tree
ever was) and we are approaching two million objects. At that point,
seven hex digits is still unique for a lot of them, but when we're
talking about just two orders of magnitude difference between number
of objects and the hash size, there _will_ be collisions in truncated
hash values. It's no longer even close to unrealistic - it happens all
the time.

We should both increase the default abbrev that was unrealistically
small, _and_ add a way for people to set their own default per-project
in the git config file.

This is the first step to first make it configurable; the default of 7
is not raised yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    6 ++++++
 builtin/describe.c       |    6 +++++-
 cache.h                  |    5 +++--
 config.c                 |    8 ++++++++
 environment.c            |    1 +
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..30afde9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,12 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
 
+core.abbrevLength::
+	Set the length object names are abbreviated to.  If unspecified,
+	many commands abbreviate to 7 hexdigits, which may not be enough
+	for abbreviated object names to stay unique for sufficiently long
+	time.
+
 add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/builtin/describe.c b/builtin/describe.c
index 342129f..9591596 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -21,7 +21,7 @@ static int debug;	/* Display lots of verbose info */
 static int all;	/* Any valid ref can be used */
 static int tags;	/* Allow lightweight tags */
 static int longformat;
-static int abbrev = DEFAULT_ABBREV;
+static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
 static struct hash_table names;
 static int have_util;
@@ -420,7 +420,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
+	if (abbrev < 0)
+		abbrev = DEFAULT_ABBREV;
+
 	if (max_candidates < 0)
 		max_candidates = 0;
 	else if (max_candidates > MAX_TAGS)
diff --git a/cache.h b/cache.h
index d83d68c..8d73d88 100644
--- a/cache.h
+++ b/cache.h
@@ -540,6 +540,7 @@ extern int trust_executable_bit;
 extern int trust_ctime;
 extern int quote_path_fully;
 extern int has_symlinks;
+extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
@@ -758,8 +759,8 @@ static inline unsigned int hexval(unsigned char c)
 }
 
 /* Convert to/from hex/sha1 representation */
-#define MINIMUM_ABBREV 4
-#define DEFAULT_ABBREV 7
+#define MINIMUM_ABBREV minimum_abbrev
+#define DEFAULT_ABBREV default_abbrev
 
 struct object_context {
 	unsigned char tree[20];
diff --git a/config.c b/config.c
index 625e051..e8a6e56 100644
--- a/config.c
+++ b/config.c
@@ -531,6 +531,14 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.abbrevlength")) {
+		int abbrev = git_config_int(var, value);
+		if (abbrev < minimum_abbrev || abbrev > 40)
+			return -1;
+		default_abbrev = abbrev;
+		return 0;
+	}
+
 	if (!strcmp(var, "core.loosecompression")) {
 		int level = git_config_int(var, value);
 		if (level == -1)
diff --git a/environment.c b/environment.c
index 9564475..f2d90a8 100644
--- a/environment.c
+++ b/environment.c
@@ -15,6 +15,7 @@ int user_ident_explicitly_given;
 int trust_executable_bit = 1;
 int trust_ctime = 1;
 int has_symlinks = 1;
+int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
-- 
1.7.4.1.404.g62d316
