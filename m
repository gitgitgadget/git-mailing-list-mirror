Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65542C433FE
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 11:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiBSLaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 06:30:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiBSLaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 06:30:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9C19FACE
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so18736604wrb.5
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIYUNSHQ98MNMZ393qWJIKOHxaLldNcx/UX56F5CkAo=;
        b=AuV75/hI48w/6pNmaa84EpYZ9bmJESaP3Pq/fgr3P81ScEcWDTdfRyBl/bMop23nKd
         KIn9baj5y0S0hlZ4SOwHbWdslVKD+ZwJoSj6PBN08agg8MKKy6BzQrxscbCv2113oVei
         YNlVvMVW7n08pkUeJE1qvkRXgNuUcNuSnHW9I1f1CfxDMW+iSqeRwehbG27fG/XbbPfS
         OKJVB/jEpRB9JMoPDwqt1kaU9gkwdipMH0MVIxYiQV9MAkY+AkeEOedFLtIj++kLnUrS
         G2sm0LNXf+xn8Te5s74xFBn753rJHLonHJXgZO9UyirHRPdG62gZgnfpRci7k2fssojW
         N4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIYUNSHQ98MNMZ393qWJIKOHxaLldNcx/UX56F5CkAo=;
        b=kDZE9OxtPXD2XQ8GL6GPuW7Npe0D6pFt79zLLAZnecYrljv4qJ/07vO8iIIneC3n9P
         O5jVsn/XZ6igy3Iz33TJIN38yKzVcSDzxXPBqm461HvrsfjgQG+M0McisTY11EM7DLcV
         kYHiJ+tpDDzE9Z1dpGaGE3Txjb5Rccb2JjChfkOwBI0Ls2Fik7rCoY25+ijfoTfKA8ID
         C6xJOwTXqMNVK4dECNwgpU7yVSX2gemJ0tYv74YCzcOiGONvLu0phjXQcLTJJDhT+unf
         QAATGrW2pI0+B/cZXLLzSAFg5ZhBWmy+WNlLkOUu9RsMG5jjv7BKV0kt+eg0ToLGon9g
         nmhg==
X-Gm-Message-State: AOAM5300qJq+T/tEhvCOaZqRRuOYScrBhFmHR8MEgNmqFn9qvP9SPmh2
        pQsg4q3jFL867Lsl9WBoHvrsujs8gssvug==
X-Google-Smtp-Source: ABdhPJzS7e3BwnOGEfyr6xrbfliEWkETePkEDXmQwNV7v4eT79rKwMO+nSAW+yyDx6buHBHhFTpusA==
X-Received: by 2002:a05:6000:1c5:b0:1e4:a915:9e5d with SMTP id t5-20020a05600001c500b001e4a9159e5dmr9026828wrx.106.1645270188217;
        Sat, 19 Feb 2022 03:29:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12sm29464695wrw.32.2022.02.19.03.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:29:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] test-lib: improve LSAN + ASAN stack traces
Date:   Sat, 19 Feb 2022 12:29:39 +0100
Message-Id: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1130.g7c6dd716f26
In-Reply-To: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A UX improvement for LSAN stack traces. See
https://lore.kernel.org/git/cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com/
for the v1.

I think this v2 should address all the comments on the v1, thanks
Taylor & Junio!

Changes:
 * Renamed XSAN_OPTIONS to GIT_XSAN_OPTIONS
 * The "prepend_var" now handles an empty $3, as suggested by Junio.
 * I added a new 2/4 updating the $TEST_DIRECTORY commentary to note
   that we depend on it pointing to *the* "t" directory.

