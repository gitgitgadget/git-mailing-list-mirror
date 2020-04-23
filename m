Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A369C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5822075A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOKYGMNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDWTWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWTWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 15:22:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF8C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 12:22:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so7733270qkg.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=t45MDmuxUT7pUVfrAWTYZw6mCYtMFfXU+OUoU8wYf+A=;
        b=JOKYGMNyqQcKVRp4h2L3MLswcodC0ewpv4P8Ewre8hYEw/edOeH0wuFNMgGSxXwOC4
         Bt/HgnsyW5ffGbamypHRLbt0xxoCIPyi/KAzFohzGN+ZAuDd543cRQYn3lw25+mGnRew
         TdvDzpJ2/25Lh10Ug0WOcqZa4W6CaB9K+zeLlqeQww1HkNHnTWMkCiE0hJnTJVif8s1d
         kRT7cBAd3arCf8BR9shEDMHQR3m/ksznoJGCKJs4gcAblqmW8xJbDbNmS1MgxOobeuim
         +qJqFiMrcZACt8p80KyD9dW2ovDD8bR1G9vRAKojIsFLG3xyVVDkIrcAjTHbkdOmQlr+
         LPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:autocrypt:organization
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=t45MDmuxUT7pUVfrAWTYZw6mCYtMFfXU+OUoU8wYf+A=;
        b=NesDSN/jMEYcAOuqD7B4IRsRQxeXqwyuC6AyMGq/G3mkhr1yJOuty0j1hod45vawuC
         fuI2KF3ogJlB+U9XLRAmnUyrjQQbB/P6rC2IxX4rTnYA+vUF5nDmCJqnuzMZNvi02d4x
         nJy4eeieXEp6pDjmfZ2GYMBMOJKePrieoPi+PorU2Z6nWXISf9hqYH7YUH/RfQLa6Mrr
         sjOIxiOljB8YEyOJ36C49yoOGM4gyn4Pvn/dFpIGKsDhTBNnAAAd7sW1jn2GcSwUpDBZ
         33wroMosneoA2BSqJS4mnWteLyjD9/uwd5IFRNRs18SZoDCxB2f2I/PzQPoO/bq3ks+U
         vwyQ==
X-Gm-Message-State: AGi0PuY0WwhGslu6jaWeC5Ti+dtrIEQIqH/5e2Upp+KnFATL7ILjaMVf
        4AnypyAvBu0dhhENT8vK3h725/DU
X-Google-Smtp-Source: APiQypLlL97I72JnSNDYUt5foo9vseVtvk8ZGC/W+IkuxJxUcBEldxV1jtjDI1guqVt1iHeXElVPsA==
X-Received: by 2002:a37:a94b:: with SMTP id s72mr5406406qke.415.1587669727548;
        Thu, 23 Apr 2020 12:22:07 -0700 (PDT)
Received: from mbp.home ([2804:f1c:7300:de00:d88f:d074:4af3:486d])
        by smtp.gmail.com with ESMTPSA id v16sm2101588qkf.80.2020.04.23.12.22.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:22:06 -0700 (PDT)
