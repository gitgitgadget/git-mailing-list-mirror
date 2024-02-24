Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA74DA09
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814221; cv=none; b=L8bYCogQGwjEs3hBaUKGjh5Sn6nbLt2riywxHa1S4SzIHDZWQWRpRtWuc2p7Ctz7ytNbgWNEvCAgrOodm9yB2iUzVzOOVRon+YOuYOK45Aeu8t2cIkYggfNC2qLJz+2HosT5eysDE8ydWy9TEhAhUgxxH7gnSTsKQE263dDWJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814221; c=relaxed/simple;
	bh=/81bYJCenHzgMaEu5XDYuan3+gGdhDCs6+uRMp/Nlfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mA/l6/lxT+b6OjQa1k83yGfBW2vnbV7RGVPjp6erSvp75sMmMxZ6ia5CpRP7gVLJboYc46QRj5PvW/yMI4O6cwC8ugp6tfNlALn7eJyjhooq3L8To3hX6iS/h6pbuLn2K73bA8bIsDJz2Ex8olZaKHYD6dOp8fZ3SzZFybCqFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ccyi9Bks; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ccyi9Bks"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA8521E9AA6;
	Sat, 24 Feb 2024 17:36:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/81bYJCenHzgMaEu5XDYuan3+gGdhDCs6+uRMp
	/Nlfc=; b=ccyi9Bks2Qs6BguyfhfmxGBDG1LldGxv+GvsYGXlEdTizAy5U9gRvy
	90TzMu8wySCJeTRui265aCUu/T6VEEvO6QIEomZHpcJp2r9g44llqCLpWFvBTVE/
	YIiMrG++BHbOKBnQbsxBhEtSWBSaeHii1gRmowUkeXrRo6IzUZ+qE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C25A91E9AA5;
	Sat, 24 Feb 2024 17:36:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E5211E9AA4;
	Sat, 24 Feb 2024 17:36:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,  Calvin Wan
 <calvinwan@google.com>,  Jonathan Tan <jonathantanmy@google.com>,  Elijah
 Newren <newren@gmail.com>
Subject: [PATCH v2] doc: clarify the wording on <git-compat-util.h> requirement
In-Reply-To: <xmqq4jdxmx2e.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	24 Feb 2024 12:22:49 -0800")
References: <xmqq4jdxmx2e.fsf@gitster.g>
Date: Sat, 24 Feb 2024 14:36:57 -0800
Message-ID: <xmqqh6hxlcae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38235A30-D365-11EE-8D5B-25B3960A682E-77302942!pb-smtp2.pobox.com

The reason why we require the <git-compat-util.h> file to be the
first header file to be included is because it insulates other
header files and source files from platform differences, like which
system header files must be included in what order, and what C
preprocessor feature macros must be defined to trigger certain
features we want out of the system.

We tried to clarify the rule in the coding guidelines document, but
the wording was a bit fuzzy that can lead to misinterpretations like
you can include <xdiff/xinclude.h> only to avoid having to include
<git-compat-util.h> even if you have nothing to do with the xdiff
implementation, for example.  "You do not have to include more than
one of these" was also misleading and would have been puzzling if
you _needed_ to depend on more than one of these approved headers
(answer: you are allowed to include them all if you need the
declarations in them for reasons other than that you want to avoid
including compat-util yourself).

Instead of using the phrase "approved headers", enumerate them as
exceptions, each labeled with its intended audiences, to avoid such
misinterpretations.  The structure also makes it easier to add new
exceptions, so add the description of "t/unit-tests/test-lib.h"
being an exception only for the unit tests implementation as an
example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The most notable change since the first one is that the reason
   why the requirement exists is added to the document, not just
   telling them what to do but also telling them why.

   Also the path to "test-lib.h" used in the unit-test framework has
   been spelled out relative to the root of the working tree, like
   all other header files.

