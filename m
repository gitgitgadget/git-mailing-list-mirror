Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF0C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 12:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiDENAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiDEMdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 08:33:51 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AFA8CD8F
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 04:46:21 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=EsAtwbdd8AUZxHYvM4rzuge8a2zgF0Nx0KevaK1P3AQ8icjuU3DPLcTu0YX9tnxDbxtBwCtSI7xLtYOR4sJiFejXn120X3zD0b721yVqcjcGWmVIBO753CBAJGC/TnjszMdyEQHNWIP6X2N1TOC2pzWn2WPOhB9WH0Z7+C2P3MDNjlBxvJ6ykW6C0i5TishYIyJKLA9tN536+5rlud8vt8mat4mw/VNier5JmiFb9sGTkdnV2KQmGZ08qV2a59aQ/K68N9awx8uw7aGoSmsfii7I5H2rhsDdd1HoOlo0M5P+EG48fopd+m3miBWT/DIQWviy4wyR8FL5yQ9ASESI1A==; s=purelymail1; d=slashdev.space; v=1; bh=FwEUmAjT/+EnsRAKAjZBB/GOjoyBrMcsIjptlB7dqR0=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=bJFNCwTT0yqcqCzVQplhBmBWAgMmh4VVPHIpntPprO82/Wi2AuN84OEuJziwEQCrimmNjUK8Ln36nlu6Yje54c3evf/WZ4947K/XjsaQCC560NQIO/mak6agvsgOu6f787GjeQI7Cbz1idyUInsey8PP2jJo0Q1eZqRTxJ2aujixbfIGo7VS/WShZju1ovvLuU8kEwk2vTMsAJgrw0ssbY3cUY/98436A8J7m/J+0Q4sptKCcIOb25UWyb+gNmN/Pd9f78lmH/PkdPF6zgzCSBaPtCc4Djg7o1UetXLZSD3nOi/jHJmxCp6YUGn7ifR4W8fEdJ6xdAZzAOqgCMDTVA==; s=purelymail1; d=purelymail.com; v=1; bh=FwEUmAjT/+EnsRAKAjZBB/GOjoyBrMcsIjptlB7dqR0=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 981976735;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Tue, 05 Apr 2022 11:46:14 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     avarab@gmail.com
Cc:     garrit@slashdev.space, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v2 1/4] contrib: add iwyu script
Date:   Tue,  5 Apr 2022 13:45:04 +0200
Message-Id: <20220405114505.24389-2-garrit@slashdev.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331194436.58005-1-garrit@slashdev.space>
References: <20220331194436.58005-1-garrit@slashdev.space>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=ANSI_X3.4-1968
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

add include-what-you-use helper.

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---
 contrib/iwyu/README  | 33 +++++++++++++++++++++++++++++++++
 contrib/iwyu/iwyu.sh |  2 ++
 2 files changed, 35 insertions(+)
 create mode 100644 contrib/iwyu/README
 create mode 100755 contrib/iwyu/iwyu.sh

diff --git a/contrib/iwyu/README b/contrib/iwyu/README
new file mode 100644
index 0000000000..5e2d218602
--- /dev/null
+++ b/contrib/iwyu/README
@@ -0,0 +1,33 @@
+Include What You Use
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Include what you use (iwyu) [1] is a tool that points out which headers a =
file
+should include. Moreover, it can point out includes that are not used by a=
 file,
+which makes it especially handy for cleanup tasks.
+
+To run this script, you will need iwyu to be installed on your system.
+
+The "iwyu.sh" script runs iwyu on a given object and omits mandatory heade=
rs
+defined in "Documentation/CodingGuidelines".
+
+Example usage:
+
+    ./contrib/iwyu/iwyu.sh diff.o
+
+This yields:
+
+    diff.c should remove these lines:
+    - #include "attr.h"  // lines 13-13
+    - #include "submodule-config.h"  // lines 18-18
+
+In its current form, this script should not be used to auto-generate patch=
es,
+since there are still some false-positives that only a human can resolve. =
It is
+meant as a starting point for further cleanups. It could be nice to integr=
ate
+this as a step in our CI, but we're not quite there yet.
+
+The inspiration for this script came from this [2] email-thread.
+
+Garrit Franke <garrit@slashdev.space>
+
+[1]: https://github.com/include-what-you-use/include-what-you-use
+[2]: https://lore.kernel.org/all/220401.8635ixp3f4.gmgdl@evledraar.gmail.c=
om/#t
\ No newline at end of file
diff --git a/contrib/iwyu/iwyu.sh b/contrib/iwyu/iwyu.sh
new file mode 100755
index 0000000000..3ef8639eae
--- /dev/null
+++ b/contrib/iwyu/iwyu.sh
@@ -0,0 +1,2 @@
+make $1 CC=3Dinclude-what-you-use CFLAGS=3D"-Xiwyu --verbose=3D1" 2>&1 \
+| grep -v -E -e '^#include <' -e '^#include "(cache|git-compat-util|gettex=
t)\.h"'=20
\ No newline at end of file
--=20
2.35.1

