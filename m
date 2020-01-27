Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B45C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9E32467B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="taoRkyi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0UyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:54:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33071 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0UyC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 15:54:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so12288868edq.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 12:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DYAQPYgXw/UhwMlxpeKP0ZA6lUgP1aQsZZoBCejisB8=;
        b=taoRkyi3nqVV7wjBffKbrnNor+z/8576J3AU+Ju+dzfDfqoJatnA73n5P3AeHcKOBp
         FeLdbdZOMLtWJc458oM4GSyPmMcDT1x6LXDK6Db/Cbq5vrzRIiNm/czHcMoKWKsYpG6K
         ny+ZDwcZYb7IovLpLQmqm2BhVbwjWts1gcf8kE9VQUeyra3F22lnXfVrqqO7vZ+IAD+V
         ltLNgx74Zw7uqC4E1aggPY9LA8M1u6QfEUNro3Z8kTVOz6BulzFH7J+0nxLaoGFD7nrN
         vo8MbNg/+qNhDP6kwlIgBfcKaUtTU4fZFXzFnvIkNCryRSVX5CSyx+n4ue2vKA6H+S/l
         CFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYAQPYgXw/UhwMlxpeKP0ZA6lUgP1aQsZZoBCejisB8=;
        b=gWJrQkuFzl7BntUrlvqb/mcYnzchWa29TY4xf8OO8AbkZSnhDfhGOaZxktsFas+yFC
         tZcyjb3C3RziPsIPEpy7x65LrDALvbfFQYG9SzGac4CIpOAgMqKYxhfbK59mN438tVB1
         2X3ua0W0GnT1dJFOcftSjP5XFABHB6PRCLNeT5apsv3OjX0Uya/Z+HPkKjprtioo0PRW
         hEoAId2J17ZHYXMksbojSOYuPe+UJVT4feKP7DqsaKxUi4ymA96Y0UieoQslCT8Q/2uK
         WzC6Mmp6CV43yBhXWWQ7OwJFhGm1PZQmktLZC74eKNUconyUhAr5KSOdUMIAXUvf695e
         4vmA==
X-Gm-Message-State: APjAAAWShkr4i7nbEHOGxboDET43lDTwveeqLyoITmpjLmsJp9cR1B1b
        0rvdxGnVa9/A7HUZz+o=
X-Google-Smtp-Source: APXvYqwNq64USdC3EWV9X5HOPlzyJCMvIB7MFjcqY+UTX8r3M7orfqS0cmgPBRzCulwxlAtK5fpzqA==
X-Received: by 2002:a05:6402:378:: with SMTP id s24mr564670edw.103.1580158440174;
        Mon, 27 Jan 2020 12:54:00 -0800 (PST)
Received: from ?IPv6:2a02:810a:8c80:d2c:1d4:baf0:179f:5856? ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id bs4sm294772edb.16.2020.01.27.12.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 12:53:59 -0800 (PST)
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net>
 <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
 <20200125200554.GC5519@coredump.intra.peff.net>
 <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
 <dfcf0201-b634-2274-f041-a6ec4491825a@googlemail.com>
Message-ID: <4715ac3d-0d85-c8f9-4cc1-cad58d1c1cd6@googlemail.com>
Date:   Mon, 27 Jan 2020 21:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dfcf0201-b634-2274-f041-a6ec4491825a@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27.01.20 20:48, Bert Wesarg wrote:
> Dear Jeff,
> 
> On 27.01.20 08:00, Bert Wesarg wrote:
>> On 25.01.20 21:05, Jeff King wrote:
>>> On Sat, Jan 25, 2020 at 08:38:04AM +0100, Bert Wesarg wrote:
>>>
>>>> thanks for this pointer. My initial pointer was the help for push.default:
>>>>
>>>>   From git-config(1):
>>>>
>>>>         push.default
>>>>             Defines the action git push should take if no refspec is explicitly
>>>>             given. Different values are well-suited for specific workflows; for
>>>>
>>>> Thus I expected, that this takes effect, when just calling 'git push'.
>>>
>>> Yeah, I agree "explicitly given" is vague there. Perhaps the patch below
>>> is worth doing?
>>>
>>>> What I actually want to achieve, is to track a remote branch with a
>>>> different name locally, but 'git push' should nevertheless push to
>>>> tracked remote branch.
>>>>
>>>> In my example above, befor adding the 'push.origin.push' refspec, rename the branch:
>>>>
>>>>      $ git branch -m local
>>>>      $ git push --dry-run
>>>>        To ../bare.git
>>>>         * [new branch]      local -> local
>>>>
>>>> Is it possible that this pushes to the tracked branch automatically,
>>>> and because I have multiple such branches, without the use of a push
>>>> refspec.
>>>
>>> I think if push.default is set to "upstream" then it would do what you
>>> want as long as you set the upstream of "local" (e.g., by doing "git
>>> branch --set-upstream-to=origin/master local).
>>
>> Thanks. This pushes only the current branch and honors the 'rename'.
> 
> while this works …
> 
>>
>>>
>>> There's another way of doing this, which is when you have a "triangular"
>>> flow: you might pull changes from origin/master into your local branch
>>> X, but then push them elsewhere. Usually this would be pushing to a
>>> branch named X on a different remote than origin (e.g., your public fork
>>> of upstream on a server). And for that you can set branch.X.pushRemote.
> 
> … it does not play well if you have have both flows in one repository. And I do have both flows. I track the upstream 'master' in the local branch 'Y' and I have also a branch 'X' which is based on 'Y' but should be pushed to a different remote as branch 'Y'. I have configured 'branch.X.pushRemote = triangular' but with 'push.default' set to 'upstream' I get this when:
> 
>      $ git push triangular
>      fatal: You are pushing to remote 'triangular', which is not the upstream of
>      your current branch 'X', without telling me what to push
>      to update which remote branch.
> 
> In this simple case, without a renaming, I would expect that 'git push' just works. May be just fallback to 'simple' if 'upstream' does not resolve to a fully qualified push?

Falling back to simple/current seems to work for my case:

diff --git a/builtin/push.c b/builtin/push.c
index 6dbf0f0bb7..6b2fac7977 100644 builtin/push.c
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -259,7 +259,10 @@ static void setup_default_push_refspecs(struct remote *remote)
                 break;
  
         case PUSH_DEFAULT_UPSTREAM:
-               setup_push_upstream(remote, branch, triangular, 0);
+               if (triangular)
+                       setup_push_current(remote, branch);
+               else
+                       setup_push_upstream(remote, branch, triangular, 0);
                 break;
  
         case PUSH_DEFAULT_CURRENT:

It has some fallouts in the test suite, obviously. But is this something we should pursue at all?

Bert
