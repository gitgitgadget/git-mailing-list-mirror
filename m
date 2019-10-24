Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7B71F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfJXUOq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 16:14:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41935 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727198AbfJXUOq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Oct 2019 16:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571948085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuNmu0n7jmBxVd/ojA20w2Y6maBXCiIzLZefFzZHyVQ=;
        b=Ibdzucz1QsQHjQvZOKP9p5IVuCw86E42+Re4K8FBWmEMufqNSq0AyMa4yATatRlg183XPb
        jp0hjFjHPxGtApHQ1azUzriENpCoF4lsTicdD1CMPLJm7IR8bd8ilAaMwtoYedyKROFqAn
        I1iTcFB8ktv+hHGw8+CWSQcsSDPjQvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-GFV04OCdO_OBba4QYpjAXg-1; Thu, 24 Oct 2019 16:14:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB6CD476;
        Thu, 24 Oct 2019 20:14:40 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B7235C222;
        Thu, 24 Oct 2019 20:14:39 +0000 (UTC)
Subject: Re: [PATCH v2] pretty: add "%aL"|"%al|%cL|%cl" option to output
 local-part of email addresses
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20191024125332.29958-1-prarit@redhat.com>
 <20191024161610.GA8448@sigill.intra.peff.net>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <28711c54-0635-41e1-1c3f-1fc2751c8c4e@redhat.com>
Date:   Thu, 24 Oct 2019 16:14:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191024161610.GA8448@sigill.intra.peff.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GFV04OCdO_OBba4QYpjAXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/24/19 12:16 PM, Jeff King wrote:
> On Thu, Oct 24, 2019 at 08:53:32AM -0400, Prarit Bhargava wrote:
>
>> In many projects the number of contributors is low enough that users kno=
w
>> each other and the full email address doesn't need to be displayed.
>> Displaying only the author's username saves a lot of columns on the scre=
en.
>> For example displaying "prarit" instead of "prarit@redhat.com" saves 11
>> columns.
>>
>> Add a "%aL"|"%al|%cL|%cl" option that output the local-part of an email
>> address.
>>
>> Also add tests for "%ae","%an", "%ce", and "%cn".
>
> Thanks, this is looking better, but I think there are still a few minor
> bits to address.
>

Thanks :)

>> Changes in v2:
>> - Changed option to 'L' based on https://www.ietf.org/rfc/rfc2822.txt
>>   definition of 'local-part' of email addresses.
>> - added additional information to documentation for %cL and %cl
>> - added mailmap output test
>> - modified code to use mailmap output for "L" option
>> - modified code to check if email address field has '@' symbol
>> - modified tests based on input from Peff
>
> This change list is very welcome, but it should generally go after the
> "---", so that it's not part of the commit message (i.e., it is for
> people reading this email and reviewing now, but people reading "git
> log" later would not know or care about v1).
>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Junio C Hamano <gitster@pobox.com>
>> Cc: brian m. carlson <sandals@crustytoothpaste.net>
>> Cc: Jeff King <peff@peff.net>
>
> Likewise we do not generally use "cc:" trailers in this project.
>
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-for=
mats.txt
>> index b87e2e83e6d0..9a1f900f114a 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -163,6 +163,11 @@ The placeholders are:
>>  '%ae':: author email
>>  '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
>>  =09or linkgit:git-blame[1])
>> +'%al':: author local-part (the portion of the email address preceding t=
he '@'
>> +=09symbol)
>
> I'm not sure if it is worth saying something like "preceding the @
> symbol, or the whole address if no @ symbol". It's a pretty rare case,
> I'd think, and it does clutter up the wording. So just a thought.
>

After adding the text I've decided to keep it the same.  As you pointed out=
 it
ended up being too long.

>> +'%aL':: author local-part (the portion of the email address preceding t=
he '@'
>> +=09symbol, respecting .mailmap, see linkgit:git-shortlog[1] or
>> +=09linkgit:git-blame[1])
>
> This description gets pretty long. I wonder if we can simplify by
> referring to earlier formats, which would also make clear to the user
> the relationship between the formats. Perhaps:
>
>   '%aL':: author local-part (see '%al'), respecting .mailmap (see '%aE')
>
> And ditto for %cL.

I have added this for v3.

<snip>

> I didn't think about this before, but...surely we're testing %an, etc
> already?
>
> Indeed, it looks like t6006 already covers that. Maybe you should be
> adding to that test? I note that it just hardcodes "author@example.com"
> in the expectation. I'd be OK with either following the lead there, or
> doing a separate preparatory patch to use $GIT_AUTHOR_EMAIL, etc.
>

I've done separate preparatory patches for both t6006 and t4203 for v3.

>> +=09{
>> +=09=09echo "${GIT_AUTHOR_NAME}" &&
>> +=09=09echo "${GIT_AUTHOR_EMAIL}" &&
>> +=09=09echo "${TEST_AUTHOR_LOCALNAME}"
>> +=09=09echo "${GIT_AUTHOR_NAME}" &&
>> +=09=09echo "${GIT_AUTHOR_EMAIL}" &&
>> +=09=09echo "${TEST_AUTHOR_LOCALNAME}"
>> +=09} > expect &&
>
> The expectation for %aE is the same as for %ae. So we're not really
> testing that we actually applied the mailmap. It looks like t4203 has
> some tests for %aE; you'd probably want to check %aL there.
>
>> +test_expect_success 'log pretty %cn %ce %cl %cN %cE %cL' '
>
> Likewise, both of the spots I mentioned cover the committer formats,
> too.
>
>> +TEST_AUTHOR_LOCALNAME=3Dauthor
>> +TEST_AUTHOR_DOMAIN=3Dexample.com
>> +GIT_AUTHOR_EMAIL=3D${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
>
> If you follow the lead of t6006 and just hard-code these, then this hunk
> can go away. But if you do keep it, note that...
>

I implemented the suggested tests in both test files in v3.

>>  export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
>> +export TEST_AUTHOR_LOCALNAME TEST_AUTHOR_DOMAIN
>>  export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
>> +export TEST_COMMITTER_LOCALNAME TEST_COMMITTER_DOMAIN
>
> These lines are unnecessary. We have to export GIT_AUTHOR_EMAIL, etc, so
> that the child git-commit process can read it. But there's no need to do
> so for TEST_*, which are meant to be used by the test scripts
> themselves.
>

Removed in v3.  I will post after running the test suite.

Thanks,

P.