To:     git@vger.kernel.org
From:   Renato Botelho <garga@FreeBSD.org>
Subject: Commit change disappeared from repository
Autocrypt: addr=garga@FreeBSD.org; keydata=
 mQENBFn4ZqUBCACxJRWi57JkmsCrSU0gZd/CwB+B90OTUeXmF63lDPETOQ+pBA4+vJgzjW1C
 pv7rR25wxvESJKphxZJOOk9AXTXsg5QrhdP3+KQG/zNcKd2ukbt3ezkhdMx8q81wn4wY2oTl
 WXdGIVdDKvC8sCp1fc6pPKJin71/skb9wg6ThtlRFlv9en4f8QSVmRuzRKQ6VjCbl+yIpiye
 /I5BQ4I99uouPzPhzf9ya3cvp4xbiw5wSo1F3nLsThBT2osYy/nRNz2ciuCYyyX87dGhio0T
 8Pxl37eBbGQvCGwPQBApCcfoiZBN/5F65Tt4p72gIqT+AYuqq5G7Bhj+fGTC7q0QotL/ABEB
 AAG0LFJlbmF0byBCb3RlbGhvIChGcmVlQlNEKSA8Z2FyZ2FARnJlZUJTRC5vcmc+iQFXBBMB
 CgBBAhsDBQkFo5qABQsJCAcDBRUKCQgLBRYDAgEAAh4BAheAFiEExxiLNMqsn7yXmTy7W54E
 w5ZrhhoFAln4aeUCGQEACgkQW54Ew5ZrhhpTIwf+OS+Gv/ITOy7+8D+8SKXNmkfczsTO+Uqz
 6SraXcq32j1C4QcRQCwGPhVJJgKnFSvPm3kbNPFXaQh1zD+mTQ4r/Loc78Rz+fZljYcgNx7n
 aQKhd9pdpXaELOe+Y10jvGUrT0SE06Y10BP/NmQaLplt9qG8VgLAAB9ZcsuZ9pzbBbQjd9In
 OK5VcXQzHT/EBBQ1rHsl1Aq8TYdmjbKl+HKc1c8dJ5OfXrgnTIUwQdN1rauXbmH/YW/CKN7z
 zF59v/sPBTaWfFl2CS/BORhWhe1PBudrVZWFT0oJGNuG6k8dlnssoL/0ojFaN5w5xm8mvMAf
 uAuixGf4bK6C7hcE34D/ULkBDQRZ+GalAQgApiTibUM0OpeCcxf5YUep4F4y853ClU4TMqZO
 +ho38sz0GdshQWuBEBqahOtxapHUMtlmC+wJNCBAav5JYjHHrXXE9pgRm5EgVssDpMvplLB4
 5CFdx5jBu02Bt9Wp5bD21TPH3rsYJUB3rYmxWfVmdRhNBERrCJu49OIsBSKAlIinx8altYrh
 Z7bO2C1hKOG6QHWRr4ml4HTD/gZ6TTfsrR+sktBNv/5ZRkcJNDVM+eOGagXkEUOVFe9KXynD
 3KcZBbBKpwoaW5GK8OglKJt8ggUfc78CG1xk4b5nL8QCk0CBrC6VPPOYvXTpYSTHmx1QkElm
 1iNu1Tc5ccvcyAwTswARAQABiQE8BBgBCgAmFiEExxiLNMqsn7yXmTy7W54Ew5ZrhhoFAln4
 ZqUCGwwFCQWjmoAACgkQW54Ew5ZrhhoH3wf+KuIeDyvIJOui+0C5FD5r44Bwkj/SAUVUerfp
 0qtRktc+BZoSifPs3Rqjh/PpwRvLTuJnSsiqWLz8NCTThogRzVqEcQHqZR3vOjtYM60sjYJ+
 BGQl/bjm1C/YtWEEmKs7mJc+02U8qJA4rbNKSRRRoz6XngnuN6YC0fkeD7c7rxRhOg6OWasZ
 JinB9+dO1IH7eZ5c97v518qSaLRp0T7I+FpEGOp7tTFHaepZWEnuojr5D6jI1MOEywy0EWJu
 3m0TYlh935I8o7gLABqoHEmUeW7JK7r91SZaFnr8zQ6XOAxkPh50uFMTNtNZTnM7k1pRv5Ov
 fms0VzARITYzTwmpDQ==
Organization: FreeBSD
Message-ID: <7b4f2b10-e80d-d4af-6154-6665e37da623@FreeBSD.org>
Date:   Thu, 23 Apr 2020 16:22:04 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm sending it here to devel list because after asking around at IRC and
also to friends we ended up with no reasonable explanation about what
happened, and it lead me to consider maybe it could be a bug (!?!?)

I'm running git 2.26.2 on macOS Catalina.

