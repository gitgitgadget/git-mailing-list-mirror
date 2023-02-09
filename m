Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F937C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 11:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBIL6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjBIL4v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 06:56:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D393F4
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 03:47:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so5542258ejc.4
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mosOiiK2+bkiRh9snSMkD1HwPYWuaNIikJhdo1Enayk=;
        b=igFOXBeq4r5UV41Cl+VGa2owdr971tmoiUl2XOcip8UvwZM98vUx/j7HsArN0F+uYV
         JwUPMo4D2Ydj94dVq9tNFJnSvJo3kJX378n1Y02S7KfRhdJ3RAZUD8gePkiAxqDNhrsv
         oLYxJZQ8DD3OyXQXA6y/K8OZnLN4US2557a/9X/9V5eOLcVCoWA6WvxM/B+z5fLomKGV
         ccvQ1dnRtFuWuXE0Q7WmFiL93pZISWk7gMUzuCX+ade0+ZeFO1GrdxuKR2sfXpGaLhrx
         xG9rS0UHmW6B6z6AatS/Kq5NZlkq5OSX375v3HSFXTH7ETuzSkd9DpqiTOvE369AzhoH
         tSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mosOiiK2+bkiRh9snSMkD1HwPYWuaNIikJhdo1Enayk=;
        b=cvGI9asIlTMm6hxyLQQ0+fJ+X1cxZzB7sABeKYTtuBDG98O+woYJCfEymFa1TmHStg
         0MjwH+Iv667/wQjju8PYYJAI4DYwlXPihBRcHQ7oxYiYYQFDECSlwHElVnHYjhbQBQMH
         qugqKzPvjlH/k4xt2WMLL4WFLfZCH0rAgcIStaFX9KtEGlPUm8PU3zB7da7NLVQSZJtF
         MHHTypgUoyEf4jn6+tQfOD7zbjC33XDMdqABiSmicwVydycuyYyaVvLH6ivPkZy0n7xe
         mWi0O3jvRhU7No7Ji1qosspcj+22didjZgmWblRcmUlAcnEcsy/SzvROtMsec1//qMZr
         bnhQ==
X-Gm-Message-State: AO0yUKXACFRIBfL4H4T+WxInVQoCcoV/ysD29mCtmPXonrtNHN44N/2B
        SGWlARcmFVdiJf9kfPmyvZRTJUsqjmipGDoc
X-Google-Smtp-Source: AK7set8y6+MrODAbOR5qPBYRc/FnviY07X2nD2x6GBLCq816TPfVkI8lhURd1kHmvWRqUdA95eKaHA==
X-Received: by 2002:a17:906:2ed4:b0:878:7c18:8fd9 with SMTP id s20-20020a1709062ed400b008787c188fd9mr11082809eji.44.1675943260260;
        Thu, 09 Feb 2023 03:47:40 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id x2-20020a170906296200b0084ce5d5d21bsm773509ejd.22.2023.02.09.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 03:47:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQ5Ot-001jsf-03;
        Thu, 09 Feb 2023 12:47:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 1/3] t5563: add tests for basic and anoymous HTTP access
Date:   Thu, 09 Feb 2023 12:19:03 +0100
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <d362f7016d34c4803adf42a88012997c66e0bde8.1675711789.git.gitgitgadget@gmail.com>
 <87f79e79-1591-ca28-4975-3bca5b8f7266@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <87f79e79-1591-ca28-4975-3bca5b8f7266@github.com>
Message-ID: <230209.86v8kbvz51.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>>  ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
>> +ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
>
> This setup (redirecting '/custom_auth/' routes to the 'nph-custom-auth.sh'
> script) is nice and straightforward.=20

*nod*

> [...]
>> +if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
>> +	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")
> [...]
>     if test -f "$ANONYMOUS_FILE" || (test -n "$HTTP_AUTHORIZATION" && \
>     	grep -qsi "^${HTTP_AUTHORIZATION}\$" "$VALID_CREDS_FILE")
>
> Note the addition of '-s' to 'grep' - it seems cleaner than redirecting to
> '/dev/null' (as =C3=86var suggested [1]) while achieving the same result.
>
> [1] https://lore.kernel.org/git/230206.86fsbi5y63.gmgdl@evledraar.gmail.c=
om/

I wondered if it's in POSIX, turns out it is!:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html

But we don't have any existing use of it, even for things in POSIX it's
often a gamble what the exact semantics are on our long tail of *nix,
e.g. old AIX.

In general I'd think we could just avoid "-s" or piping to "/dev/null"
here, i.e. under "-x" or whatever it's informative to know it doesn't
exist from the stderr, but on second look I think both of us long track
of a larger issue here...
> [...]
>> +fi
>> +
>> +echo 'HTTP/1.1 401 Authorization Required'
>> +if test -f "$CHALLENGE_FILE"
>> +then
>> +	cat "$CHALLENGE_FILE"
>> +fi
>
> In contrast to =C3=86var's comments in the review linked earlier, I like =
having
> the explicit 'test -f' (to sort of "self-document" that the challenge is
> only issued if $CHALLENGE_FILE exists). I think you're fine keeping this
> as-is or changing it, depending on your preference.

Looking at this again I think we should just have it be unconditional
here. I.e. it looks like we both assumed that this needs to be a
conditional, but actually every /custom_auth/ test also sets up this
"$CHALLENGE_FILE".

So this "test -f" seems to only serve the purpose of burying an error
under the rug if things have already gone wrong.