Ævar Arnfjörð Bjarmason (4):
  test-lib: add GIT_XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
  test-lib: correct commentary on TEST_DIRECTORY overriding
  test-lib: make $GIT_BUILD_DIR an absolute path
  test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS

 t/test-lib.sh | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  75c8f7a719c ! 1:  01e63a72231 test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
    +    test-lib: add GIT_XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
     
         Change our ASAN_OPTIONS and LSAN_OPTIONS to set defaults for those
         variables, rather than punting out entirely if we already have them in
    @@ t/test-lib.sh: then
      GIT_BUILD_DIR="$TEST_DIRECTORY"/..
      
     +# Prepend a string to a VAR using an arbitrary ":" delimiter, not
    -+# adding the delimiter if VAR is empty. I.e. a generalized:
    ++# adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
     +#
    -+#	VAR=$1${VAR:+$VAR}
    ++#	VAR=$1${VAR:+${1:+$2}$VAR}
     +#
    -+# Usage (using ":" as a delimiter):
    ++# Usage (using ":" as the $2 delimiter):
     +#
    -+#	prepend_var VAR : $1
    ++#	prepend_var VAR : VALUE
     +prepend_var () {
    -+	eval "$1=$3\${$1:+$2\$$1}"
    ++	eval "$1=$3\${$1:+${3:+$2}\$$1}"
     +}
     +
    -+# If [AL]SAN is in effect we want to abort so that we notice problems.
    -+prepend_var XSAN_OPTIONS : abort_on_error=1
    ++# If [AL]SAN is in effect we want to abort so that we notice
    ++# problems. The GIT_XSAN_OPTIONS variable can be used to set common
    ++# defaults shared between [AL]SAN_OPTIONS.
    ++prepend_var GIT_XSAN_OPTIONS : abort_on_error=1
     +
      # If we were built with ASAN, it may complain about leaks
      # of program-lifetime variables. Disable it by default to lower
    @@ t/test-lib.sh: then
      # before we even do our "did we build git yet" check (since we don't
      # want that one to complain to stderr).
     -: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
    -+prepend_var ASAN_OPTIONS : $XSAN_OPTIONS
    ++prepend_var ASAN_OPTIONS : $GIT_XSAN_OPTIONS
     +prepend_var ASAN_OPTIONS : detect_leaks=0
      export ASAN_OPTIONS
      
     -# If LSAN is in effect we _do_ want leak checking, but we still
     -# want to abort so that we notice the problems.
     -: ${LSAN_OPTIONS=abort_on_error=1}
    -+prepend_var LSAN_OPTIONS : $XSAN_OPTIONS
    ++prepend_var LSAN_OPTIONS : $GIT_XSAN_OPTIONS
      export LSAN_OPTIONS
      
      if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-:  ----------- > 2:  0c2867e30dc test-lib: correct commentary on TEST_DIRECTORY overriding
2:  4c53c6157ac ! 3:  229654027b8 test-lib: make $GIT_BUILD_DIR an absolute path
    @@ Commit message
         "/path/to/build". The "TEST_DIRECTORY" here is already made an
         absolute path a few lines above this.
     
    -    This will be helpful to LSAN_OPTIONS which will want to strip the
    -    build directory path from filenames, which we couldn't do if we had a
    -    "/.." in there.
    +    We could simply do $(cd "$TEST_DIRECTORY"/.." && pwd) here, but as
    +    noted in the preceding commit the "$TEST_DIRECTORY" can't be anything
    +    except the path containing this test-lib.sh file at this point, so we
    +    can more cheaply and equally strip the "/t" off the end.
    +
    +    This change will be helpful to LSAN_OPTIONS which will want to strip
    +    the build directory path from filenames, which we couldn't do if we
    +    had a "/.." in there.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/test-lib.sh: then
     +GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
      
      # Prepend a string to a VAR using an arbitrary ":" delimiter, not
    - # adding the delimiter if VAR is empty. I.e. a generalized:
    + # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
    +@@ t/test-lib.sh: prepend_var () {
    + # problems. The GIT_XSAN_OPTIONS variable can be used to set common
    + # defaults shared between [AL]SAN_OPTIONS.
    + prepend_var GIT_XSAN_OPTIONS : abort_on_error=1
    ++prepend_var GIT_XSAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
    + 
    + # If we were built with ASAN, it may complain about leaks
    + # of program-lifetime variables. Disable it by default to lower
3:  ec852e6d691 < -:  ----------- test-lib: add "strip_path_prefix" to XSAN_OPTIONS
4:  2becf76a14a ! 4:  e6a48b6e4ce test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS
    @@ t/test-lib.sh
     @@ t/test-lib.sh: prepend_var ASAN_OPTIONS : detect_leaks=0
      export ASAN_OPTIONS
      
    - prepend_var LSAN_OPTIONS : $XSAN_OPTIONS
    + prepend_var LSAN_OPTIONS : $GIT_XSAN_OPTIONS
     +prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
      export LSAN_OPTIONS
      
-- 
2.35.1.1130.g7c6dd716f26

