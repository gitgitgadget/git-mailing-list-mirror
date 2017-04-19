Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580951FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 09:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761487AbdDSJWa (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 05:22:30 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35098 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761160AbdDSJW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 05:22:27 -0400
Received: by mail-wm0-f45.google.com with SMTP id w64so75211646wma.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3SEFPc/DI7m4N7l8Csf5rRdz2ukCXg0Id45wcCKyiU=;
        b=dORb7omd9evq0icMzoJ2S8p+9h/pklAcR3W4iVRHCCkgxvoPRWGGr/+c78zvddVd4T
         DQCzTJbjudZkX4rH0OrSzTXWLwg1nhQ8o5xZQNnc52ij/BoJhe+OY67EHqlI5LeqWzL4
         D2RBx0M4E4FKrlhcnewXqLLlVrUzT1lgkpd8kYC762qeQoddIFpFW04ttPXkTzQvPbQM
         DH55hJlKjPV89bvqOxjtVg6otKU5sZp6ZZfo4AcpImSjFSmYhA0a7WVTTm6ilQbHLpOZ
         tcwU6eAYIJ0+imMmsrmoOnFikso8p+ZUOmm31+BB5O47fOZoOZEhlFXfE/anaA+8oqRq
         W54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3SEFPc/DI7m4N7l8Csf5rRdz2ukCXg0Id45wcCKyiU=;
        b=QO/IbDU+0DSaXVbnN6efkY23mFS/4kR2cWzX4APBrlA/aD5vTOLc+YNlz1eqJJuXDR
         KuuIvn6yS450w7nA1tcD5nCMSN62niDTlHWoPkE5Y17kd/V9ib1mDFsLGJUtanAJKKMJ
         BfcGWgf+hifCoTaYcZDicEiJWH2BfxbgkCwWtRe76+I30VC9wwBxdD6LsjG9UjBDp7Ka
         cpbOKz1lFyWwgtJod3EV/d0WASiLii5W0aQ4fn9+CxNc4DAk9Ppjv51I+Pz02kF0YZww
         hXkRa5pWx7Oi+D4XHvfAtNurZcPrGrEhTDLPYSAHkY49uCf8z1FLbFK2PFL5Vv+8BzA4
         1ZiQ==
X-Gm-Message-State: AN3rC/45FGRKtT8mUeZtFgmD5ooykZJNWwwJt7Wo1+zrgBew4PfUQ/h+
        rgRPZTkrj9N9vKC7+gI=
X-Received: by 10.28.12.147 with SMTP id 141mr17677659wmm.8.1492593745815;
        Wed, 19 Apr 2017 02:22:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j2sm2479840wrd.28.2017.04.19.02.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 02:22:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] push: document & test --force-with-lease with multiple remotes
Date:   Wed, 19 Apr 2017 09:22:03 +0000
Message-Id: <20170419092203.5269-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqinm3k7qa.fsf@gitster.mtv.corp.google.com>
References: <xmqqinm3k7qa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document & test for cases where there are two remotes pointing to the
same URL, and a background fetch & subsequent `git push
--force-with-lease` shouldn't clobber un-updated references we haven't
fetched.

Some editors like Microsoft's VSC have a feature to auto-fetch in the
background, this bypasses the protections offered by
--force-with-lease & --force-with-lease=<refname>, as noted in the
documentation being added here.

See the 'Tools that do an automatic fetch defeat "git push
--force-with-lease"' (<1491617750.2149.10.camel@mattmccutchen.net>)
git mailing list thread for more details. Jakub Narębski suggested
this method of adding another remote to bypass this edge case,
document that & add a test for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Apr 17, 2017 at 5:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Document & test for cases where there are two remotes pointing to the
>> same URL, and a background fetch & subsequent `git push
>> --force-with-lease` shouldn't clobber un-updated references we haven't
>> fetched.
>>
>> Some editors like Microsoft's VSC have a feature to auto-fetch in the
>> background, this bypasses the protections offered by
>> --force-with-lease as noted in the documentation being added here.
>
> That sounds like an unfortunate mix of two "feature"s that are
> mutually incompatible.  Perhaps those who thought auto-fetch was a
> good idea didn't think through the implications, 

Well, to be fair to those people there's been no negative interaction
with the everyday commands people use by aggressively fetching in the
background until this feature came along, at least not that I can
think of.

There's a lot of advice online and in our own docs to the effect of
"pull is fetch + merge|rebase, if you just want to inspect the remote
just safely fetch".

Now advice to that effect needs needs to be amended to say "...unless
you were thinking of using the shorthand of --force-with-lease, then
it'll subtly do the wrong thing".

To argue against the point I was making in
<CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
saying basically "at least it sucks less than --force", I'm not so
sure anymore. I think that this feature's bit too obscure to break the
general "fetch is safe" advice in such a way, and we should probably
change how it works by default to make that true again.

> and also it is understandable that those who never thought
> auto-fetch was a good idea would want --force-with-lease to default
> to the remote-tracking branch.
>
>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index 1624a35888..2f2e9c078b 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -210,6 +210,43 @@ or we do not even have to have such a remote-tracking branch when
>>  this form is used).  If `<expect>` is the empty string, then the named ref
>>  must not already exist.
>>  +
>> +This option interacts very badly with anything that implicitly runs
>> +`git fetch` on the remote to be pushed to in the background. The
>
> This description is not accurate.  Only those who do not to specify
> what is expected and instead use the remote-tracking branch are
> affected (but these random "git fetch" clobbering the
> remote-tracking branch is sort of known and expected).
>
> I do not think I would mind if these two new lines were added one
> paragraph above, i.e. where "--force-with-lease=<refname>" form is
> described.  It clearly says "... as the remote-tracking branch we
> have for them." and that is the best place to say "This option
> interacts badly".

