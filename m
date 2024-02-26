Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1F130AC0
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708990103; cv=none; b=IKVLpnuxWut2YwT/vcgytiTqci2eUke0YEGoSIzC2qZwwyljkTF6XJoGBcvzruw1NmIbSJfAyg6MOxsbsIjAJ0wQpnGITg87cp9UrDEibxvoqCprP/QxsDzrtqwWwrc8Iqef5y+U6fVnfSBzbe9Di7W1h1yd8SO29f03HZOCHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708990103; c=relaxed/simple;
	bh=XnyHr7mWWxMNRK8G4SvS1jcPpkufx+u9DmBx12beNtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A6KVMm/uO6o26jr3ysq9PedN1o9ARKM7nOlmxCN7GIPbKUX4VYbE/Mz5TLpnqTwG+iVhC1MYKmGv6Jq+ceiJEHFN6jqf9Y+a3Z2EhpIxGP4q06MhX+9bKExeoDVK5O8MQdVRpEgjEgdIGscYrQisrXjmsiR4GQLdJDGqD4X4Ygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xV/E/nlT; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xV/E/nlT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0059A20490;
	Mon, 26 Feb 2024 18:28:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XnyHr7mWWxMNRK8G4SvS1jcPpkufx+u9DmBx12
	beNtk=; b=xV/E/nlT3xEdKadDf8Z4OXol5gMQgVC9p+SbxWTBDdPp15ZwCOBx33
	lCBCUDq00ryiAHEl/thRNnKOTgTVmzDVKPfAyifTY1tTse4eDmzffHmvTIjNgyxg
	Zt2BYPvrv23KdQe/3g9k3nQwZA7RH4XTV3bnJ8BHxfTmY/1spBfQ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EB1A32048F;
	Mon, 26 Feb 2024 18:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5523B2048E;
	Mon, 26 Feb 2024 18:28:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,  Calvin Wan
 <calvinwan@google.com>,  Jonathan Tan <jonathantanmy@google.com>,  Elijah
 Newren <newren@gmail.com>
Subject: [PATCH v3] doc: clarify the wording on <git-compat-util.h> requirement
In-Reply-To: <xmqqh6hxlcae.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	24 Feb 2024 14:36:57 -0800")
References: <xmqq4jdxmx2e.fsf@gitster.g> <xmqqh6hxlcae.fsf@gitster.g>
Date: Mon, 26 Feb 2024 15:28:16 -0800
Message-ID: <xmqqle76kdpr.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B8E1ECFA-D4FE-11EE-B52F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

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

 * Updated the leading phrase introducing the list of exceptions.
   I think this is now clear enough to be ready for 'next'?

Range-diff:
1:  2e7082d2d2 ! 1:  470f33a078 doc: clarify the wording on <git-compat-util.h> requirement
    @@ Documentation/CodingGuidelines: For C programs:
     -   "t/helper/test-tool.h", "xdiff/xinclude.h", or
     -   "reftable/system.h".)  You do not have to include more than one of
     -   these.
    -+   implementations and sha1dc/, must be "git-compat-util.h".  This
    ++   implementations and sha1dc/, must be <git-compat-util.h>.  This
     +   header file insulates other header files and source files from
     +   platform differences, like which system header files must be
     +   included in what order, and what C preprocessor feature macros must
     +   be defined to trigger certain features we expect out of the system.
    ++   A collorary to this is that C files should not directly include
    ++   system header files themselves.
     +
    -+   In addition:
    ++   There are some exceptions, because certain group of files that
    ++   implement an API all have to include the same header file that
    ++   defines the API and it is convenient to include <git-compat-util.h>
    ++   there.  Namely:
     +
     +   - the implementation of the built-in commands in the "builtin/"
     +     directory that include "builtin.h" for the cmd_foo() prototype
    -+     definition
    ++     definition,
     +
     +   - the test helper programs in the "t/helper/" directory that include
    -+     "t/helper/test-tool.h" for the cmd__foo() prototype definition
    ++     "t/helper/test-tool.h" for the cmd__foo() prototype definition,
     +
     +   - the xdiff implementation in the "xdiff/" directory that includes
    -+     "xdiff/xinclude.h" for the xdiff machinery internals
    ++     "xdiff/xinclude.h" for the xdiff machinery internals,
     +
     +   - the unit test programs in "t/unit-tests/" directory that include
     +     "t/unit-tests/test-lib.h" that gives them the unit-tests
    -+     framework
    ++     framework, and
     +
     +   - the source files that implement reftable in the "reftable/"
     +     directory that include "reftable/system.h" for the reftable
    -+     internals
    ++     internals,
     +
     +   are allowed to assume that they do not have to include
    -+   "git-compat-util.h" themselves, as it is included as the first
    ++   <git-compat-util.h> themselves, as it is included as the first
     +   '#include' in these header files.  These headers must be the first
     +   header file to be "#include"d in them, though.
      

 Documentation/CodingGuidelines | 41 +++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 578587a471..806979f75b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -446,12 +446,41 @@ For C programs:
    detail.
 
  - The first #include in C files, except in platform specific compat/
-   implementations and sha1dc/, must be either "git-compat-util.h" or
-   one of the approved headers that includes it first for you.  (The
-   approved headers currently include "builtin.h",
-   "t/helper/test-tool.h", "xdiff/xinclude.h", or
-   "reftable/system.h".)  You do not have to include more than one of
-   these.
+   implementations and sha1dc/, must be <git-compat-util.h>.  This
+   header file insulates other header files and source files from
+   platform differences, like which system header files must be
+   included in what order, and what C preprocessor feature macros must
+   be defined to trigger certain features we expect out of the system.
+   A collorary to this is that C files should not directly include
+   system header files themselves.
+
+   There are some exceptions, because certain group of files that
+   implement an API all have to include the same header file that
+   defines the API and it is convenient to include <git-compat-util.h>
+   there.  Namely:
+
+   - the implementation of the built-in commands in the "builtin/"
+     directory that include "builtin.h" for the cmd_foo() prototype
+     definition,
+
+   - the test helper programs in the "t/helper/" directory that include
+     "t/helper/test-tool.h" for the cmd__foo() prototype definition,
+
+   - the xdiff implementation in the "xdiff/" directory that includes
+     "xdiff/xinclude.h" for the xdiff machinery internals,
+
+   - the unit test programs in "t/unit-tests/" directory that include
+     "t/unit-tests/test-lib.h" that gives them the unit-tests
+     framework, and
+
+   - the source files that implement reftable in the "reftable/"
+     directory that include "reftable/system.h" for the reftable
+     internals,
+
+   are allowed to assume that they do not have to include
+   <git-compat-util.h> themselves, as it is included as the first
+   '#include' in these header files.  These headers must be the first
+   header file to be "#include"d in them, though.
 
  - A C file must directly include the header files that declare the
    functions and the types it uses, except for the functions and types
-- 
2.44.0

