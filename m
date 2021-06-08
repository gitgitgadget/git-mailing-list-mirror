Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E5C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46776613AD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhFHWTE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Jun 2021 18:19:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:33534 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHWTD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 18:19:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 158MH2HK017030
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jun 2021 18:17:03 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>, <git@vger.kernel.org>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>
References: <20210608185855.668050-1-emilyshaffer@google.com> <20210608221059.1935021-1-emilyshaffer@google.com>
In-Reply-To: <20210608221059.1935021-1-emilyshaffer@google.com>
Subject: RE: [PATCH v5] tr2: log parent process name
Date:   Tue, 8 Jun 2021 18:16:57 -0400
Message-ID: <023201d75cb4$02006d10$06014730$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGAGyFWR3wFyr5KGh3bH3Y8Zz0L4qu5MISg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 8, 2021 6:11 PM, Emily Shaffer wrote:
>It can be useful to tell who invoked Git - was it invoked manually by a user via CLI or script? By an IDE?  In some cases - like 'repo' tool -
>we can influence the source code and set the GIT_TRACE2_PARENT_SID environment variable from the caller process. In 'repo''s case,
>that parent SID is manipulated to include the string "repo", which means we can positively identify when Git was invoked by 'repo' tool.
>However, identifying parents that way requires both that we know which tools invoke Git and that we have the ability to modify the source
>code of those tools. It cannot scale to keep up with the various IDEs and wrappers which use Git, most of which we don't know about.
>Learning which tools and wrappers invoke Git, and how, would give us insight to decide where to improve Git's usability and performance.
>
>Unfortunately, there's no cross-platform reliable way to gather the name of the parent process. If procfs is present, we can use that;
>otherwise we will need to discover the name another way. However, the process ID should be sufficient to look up the process name on
>most platforms, so that code may be shareable.
>
>Git for Windows gathers similar information and logs it as a "data_json"
>event. However, since "data_json" has a variable format, it is difficult to parse effectively in some languages; instead, let's pursue a
>dedicated "cmd_ancestry" event to record information about the ancestry of the current process and a consistent, parseable way.
>
>Git for Windows also gathers information about more than one generation of parent. In Linux further ancestry info can be gathered with
>procfs, but it's unwieldy to do so. In the interest of later moving Git for Windows ancestry logging to the 'cmd_ancestry' event, and in the
>interest of later adding more ancestry to the Linux implementation - or of adding this functionality to other platforms which have an
>easier time walking the process tree - let's make 'cmd_ancestry' accept an array of parentage.

We are probably going to have to discuss this one at more length. On NonStop, in some cases, I have access to the program arguments of the parent (rather like ps -ef) in POSIX-land, but not from the other personality. I do have access to the program object name, in both sides, although if someone replaces the object - which is not actually possible for a running program, but a rename is - the object may end up being somewhat meaningless or mangled. My suspicion is that I'm going to have to supply different things for the two personalities, but I'm not sure what as of yet.

Regards,
Randall

