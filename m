Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA71C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCFS2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCFS2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 13:28:37 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F4239CC8
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1678127283; i=l.s.r@web.de;
        bh=qIXI8K6KwOCO2uoKVig+uPoTHrGO7v/LLqpIZVRKmjU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=idJ7ANMvw7Q3tf0yuZiwxZ0e80bOPt6FmaFOzAxrvTaS0Z8Xe0+4u46FpGv2BzA2Y
         6PfE8iWXt/c3f0MvRE4sDqan86cfRyoBeOrJ2GYNBCV139XYM8li41nHNQOphgKnHd
         H+1VkWB9d4D7A0V3qlSrr16EvA5iYeA/wj4IzWAf9/GAJbHhYTvghDXs9Mqnd9Cccq
         jGwS5kAxK7gI3wUVLN56dtMVgZbONUGHaiuLiG34kJ0opCFvRdzWucZRCfoRwBdXH3
         Ws4fBp1UfOyTnN4OjWBrrUfeS/rJAKTiIPoUXqtZJj5+xnnU41wFUYs7dr8lp3QLnY
         0rUgn25kQbAVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.151]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vRY-1qXvDr0nbg-0117b7; Mon, 06
 Mar 2023 19:28:03 +0100
Message-ID: <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de>
Date:   Mon, 6 Mar 2023 19:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: Bug in git archive + .gitattributes + relative path
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> <xmqqcz5lbxiq.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqcz5lbxiq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gXK2L2xuFR9eGjKkzP3JVzbS2tPm8fUputFAHPv8spJB9gZbNYM
 y8UWNyYAFDhymyWI3nVod/BL3HnvqRyipmQvlBKEXju/gkuz1LbizeSvVjNZ0dk4E+YXmfD
 7Hg7kBd+fqDl63c+rmqHhfFIdod+fF+D/U6Lk/aeaGTv93SQczQgafR621z/hRSyJC2tOHy
 C3x8A7Qs0UHvHqVl5mrwg==
UI-OutboundReport: notjunk:1;M01:P0:F6S8pGRux04=;49jr77Avr90pSWabdymRODRS/SY
 I67m5OSwMVUA0OnxkJbwSFy5JgvWUCC70YaWHYV09F02ZAwY9j4mJ58timNo8JJuEDlbyEg+I
 Oq6/CLm40X7YCLmrzUeF3JeJkxiuB1iDTY++z6gdHymeXwnuLm3olxdAvrp+UCeDmb8oaV44n
 psxIchH5Hbx8zyRrFKwhyznIln7vQ+V7amlzr/wRRzou2NI4RC2hZ1O7ogjWLXzmJDRww3PNo
 bT4lJiDsmTs5EowRbWB9OWutHqe+Il7tyDAiGtmExLqoZuNdl1X9q7QUsZS0KFtnSmSRILe08
 q/QBhKBXry4qUBIpD7SRJ7rL2mmYeU/0Y4GTn41hu/0O3JddrEjN2Ba4VUi071WqW0gci8pnK
 9rrRYYTaxNqiz5J8ThufHl6uVCpY6CbE4x/NBQI7BA5Ka3htNdgB/MQ8Hz89lClqwhUJDw9vQ
 T8nVILzbGGQ7tcT4Q5KyJqhgfHN26XT34gsL2D0CgnVgYYXynU7RvooTk9y07aTO3Wdwop8Rd
 iVUd2KZmcQ2FnXf1FTBCduoIiPMEfBJa8TRYdYDo8MNevopVxa1mTSaHqvjSINFAMIkFcJs3X
 JrqnIvagy2Z9BQcJLE38DnP7/Yrwtt6JLuns26lULD2vu3qNGwYd7hBmLcLmWXVHzrgWJ7+X8
 Ec04UQ/xxO7VD7eCxbH2vISu9j1cXhjai0KQRHpIR+D4YAZvrCYsObXlBK11B2/5s++ZyfW+T
 6b/wIACkVF9lGpVJU3TMz8eVkSBtGXvbrOPebJcbij1nrFhoYtGT2hktxBpRWnFeYhdTUxPYw
 dSfXOb3z9C2eQg6yxQ09ZtD8IjmscPuxG4EwMKj7OsFTPby1Y5BFbVnWuZswJtzajcJfhPVJ8
 1LWz9bhYaLzDt5BH2AmjibpjlqzfJDuKrSodNtoHHJcvs1ERpH4yAN1bIW5dq+M8LmMQiawRD
 Qjl9sIGeeoi3EndNidS3AmLmYHo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.23 um 18:27 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Subject: [PATCH] archive: add --strip-components
>>
>> Allow removing leading elements from paths of archive entries.  That's
>> useful when archiving sub-directories and not wanting to keep the
>> common path prefix, e.g.:
>>
>>    $ git archive --strip-components=3D1 HEAD sha1dc | tar tf -
>>    .gitattributes
>>    LICENSE.txt
>>    sha1.c
>>    sha1.h
>>    ubc_check.c
>>    ubc_check.h
>>
>> The same can be achieved by specifying a tree instead of a commit and
>> a pathspec:
>>
>>    $ git archive HEAD:sha1dc | tar tf -
>>    .gitattributes
>>    LICENSE.txt
>>    sha1.c
>>    sha1.h
>>    ubc_check.c
>>    ubc_check.h
>
> Another way I am not sure is working as designed is
>
>     $ cd sha1dc && git archive HEAD . | tar tf -
>     .gitattributes
>     LICENSE.txt
>     sha1.c
>     sha1.h
>     ubc_check.c
>     ubc_check.hq
>
> I didn't check if the attribute look-up is done on the correct path
> or export-subst kicks in in such a use, though.

export-subst is supported in that invocation because git archive has a
commit to work with.

I can kinda see others preferring the directory prefix "sha1dc/" added
to those entries.  Perhaps it depends on what git archive is supposed to
archive: A commit or the files of a commit?  I'm in the latter camp, and
expect to see the same paths as given by git ls-files or git ls-tree.

But that invocation in a sub-directory probably has the same problem
with attributes as the one with a sub-tree above it, i.e. that
attributes are always looked up relative to the repository root.  I
wonder if 47cfc9bd7d (attr: add flag `--source` to work with tree-ish,
2023-01-14) provided the means to fix this when it added a tree_oid
parameter to git_check_attr().

Ren=C3=A9
