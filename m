Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63A7C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D6720748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE/9Eq1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHUSzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgHUSyH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1ADC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:54:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i13so608768pjv.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1JgqUg/FbM6JkTTAH+dkTnIII6Yu4m8YZ5pz0mcRRbQ=;
        b=FE/9Eq1NPKDFVTS7KfZffkba5280524vmkCbeSANAfFTC+QnICoimSd0Fd30ooMRG8
         CpjSLnTqwMZQiiS/byD209PrD1/JLQvnjsBT+jR+5Tuq/tyXVPpOoWt9vnWiAElbvmM1
         B9nRkkRMClEBlFkbnkRalkAazgIPPRuHtHcuInMGWwuxBeUB2grGpf4QCUdnJG3uvgCD
         rmIOieu4x2AtW6QrixL7RH8Og8HcHzPcrAlXs1VAWWLaAT1VWAlEadOT0YRXcF09ILUO
         6HMXe04VgzTIXoRLjy5sR8rxddu0winD/s9MwlX925ShQMhFCC+C6YwCIBVV/kmyP/N2
         JWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1JgqUg/FbM6JkTTAH+dkTnIII6Yu4m8YZ5pz0mcRRbQ=;
        b=aqBPJA6YNRVb+NecH80A06zRlc4X8h+WYtEHTo+0J5afN1vpedq3CiTIyl7hbSB8pO
         O+wSUDbamJvoBarUkw8kP0TqaIagfCjwLlinp23qsfrrS0cGgHZzX17/QcGU6krC+M6v
         m6uIaasi2Pypd17gqT1QSIShyCqF4F0xqGck1XzqU+3MG9I7FeMMsYhAqJmyM+yXhTph
         9MpkACiu5TDZpmm2OV0F11RwmxQLpbHSmhLAX6mHr0N/Q/+FCnqY8GpsmeEvXrtt/2Xw
         K6DKN1Xf+wF2IdRXOCT/k1yLwFWrgvAcBrVkag14dAw/W+HI1+1s3cvt8fdvhu84L3F3
         PSHQ==
X-Gm-Message-State: AOAM532XM76XDHu2P8KMsDz5riP98rnsiarLcRbP2ce/oUx9OtjIhvsF
        WepxwI9ebrGDEeitMrsMQiQ=
X-Google-Smtp-Source: ABdhPJwKEdDIThxbUbiBKjYEkElp7zMwr/xHYuVktCqDWTQ89nT5pmxKR5JWBuj1vkO/HnbqomvCgQ==
X-Received: by 2002:a17:902:ba8f:: with SMTP id k15mr3512644pls.79.1598036046709;
        Fri, 21 Aug 2020 11:54:06 -0700 (PDT)
Received: from lwitch-pc ([49.207.134.55])
        by smtp.gmail.com with ESMTPSA id m29sm2885471pgc.55.2020.08.21.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:06 -0700 (PDT)
Message-ID: <377b1a2ad60c5ca30864f48c5921ff89b5aca65b.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Date:   Sat, 22 Aug 2020 00:24:01 +0530
In-Reply-To: <xmqq5z9ban27.fsf@gitster.c.googlers.com>
References: <20200821171705.GA16484@konoha>
         <xmqq5z9ban27.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-08-21 at 11:09 -0700, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > > I think a test that relies on platform-specific error string is a
> > > bug.  It's like expecting an exact string out of strerror(),
> > > which
> > > we had to fix a few times.
> > > So I am not sure we would want to butcher compat/mingw.c only to
> > > match such an expectation by a (buggy) test.
> > 
> > Alright. That is understandable. What alternative do you suggest?
> > Should
> > we change the check in the test?
> 
> A buggy check should of course be changed.
> 
> It should be sufficient to ensure "git submodule summary" fails,
> regardless of what exact error message it issues, no?
> 

Unfortunately, we can't do that here. See below.

> If the command does not exit with non-zero exit status, when it
> gives a "fatal" error message, that may indicate another bug,
> though.

Here's the error message with context of the trash directory of that
test:

-- 8< --
$ cd t
$ ./t7421-submodule-summary-add.sh  -d
$ cd trash\ directory.t7421-submodule-summary-add/

$ git submodule summary HEAD^^
fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
* my-subm 35b40f1...0000000:

* subm 0000000...dbd5fc8 (2):
  > add file2

-- >8 --

That 'fatal' is a consequence of spawning a process in
`verify_submodule_committish` of `builtin/submodule--helper.c` even for
non-existent submodules. I don't think that 'fatal: ' message is giving
any useful information here. The fact that submodule 'my-subm' doesn't
exist can easily be inferred just by looking at the destination mode
(0000000). If anything that 'fatal' message is just confusing and
unnecessary, IMO.

So, we could easily suppress it by doing something like this (while
also fixing the test):

-- 8< --
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 63ea39025d..d45be7fbdf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -972,7 +972,7 @@ static char* verify_submodule_committish(const char *sm_path,
        strvec_pushf(&cp_rev_parse.args, "%s^0", committish);
        strvec_push(&cp_rev_parse.args, "--");
 
-       if (capture_command(&cp_rev_parse, &result, 0))
+       if (!is_directory(sm_path) || capture_command(&cp_rev_parse, &result, 0))
                return NULL;
 
        strbuf_trim_trailing_newline(&result);
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
index 59a9b00467..8a2c2b38b6 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -58,7 +58,6 @@ test_expect_success 'submodule summary output for submodules with changed paths'
        git commit -m "change submodule path" &&
        rev=$(git -C sm rev-parse --short HEAD^) &&
        git submodule summary HEAD^^ -- my-subm >actual 2>err &&
-       grep "fatal:.*my-subm" err &&
        cat >expected <<-EOF &&
        * my-subm ${rev}...0000000:
 
-- >8 --

BTW, I noted that `print_submodule_summary` has the following
definition:

   static void print_submodule_summary(struct summary_cb *info, char* errmsg
   				    ...

Note how '*' is placed near 'char' for 'errmsg' with an incorrect style. Ditto
for the return type of `verify_submodule_committish`. This might make
for a nice cleanup patch.

-- 
Sivaraam


