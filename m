Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B347208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 09:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbdHWJuS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 05:50:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38821 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753733AbdHWJuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 05:50:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id k10so747264wre.5
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 02:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m0dqZ0UHpjyyEJOoGMGMDIbmbrCbGuqfSrBFSFqjvJQ=;
        b=uISpIzA1cgGKCR17Qkay64fN4cIQWxCZjJo4mppehgyxWVjh4O+tL/sNfws+x+GpuE
         y2HDy4ikCzpCn38JSUZGCIvkAYfucbcCVBLt6N6RY68kTHYrZ4KarXhwU0cjJZyc6Sz2
         ZrCKieO0pnpJAOBUKCpbN9HDd5Bryo4m0WJlUazN8sHYhRBNZRnN1Aauahiy5Vd7TBR6
         EVOaDRONuEddxVO8LkaJG1sTIqq/NOj2/tPe+asy1MqFxUtnklbkYEsJoTpsvejUMPzK
         Y1LA9nVJzMJvJMLQBTgkdr+5Gw9JHFUhxI2f3wp16dl7b23FNzgha1odDRysJP0JuqGi
         UIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m0dqZ0UHpjyyEJOoGMGMDIbmbrCbGuqfSrBFSFqjvJQ=;
        b=f+TMrEkcKa+Pk4+kyVwDwDmN+sOtwMZK+jBkY9mLMohJRE/R0DD/e3Z6o7muVDrxrj
         nN0qr7aHsvPSTFi97A7f9RgBSz9t9mjGpNPneh2mAJJwsAZpTQ0EeJUDGhrIkBQ0SLxA
         6ByxAKk3edXPSaom7aIrEKWTb0oNq4L4NjtaXDs6/gOXyqLa8qJ0OsmKh17Er1Bpo0xU
         FoFJSo6EHmRVtIK9pH9BIdkxT2+bJ9Ag/wkRGfQzJiDhQvH85gd4Sh1jvq0SSXTyMYhg
         HloT92m8yLDChV4f6GUNRoN1uhpdLKsG8AkHc3F80Thakg/7aKn4brhBCxQHsDqDbg8o
         ys/Q==
X-Gm-Message-State: AHYfb5iTHrGpwzoINbj4waFkxWKLMTDoMjODiGM2YpqbFL3KdKVli4KS
        29i8mQRV0QO/9ClBJck=
X-Received: by 10.223.169.47 with SMTP id u44mr1097607wrc.332.1503481814632;
        Wed, 23 Aug 2017 02:50:14 -0700 (PDT)
Received: from gimli.lan (host-176-36-105-88.la.net.ua. [176.36.105.88])
        by smtp.gmail.com with ESMTPSA id 81sm1292113wmm.17.2017.08.23.02.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 02:50:14 -0700 (PDT)
From:   Ivan Vyshnevskyi <sainaen@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC] push: anonymize URL in error output
Date:   Wed, 23 Aug 2017 12:49:29 +0300
Message-Id: <20170823094929.13541-1-sainaen@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commits 47abd85 (fetch: Strip usernames from url's before storing them,
2009-04-17) and later 882d49c (push: anonymize URL in status output,
2016-07-14) made fetch and push strip the authentication part of the
remote URLs when used in the merge-commit messages or status outputs.
The URLs that are part of the error messages were not anonymized.

A commonly used pattern for storing artifacts from a build server in a
remote repository utilizes a "secure" environment variable with
credentials to embed them in the URL and execute a push. Given enough
runs, an intermittent network failure will cause a push to fail, leaving
a non-anonymized URL in the build log.

To prevent that, reuse the same anonymizing function to scrub
credentials from URL in the push error output.

Signed-off-by: Ivan Vyshnevskyi <sainaen@gmail.com>
---

This is my first attempt to propose a patch, sorry if I did something wrong!

I've tested my changes on Travis CI, and the build is green [1].

Not sure how much of the background should be included in the commit message.
The "commonly used pattern" I mention could be found in the myriad of
online tutorials and looks something like this:

    git push -fq https://$GIT_CREDS@github.com/$REPO_SLUG

Note, that a lot of developers mistakenly assume that '--quiet' ('-q') will
suppress all output. Sometimes, they would redirect standard output to
/dev/null, without realizing that errors are printed out to stderr.

I didn't mention this in the commit, but another typical offender is a tool that
calls 'git push' as part of its execution. This is a spectrum that starts with
shell scripts, includes simple one-task apps in Python or Ruby, and ends with
the plugins for JavaScript, Java, Groovy, and Scala build tools. (I'd like to
avoid shaming their authors publicly, but could send you a few examples
privately.)

I gathered the data by going through build logs of popular open source projects
(and projects of their contributors) hosted on GitHub and built by Travis CI.
I found about 2.3k unique credentials (but only about nine hundred were active
at the time), and more than a half of those were exposed by a failed push. See
the advisory from Travis CI [2] for results of their own scan.

While the issue is public for several months now and addressed on Travis CI,
I keep finding build logs with credentials on the internet. So I think it's
worth fixing in the git itself.

[1]: https://travis-ci.org/sainaen/git/builds/267180560
[2]: https://blog.travis-ci.com/2017-05-08-security-advisory

 builtin/push.c             |  2 +-
 t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 03846e837..59f3bc975 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -336,7 +336,7 @@ static int push_with_options(struct transport *transport, int flags)
 	err = transport_push(transport, refspec_nr, refspec, flags,
 			     &reject_reasons);
 	if (err != 0)
-		error(_("failed to push some refs to '%s'"), transport->url);
+		error(_("failed to push some refs to '%s'"), transport_anonymize_url(transport->url));
 
 	err |= transport_disconnect(transport);
 	if (!err)
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d38bf3247..0b6fb6252 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
 	grep "^To $HTTPD_URL/smart/test_repo.git" status
 '
 
+cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
+#!/bin/sh
+exit 1
+EOF
+chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
+
+cat >exp <<EOF
+error: failed to push some refs to '$HTTPD_URL/smart/test_repo.git'
+EOF
+
+test_expect_success 'failed push status output scrubs password' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_must_fail git push "$HTTPD_URL_USER_PASS/smart/test_repo.git" +HEAD:scrub_err 2>stderr &&
+	grep "^error: failed to push some refs" stderr >act &&
+	test_i18ncmp exp act
+'
+rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
+
 stop_httpd
 test_done
-- 
2.14.1

