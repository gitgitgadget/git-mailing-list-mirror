Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4244C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7425565001
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCEBFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhCEBFi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 20:05:38 -0500
X-Greylist: delayed 1133 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Mar 2021 17:05:38 PST
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F74BC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 17:05:38 -0800 (PST)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 1250Tr00029821;
        Fri, 5 Mar 2021 00:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=Xrk53vk73W+ai7lOPhjwo5fPiVPzrXFKLCaszpGzwfg=;
 b=KvzLmcSUtC8su/Ht30RPQNDzuyb9t7tY/YE0bpfVYbTIsUuPU0E0j3NrCPm0LizW1l6A
 xcbLAKvUDnZb9tP2n473n92zx9tehJfK2evPCDbZlGR8jSwK1CQFZrgecJ7mQxV09SAj
 KcvpUQk45mtqeg7vpyKQg421IZrjyVq5EI/3YLX+PTa8wKE+jl5/BGVOqBVQXLHuWKEe
 /3nsN2sgwBOjxJA46K6FMSbS4UuUqQN9BdIr/Kxha+w3969iToqB7N1ugfMLNLREDM67
 BJIn/Q20hn97b+Rt2jnqMBQazmOrevQpJKdMo3jQYlPjefrXqVGfx0wZb9c0hiDis7Sf Ww== 
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 36yfej34ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 00:46:41 +0000
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.43/8.16.0.43) with SMTP id 1250Y1GE008812;
        Thu, 4 Mar 2021 19:46:40 -0500
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint8.akamai.com with ESMTP id 36yja55f7w-1;
        Thu, 04 Mar 2021 19:46:40 -0500
Received: from [0.0.0.0] (unknown [172.27.119.138])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id D06315FA;
        Fri,  5 Mar 2021 00:46:39 +0000 (GMT)
Subject: Re: [PATCH] branch: return error when --list finds no matches
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Hunt <joshua.hunt@berkeley.edu>
References: <pull.892.git.1614793491538.gitgitgadget@gmail.com>
 <xmqqr1kvemid.fsf@gitster.c.googlers.com>
From:   Josh Hunt <johunt@akamai.com>
Message-ID: <4f8b0030-0e15-0035-a9e8-224f64cb48f5@akamai.com>
Date:   Thu, 4 Mar 2021 16:46:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1kvemid.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_09:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050001
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_09:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050001
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.34)
 smtp.mailfrom=johunt@akamai.com smtp.helo=prod-mail-ppoint8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/21 5:27 PM, Junio C Hamano wrote:
> "Josh Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Josh Hunt <johunt@akamai.com>
>>
>> Currently git branch --list foo always returns an exit status of 0 even
>> when the branch being searched for does not exist. Now an error is printed
>> and returns a non-zero exit status.
> 

Junio

Thanks so much for the review.

> Explaining what happens in the current code upfront is a good thing
> and is in line with the convention used in our project, which is
> good.  But drop "currently" from there.
> 
> Strictly speaking, it is not "always".  In a corrupt repository, it
> is likely to show a proper error message and die.
> 
> Also explaining what you want to happen before the end of the log
> message is good.

Thank you. I will make the above changes to the commit message if this 
moves forward.

> 
> But the proposed log message lacks why it is a good idea to make
> such a change, which is the most important part.

OK sure. To provide better context I came across this when using 'git 
branch --list foo' in a script and there was an expectation (possibly 
incorrect) when the search was not successful it would return an 
non-zero exit status.

I don't know if there's a convention that git follows, but I have the 
following examples where a similar type of command does return a 
non-zero exit status:

johunt@johunt-ThinkPad-T480s:~$ ls foo
ls: cannot access 'foo': No such file or directory
johunt@johunt-ThinkPad-T480s:~$ echo $?
2

johunt@johunt-ThinkPad-T480s:~$ touch foo
johunt@johunt-ThinkPad-T480s:~$ grep bar foo
johunt@johunt-ThinkPad-T480s:~$ echo $?
1

johunt@johunt-ThinkPad-T480s:~$ grep . foo
grep: foo: No such file or directory
johunt@johunt-ThinkPad-T480s:~$ echo $?
2

Not just these tools, but even in git itself:

johunt@johunt-ThinkPad-T480s:~$ git init foo
Initialized empty Git repository in /home/johunt/foo/.git/
johunt@johunt-ThinkPad-T480s:~/foo$ touch bar
johunt@johunt-ThinkPad-T480s:~/foo$ git add bar
johunt@johunt-ThinkPad-T480s:~/foo$ git commit -am 'initial commit'
[master (root-commit) 771510f] initial commit
  1 file changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 bar
johunt@johunt-ThinkPad-T480s:~/foo$ git log foo
fatal: ambiguous argument 'foo': unknown revision or path not in the 
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
johunt@johunt-ThinkPad-T480s:~/foo$ echo $?
128

johunt@johunt-ThinkPad-T480s:~/foo$ git grep foo .
johunt@johunt-ThinkPad-T480s:~/foo$ echo $?
1

However it does seem like 'tag --list' follows the branch behavior:

johunt@johunt-ThinkPad-T480s:~/foo$ git tag --list foo
johunt@johunt-ThinkPad-T480s:~/foo$ echo $?
0

There are likely other examples of git commands showing both behaviors. 
Is it that branch and tag are a certain type of command which allows 
them to behave differently than say log or grep?

> 
> If you ask me, I would say that the command was asked to show any
> branches, if exist, that match the given pattern, and did what it
> was asked to do without encountering any error---it just happened to
> have seen 0 branch that matched.  So I think returning non-zero
> status would be a bug.

Interesting. Going back to the scripting context then your suggestion 
would just be to check if output is NULL? This is what I've converted my 
scripts to do for now, but still feel like if --list can't find the 
branch I'm looking for then it should return non-zero as it matches 
behavior of other tools :)

Josh
