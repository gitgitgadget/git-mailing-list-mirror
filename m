Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81AF81F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbeBBJcv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:32:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:41136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeBBJcY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:32:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2282DAC8C;
        Fri,  2 Feb 2018 09:32:23 +0000 (UTC)
Subject: Re: [PATCHv2] tag: add --edit option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com>
 <CAPig+cT8vKyhq6DvFMz-0CPRO-Y7R4EE_JhN6yuiSUNXW8-Yww@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Message-ID: <fa3f512a-bd77-80c7-4fec-071639f62d26@suse.com>
Date:   Fri, 2 Feb 2018 08:15:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT8vKyhq6DvFMz-0CPRO-Y7R4EE_JhN6yuiSUNXW8-Yww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 02/02/2018 à 02:29, Eric Sunshine a écrit :
> On Thu, Feb 1, 2018 at 12:21 PM, Nicolas Morey-Chaisemartin
> <nmoreychaisemartin@suse.com> wrote:
>> Add a --edit option whichs allows modifying the messages provided by -m or -F,
>> the same way git commit --edit does.
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
>> ---
>> Changes since v1:
>> - Fix usage string
>> - Use write_script to generate editor
>> - Rename editor to fakeeditor to match the other tests in the testsuite
> Thanks for explaining what changed since the previous attempt. It is
> also helpful for reviewers if you include a reference to the previous
> iteration, like this:
> https://public-inbox.org/git/450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com/T/#u
>
> Cc:'ing reviewers of previous iterations is also good etiquette when
> submitting a new version.

I thought I did. My script might be glitchy. Sorry for that.

>
>> - I'll post another series to fix the misleading messages in both commit.c and tag.c when launch_editor fails
> Typically, it's easier on Junio, from a patch management standpoint,
> if you submit all these related patches as a single series.
> Alternately, if you do want to submit those changes separately, before
> the current patch lands in "master", be sure to mention atop which
> patch (this one) the additional patch(es) should live. Thanks.

Well this patch does not touch any of the line concerned by fixing the error message. So both should be able to land in any order.
Plus I've never had to look into localization yet so I'm going to screw up on the first few submissions (not counting on people that disagree or would prefer another message),
and I don't want this patch to get stuck in the pipe for that :)

>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> @@ -167,6 +167,12 @@ This option is only applicable when listing tags without annotation lines.
>> +-e::
>> +--edit::
>> +       The message taken from file with `-F` and command line with
>> +       `-m` are usually used as the tag message unmodified.
>> +       This option lets you further edit the message taken from these sources.
> You probably ought to add this new option to the command synopsis. In
> the git-commit man page, the synopsis mentions only '-e' (not --edit),
> so perhaps this man page could mirror that one. (Sorry for not
> noticing this earlier.)

Yep makes sense.

>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> @@ -452,6 +452,21 @@ test_expect_success \
>> +get_tag_header annotated-tag-edit $commit commit $time >expect
>> +echo "An edited message" >>expect
> Modern practice is to perform these "expect" setup actions (and all
> other actions) within tests themselves rather than outside of tests.
> However, consistency also has value, and since this test script is
> filled with this sort of stylized "expect" setup already, this may be
> fine, and probably not worth a re-roll. (A "modernization" patch by
> someone can come later if warranted.)
>
>> +test_expect_success 'set up editor' '
>> +       write_script fakeeditor <<-\EOF
>> +       sed -e "s/A message/An edited message/g" <"$1" >"$1-"
>> +       mv "$1-" "$1"
>> +       EOF
>> +'

It's probably worth doing a whole cleanup of these (and switch to write script) in a dedicated patch series.

Nicolas
