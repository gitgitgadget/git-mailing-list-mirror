Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB7820960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbdDMTZc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:25:32 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33403 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdDMTZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:25:30 -0400
Received: by mail-pg0-f46.google.com with SMTP id x125so34748822pgb.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s50a5VXAfnAdlLv1wrw/Fkwn3C/o60Bfp8jbUW6YJzI=;
        b=NOuWYvh5xOVYh0sl8GMr8n/plzomUAUn6tU5pu7kxhxNaWe3MpDSKyQK8+/E2zV8bH
         MiXaFmJ8WbtHMjfJrIIlvRbdcwpNm4z5ETvZjs2ZZ76HSOfkmyc5uF1+VjiPYMUdrsq8
         7mmXyVtasmJELm5hG4W6SXmTsDq6xB7rgYj+BsoUWD9XJpqtJfGM+6n1FggoiAcW7pe6
         idT2EQWH62RkdiCTafTgUyg4Kr+5sKiqgnQiAHQy4W7wt6T3GxrmM5Z7QQ49it3atl7+
         ruzoN9kDCH5UrM15MSwnUn4mzqo9e6gCde2VJ3KyhMMrV4lZGqz2oxz7w7MaXb8lW4eg
         akhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s50a5VXAfnAdlLv1wrw/Fkwn3C/o60Bfp8jbUW6YJzI=;
        b=qIsCWS4ZJE/wbixMQE+IlGAuKJfIvTEWCicrMEXJwhpv0JA72283UIzZBj+U4LBPrA
         X4h2mm9GESigU3Ayf3cMt+uCYFyB3/6kJQb3dxcE4BcQh32Lre1MoWLlHGfS7Hvkpn2R
         0XP/Xn3+hom/FJ119ViWncZ5ZF8mStbJfgvZbtUqDL2V2iC+dV8DDXTpGb2XycQ1HKvY
         Jo/LmC9M6BTDokHR9l+8V7B3FXtXqZ+yRQrnme/8httIEGDxeNLfYnwRxfldkRFs24l2
         5f4rCjh8Tv7/Ak0GjX80a9hFOmh6rBZWVabwmZub2XmCwbBJHXdxpk7jhPM4jgqjY6xM
         lQxA==
X-Gm-Message-State: AN3rC/7bvdZZm+rcjlGsL/LPixoP0K3THuqXXDlCgQqd9rnemuh3gmkT
        Tcct/+FP/ZHS8cQJvL82k7wYqVJAj36CmCDSjg==
X-Received: by 10.98.9.29 with SMTP id e29mr4248654pfd.101.1492111529592; Thu,
 13 Apr 2017 12:25:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Thu, 13 Apr 2017 12:25:28 -0700 (PDT)
In-Reply-To: <CA+P7+xp=1PUsq1_or=J8ED+-1NMaF=BckC9bK4jqWbA+RFeszw@mail.gmail.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413185707.97746-1-bmwill@google.com> <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
 <CA+P7+xp=1PUsq1_or=J8ED+-1NMaF=BckC9bK4jqWbA+RFeszw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 12:25:28 -0700
Message-ID: <CAGZ79kaRTrgHMnP6mA3V2rDHzf8iOidqLTpp2aXmi6x+6YeZxw@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 12:12 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Apr 13, 2017 at 12:05 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, Apr 13, 2017 at 11:57 AM, Brandon Williams <bmwill@google.com> wrote:
>>> Add in a check to see if a submodule is active before attempting to
>>> recurse.  This prevents 'ls-files' from trying to operate on a submodule
>>> which may not exist in the working directory.
>>
>> What would currently happen on recursing into non-active submodules?
>> Can we have a test for this?
>>
>> Thanks,
>> Stefan
>
> We should be able to test for this. Is it possible that we can recurse
> into a submodule as long as we have the clone in .git/modules/<name>
> even if we don't have it checked out currently?

Conceptually that should be possible, e.g.

    git ls-files --recurse-submodules <ancient ref>

where the ancient ref contained submodules that are not present any more.
In that case we would need to do

    struct strbuf sb = STRBUF_INIT;
    struct child_process = CHILD_PROCESS_INIT;
    struct submodule *sub = submodule_from_path( \
        <path as recorded in ancient tree>, <ancient ref>)
    strbuf_git_path(&sb, "modules/%s", sub->name);

    argv_array_pushl(&cp.args, "git", "ls-files", "--recurse", ...);
    cp.dir = sb.buf;
    run_command(&cp);

Stefan
