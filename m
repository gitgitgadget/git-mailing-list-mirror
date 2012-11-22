From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 2/4] diff: introduce diff.submodule configuration variable
Date: Thu, 22 Nov 2012 15:10:06 +0530
Message-ID: <CALkWK0kZ0p4ptmAySXKspU2qJm9gm6Wg4uyBhRnXQ4qdSC34FA@mail.gmail.com>
References: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-3-git-send-email-artagnon@gmail.com> <7vk3tht7yz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 19:28:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbbVp-0002pW-UI
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab2KVS2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:28:17 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56346 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab2KVS2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:28:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8323643obb.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 10:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CQ2HRl4lT7qrFKo61USAToN+pqXAZ5rlSU4Z3/EEnxE=;
        b=VF3Si/fJqaOduJXQG/RvPzlDU/7PL1iDJ7bWTFZohtxotn91UWT6VcAte0uCv4xD2a
         04usFGtVawxQ15dQWzxwi3JQu+RKa4LdIbGCUxZ2BctDOQkS6qzCzvnvtBY5HVTCrmVe
         2mQEa1+2Y36Dm1P7KIE3Am33WZNg30rcXLmk8wVfzD5iFJlxoOLeQ/2xjsNsbV6NyX5m
         snw0iTWmiEmc6TI2LDoJYOV1xFRZZ+IvRZTQ0AWOe+/+lAcpRxzVaVfLtcldgUCTBLxf
         QWRrQS1kwQ5r3XH9PmQsc2HqzqvK8OhQRAOEY9cYbMJopDnLcIqlm6iFPItR2GByb6kJ
         AnkA==
Received: by 10.60.169.243 with SMTP id ah19mr18594895oec.127.1353577226554;
 Thu, 22 Nov 2012 01:40:26 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Thu, 22 Nov 2012 01:40:06 -0800 (PST)
In-Reply-To: <7vk3tht7yz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210179>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
>> index 6c01d0c..e401814 100755
>> --- a/t/t4041-diff-submodule-option.sh
>> +++ b/t/t4041-diff-submodule-option.sh
>> @@ -33,6 +33,7 @@ test_create_repo sm1 &&
>>  add_file . foo >/dev/null
>>
>>  head1=$(add_file sm1 foo1 foo2)
>> +fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)
>
> That looks like quite a roundabout way to say
>
>         $(cd sm1; git rev-parse --verify HEAD)
>
> doesn't it?  I know this is just moved code from the original, so I
> am not saying this should be fixed in this commit.

Exactly what I was thinking.

> Existing code in t7401 may want to be cleaned up, perhaps after this
> topic settles.  The add_file() function, for example, has at least
> these points:
>
>  - do we know 7 hexdigits is always the right precision?
>  - what happens when it fails to create a commit in one of the steps
>    while looping over "$@" in its loop?
>  - the function uses the "cd there and then come back", not
>    "go there in a subshell and do whatever it needs to" pattern.

Okay, will do.

>> +test_expect_success 'added submodule, set diff.submodule' "
>
> s/added/add/;

I see that the topic is already in `next`.  Do you want to fix it up there?

> Shouldn't it test the base case where no diff.submodule is set?  For
> those people, the patch should not change the output when they do or
> do not pass --submodule option, right?

When no diff.submodule is set, `git diff --submodule` should just work
as before; isn't this tested by the other tests in the file?

Ram
