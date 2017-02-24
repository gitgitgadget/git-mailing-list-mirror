Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBFCD2022D
	for <e@80x24.org>; Fri, 24 Feb 2017 06:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdBXGJC (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 01:09:02 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34903 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdBXGJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 01:09:00 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so1874118pgz.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 22:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/hzGCrxCg0PoPd9ZHmMODcp4p6XAkG018s86pb3NTGs=;
        b=HgBNBDpWO1jrNGeObCFdASxb2cP3EmyoS9PD1u+4QjsZR+TnpqIli+AI8u7N9kMCiG
         P511fMkzNuK7TC31ysEWYYGzlr+UPY++Sv1PGxUkXn2xGiqumN8Jv86BtW6XwX9nvc8Z
         qAdMw16cW/hruQCuCxoeaLE0t4h99dcqqcKbszbOZvG07eukzIir9pItTf6y6QKRZKbI
         jx2lZVMIjc1qs0D3/tnthVO5egA9dSrVGwbfCGDHE86d2JhMq2g3DMjXk+SQg9K8Z11v
         YQGcC/bOSC3tIeuiww/sEFxR0mPJrMmtBJVIYUYhMCsZ7UjgE2qFX6k9KmtBKocITkMq
         qJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/hzGCrxCg0PoPd9ZHmMODcp4p6XAkG018s86pb3NTGs=;
        b=IVL6iFqPfzATIwMNAXokuRogLHgkTRUR1AYRlRtBzHUlewNmCbjaRotpfCUhA+emIC
         tXh8rjnJUaL7IugGubK3L10JUHDty5b+lTavwi7bo5VAJB6NubcgJs9oVGjqvABUJQkf
         CQcFYnOCIhLQJ8Xj2QsYHqHZQlYtAVaTWCESaUVn+n7OoB6/TtS0Xc64geK5smszRa+Z
         cuWewPHW8tSQkmQdSdVCrRQwr8yXACj9gbu1ZQEuVurqH4F5DxFVcEcKzTRTI+zCNKYP
         +6s/Yu+MeA5tVn8znB4gXmqj25dZs9zeSB3O9Hff6XWl1LmibwZ1CntHmmd5VL4Uq8Xn
         /A7w==
X-Gm-Message-State: AMke39mcuIEcMRmSTIIMISte7c7C4yBUMUUZ6cGd0I+7815MTLQ3YqyXcp9PucttKI8Enw==
X-Received: by 10.84.241.138 with SMTP id b10mr1598728pll.32.1487916539776;
        Thu, 23 Feb 2017 22:08:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id q90sm12864488pfk.73.2017.02.23.22.08.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 22:08:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
References: <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
        <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
        <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
        <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
        <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com>
        <xmqqy3ww5wbl.fsf@gitster.mtv.corp.google.com>
        <20170224004105.ayddcwlnpmq7tifu@sigill.intra.peff.net>
        <xmqqh93k5ijb.fsf@gitster.mtv.corp.google.com>
        <20170224042227.2rjgf4zbiadxbrtz@sigill.intra.peff.net>
Date:   Thu, 23 Feb 2017 22:08:57 -0800
In-Reply-To: <20170224042227.2rjgf4zbiadxbrtz@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Feb 2017 23:22:27 -0500")
Message-ID: <xmqqd1e85ddy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Backtracking will not fundamentally "fix" parsing of
>> 
>> 	a.b=c=.d
>> 
>> between twhse two
>> 
>> 	[a "b="] c = ".d"
>> 	[a]      b = "c=.d"
>> 
>> unfortunately, I think.  I do not think it is worth doing the "best
>> effort" with erroring out when ambiguous, because there is no way
>> for the end user to disambiguate, unless we introduce a different
>> syntax, at which point we cannot use config_parse_key() anymore.
>
> Ah, yeah, you're right. I thought the problem was just that the "split"
> was too naive, but it really is that the whole syntax is badly
> specified.
>
> I guess "git config --list" suffers from the same problem. You can get
> around it there with "-z", but that probably would not be very pleasant
> here. :)
>
> Probably not worth worrying too much about if nobody is complaining.

Yup.

Anyway, here is an updated one (the part of the patch to t/ is not
shown as it is unchanged).

-- >8 --
Subject: [PATCH] config: use git_config_parse_key() in git_config_parse_parameter()

The parsing of one-shot assignments of configuration variables that
come from the command line historically was quite loose and allowed
anything to pass.  It also downcased everything in the variable name,
even a three-level <section>.<subsection>.<variable> name in which
the <subsection> part must be treated in a case sensitive manner.

Existing git_config_parse_key() helper is used to parse the variable
name that comes from the command line, i.e. "git config VAR VAL",
and handles these details correctly.  Replace the strbuf_tolower()
call in git_config_parse_parameter() with a call to it to correct
both issues.  git_config_parse_key() does a bit more things that are
not necessary for the purpose of this codepath (e.g. it allocates a
separate buffer to return the canonicalized variable name because it
takes a "const char *" input), but we are not in a performance-critical
codepath here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index b8cce1dffa..1c1a1520ff 100644
--- a/config.c
+++ b/config.c
@@ -295,7 +295,9 @@ int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
+	char *canonical_name;
 	struct strbuf **pair;
+	int ret;
 
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
@@ -313,13 +315,15 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	strbuf_tolower(pair[0]);
-	if (fn(pair[0]->buf, value, data) < 0) {
-		strbuf_list_free(pair);
-		return -1;
+
+	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL)) {
+		ret = -1;
+	} else {
+		ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
+		free(canonical_name);
 	}
 	strbuf_list_free(pair);
-	return 0;
+	return ret;
 }
 
 int git_config_from_parameters(config_fn_t fn, void *data)
-- 
2.12.0-rc2-308-gbf7e63c428

