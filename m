Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF6E20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755683AbdDMSbc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:31:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36832 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755136AbdDMSba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:31:30 -0400
Received: by mail-lf0-f65.google.com with SMTP id 75so7811889lfs.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Utf+4RuMkbC/QT0qDj2bHFpAhha5ieQEoHMA4tujMfg=;
        b=Due+wA+/J/Qalu9WO+WU7tRSJGRWZwfcA+gqRQ+WkmesaFH3ilGLXyzUcpCBnKO8Iz
         FHEYaTRGQk8olVy1Jxs04aC+2DPRMzrBJi/OjtJ+RPjwWIBLv0lA9O05jEba0XheIBNX
         pdy77TQXgbkgdKayQi8KpwaS7J4Od01G4n01yawb+9unEKULlp61fjsiu2ErJh95DlbO
         vEUbuvYLDvHp+eI2vCBOJosF5p9+yzwrF9Zrurq7llTHlis2y46Ffaj4XGdecdfZV5DD
         osHgaclwGbAGED9GjFHuo0r7c+bnPZusDGJWtXTTirW4wDvfxGcPxKlcNyoBfvW5dSk6
         5jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Utf+4RuMkbC/QT0qDj2bHFpAhha5ieQEoHMA4tujMfg=;
        b=CcrX6rK+MucdPSMTh8/yMahh3LcouO3LUJMgUJiQIAItzyMq2XJt20NYDXuWn3zrsR
         B6Z0r2G0e3xl48eyvnfQiwxJcwer6ApxhLrgddnO6gpu2tCPva7XFVfR02t0UeDKUx4Z
         l5fNbkjefW9+ItTI/35ynITnQJGbrBJbyUm38P0pfCkNs34fJ+bPRUP13wTFuwXJOfya
         ZYuja0D8EJRaoap6SIbgKny88Mv+fCjzoAbHGJJ5VrQzOu2MOz2nU6H6eufB6iFnAC8b
         AYDFnEQyaNMnXCLK4y0r23l1aZWGgY02QxJY/ESR1NmIMfOVNIr7qAQsUIHS6ZDJUegz
         qmUA==
X-Gm-Message-State: AN3rC/7p326lfGdVfJmKxLxnlRTtJnhYCO5sDWhUOJ5dQHHdBSuOtyCK
        0uXnT7TSRuCbfjjqT1SfDYn9jH83dg==
X-Received: by 10.25.163.193 with SMTP id m184mr1589876lfe.114.1492108283961;
 Thu, 13 Apr 2017 11:31:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 11:31:03 -0700 (PDT)
In-Reply-To: <20170413180357.GA96917@google.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com> <20170413180357.GA96917@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 11:31:03 -0700
Message-ID: <CA+P7+xr6zkb4kLTM-+0f5OTtt583WR_0j=NEebOdYuO3Z6h1+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ls-files: fix recurse-submodules with nested submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 11:03 AM, Brandon Williams <bmwill@google.com> wrote:
> On 04/13, Jacob Keller wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Since commit e77aa336f116 ("ls-files: optionally recurse into
>> submodules", 2016-10-07) ls-files has known how to recurse into
>> submodules when displaying files.
>>
>> Unfortunately this fails for certain cases, including when nesting more
>> than one submodule, called from within a submodule that itself has
>> submodules, or when the GIT_DIR environemnt variable is set.
>>
>> Prior to commit b58a68c1c187 ("setup: allow for prefix to be passed to
>> git commands", 2017-03-17) this resulted in an error indicating that
>> --prefix and --super-prefix were incompatible.
>>
>> After this commit, instead, the process loops forever with a GIT_DIR set
>> to the parent and continuously reads the parent submodule files and
>> recursing forever.
>>
>> Fix this by preparing the environment properly for submodules when
>> setting up the child process. This is similar to how other commands such
>> as grep behave.
>>
>> This was not caught by the original tests because the scenario is
>> avoided if the submodules are created separately and not stored as the
>> standard method of putting the submodule git directory under
>> .git/modules/<name>. We can update the test to show the failure by the
>> addition of "git submodule absorbgitdirs" to the test case. However,
>> note that this new test would run forever without the necessary fix in
>> this patch.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>
> This looks good to me.  Thanks again for catching this.  Dealing with
> submodules definitely isn't easy (I seem to have made a lot of mistakes
> that have been cropping up recently)...it would be easier if we didn't
> have to spin out a process for each submodule but that's not the world
> we live in today :)
>

Spinning out a process is one of the big downsides of working with
submodules in our code. Unfortunately, spinning out a process is also
one of the biggest ways we isolate submodules, and if we wanted to do
this "in-process" we would need to add an abstraction layer that lets
us handle submodules in-process in some clean way.