But if we're making these requests why are we writing a script that
handles the combination of 3 parameters, and needs to second guess
things? We can just create N urls and N scripts instead. So I tried this
fix-up instead:
=09
	diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
	index 7979605d344..c25e3000db0 100644
	--- a/t/lib-httpd.sh
	+++ b/t/lib-httpd.sh
	@@ -141,6 +141,7 @@ prepare_httpd() {
	 	install_script error.sh
	 	install_script apply-one-time-perl.sh
	 	install_script nph-custom-auth.sh
	+	install_script nph-custom-auth-anon.sh
=09=20
	 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
=09=20
	diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
	index 2aac922376c..7a63a9169c3 100644
	--- a/t/lib-httpd/apache.conf
	+++ b/t/lib-httpd/apache.conf
	@@ -140,6 +140,7 @@ ScriptAlias /error_smart/ error-smart-http.sh/
	 ScriptAlias /error/ error.sh/
	 ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
	 ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
	+ScriptAliasMatch /custom_auth_anon/(.*) nph-custom-auth-anon.sh/$1
	 <Directory ${GIT_EXEC_PATH}>
	 	Options FollowSymlinks
	 </Directory>
	diff --git a/t/lib-httpd/nph-custom-auth-anon.sh b/t/lib-httpd/nph-custom-=
auth-anon.sh
	new file mode 100755
	index 00000000000..3c7a24fed6b
	--- /dev/null
	+++ b/t/lib-httpd/nph-custom-auth-anon.sh
	@@ -0,0 +1,4 @@
	+#!/bin/sh
	+
	+echo 'HTTP/1.1 200 OK'
	+exec "$GIT_EXEC_PATH"/git-http-backend
	diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth.=
sh
	index 8f851aebac4..e3ee61c8c9e 100755
	--- a/t/lib-httpd/nph-custom-auth.sh
	+++ b/t/lib-httpd/nph-custom-auth.sh
	@@ -1,28 +1,15 @@
	 #!/bin/sh
=09=20
	+set -e
	+
	 VALID_CREDS_FILE=3Dcustom-auth.valid
	-CHALLENGE_FILE=3Dcustom-auth.challenge
	-ANONYMOUS_FILE=3Dcustom-auth.anonymous
=09=20
	-#
	-# If $ANONYMOUS_FILE exists in $HTTPD_ROOT_PATH, allow anonymous access.
	-#
	 # If $VALID_CREDS_FILE exists in $HTTPD_ROOT_PATH, consider each line as =
a valid
	 # credential for the current request. Each line in the file is considered=
 a
	 # valid HTTP Authorization header value. For example:
	 #
	 # Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA=3D=3D
	-#
	-# If $CHALLENGE_FILE exists in $HTTPD_ROOT_PATH, output the contents as h=
eaders
	-# in a 401 response if no valid authentication credentials were included =
in the
	-# request. For example:
	-#
	-# WWW-Authenticate: Bearer authorize_uri=3D"id.example.com" p=3D1 q=3D0
	-# WWW-Authenticate: Basic realm=3D"example.com"
	-#
	-
	-if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
	-	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")
	+if grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE"
	 then
	 	# Note that although git-http-backend returns a status line, it
	 	# does so using a CGI 'Status' header. Because this script is an
	@@ -31,12 +18,15 @@ then
	 	# This is only a test script, so we don't bother to check for
	 	# the actual status from git-http-backend and always return 200.
	 	echo 'HTTP/1.1 200 OK'
	-	exec "$GIT_EXEC_PATH"/git-http-backend
	+	exit 1
	 fi
=09=20
	+# Output of our challenge file as headers
	+# in a 401 response if no valid authentication credentials were included =
in the
	+# request. For example:
	+#
	+# WWW-Authenticate: Bearer authorize_uri=3D"id.example.com" p=3D1 q=3D0
	+# WWW-Authenticate: Basic realm=3D"example.com"
	 echo 'HTTP/1.1 401 Authorization Required'
	-if test -f "$CHALLENGE_FILE"
	-then
	-	cat "$CHALLENGE_FILE"
	-fi
	+cat custom-auth.challenge
	 echo
	diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
	index a7b1e5bd1af..feb8149de8f 100755
	--- a/t/t5563-simple-http-auth.sh
	+++ b/t/t5563-simple-http-auth.sh
	@@ -47,8 +47,7 @@ test_expect_success 'setup repository' '
=09=20
	 test_expect_success 'access anonymous no challenge' '
	 	test_when_finished "per_test_cleanup" &&
	-	touch "$HTTPD_ROOT_PATH/custom-auth.anonymous" &&
	-	git ls-remote "$HTTPD_URL/custom_auth/repo.git"
	+	git ls-remote "$HTTPD_URL/custom_auth_anon/repo.git"
	 '
=09=20
	 test_expect_success 'access using basic auth' '

I think that's much better, now we just have a 2-line script to handle
this "anon auth" case. Instead of creating a "custom-auth.anonymous"
file to communicate how the remote end should behave, let's just
communicate that by requesting a different URL, one that accepts
anonymous authentication.

I did insert a deliberate bug here, or:

	-	exec "$GIT_EXEC_PATH"/git-http-backend
	+	exit 1

So aside from your "exec" comment it seems both of us missed that this
"exec" does nothing useful, the test will fail if we emit different
headers, but it doesn't matter that we execute the git-http-backend.

Or maybe it does, but the tests aren't good enough to spot the
difference.

The above is a rough WIP, I'm leaving it here for Matthew to follow-up
on. I think it might benefit from being further split-up, i.e. we know
which URLs we expect to fail auth, so if we just had another URL for
"the auth response fails here" we'd have 3x trivial scripts with no
if/else; but maybe that sucks, I didn't try it.
