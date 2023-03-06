Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2093C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 19:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCFTA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCFTA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 14:00:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA52F791
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:59:59 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b20so6505800pfo.6
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678129191;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nn5EXt62BRgF3ASNKQO1QeGbNNJDVOZzm/j/Pi8l/qg=;
        b=XKZm1boKC4nTDB+udfBjk8wQmYryZ36g3+wTeCDBCZd55jHSJKbTqCjB6auOOQAute
         7PIeoEqojHDPD1RwgQpCgtY51Uqt0w/P6Ms6aCm4Uy7qqECMZafKsyTxXjapHxtqIXXr
         znsReH4u3IqLMNuRFLLYm57kHLcE118LWa+Wg37kOcgh6clyxH68/7nxmxWxUptjkSGn
         Nn4zDWvyeitwCNanjIZ7Jv7v14kfy+ki7zp2q7mWzPGlww91do85Ozx2R4YkO3SZvwAW
         yXEHq2+21+B99ZsSkSHenhB9jPzXMwqAM/xwvo4+EcWemad8TyJnpmCqzq6d8dqd179k
         eTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678129191;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn5EXt62BRgF3ASNKQO1QeGbNNJDVOZzm/j/Pi8l/qg=;
        b=vty50LXfD9xjhwJsz5uiHXKpSv/KQAzA/xNXKTqDT7n9JggAiTGUtHDVswaoOnyN1f
         YfQpt1kERfQ/DMQphxKHXgz6hba/MxM9ZKgC9IVeeyYFAxDvVFrhS8P+fH0KZ479fHy6
         w77vtlKI2KDZYVOwq+cOtc3lhlRbVIdqxL0ogA35aYBEEtzvSkiHTUmp1UZNMlzb0Jsx
         ljlI/M1mOI/VIOnpbMpnZwNwUiFHS/J5dSuFFmGJSFJ/UL4kA8EbFZ20MW6iX1pz4oUp
         w0MJpxQleTJ0xl0UwIqVTt4ingnDnhHebyY0oOy+3jqRbTAB8mdL7s90H0GmDg3dBH7O
         f9FA==
X-Gm-Message-State: AO0yUKVRegzVhwLGRH5j50f7RzHRM0w65y5QG/8ziya/pBOOB1L1jpGY
        wCUO27EleC6GUuwRjBGcPCY=
X-Google-Smtp-Source: AK7set9PAs47AxOdWwxaCENY3tTGJDsHcvLWoF5BdpSTUmNbHaSrqCQ2fpNvHsqjfT1rx8UKSAaj4Q==
X-Received: by 2002:aa7:970f:0:b0:5d4:e4c8:2ef5 with SMTP id a15-20020aa7970f000000b005d4e4c82ef5mr11112887pfg.33.1678129191404;
        Mon, 06 Mar 2023 10:59:51 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79398000000b0056be1581126sm6821614pfe.143.2023.03.06.10.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:59:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
Subject: Re: Bug in git archive + .gitattributes + relative path
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
        <xmqqcz5lbxiq.fsf@gitster.g>
        <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de>
Date:   Mon, 06 Mar 2023 10:59:50 -0800
In-Reply-To: <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 6 Mar 2023 19:28:02 +0100")
Message-ID: <xmqqo7p59049.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> Another way I am not sure is working as designed is
>>
>>     $ cd sha1dc && git archive HEAD . | tar tf -
>>     .gitattributes
>>     LICENSE.txt
>>     sha1.c
>>     sha1.h
>>     ubc_check.c
>>     ubc_check.hq
>>
>> I didn't check if the attribute look-up is done on the correct path
>> or export-subst kicks in in such a use, though.
>
> export-subst is supported in that invocation because git archive has a
> commit to work with.
>
> I can kinda see others preferring the directory prefix "sha1dc/" added
> to those entries.  Perhaps it depends on what git archive is supposed to
> archive: A commit or the files of a commit?  I'm in the latter camp, and
> expect to see the same paths as given by git ls-files or git ls-tree.
>
> But that invocation in a sub-directory probably has the same problem
> with attributes as the one with a sub-tree above it, i.e. that
> attributes are always looked up relative to the repository root.  I
> wonder if 47cfc9bd7d (attr: add flag `--source` to work with tree-ish,
> 2023-01-14) provided the means to fix this when it added a tree_oid
> parameter to git_check_attr().

It somehow feels that the use of pathspec in "git archive" is
somewhat iffy, e.g.

   $ cd sha1dc && git archive HEAD :/ | tar tf -

does not compare very well with

   $ cd sha1dc && git ls-tree -r HEAD :/

For that matter, replacing ":/" (full tree) with ".." (we know one
level above is the root of the working tree) has the same "why don't
they work the same way???" confusion.

