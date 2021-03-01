Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4053BC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4C064E46
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhCAIKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:10:15 -0500
Received: from gate3.osm-gmbh.de ([194.77.68.107]:53497 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhCAIKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:10:10 -0500
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id F32DB3C088;
        Mon,  1 Mar 2021 09:08:31 +0100 (CET)
Received: from pcmn.osm-gmbh.de (pcmn.osm-gmbh.de [193.101.76.39])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id D807F3DC01E;
        Mon,  1 Mar 2021 09:08:31 +0100 (CET)
Date:   Mon, 1 Mar 2021 09:08:31 +0100 (CET)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
Sender: martin@pcmn.osm-gmbh.de
Reply-To: Martin Nicolay <m.nicolay@osm-ag.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Martin Nicolay <m.nicolay@osm-ag.de>, git@vger.kernel.org
Subject: Re: bug: setting GIT_DIR to $(git rev-parse --git-dir) changes
 behavior
Message-ID: <alpine.LSU.2.20.2103010847410.20742@cpza.bfz-tzou.qr>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
X-Virus-Scanned: by "The Virus" itself
X-Mailer: Pine 4.63
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 2021-02-27 22:06, Junio C Hamano wrote:
> Martin Nicolay <m.nicolay@osm-ag.de> writes:
>> *facepalm* The part about GIT_DIR setting the work-tree in addition to
>>  the repository I hadn't read. How embarrasing.
>>
>> I apoligize for my bad reading skills and wasting you time.
>
> We would love to hear observations on which part of the
> documentation was misleading and suggestions on how to make it
> harder to misinterpret it.

There are multiple explanations regarding $DIR_DIR or --git-dir.

From git(1) two parts:

1)
        --git-dir=<path>
            Set the path to the repository (".git" directory). This can also be
            controlled by setting the GIT_DIR environment variable. It can be
            an absolute path or relative path to current working directory.

            Specifying the location of the ".git" directory using this option
            (or GIT_DIR environment variable) turns off the repository
            discovery that tries to find a directory with ".git" subdirectory
            (which is how the repository and the top-level of the working tree
            are discovered), and tells Git that you are at the top level of the
            working tree. If you are not at the top-level directory of the
            working tree, you should tell Git where the top-level of the
            working tree is, with the --work-tree=<path> option (or
            GIT_WORK_TREE environment variable)

2)
        GIT_DIR
            If the GIT_DIR environment variable is set then it specifies a path
            to use instead of the default .git for the base of the repository.
            The --git-dir command-line option also sets this value.

The first part mentions the dual effect of setting git-dir, the second 
not so.

As I had used GIT_DIR described in the second part, I feel vindicated ;-)
Hooray, instead of a software-bug I've found a documentation-bug.

My suggestion is to ammend the first sentence to something like "If the 
GIT_DIR environment variable is set then it specifies a path to use 
instead of the default .git for the base of the repository and also the 
top-level directory of the working tree."