I think this addresses your concerns in a better way. I didn't want to
add this huge multi-paragraph digression in the middle of where we're
briefly explaining the various forms of --force-with-lease above, but
I've reworded this so that it's clear that we're only talking about
the shorthard forms now, not --force-with-lease=<ref>:<expect>.

A word-diff with version 1:
    
    diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
    index 2f2e9c078b..0a639664fd 100644
    --- a/Documentation/git-push.txt
    +++ b/Documentation/git-push.txt
    @@ -212,5 +212,17 @@ must not already exist.
    +
    [-This-]{+Note that all forms other than `--force-with-lease=<refname>:<expect>`+}
    {+that specifies the expected current value of the ref explicitly are+}
    {+still experimental and their semantics may change as we gain experience+}
    {+with this feature.+}
    {+++}
    {+"--no-force-with-lease" will cancel all the previous --force-with-lease on the+}
    {+command line.+}
    {+++}
    {+A general note on safety: supplying this+} option {+without an expected+}
    {+value, i.e. as `--force-with-lease` or `--force-with-lease=<refname>`+}
    interacts very badly with anything that implicitly runs `git fetch` on
    the remote to be pushed to in the [-background.-]{+background, e.g. `git fetch origin`+}
    {+on your repository in a cronjob.+}
    {+++}
    The protection it offers over `--force` is ensuring that subsequent
    changes your work wasn't based on aren't clobbered, but this is
    @@ -231,3 +243,3 @@ on `origin-push` won't be updated, and thus commands like:
    +
    	git push --force-with-lease [-origin-]{+origin-push+}
    +
    @@ -238,5 +250,5 @@ more tedious like:
    +
    	git fetch              [-;#-]{+#+} update 'master' from remote
    	git tag base master    [-;#-]{+#+} mark our base point
    	git rebase -i master   [-;#-]{+#+} rewrite some commits
    	git push --force-with-lease=master:base master:master
    @@ -248,10 +260,2 @@ force push changes to `master` if the remote version is still at
    updated to in the background.
    [-+-]
    [-Note that all forms other than `--force-with-lease=<refname>:<expect>`-]
    [-that specifies the expected current value of the ref explicitly are-]
    [-still experimental and their semantics may change as we gain experience-]
    [-with this feature.-]
    [-+-]
    [-"--no-force-with-lease" will cancel all the previous --force-with-lease on the-]
    [-command line.-]

 Documentation/git-push.txt | 41 +++++++++++++++++++++++++++++++++++++++++
 t/t5533-push-cas.sh        | 29 +++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 1624a35888..0a639664fd 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -217,6 +217,47 @@ with this feature.
 +
 "--no-force-with-lease" will cancel all the previous --force-with-lease on the
 command line.
++
+A general note on safety: supplying this option without an expected
+value, i.e. as `--force-with-lease` or `--force-with-lease=<refname>`
+interacts very badly with anything that implicitly runs `git fetch` on
+the remote to be pushed to in the background, e.g. `git fetch origin`
+on your repository in a cronjob.
++
+The protection it offers over `--force` is ensuring that subsequent
+changes your work wasn't based on aren't clobbered, but this is
+trivially defeated if some background process is updating refs in the
+background. We don't have anything except the remote tracking info to
+go by as a heuristic for refs you're expected to have seen & are
+willing to clobber.
++
+If your editor or some other system is running `git fetch` in the
+background for you a way to mitigate this is to simply set up another
+remote:
++
+	git remote add origin-push $(git config remote.origin.url)
+	git fetch origin-push
++
+Now when the background process runs `git fetch origin` the references
+on `origin-push` won't be updated, and thus commands like:
++
+	git push --force-with-lease origin-push
++
+Will fail unless you manually run `git fetch origin-push`. This method
+is of course entirely defeated by something that runs `git fetch
+--all`, in that case you'd need to either disable it or do something
+more tedious like:
++
+	git fetch              # update 'master' from remote
+	git tag base master    # mark our base point
+	git rebase -i master   # rewrite some commits
+	git push --force-with-lease=master:base master:master
++
+I.e. create a `base` tag for versions of the upstream code that you've
+seen and are willing to overwrite, then rewrite history, and finally
+force push changes to `master` if the remote version is still at
+`base`, regardless of what your local `remotes/origin/master` has been
+updated to in the background.
 
 -f::
 --force::
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index a2c9e7439f..d38ecee217 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -229,4 +229,33 @@ test_expect_success 'new branch already exists' '
 	)
 '
 
+test_expect_success 'background updates of REMOTE can be mitigated with a non-updated REMOTE-push' '
+	rm -rf src dst &&
+	git init --bare src.bare &&
+	test_when_finished "rm -rf src.bare" &&
+	git clone --no-local src.bare dst &&
+	test_when_finished "rm -rf dst" &&
+	(
+		cd dst &&
+		test_commit G &&
+		git remote add origin-push ../src.bare &&
+		git push origin-push master:master
+	) &&
+	git clone --no-local src.bare dst2 &&
+	test_when_finished "rm -rf dst2" &&
+	(
+		cd dst2 &&
+		test_commit H &&
+		git push
+	) &&
+	(
+		cd dst &&
+		test_commit I &&
+		git fetch origin &&
+		test_must_fail git push --force-with-lease origin-push &&
+		git fetch origin-push &&
+		git push --force-with-lease origin-push
+	)
+'
+
 test_done
-- 
2.11.0

