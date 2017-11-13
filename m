Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523851F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 07:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdKMH61 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 02:58:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbdKMH61 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 02:58:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2F0FAAA3;
        Mon, 13 Nov 2017 07:58:25 +0000 (UTC)
Subject: Re: [RFC] cover-at-tip
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <357e8afb-4814-c950-1530-530bb6dd5f5a@suse.de>
 <e1d3ab5b-82e6-8490-8f2e-00c1359c6deb@suse.de>
 <xmqqbmkaf0yn.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <bbdeaba0-b757-041d-9649-4150080d4b07@suse.de>
Date:   Mon, 13 Nov 2017 08:58:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmkaf0yn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 10/11/2017 à 19:22, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:
>
>> I would need to add "some" level of parsing to am.c to make sure
>> the patch content is just garbage and that there are no actual
>> hunks for that.
>>
>> I did not find any public API that would allow me to do that,
>> although apply_path/parse_chunk would fit the bill.  Is that the
>> right way to approach this ?
> I do not think you would want this non-patch cruft seen at the apply
> layer at all.  Reading a mailbox, with the help of mailsplit and
> mailinfo, and being the driver to create a series of commits is what
> "am" is about, and it would have to notice that the non-patch cruft
> at the beginning is not a patch at all and defer creation of an
> empty commit with that cover material at the end.  For each of the
> other messages in the series that has patches, it will need to call
> apply to update the index and the working tree so that it can make a
> commit, but there is NO reason whatsoever to ask help from apply, whose
> sole purpose is to read a patch and make modifications to the index
> and the working tree, to handle the cover material.
>
>

I agree this is a "am" job. Was just wondering if reusing some of the code from apply (and move it so it makes more sense) wouldnd't make more sense than rewriting a patch detection function.

Nicolas