We first noted a package built from pfSense FreeBSD-ports repository [1]
was missing a patch and then after investigate we found these relevant
information (it's all about RELENG_2_4_5 branch):

1. The original commit made in Jan 3 is present in the repo:

❯ git log RELENG_2_4_5 | grep -A5 53e5b36834f1
commit 53e5b36834f1
Author: jim-p <jimp@netgate.com>
Date:   Fri Jan 3 11:50:09 2020 -0500

    Allow sshguard to process via stdin again. Issue #9971

2. Despite the fact commit was present, the change it introduced was not
present on repository contents.

3. This commit changed the file
security/sshguard/files/patch-src_sshguard.in as we can see:

❯ git show 53e5b36834f1 -- security/sshguard/files/patch-src_sshguard.in
commit 53e5b36834f1
Author: jim-p <jimp@netgate.com>
Date:   Fri Jan 3 11:50:09 2020 -0500

    Allow sshguard to process via stdin again. Issue #9971

diff --git a/security/sshguard/files/patch-src_sshguard.in
b/security/sshguard/files/patch-src_sshguard.in
index 6881e162028f..788f0ac2bc47 100644
--- a/security/sshguard/files/patch-src_sshguard.in
+++ b/security/sshguard/files/patch-src_sshguard.in
@@ -1,6 +1,6 @@
 --- src/sshguard.in.orig       2019-05-23 22:25:17 UTC
 +++ src/sshguard.in
-@@ -97,14 +97,8 @@ elif [ -z "$tailcmd" ]; then
+@@ -97,19 +97,12 @@ elif [ -z "$tailcmd" ]; then
      exit 1
  fi

@@ -17,3 +17,9 @@

  # Make sure to kill entire process group (subshell) on exit/interrupts.
  trap "clean_and_exit" INT TERM
+ trap "kill 0" EXIT
+
+ eval $tailcmd | $libexec/sshg-parser | \
+-    $libexec/sshg-blocker $flags | $BACKEND &
+-wait
++    $libexec/sshg-blocker $flags | ($BACKEND ; pkill -PIPE -P $$)

4. Here the odd facts start, git log doesn't show this commit when
filtering the file it changed, which btw, was never moved/renamed.

❯ git log RELENG_2_4_5 -- security/sshguard/files/patch-src_sshguard.in
commit 88d6f4488ab5
Author: delphij <delphij@FreeBSD.org>
Date:   Sun Nov 10 18:34:54 2019 +0000

    Remove redundant pidfile check.

    This fixes an issue that SSHguard won't start after an incompelete
    shutdown.

    PR:             ports/241751
    Approved by:    portmgr (bugfix blanket)
    MFH:            2019Q4

5. After trying to understand what happened, --follow parameter was used
and it shows that commit.  As I mentioned previously, the change it did
on that file was not there, and no other commit reverting it show up.

❯ git log RELENG_2_4_5 --follow -M --
security/sshguard/files/patch-src_sshguard.in
commit 53e5b36834f1
Author: jim-p <jimp@netgate.com>
Date:   Fri Jan 3 11:50:09 2020 -0500

    Allow sshguard to process via stdin again. Issue #9971

commit e4cccfc2c3ab
Author: delphij <delphij@FreeBSD.org>
Date:   Sun Nov 10 18:35:55 2019 +0000

    MFH: r517220

    Remove redundant pidfile check.

    This fixes an issue that SSHguard won't start after an incompelete
    shutdown.

    PR:             ports/241751
    Approved by:    portmgr (bugfix blanket)
    Approved by:    ports-secteam (bugfix blanket)

commit 88d6f4488ab5
Author: delphij <delphij@FreeBSD.org>
Date:   Sun Nov 10 18:34:54 2019 +0000

    Remove redundant pidfile check.

    This fixes an issue that SSHguard won't start after an incompelete
    shutdown.

    PR:             ports/241751
    Approved by:    portmgr (bugfix blanket)
    MFH:            2019Q4

Please let me know if you need me to collect more data.

[1] https://github.com/pfsense/FreeBSD-ports
-- 
Renato Botelho
