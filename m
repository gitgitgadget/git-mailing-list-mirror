Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF1C0015E
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGUMlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGUMlp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:41:45 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8830C0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943296; x=1690548096; i=l.s.r@web.de;
 bh=2rC7uphEXcLP8sTX0TSqSTeFmLFLltYFi1YU7zKEyfg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FzNm3Pd7z30zz0S28uRSDkQQfB0HiKXmDqnqJvG9uaEK9QFWBXP6FlP8JMJmxeniLBWbP63
 RL+DKEYT8cleGb7w8+r5rP5RBcLf0lMbUxiDovBKckaOH/zB6GMzn7OMh+WNVWonc5kF8w6BN
 RpsI1QhDHo5U5n4yy4q8suQ2GnfW6CW21PXdqWaHdfdU0OH+XnW1C9RZ3d6DcAeLJ2qU3zYox
 NlSLUlzRw+aPdbJVr1GIwUbZ90hOGO5NTiplRnAPOvyK+Fk1bAi+L+xi8vbVTGLSv3iKBlY80
 aOIpbMRKVY3MhpUE9nzDNGB0fTWRNJ1YcRzJ83S+086Prs3+/vIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28WT-1qKtde3Zhh-002kC0; Fri, 21
 Jul 2023 14:41:35 +0200
Message-ID: <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
Date:   Fri, 21 Jul 2023 14:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ls-tree: fix --no-full-name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GghEm5tHs0H5H+TAsuhv705KKXldf0PNIPwyUCThyVWvRazJiB6
 EfR6/3+7rL8ZQB/leMG97HqJ8DMth9LEA/dVorNd2UzQn+lbyDk1lNH3Oooel4uJSsvoSLH
 RMF3/odnyKIcV1K2cCR+IJ7Xvt/TEZLWmJoRJHBeDkV6KUJbIGi404nzj1m33B/QGh5Y3X7
 sNylaOroXqkdhczMmATzw==
UI-OutboundReport: notjunk:1;M01:P0:Udmxh37lLg0=;XcazQBVo833mPeve16Gff0KBCPZ
 Dkoyf9S6Y7Fua4grmKqjo9KThBvFuVAirz3gUd1v0Et52iJInbj6RucTQ2y40FiZHYeKgYhIn
 UTbnAfPDXbfDYzh5c/oJuMANqZX45yff2aDaEdoDr0e1idBxdOaxqyh4HNc0EVLi9VEq0HZs4
 oFMkjgBQer+rdHZLUGK3JUVgXMOwG1oajjQqIs4/NTGbcSWE9l83cnCkJtlmNKy0HXcEVfjpx
 htPBYqjR7Rwh46kD/7KyaQz/LXfIpn7jXJEY1wWc46/ek/cIkhcdKMNlV+ALalfZ8AYETBwFS
 6Jkja1L4jM/ZJCPjd3Vpr2Cv5oudVurj356jHsnn78BfdHL48rKxbVKf6QzG+bcllIQutwnOP
 bQa3N+RCb8uaPwezTf6zOeLjN0xnQPoq7UBLKAFArwb80BzO8GJUDSLTq9IDG0bpJ/oi9O+Cx
 wtiz0/kINW0Zb/NtWWBcWwQxbJqBkLnPwNAY77VmZR57/w72GiRuGJz/2Zkj/N8C2adm67Wow
 WlFad3VreNvVM+aNDatGVWlqtOlHcPaa5dYTa9f3AsrXTwLGClTmQ9a+zF/pg/r9HkhH2pj7G
 zXOb3XuOHnCy2EvCS6gZnWCEWtaodkMHuybQKYNnA0Dzx7gLZyMzzxpQmfcRrhv8/nIEn2HcI
 72ja3A6shgupDKNTlAzKYGQv42pr6zXXrdvi3DKmLjlNQaD+vd8HHo4/dSKjYXwjFbzlsLuN8
 dJEzSDRDavwOw6dLVSi2HYwY1Ajcam1Ykp+nBGA7rboRF/Kdl0tzeXkLfmeQRhgUHpc/pi5Fw
 +a1SGM6uftPBSVAjfgvhqvIoy24qL9Ebm4JI5YsmcMGm1e/XrSLewKuFnKTBAqux7ChPiWliM
 bnnOejARPURfiilZZ7dMBRFqTEBK9OjUa9xoN1DW0GGLyzg239xUzbVNc/UgJ80HBSaNDoIki
 Dy2fQdw5AKQMSDjvLusAgcxtaak=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.07.23 um 18:37 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> I wonder if there are cases where it makes sense to allow the
> "--no-" variant to an option parsed with OPT_SET_INT() that sets '0'
> as the value?

I doubt it.

> Some random findings while reading hits from "git grep OPT_SET_INT":

Woah, so many!

>  * "git branch --list --no-all" is accepted, sets filter.kind to 0,
>    and triggers "fatal: filter_refs: invalid type".  Shouldn't we
>    detect error much earlier?

Yes.  And "git branch --no-copy" etc. are funny as well.

>  * "git bundle create --no-quiet" is accepted and sets the progress
>    variable to 0, just like "--quiet" does, which is the same issue
>    as the one fixed by your patch.

The same in pack-objects.  It's a bit trickier because of the presence
of a third state (--quiet, --progress and --all-progress).  The help
text changes of 8b95521edb (bundle: turn on --all-progress-implied by
default, 2023-03-04) state that only two states remain in git bundle
(--quiet and --all-progress), but that's not fully true because the
option --all-progress-implied is still wired up.  "git bundle
=2D-no-all-progress-implied --progress" still gives git pack-objects a
lone --progress.

>  * "git clone (--no-ipv4|--no-ipv6)" are accepted and uses
>    TRANSPORT_FAMILY_ALL, presumably allowing both v4 and v6.
>    Shouldn't we reject these?  "fetch" and "push" share the same
>    issue.

Either that, or we could turn them into OPT_BITs and let --no-ipv6
mean "give me anything but IPv6", which currently happens to be
the same as --ipv4..

>  * "git remote add" has an OPT_SET_INT() entry whose short and long
>    forms are (0, NULL).  What is this supposed to do?  Shouldn't
>    parse-options.c:parse_options_check() notice it as an error?

It extends the help text of the previous option.  Horrible.

>  * "git stash push --no-all" is the same as "--no-include-untracked",
>    which smells iffy but probably is OK.

Hard to imagine a situation where a --no-all would be well-defined
and intuitive.

Overall I get the impression that having the negative form enabled by
default was not a good idea.  For boolean options it makes sense, for
options with arguments perhaps as well, but for OPT_SET_INT we would
have less confusion if the negated form was opt-in.

To make it easier discoverable we could let the short help include
the optional "no-" part, which would look like this:

usage: git ls-tree [<options>] <tree-ish> [<path>...]

    -d                    only show trees
    -r                    recurse into subtrees
    -t                    show trees when recursing
    -z                    terminate entries with NUL byte
    -l, --long            include object size
    --name-only           list only filenames
    --name-status         list only filenames
    --object-only         list only objects
    --[no-]full-name      use full path names
    --[no-]full-tree      list entire tree; not just current directory (im=
plies --full-name)
    --format <format>     format to use for the output
    --[no-]abbrev[=3D<n>]   use <n> digits to display object names

Thoughts?

Ren=C3=A9
