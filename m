Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C5C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C72F206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiMQPC38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHKURK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKURK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:17:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D393FC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:17:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g6so14929938ljn.11
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kP5eGjmySjYNzX8TwbnR9g7F+tJCXkRyp6tQyA4aBvg=;
        b=JiMQPC38CeI7SVVgBFA8cjf/CyOQrUuwKzPkV3xsExPHMKGvsVPluCOVZV00Nkef+B
         Pre0CFxHR4bXoOnAuieC7Ic9WCZmLJ1gmHNAf2CRgs18FO3fgyQ8K/oiufnEmZEvr3MD
         EVZX6xyJT2q/MrBQW2maUNIgKPMWwAF+DNw2WRyIJ6W2JIibghSZBsZjMIfIlOBdirJk
         axGjSBVyS3XuqA7x4sLQQ0zagygmd9FhRVbGAkakTIQN1rnbOlcMy49naIDIG9HGgalB
         yHTkCEtSOxCgjhGmHh0o/Pfpy/ySH5v95G83UULkSPy4mpCzy/TalwcacciFlBNhqWVr
         ehZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=kP5eGjmySjYNzX8TwbnR9g7F+tJCXkRyp6tQyA4aBvg=;
        b=OFVqB7TnrsMUN85VV6Sl/qMu+00VE4FDebwdjPT+QaOaAVQEHLZU3WeUMpHiONHFsE
         cPNC+WI2Qs8gMNNWIqmkgWZcSDqgXbsSDitQKLIWqUvPGBvHBJZ4/vOjOz7NxgzautwX
         z6bsM1DJ1x1nzyHEZIBh9+XyML0R03hkzcCOfiGiQAwCzRm4YDek7Hb9G5zi6w/4+5jt
         E517ERCz4Rm/obIdvQabUj/x10252Uxg/gosXUX4ki46NoHu3WF5BcnHtfvSQZa+x3bY
         cbr6qM3z0R9PIDX0GkbTvAg0ME8xcHGybIEbd3JAhNHh5rPJU87XyHNtKpoeVscNBU23
         ID5A==
X-Gm-Message-State: AOAM532e1oxXJCLYfgqN+UTbOMOlv1EIqB5PVKrYSmyiyGRJoIJe65IG
        8x5GfTWpM8IPSV7UMzG4PzNQsIVB
X-Google-Smtp-Source: ABdhPJxToJsgNDbUDiN/P9sgKo416NKzO39ahcI06jxquz/uQzR2swpF9XyyF1zXxjA//Rjtt98bmA==
X-Received: by 2002:a2e:990c:: with SMTP id v12mr3985896lji.449.1597177027505;
        Tue, 11 Aug 2020 13:17:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s2sm10265276ljg.84.2020.08.11.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:17:06 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <874kp9biho.fsf@osv.gnss.ru> <xmqq7du59eb4.fsf@gitster.c.googlers.com>
        <87364t563r.fsf@osv.gnss.ru>
Date:   Tue, 11 Aug 2020 23:17:05 +0300
In-Reply-To: <87364t563r.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        11 Aug 2020 22:34:48 +0300")
Message-ID: <87tux93pku.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>> [...]
>>>
>>>> * jk/log-fp-implies-m (2020-07-29) 7 commits
>>>>   (merged to 'next' on 2020-08-03 at 39fefa6b82)
>>>>  + doc/git-log: clarify handling of merge commit diffs
>>>>  + doc/git-log: move "-t" into diff-options list
>>>>  + doc/git-log: drop "-r" diff option
>>>>  + doc/git-log: move "Diff Formatting" from rev-list-options
>>>>  + log: enable "-m" automatically with "--first-parent"
>>>>  + revision: add "--no-diff-merges" option to counteract "-m"
>>>>  + log: drop "--cc implies -m" logic
>>>>
>>>>  Originally merged to 'next' on 2020-08-01
>>>>
>>>>  "git log --first-parent -p" showed patches only for single-parent
>>>>  commits on the first-parent chain; the "--first-parent" option has
>>>>  been made to imply "-m".  Use "--no-diff-merges" to restore the
>>>>  previous behaviour to omit patches for merge commits.
>>>>
>>>>  On hold a bit.
>>>>  cf. <20200804200018.GB2014743@coredump.intra.peff.net>
>>>
>>> I believe I've submitted resolution for that.
>>>
>>> <20200805220832.3800-1-sorganov@gmail.com>
>>>
>>> Do you expect anything from me to push all this further?
>>
>> I was waiting for a reroll of the "resolution" with just one extra
>> test I mentioned in <xmqq3650n2rc.fsf@gitster.c.googlers.com> in the
>> thread.  With that everything would be good to go, I would think.

Here is the patch you've asked for, separately, as I honestly believe it
does not belong to the series in question themselves. This is on top of
the series.

-- >8 --
Subject: [PATCH] t/t4013: add permutation test for --diff-merges vs --first-parent

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh                       |  1 +
 ...--first-parent_--diff-merges=off_-p_master | 78 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 86fb11cecc61..7f7f1058cb86 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -299,6 +299,7 @@ log --root -c --patch-with-stat --summary master
 log --root --cc --patch-with-stat --summary master
 log --no-diff-merges -p --first-parent master
 log --diff-merges=off -p --first-parent master
+log --first-parent --diff-merges=off -p master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
diff --git a/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master b/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master
new file mode 100644
index 000000000000..ad2e6d3be22c
--- /dev/null
+++ b/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master
@@ -0,0 +1,78 @@
+$ git log --first-parent --diff-merges=off -p master
+commit 80e25ffa65bcdbe82ef654b4d06dbbde7945c37f
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side' into master
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
-- 
2.20.1
