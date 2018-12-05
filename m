Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5260211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 06:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeLEGCd (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 01:02:33 -0500
Received: from mout.web.de ([212.227.15.4]:42761 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbeLEGCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 01:02:33 -0500
Received: from [192.168.178.36] ([79.237.241.17]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6PP-1hF1HW2krv-00oY08; Wed, 05
 Dec 2018 07:02:21 +0100
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com> <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
 <20181203220424.GA11883@sigill.intra.peff.net>
 <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
 <20181205044645.GA12284@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <54e7a97d-501c-1aa7-55cd-83f070d05a8c@web.de>
Date:   Wed, 5 Dec 2018 07:02:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181205044645.GA12284@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TfzXIsIpyz3E6nyFZd24ZZC7hMgnf2dg84Oxm+vcRGLH5flmExd
 CBVst/dpC5HKZxf5CvYmOMjNVusIbmMw0ugJXPKRuMEnl5W9i/IHTxwj+8YTPt8/t1gU32r
 LLaV44VFo5qu9pTlYrQ5NrsyI6TEtVCCqD8WSTgzeMXcdWcHCxLJFglAknDaERberNPd3iK
 LBECPDFV3AakiasjN/Dcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E+QPBdpfHrU=:cJ1S6HMArGM9f0x1SNrRih
 f2jzD3iVgJhTw4QUiMhmsIF0UHGpkutThscfLhtgg8YYzXK20K7fbdOqO3BOOYoNNdRjKY9oW
 I6iktRghxoYy33N7d1GzmrF3c56uzHN9Eu7HIj0ZkEJRhJ+3Hj1W+Huz7LDKk4rT8Xr5vyMGQ
 IAPexzqSQwB4VWn++zFiPMEGd62TQiKBAj/KVnBfUo0+rO4zaLK8IuqH3KykKBF9jNLIh/QXO
 3txvKAmA0NxAOLMILGpWskk7VxpGKgdFFYSQjIP9vhwDU1NJoso9c280JCoj9rhB7m+oFnKqG
 aCVwpPHgGt+QrkCXFhQ7ypAda8ig/yTRijIl6HGHkVYlUN9xR1qTBBEZAyq9LigAeNO7W01ph
 bmXV6BjhCRGmrJuMOdqL8dTrpuAQ9E7+cLPj04YOKCtcXlS4gYb+zrK91gBzkvJ/8t+soLSgo
 1CEZJmFmAk7zrhnv0mnjM33xFvVXMqiMIRK99TnXIiZ/PQTlFGLlvzw0AH7bGkd1r9YDzqHUh
 5uavzkPO6CtYzVveKZIBMSJ81DrxD5Q8rsaReuq1JdGdI/Z/6auISPqGp9uyTpMiax7PSSgyz
 kg6Ho4ZF7P3GceUM4OAOv1ckESwVy8FKwWzhNuekgTsm3J31MZS7pnB7epi6jrRVln5s5+86O
 no+R7j3fvQF+ke56Ii8le1yAflXQkSKQGFMNIj5tmIpsTK4wg7uATB/KKAxQqxNgVcvuFFsKM
 OsIgq/Sx+lZwdzIhCOk/xrGwlXNrWH3QKBSv9bqjnsYWSloRHY2viOQUH1nAGUb6/NcusnOT8
 F7BiTp5jBL6ajJFXGJnyjrUlv7arjykI1Th2P1vCyLFnk81QPZ40Qj8XRVuMj83NxgkMAvUcS
 62XFaDTXh+iRNp4bDnMMr7sGraXBF/8BRpdkVpiNkQuev2NS4+1mcYic6iJYwk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.2018 um 05:46 schrieb Jeff King:
> On Tue, Dec 04, 2018 at 10:45:13PM +0100, René Scharfe wrote:
> 
>>> The comment in the context there is warning callers to remember to load
>>> the cache first. Now that we have individual caches, might it make sense
>>> to change the interface a bit, and make these members private. I.e.,
>>> something like:
>>>
>>>   struct oid_array *odb_loose_cache(struct object_directory *odb,
>>>                                     int subdir_nr) 
>>>   {
>>> 	if (!loose_objects_subdir_seen[subdir_nr])
>>> 		odb_load_loose_cache(odb, subdir_nr); /* or just inline it here */
>>>
>>> 	return &odb->loose_objects_cache[subdir_nr];
>>>   }
>>
>> Sure.  And it should take an object_id pointer instead of a subdir_nr --
>> less duplication, nicer interface (patch below).
> 
> I had considered that initially, but it's a little less flexible if a
> caller doesn't actually have an oid. Though both of the proposed callers
> do, so it's probably OK to worry about that if and when it ever comes up
> (the most plausible thing in my mind is doing some abbrev-like analysis
> without looking to abbreviate a _particular_ oid).

Right, let's focus on concrete requirements of current callers.  YAGNI..
:)

>> And quick_has_loose() should be converted to object_id as well -- adding
>> a function that takes a SHA-1 is a regression. :D
> 
> I actually wrote it that way initially, but doing the hashcpy() in the
> caller is a bit more awkward. My thought was to punt on that until the
> rest of the surrounding code starts handling oids.

The level of awkwardness is the same to me, but sha1_loose_object_info()
is much longer already, so it might feel worse to add it there.  This
function is easily converted to struct object_id, though, as its single
caller can pass one on -- this makes the copy unnecessary.

> This patch looks sane. How do you want to handle it? I'd assumed your
> earlier one would be for applying on top, but this one doesn't have a
> commit message. Did you want me to squash down the individual hunks?

I'm waiting for the first one (object-store: use one oid_array per
subdirectory for loose cache) to be accepted, as it aims to solve a
user-visible performance regression, i.e. that's where the meat is.
I'm particularly interested in performance numbers from Ævar for it.

I can send the last one properly later, and add patches for converting
quick_has_loose() to struct object_id.  Those are just cosmetic..

René