Range-diff:
1:  dde3a79470 ! 1:  b9f3d36e9a doc: clarify the wording on <git-compat-util.h> requirement
    @@ Metadata
      ## Commit message ##
         doc: clarify the wording on <git-compat-util.h> requirement
     
    -    The reason why we insist including the compat-util header as the
    -    very first thing is because it is our mechanism to absorb the
    -    differences across platforms, like the order in which system header
    -    files must be included, and C preprocessor feature macros that are
    -    needed to trigger certain features we want out of the systems, and
    -    insulate other headers and sources from such minutiae.
    +    The reason why we require the <git-compat-util.h> file to be the
    +    first header file to be included is because it insulates other
    +    header files and source files from platform differences, like which
    +    system header files must be included in what order, and what C
    +    preprocessor feature macros must be defined to trigger certain
    +    features we want out of the system.
     
    -    Earlier we tried to clarify the rule in the coding guidelines
    -    document, but the wording was a bit fuzzy that can lead to
    -    misinterpretations like you can include xdiff/xinclude.h only to
    -    avoid having to include git-compat-util.h file even if you have
    -    nothing to do with xdiff implementation, for example.  "You do not
    -    have to include more than one of these" were also misleading and
    -    would have been puzzling if you _needed_ to depend on more than one
    -    of these approved headers (answer: you are allowed to include them
    -    all if you need the declarations in them for reasons other than that
    -    you want to avoid including compat-util yourself).
    +    We tried to clarify the rule in the coding guidelines document, but
    +    the wording was a bit fuzzy that can lead to misinterpretations like
    +    you can include <xdiff/xinclude.h> only to avoid having to include
    +    <git-compat-util.h> even if you have nothing to do with the xdiff
    +    implementation, for example.  "You do not have to include more than
    +    one of these" was also misleading and would have been puzzling if
    +    you _needed_ to depend on more than one of these approved headers
    +    (answer: you are allowed to include them all if you need the
    +    declarations in them for reasons other than that you want to avoid
    +    including compat-util yourself).
     
         Instead of using the phrase "approved headers", enumerate them as
    -    exceptions, each labeled with intended audiences, to avoid such
    +    exceptions, each labeled with its intended audiences, to avoid such
         misinterpretations.  The structure also makes it easier to add new
         exceptions, so add the description of "t/unit-tests/test-lib.h"
         being an exception only for the unit tests implementation as an
    @@ Documentation/CodingGuidelines: For C programs:
     -   "t/helper/test-tool.h", "xdiff/xinclude.h", or
     -   "reftable/system.h".)  You do not have to include more than one of
     -   these.
    -+   implementations and sha1dc/, must be "git-compat-util.h".  In
    -+   addition:
    ++   implementations and sha1dc/, must be "git-compat-util.h".  This
    ++   header file insulates other header files and source files from
    ++   platform differences, like which system header files must be
    ++   included in what order, and what C preprocessor feature macros must
    ++   be defined to trigger certain features we expect out of the system.
    ++
    ++   In addition:
     +
     +   - the implementation of the built-in commands in the "builtin/"
     +     directory that include "builtin.h" for the cmd_foo() prototype
    @@ Documentation/CodingGuidelines: For C programs:
     +     "xdiff/xinclude.h" for the xdiff machinery internals
     +
     +   - the unit test programs in "t/unit-tests/" directory that include
    -+     "test-lib.h" that gives them the unit-tests framework
    ++     "t/unit-tests/test-lib.h" that gives them the unit-tests
    ++     framework
     +
     +   - the source files that implement reftable in the "reftable/"
     +     directory that include "reftable/system.h" for the reftable
     +     internals
     +
    -+   are allowed to assume that their header file includes
    -+   "git-compat-util.h", and they do not have to include
    -+   "git-compat-util.h" themselves.  These headers must be the first
    ++   are allowed to assume that they do not have to include
    ++   "git-compat-util.h" themselves, as it is included as the first
    ++   '#include' in these header files.  These headers must be the first
     +   header file to be "#include"d in them, though.
      
       - A C file must directly include the header files that declare the

 Documentation/CodingGuidelines | 36 ++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 578587a471..291b2898a2 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -446,12 +446,36 @@ For C programs:
    detail.
 
  - The first #include in C files, except in platform specific compat/
-   implementations and sha1dc/, must be either "git-compat-util.h" or
-   one of the approved headers that includes it first for you.  (The
-   approved headers currently include "builtin.h",
-   "t/helper/test-tool.h", "xdiff/xinclude.h", or
-   "reftable/system.h".)  You do not have to include more than one of
-   these.
+   implementations and sha1dc/, must be "git-compat-util.h".  This
+   header file insulates other header files and source files from
+   platform differences, like which system header files must be
+   included in what order, and what C preprocessor feature macros must
+   be defined to trigger certain features we expect out of the system.
+
+   In addition:
+
+   - the implementation of the built-in commands in the "builtin/"
+     directory that include "builtin.h" for the cmd_foo() prototype
+     definition
+
+   - the test helper programs in the "t/helper/" directory that include
+     "t/helper/test-tool.h" for the cmd__foo() prototype definition
+
+   - the xdiff implementation in the "xdiff/" directory that includes
+     "xdiff/xinclude.h" for the xdiff machinery internals
+
+   - the unit test programs in "t/unit-tests/" directory that include
+     "t/unit-tests/test-lib.h" that gives them the unit-tests
+     framework
+
+   - the source files that implement reftable in the "reftable/"
+     directory that include "reftable/system.h" for the reftable
+     internals
+
+   are allowed to assume that they do not have to include
+   "git-compat-util.h" themselves, as it is included as the first
+   '#include' in these header files.  These headers must be the first
+   header file to be "#include"d in them, though.
 
  - A C file must directly include the header files that declare the
    functions and the types it uses, except for the functions and types
-- 
2.44.0

