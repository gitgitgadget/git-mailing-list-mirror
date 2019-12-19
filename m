Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D70FC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 00:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DF9222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 00:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSk4HU0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLSAMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:12:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45934 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfLSAMs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 19:12:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so3155637qkl.12
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=6skFB/LcIbe4F4YacfpSJfGYD0lztlPjYuizKw7K8ro=;
        b=kSk4HU0/iFLOXD6vYcDFaOvvrRVo+86shaaXZ/5BEcdjha/bPqfD6xAgDVFBpupkgb
         p4kody6uXpdavgac0MpthNZf7jjdp4HeFbNy3KFSZp2yFk4LK94JGwG56g0oKy4FZyfr
         iNAll6+qNITsBWMEsnXWbjhlmuPfqR0xUSNVnmNbQOXds+iWLb5a9k2ofYHFtBNnnznN
         aAorXaUVq9F2s/pDXX1ZnKn6FjW7pM2OdYIY2AIWdorD4zNoEMBxjs6Ik7EYuTNvhoEA
         jCbqjj5ROQZckTFxzd4U7xn75ganswM8ih3fffPvdvYcgV5sFH5wPy3LhKVJ/9HRt2lp
         Oxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=6skFB/LcIbe4F4YacfpSJfGYD0lztlPjYuizKw7K8ro=;
        b=halvsNQL/pbRg2ppkbHxiFf24+iyASPvEYzUP81I+Ui8SC1JqlwPX7Yh3MrKN8aDOI
         AIxmf0N8vk9IqhM/BjqVcOygS1IzCJKR7RbCMTmUee30xjpuni37HhW8JRzDajKvjo9v
         GKlE0LLIXWwhOH6q3MPkubEVOTzrSOpIss7WDj62rVln+VFhVamRBT35OUSni6KO9M1S
         uNOvVkqRfW5IeZBstD4qi/Vpao7IAndNaoa+MtNkm8TPt6jrHTVTtvUui9zx82qOvGot
         3WXx9Qrm9Vn6yn67X0abtq03Ohc2nE8uLiYgTbHO9r/ooyE2oZB/1AkT6ckUqBBRNjvR
         Yj1w==
X-Gm-Message-State: APjAAAUbb9pfZ/7UL5xrDcfV6JPfNuyYJvJZz0KZSj5kyfbcQfALjzzf
        1H5GHxR8zjNm+qqjlFl6ZO9hPOQaJR8=
X-Google-Smtp-Source: APXvYqw8H3/pRwmCuViJhwd8XxcbFwbubnv/fxhsM1SVO2+vF+IsOp+zaZKj158SiEiO7JsDPVELVw==
X-Received: by 2002:a37:a70b:: with SMTP id q11mr5442566qke.393.1576714367406;
        Wed, 18 Dec 2019 16:12:47 -0800 (PST)
Received: from DESKTOPCTCSEL8 (ool-44c0afa6.dyn.optonline.net. [68.192.175.166])
        by smtp.gmail.com with ESMTPSA id o187sm1197855qkf.26.2019.12.18.16.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 16:12:46 -0800 (PST)
From:   <mattr94@gmail.com>
To:     "'Philip Oakley'" <philipoakley@iee.email>,
        "'Matthew Rogers via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com> <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com> <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email>
In-Reply-To: <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email>
Subject: RE: [PATCH 1/1] config: allow user to know scope of config options
Date:   Wed, 18 Dec 2019 19:12:44 -0500
Message-ID: <03b001d5b601$09b950e0$1d2bf2a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI3Ms5TF/MsGXmA5zsV0lPqpVawTQF1OABfAp3kd6mm3PrMYA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

>These are correct changes, but is unrelated noise in the context of
>the theme of the patch, no?

I think that's the case, would the recommended course of action be to
move these changes into its own commit? 


>> +     if (use_local_config || scope == CONFIG_SCOPE_REPO) {
>> +             return "local";
>> +     } else if (use_global_config || scope == CONFIG_SCOPE_GLOBAL) {
>> +             return "global";
>> +     } else if (use_system_config || scope == CONFIG_SCOPE_SYSTEM) {
>> +             return "system";
>
>The above is slightly tricky; --global/--system/--local are made
>mutually exclusive in the higher level, so if any of them is set,
>we do not even need to look at the "scope" to tell what kind of
>source we are reading from.

So the way I structured these was to mirror the way other parts 
of this file check if we should be doing a --local, etc. and mirrored 
that here.  This could definitely be cleaned up if we change the behavior
with how --local, etc. set the current_config_scope.


>> +     } else if (given_config_source.use_stdin ||
>> +             given_config_source.blob ||
>> +             given_config_source.file ||
>> +             scope == CONFIG_SCOPE_CMDLINE) {
>> +             return "command line";
>
>I am not sure what the implication of saying "they came from the
>command line" when we read from the standard input or from a blob.

I agree with you here, I only put this as "command line" 
because they came from a place that was ultimately fed in from 
command line options (--file/--blob).  I wouldn't have a problem with 
calling them out as their own scope ("file", "blob", "stdin").


>> +     } else {
>> +             return "unknown";
>> +     }
>> +}
>
>In any case, the need for such logic that says "scope might not say
>it is REPO, but when use_local_config is true, we are doing a local
>config" implies that "scope" parameter the caller of this function
>has is not set correctly when these options are used---would that be
>the real bug that needs fixing, rather than getting "worked around"
>with a code like this?
>
>It almost makes me point fingers at config.c::config_with_options()
>where config_source is inspected and git_config_from_*() helpers are
>called without setting the current_parsing_scope.  Unlike these
>cases, when do_git_config_sequence() is called from that function,
>the scope is recorded in the variable before each standard config
>source file is opened and read.  What would we be breaking if we
>taught the function to set the current_parsing_scope variable
>correctly even when reading from the config_source?  That would
>certainly simplify this function quite a lot, but if the other parts
>of the codebase relies on the current behaviour, we cannot make such
>a change lightly.

From what I can tell from a cursory glance. the only two clients of 
this function are remote.c and upload-pack.c.  The usecase for remote.c
 mostly seems to be to determine the result of `remote_is_configured()`
which (more importantly) seems to be done when that iterates through 
the relevant configuration options.  Similarly for upload-pack.c.

I don't think it would be harmful for git config --local, etc. to set that
as we would normally intuit.


>> +static void show_config_scope(struct strbuf *buf)
>> +{
>> +     const char term = end_nul ? '\0' : '\t';
>> +     const char *scope = scope_to_string(current_config_scope());
>> +
>> +     strbuf_addch(buf, '(');
>> +     if (end_nul)
>> +             strbuf_addstr(buf, N_(scope));
>> +     else
>> +             quote_c_style(scope, buf, NULL, 0);
>
>Isn't this overkill?  I think this code was copied-and-pasted from
>the other function that needs to show an arbitrary end-user supplied
>data which is a pathname, so it makes perfect sense to use c-style
>quoting, but the token scope_to_string() returns is taken from a
>bounded set that doesn't require such quoting, no?

Yeah, I guess that is a copy+paste mistake.  I don't think its 
necessary since we control the input into this function, So I'll fix 
that.


Philip,

>Doesn't this also need a man page update as well for adding the option
>to the synopsis.
>
>The commit message doesn't fully highlight that the config list will
>often be all the users config values, so each value will be
>disambiguated/identified as to it's origin.

I'm agreed on these. So I'll look to readjust that.

