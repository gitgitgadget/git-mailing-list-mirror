Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB2AC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F896619BB
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhKRTn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 14:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKRTnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 14:43:25 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF42FC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 11:40:24 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bj13so16638898oib.4
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vE1loFUPLLWZZKLomBJDSsYF9AwoCEOleHP0E08I1D8=;
        b=T2Y8h0UiJ9o1o0hNp4zOFo+DhzBfqo0uQhvLhavkmBPqX5kt8/jedvObzbqzH/vZUc
         bTpU22Lfamz39hIonJUHCvSJdyy+EZyhjN7GAFGV8zId1pU24aTL6tjCkFIqhMHRCLgm
         M3yMhjRe4nnhY5rAg+o/9scH8163RGkX8RV+63osXWoMdfJtp7MS/j3d4VoVU3s1f1c0
         z1L/1RZq6UVLZYtJku108OKloWN97zQZ+klNMw/rxEXC9D2c4BJPlfgf6dmBT72l+LNQ
         Gh+yWRTXQDqmSRAJrTUrz83jjZtad0paDFuKmq2WLOtsPJe1C23t90eyrDp37TAcn9F5
         sHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vE1loFUPLLWZZKLomBJDSsYF9AwoCEOleHP0E08I1D8=;
        b=Uq3zLE3faleBlUsnB39FvM4Vkit9CLQOJC/AWYWLG8saoSmJ3aPTPt0hx/c6jw2SRr
         sqtkLbs5PsD3ftcaScnbA1NVjzG3+IZiDSN0E40kXkHjhN5LQlF4ygc5YiWspZE/+rIk
         gnsWE7fqh8V7aBH7JzisV8fKA/J0SVgpLDOkAgehH6+w+t0ko4J2eLA9cla80CQ7OsBJ
         D5+2iXqyYey6PeWq9P+lu4WsTJ7WSeTvsefR6nFUfxW2DYwsbItsjkc1U1AVn4o0FAIG
         lA4oaPY8Vsty+Gjfak2qfvcC4cLIYc5wbDu9T4Y8E/XvCdouGhtG1DiuVvIvtTyPov6+
         0xBw==
X-Gm-Message-State: AOAM531PVWJb3Xcahm4VEFm/bTJD6Hzu2lJIgmiBBU6p6ggAbGuonamy
        yj6ObPlWbDopW1uMVJAPNOI=
X-Google-Smtp-Source: ABdhPJxZOr4dpW1M99uKO4jKQ8HKUQ+VzDej/6j+WYLCfX+4PkIVHxe8XEFT1U3e5reTsHwdc2EE7w==
X-Received: by 2002:a05:6808:20a5:: with SMTP id s37mr9517763oiw.127.1637264424134;
        Thu, 18 Nov 2021 11:40:24 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w4sm186759oiv.37.2021.11.18.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:40:23 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:40:21 -0800
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] grep/pcre2: limit the instances in which UTF mode is
 enabled
Message-ID: <YZasJWuysic3OWS1@carlos-mbp.lan>
References: <20211118084143.279174-1-someguy@effective-light.com>
 <CAPUEspi5-urxZxHCsAWjyLxPWDfaYCK7nqGBL8FejU=n=qcFrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEspi5-urxZxHCsAWjyLxPWDfaYCK7nqGBL8FejU=n=qcFrQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 02:04:08AM -0800, Carlo Arenas wrote:
> 
> I haven't tested it, but I think that for this to work with the log,
> we also need to make sure that all log entries that might not be UTF-8
> get first iconv() which is why probably Æevar mentioned[1]
> i18n.commitEncoding in his old email.

Having tested it, it seems this might work, but needs at least the
following to make the test for it meaningful:

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 1da6b07a57..e1fbdc0f80 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -47,6 +47,8 @@ test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
 '
 
 test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
+	GIT_COMMITTER_NAME="C O Mitter" &&
+	GIT_COMMITTER_EMAIL="committer@example.com" &&
 	git commit -m first &&
 	git log --format=%f -i -S"TILRAUN: HALLÓ HEIMUR!" >actual &&
 	echo first >expected &&
@@ -72,10 +74,10 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log --committer with an ascii pattern o
 	EOF
 	test_write_lines "fifth" >file5 &&
 	git add file5 &&
-	GIT_COMMITTER_NAME="Ç O Mîtter" &&
+	GIT_COMMITTER_NAME=$(echo "Ç O Mîtter" | iconv -t ISO-8859-1) &&
 	GIT_COMMITTER_EMAIL="committer@example.com" &&
 	git -c i18n.commitEncoding=latin1 commit -m thïrd &&
-	git -c i18n.logOutputEncoding=latin1 log -1 --pretty=fuller --color=always --perl-regexp --committer=" O.*" >log &&
+	git log -1 --pretty=fuller --color=always --perl-regexp --committer=" O.*" >log &&
 	grep Commit: log >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expected actual

The first hunk is a nice to have and mimics what is done in the previous
test where a non UTF match will match instead an equivalent ASCII text,
but is not strictly needed unless the expression is also tightened.

Note the second hunk is incomplete as the message is still not really
encoded as latin1 and will need an equivalent processing, but left it
out so it can be done together with fixing the corresponding test.

I have to admit that adding to a complex condition might be obscuring
some other edge case, and indeed the fact the test passed even without
this fix is concerning.

From my reading of what Ævar suggested originally[1], it would seem that
the new is_log condition should be on an branch of its own, and more code
should be needed to make sure the contents we are going to use are indeed
utf8 by the time it hits pcre2_*match() before setting it.

Carlo

[1] https://lore.kernel.org/git/211116.86tugcp8mg.gmgdl@evledraar.gmail.com/
