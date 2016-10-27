Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F7C2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 04:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbcJ0Ejh (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 00:39:37 -0400
Received: from nsstlmta31p.bpe.bigpond.com ([203.38.21.31]:56305 "EHLO
        nsstlmta31p.bpe.bigpond.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754852AbcJ0Ejd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Oct 2016 00:39:33 -0400
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Oct 2016 00:39:32 EDT
Received: from smtp.telstra.com ([10.10.24.4])
          by nsstlfep30p-svc.bpe.nexus.telstra.com.au with ESMTP
          id <20161027042321.HCWS335.nsstlfep30p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
          Thu, 27 Oct 2016 15:23:21 +1100
X-RG-Spam: Unknown
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2016.10.27.35117:17:8.317,ip=,rules=__BOUNCE_CHALLENGE_SUBJ,
 __BOUNCE_NDR_SUBJ_EXEMPT, __SUBJ_ALPHA_END, __TO_MALFORMED_2, __TO_NAME,
 __TO_NAME_DIFF_FROM_ACC, __REFERENCES, __HAS_CC_HDR, __MULTIPLE_RCPTS_CC_X2,
 __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __HAS_FROM, __FRAUD_WEBMAIL_FROM,
 __HAS_MSGID, __SANE_MSGID, __USER_AGENT, __MOZILLA_USER_AGENT,
 __MIME_VERSION, __IN_REP_TO, __CT, __CT_TEXT_PLAIN, __CTE, __UNUSABLE_MSGID,
 __ANY_URI, __URI_NO_WWW, ECARD_KNOWN_DOMAINS, __SUBJ_ALPHA_NEGATE,
 __FORWARDED_MSG, BODY_SIZE_3000_3999, __MIME_TEXT_P1, __MIME_TEXT_ONLY,
 __URI_NS, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, __FRAUD_WEBMAIL,
 MULTIPLE_RCPTS, __PHISH_SPEAR_STRUCTURE_1, IN_REP_TO, __MIME_TEXT_P,
 REFERENCES, BODY_SIZE_7000_LESS, NO_URI_HTTPS, MSG_THREAD, __TO_REAL_NAMES,
 __CC_REAL_NAMES, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
X-RG-Spam: Unknown
X-RG-Spam: Unknown
X-RG-Spam: Unknown
X-Authentication-Info: Submitted using ID pwil3058@bigpond.net.au
Received: from mudlark.localdomain (101.177.165.166) by smtp.telstra.com (9.0.018.03.01) (authenticated as pwil3058@bigpond.net.au)
        id 57966FEE038FDAD5; Thu, 27 Oct 2016 15:23:21 +1100
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and
 rebase
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <1477523244.2764.114.camel@mattmccutchen.net>
 <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
 <xmqqk2cuach3.fsf@gitster.mtv.corp.google.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
From:   Peter Williams <pwil3058@bigpond.net.au>
Message-ID: <f07745f8-d0ff-c41f-fd44-0812757fbd43@bigpond.net.au>
Date:   Thu, 27 Oct 2016 14:23:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2cuach3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/16 09:59, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> - We have to make separate commits and manage corresponding topic
>>> branches for the superproject and subprojects.
>>
>> Well yeah, that is how submodule work on a conceptual level.
>> While having multiple commits may seem like overhead, note
>> the subtle difference for these commits. One if deep down in the
>> stack patching one of the submodules, the other is a high level
>> commit advancing the submodule pointer.
>>
>> Note that the target audience of these two commit messages
>> might be vastly different, hence can be worded differently.
>> (The submodule describing how you fixed e.g. a memleak or race condition
>> and the superproject describes on why you needed to include that submodule,
>> e.g. because you switched your toplevel application to use threads.)
>
> Both good points.
>
> Another thing to keep in mind is that in a well-organized project,
> it is expected that you would have multiple commits in a submodule,
> solving one single issue that is needed by the superproject in a
> finer grained way, before the resulting submodule tip is recorded in
> the tree of the superproject in one commit.  IOW, between the time
> the superproject's history moves by one commit, the submodule may
> have multiple commits in order for the submodule to become ready to
> be consumed by the superproject.
>
>

I'm a relatively new user of submodules and I quite like them (having 
tried a few other strategies for sharing common code between multiple 
projects and found them quite painful) and find them fairly easy to use. 
  I especially like the fact that the submodule command isn't very 
complicated and that the best method for managing commits, etc in the 
submodule is to cd into their root directory and then treat them like 
any other git repository (greatly reducing the amount of new stuff that 
you have to learn in order to use them).  Also, from my experience so 
far, I see three different types of work going on within my workspaces 
that include submodules:

1. I'm working on changes to the submodule and using the superproject 
that it's checked out in to test those changes in which case most of the 
change is occurring in the submodule with changes in the superproject 
usually being small one related to API changes in the submodule.

2. I'm working on changes in the superproject and the only changes that 
get made in the submodules are to fix bugs uncovered by the work in the 
superproject.

3. I'm modifying a superproject to accommodate changes to a submodule 
that's changed as a result of having changes pulled from another repository.

In none of these cases do I feel the desire/need to commit the changes 
to the superproject and submodule(s) with a single commit command which 
more or less agrees with your points.

However, for git commands such as diff/status whose job is to display 
information it would be nice if they had a --recursive option to 
override the default submodule diff/status and show details of the 
changes in the submodules.  Sometimes you want to see the big picture in 
detail.

