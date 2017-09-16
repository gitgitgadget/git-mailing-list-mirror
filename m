Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4626920281
	for <e@80x24.org>; Sat, 16 Sep 2017 03:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdIPD32 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 23:29:28 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:50726 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbdIPD32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 23:29:28 -0400
Received: by mail-it0-f54.google.com with SMTP id y126so4309105itb.5
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 20:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qHKU35URkHU+dkPILCudC/JXCTxLZWS4fuH4PKMneO0=;
        b=lwAX+djOLhcYiNDCBHYoZL/MXRT6DYx0Zf9UrVYhzoyQ/+hy/SMtZWuh7kNhSHFOgm
         gr6byNa5nvTcc0ygAF+5+pallSEgQ4USgtudhZVBupNZ4Q5D6arcvRppnZd8OnxRPd/L
         Z56Rhj/xMajvWhgBex3vsjZADLupo88rXQGiqjLzAkwDaEGIDcJNj2BlD9eExvQTwsxB
         C5oksw9jicY8M456yszCQT0b3TvsOOinJHqtA/58TdoG5vENf0Jq4D4FtuDlslL2R79/
         cj33CEiAftoja2ODbjpCEeaSbYfwCwanXX8JBuoyQjZziPfODDC4U2xK1/MOi/jfeKmg
         V1QA==
X-Gm-Message-State: AHPjjUhz2xsaj7zzFzzYigoYTWuUYnF/E5lhtDkZWxXB95A179LM+nPM
        ZDtWAuSBRFupzLUvhKN5aHVpeeLUCP5piwyuhtaMmA==
X-Google-Smtp-Source: AOwi7QDffeqPEmMa1zf18t04pSobmbXSaW0qJSRCLJSilK6P1r5Wda1s9U98SDmaYtV7THTiAoWYlvh/ix94W8n6YBM=
X-Received: by 10.36.4.151 with SMTP id 145mr9038731itb.33.1505532567441; Fri,
 15 Sep 2017 20:29:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.166.140 with HTTP; Fri, 15 Sep 2017 20:29:06 -0700 (PDT)
In-Reply-To: <20170915215303.GV27425@aiede.mtv.corp.google.com>
References: <20170915170818.27390-1-jason@redhat.com> <20170915175248.GT27425@aiede.mtv.corp.google.com>
 <CADzB+2mxyXcROYx72tac8cUxBMxi=ZxUNQYxpUR1CZ43e-j9gA@mail.gmail.com> <20170915215303.GV27425@aiede.mtv.corp.google.com>
From:   Jason Merrill <jason@redhat.com>
Date:   Fri, 15 Sep 2017 23:29:06 -0400
Message-ID: <CADzB+2mT=Ht5AQybp+44+PMbRrWXB4dPyTmsEgfVkOOujZYQxQ@mail.gmail.com>
Subject: Re: [PATCH] Fix merge parent checking with svn.pushmergeinfo.
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Aldy Hernandez <aldyh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 5:53 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jason Merrill wrote:
>> On Fri, Sep 15, 2017 at 1:52 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > Jason Merrill wrote:
>
>>>> Subject: Fix merge parent checking with svn.pushmergeinfo.
>>>>
>>>> Without this fix, svn dcommit of a merge with svn.pushmergeinfo set would
>>>> get error messages like "merge parent <X> for <Y> is on branch
>>>> svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
>>>> svn+ssh://jason@gcc.gnu.org/svn/gcc!"
>>>>
>>>> * git-svn.perl: Remove username from rooturl before comparing to branchurl.
>>>>
>>>> Signed-off-by: Jason Merrill <jason@redhat.com>
>>>
>>> Interesting.  Thanks for writing it.
>>
>> Thanks for the review.
>>
>>> Could there be a test for this to make sure this doesn't regress in
>>> the future?  See t/t9151-svn-mergeinfo.sh for some examples.
>>
>> Hmm, I'm afraid figuring out how to write such a test would take
>> longer than I can really spare for this issue.  There don't seem to be
>> any svn+ssh tests currently.
>
> Well, could you give manual commands to allow me to reproduce the
> problem?
>
> Then I'll translate them into a test. :)

Something like this:

git svn clone -s svn+ssh://user@host/repo
git config svn.pushmergeinfo yes
git checkout -b branch origin/branch
git merge origin/trunk
git svn dcommit

Thanks!

> FWIW remove_username seems to be able to cope fine with an http://
> URL.  t/lib-httpd.sh starts an http server with Subversion enabled,
> as long as the envvar GIT_SVN_TEST_HTTPD is set to true.  Its address
> is $svnrepo, which is an http URL (but I don't see a username in the
> URL).  Does that help?

I think the http transport handles the username separately, not in the URL.

I would expect that a dummy ssh wrapper like some of the tests use
would be sufficient, no need for an actual network connection.

> Alternatively, does using rewrite-root as in t9151-svn-mergeinfo.sh
> help?

Hmm, I'm not sure how rewriteRoot would interact with this issue,
whether it would be useful as a workaround or another problematic
case.

Jason
