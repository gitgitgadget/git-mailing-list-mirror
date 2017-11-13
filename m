Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0571F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755110AbdKMTxz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 14:53:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:36606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755059AbdKMTxx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 14:53:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D565FABB1;
        Mon, 13 Nov 2017 19:53:52 +0000 (UTC)
Subject: Re: [RFC 0/3] Add support for --cover-at-tip
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
 <ab9dde24-bd1f-37b6-5fb4-247937e13432@suse.de>
 <20171113114010.0d4acb09a7a133f4baee9076@google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <0b916607-4d8a-6574-84e5-6e4f8f484616@suse.de>
Date:   Mon, 13 Nov 2017 20:53:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <20171113114010.0d4acb09a7a133f4baee9076@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 13/11/2017 à 20:40, Jonathan Tan a écrit :
> On Mon, 13 Nov 2017 18:13:27 +0100
> Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> wrote:
>
>> v2:
>> - Enhance mailinfo to parse patch series id from subject
>> - Detect cover using mailinfo parsed ids in git am
> I noticed that this was done in the patch set by searching for "PATCH" -
> that is probably quite error-prone as not all patches will have a
> subject line of that form. It may be better to search for "0/" and
> ensure that it is immediately followed by an integer.

Yes this could be moved. I wasn't sure about the risk of colliding with something else.


> Also, it might be worth checking the message IDs to ensure that the
> PATCH M/Ns all indeed are replies to PATCH 0/N.

Doesn't that only work if mails [1..N] are reply to the cover ? Depending on the mailer and your option, this might not always be the case (I think).

>
>> - Support multiple patch series in a single run
> Is this done? I would have expected that some buffering of messages
> would be necessary, since you're writing a series of messages of the
> form <cover><patch 1>...<patch N> to the commits <patch 1>...<patch
> N><cover>.
>

This is for git am. It handles the fact that an input may contain multiple series (expect them to be in order).
When reaching patch N/N, it flushed the cover.


>> TODO:
>> - Add doc/comments
>> - Add tests
>> - Add a new "seperator" at the end of a cover letter.
>>   Right now I added a triple dash to all cover letter (manual or cover-at-tip) before shortlog/diff stat
>>   This allows manually written cover letters to be handle by git am --cover-at-tip without including the shortlog/diffstat but
>>   breaks compat with older git am as it is seen has a malformed patch. A new separator would solve that.
> I think the triple dash works. I tried "git am" with a cover letter with
> no triple dash, and it complains that the commit is empty anyway, so
> compatibility with older git am might not be such a big issue. (With the
> triple dash, it indeed complains about a malformed patch, as you
> describe.)

It kinda work but it makes the message difficult to understand for the user.
And change the behaviour from the previous releases.

Thanks for the feedback.

Nicolas
