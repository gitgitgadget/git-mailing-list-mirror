Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852721F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbdLMP6G (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:58:06 -0500
Received: from siwi.pair.com ([209.68.5.199]:38846 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753505AbdLMP6E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:58:04 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B4E16844F2;
        Wed, 13 Dec 2017 10:58:03 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5673E844F0;
        Wed, 13 Dec 2017 10:58:03 -0500 (EST)
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
To:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3Jt+0Lq9Yx_7x3sJD+jG+A25bAgDg7zp+dZV43+1-vow@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <329228e6-bad0-3685-1110-635da044e11b@jeffhostetler.com>
Date:   Wed, 13 Dec 2017 10:58:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3Jt+0Lq9Yx_7x3sJD+jG+A25bAgDg7zp+dZV43+1-vow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/12/2017 4:30 AM, Christian Couder wrote:
> On Thu, Dec 7, 2017 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * jh/object-filtering (2017-12-05) 9 commits
>>    (merged to 'next' on 2017-12-05 at 3a56b51085)
>>   + rev-list: support --no-filter argument
>>   + list-objects-filter-options: support --no-filter
>>   + list-objects-filter-options: fix 'keword' typo in comment
>>    (merged to 'next' on 2017-11-27 at e5008c3b28)
>>   + pack-objects: add list-objects filtering
>>   + rev-list: add list-objects filtering support
>>   + list-objects: filter objects in traverse_commit_list
>>   + oidset: add iterator methods to oidset
>>   + oidmap: add oidmap iterator methods
>>   + dir: allow exclusions from blob in addition to file
>>   (this branch is used by jh/fsck-promisors and jh/partial-clone.)
>>
>>   In preparation for implementing narrow/partial clone, the object
>>   walking machinery has been taught a way to tell it to "filter" some
>>   objects from enumeration.
>>
>>
>> * jh/fsck-promisors (2017-12-05) 12 commits
>>   - gc: do not repack promisor packfiles
>>   - rev-list: support termination at promisor objects
>>   - fixup: sha1_file: add TODO
>>   - fixup: sha1_file: convert gotos to break/continue
>>   - sha1_file: support lazily fetching missing objects
>>   - introduce fetch-object: fetch one promisor object
>>   - index-pack: refactor writing of .keep files
>>   - fsck: support promisor objects as CLI argument
>>   - fsck: support referenced promisor objects
>>   - fsck: support refs pointing to promisor objects
>>   - fsck: introduce partialclone extension
>>   - extension.partialclone: introduce partial clone extension
>>   (this branch is used by jh/partial-clone; uses jh/object-filtering.)
>>
>>   In preparation for implementing narrow/partial clone, the machinery
>>   for checking object connectivity used by gc and fsck has been
>>   taught that a missing object is OK when it is referenced by a
>>   packfile specially marked as coming from trusted repository that
>>   promises to make them available on-demand and lazily.
> 
> I am currently working on integrating this series with my external odb
> series (https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/).
> 
> Instead of using an "extension.partialclone" config variable, an odb
> will be configured like using an "odb.<odbname>.promisorRemote" (the
> name might still change) config variable. Other odbs could still be
> configured using "odb.<odbname>.scriptCommand" and
> "odb.<odbname>.subprocessCommand".
> 
> The current work is still very much WIP and some tests fail, but you
> can take a look there:
> 
> https://github.com/chriscool/git/tree/gl-promisor-external-odb440
> 

In our current V6 patch series, Jonathan Tan and I are using the
extension.partialclone config variable for 2 purposes.  First, to
indicate a change in the repository format and stop non-aware clients
(older versions of git.exe) from operating on the repo -- since they
won't know how to handle missing objects.   Second, to name the remote
to help the client later demand load missing objects.  This is a current
limitation (we only support one promisor remote), so this second usage
may change.  I haven't had time to look at your branch yet, so I can't
comment on how it might help/solve our second usage, but we do need to
keep the first usage in mind.

Jeff
