Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C041F858
	for <e@80x24.org>; Thu, 28 Jul 2016 17:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759073AbcG1R3y (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 13:29:54 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:3908 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161010AbcG1R3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 13:29:52 -0400
Received: from [192.168.2.201] ([92.22.55.62])
	by smtp.talktalk.net with SMTP
	id Sp81br7zDHGLwSp82bKovK; Thu, 28 Jul 2016 18:29:50 +0100
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
	t=1469726990; bh=KAc32KIlqBq+sJhNkQ1smFryI7u79iG3gQYu1fhX7KY=;
	h=Reply-To:Subject:References:To:Cc:From:Date:In-Reply-To;
	b=TOXZW/ORRdu6Yaalsg0ISVTQwHNFflO2gocBNvUBG1irzx0hJWiUulA8l5Gp1suEa
	 MWDbFnECiVUjh7swAwP8rLq1UrVzXoIe3vzc3OSZgbnX1Riw5oFw6JwpzLv/FeEFGj
	 ZW5z7rawkYi3V4X9VeQuGLnQJrAiBrpuyczX5eXs=
X-Originating-IP: [92.22.55.62]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=emT4YZXqgNgQELh026CzWg==:117
 a=emT4YZXqgNgQELh026CzWg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=B_sbImRsnVZG4_ydEcgA:9 a=NWVoK91CQySWRX1oVYDe:22 a=wQf5WvvPLwzY6UdiLRIz:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug? git rebase -i --autostash fails to restore working files
References: <222a3e5b-ff2c-799e-0fcb-cba23815019f@talktalk.net>
 <568300231.1133609.1469710974063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
To:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	phillip wood <phillip.wood@dunelm.org.uk>
Cc:	git@vger.kernel.org
From:	Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <595ec1d8-a759-e2cf-b387-a68bd6c0a437@talktalk.net>
Date:	Thu, 28 Jul 2016 18:29:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <568300231.1133609.1469710974063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOCcW9l/Z3fuZply4ljZspludBpnm20ZryGmNvmLiahnivxjPoJ8YAUZiyRDtvPBvxFw2O/SWh/gmBqArdiMiuF86JXqeL04r9K+E5DRLdm9OvCicXJy
 HnQm8TPcrQ+S+b/urAl55ahXLVzxVwY7/zZSwFF6c1pnmA1XBPU4eVomKgPJxKLxHUhY/++4zgJdiWSZudJu6pjNtcyibO0DtKlEsCy0GC7ylq3Jup2fZwtm
 GW6Cfz7LV373ASVw8B8K+rpyOCk0u/mx+0s40swvMHI=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 28/07/16 14:02, Remi Galan Alfonso wrote:
> Hi Phillip,
> 
> Phillip Wood <phillip.wood@talktalk.net> writes:
>> When running ‘git rebase -i --autostash’ if the editor fails then the
>> rebase fails but stash is not applied so the working files are not
>> restored. Running ‘git rebase --abort’ replies that there’s no rebase
>> in progress. If you notice what’s happened it’s not a problem if you
>> know to do ‘git stash apply <autostash id>’ but it’s confusing as
>> normally the stash would be automatically applied. This happened to me
>> when I messed up my editor configuration but you can reproduce it with
>>
>> $ GIT_SEQUENCE_EDITOR=false git rebase -i --autostash HEAD^^
>> Created autostash: ff960d4
>> HEAD is now at f1b8af7 [git] Turn on rebase.missingCommitsCheck
> 
> [I'm happy to see rebase.missingCommitsCheck being used.]
> 
>> Could not execute editor
>>
>> $ git rebase --abort
>> No rebase in progress?
> 
> I remembered having read something about it recently and a quick
> search confirmed it. It was corrected in commit 33ba9c6 (29/06/2016,
> rebase -i: restore autostash on abort) that recently graduated to
> master (on 19/07/2016 if I read the various "What's cooking"
> correctly). So you will need to build git from source to have this
> corrected.

Hi Rémi

Thanks for the reply, it's good to know it's been fixed.

Best Wishes

Phillip

