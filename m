From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/8] update-index: add untracked cache notifications
Date: Fri, 11 Dec 2015 09:51:53 +0100
Message-ID: <CAP8UFD1F-s_oPEgSXehcTV7UD1uC_Uxf8cMNPfyFro8fj4zZEA@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-2-git-send-email-chriscool@tuxfamily.org>
	<xmqq6108lq3w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 09:52:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7JQl-0004ql-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 09:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbbLKIv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 03:51:56 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35138 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbLKIvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 03:51:55 -0500
Received: by lbpu9 with SMTP id u9so59697448lbp.2
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 00:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=38so1ss/FAGMT9tbVJdzNAXUm4Yxc2MJ9D+AM+Bjxs4=;
        b=P5fU72UareOUm4lQA7nXJ9UBt53RFC3siTZENp1qJFLbB6C2NJTEMEdnfRhN9fHy32
         mmLDRC9DDUZuaGzrZhEV80fE7yM8Ff3VKpPnFRCGeqIh0zzSWW5OWR5YHh3A/Zu5DhKK
         IPz4Bic59Z66XKg1pwNwDUbz/LD9yL/I/PZ3kRgJ8RZGb03W87hqCJ8mWlilau1/OF2W
         6hqogrmTzk51OsREdTAPO3osCr2iTDTffU70o5YGwFgUeawQxXxvZ30Q7MIlfT1sxMZH
         jUNPbRmz4gGPFbVkTIuCY4ur5e6fijU8XdyWCFMw8VCQGO6Tlh++BYHnvL67au3zOdvv
         C9iQ==
X-Received: by 10.112.242.167 with SMTP id wr7mr6362340lbc.69.1449823913767;
 Fri, 11 Dec 2015 00:51:53 -0800 (PST)
Received: by 10.25.23.90 with HTTP; Fri, 11 Dec 2015 00:51:53 -0800 (PST)
In-Reply-To: <xmqq6108lq3w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282251>

On Tue, Dec 8, 2015 at 8:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Doing:
>>
>>   cd /tmp
>>   git --git-dir=/git/somewhere/else/.git update-index --untracked-cache
>>
>> doesn't work how one would expect. It hardcodes "/tmp" as the directory
>> that "works" into the index, so if you use the working tree, you'll
>> never use the untracked cache.
>
> I think your "expectation" needs to be more explicitly spelled out.
>
> "git -C /tmp --git-dir=/git/somewhere/else/.git" is a valid way to
> use that repository you have in somewhere else to track things under
> /tmp/ (as you are only passing GIT_DIR but not GIT_WORK_TREE, the
> cwd, i.e. /tmp, is the root level of the working tree), and for such
> a usage, the above command works as expected.  Perhaps
>
>     Attempting to flip the untracked-cache feature on for a random index
>     file with
>
>        cd /random/unrelated/place
>        git --git-dir=/somewhere/else/.git update-index --untracked-cache
>
>     would not work as you might expect.  Because flipping the
>     feature on in the index also records the location of the
>     corresponding working tree (/random/unrelated/place in the above
>     example), when the index is subsequently used to keep track of
>     files in the working tree in /somewhere/else, the feature is
>     disabled.
>
> may be an improvement.

Yeah, I agree that it is better. I have included your explanations in
the next version I will send. Thanks.

> The index already implicitly records where the working tree was and
> that is not limited to untracked-cache option.  For example, if you
> have your repository and its working tree in /git/somewhere/else,
> which does not have a path X, then doing:
>
>     cd /tmp && >tmp/X
>     git --git-dir=/git/somewhere/else/.git update-index --add X
>
> would store X taken from /tmp in the index, so subsequent use of the
> index "knows" about X that was taken outside /git/somewhere/else/
> after the above command finishes and the subsequent use is made
> without the --git-dir parameter, e.g.
>
>     cd /git/somewhere/else/ && git diff-index --cached HEAD'
>
> would say that you added X, even though /git/somewhere/else/ may not
> have that X at all.  And this is not limited to update-index,
> either.  You can temporarily use --git-dir with "git add X" and the
> result would persist the same way in the index.
>
> I think the moral of the story is that you are not expected to
> randomly use git-dir and git-work-tree to point at different places
> without knowing what you are doing, and we may need a way to help
> people understand what is going on when it is done by a mistake.

Yeah, I agree, and I think displaying more information might be a good way.

> The patch to show result from xgetcwd() and get_git_work_tree() may
> be a step in the right direction, but if the user is not doing
> anything fancy, "Testing mtime in /long/path/to/the/directory" would
> be irritatingly verbose.

Yeah, but after this series only "--test-untracked-cache" does any
testing, and the 10 seconds time it takes are probably more irritating
than its output.

> I wonder if it is easy to tell when the user is doing such an
> unnatural thing.  Off the top of my head, when the working tree is
> anywhere other than one level above $GIT_DIR, the user is doing
> something unusual; I do not know if there are cases where the user
> is doing something unnatural if $GIT_WORK_TREE is one level above
> $GIT_DIR, though.

Yeah, it could only print a warning in case something unusual is done.
I am not sure it is worth it though.

Thanks,
Christian.
