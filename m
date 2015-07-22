From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: Passing a number as an option to git tags for displaying latest tags
Date: Wed, 22 Jul 2015 12:20:46 -0700
Message-ID: <xmqq7fpsroc1.fsf@gitster.dls.corp.google.com>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
	<xmqqbnf4rohs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Halil =?utf-8?B?w5Z6dMO8cms=?= <halilozturk55@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzZV-0001Ex-0f
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbbGVTUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 15:20:49 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36741 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbbGVTUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:20:48 -0400
Received: by pdjr16 with SMTP id r16so145826762pdj.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wQfyP0ZQXwfKuPklAMgqKIJ3Zi10IT+E/DDspu7lUUk=;
        b=UxSrzRNxfIYvBDitYd9eswqeyh6rf6hwunQ6t3kW/XYYzoZiTjIOfG5AC2doIPsACF
         qjVjJpUuxzCQU3HoJK9GC5W6t95QsLZCnzPRus134WiyPL3xPyaQ4cd5GWi35zNZDr7J
         9wBCLlaHqpHwfYIx8xQDbSf9zRb9xX+tHEb08yDpBJ7Gsh9U0rb2xJA6gHUDyMGBjWXQ
         Uq1oCwfFqIrsChZ/47Zn2pu+TsDAdQw4FGJlnAGmWD0BIJkke+GA+Ut2JpfU2sKLQljl
         M59Ihv6XFYvX53OmrAG8ZmmTF6Lbkv+K9Rsge2pDkLKtyVAD3F8NT4s74fUqy+s4TR6a
         8vXQ==
X-Received: by 10.66.140.98 with SMTP id rf2mr9383578pab.138.1437592847951;
        Wed, 22 Jul 2015 12:20:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id yd8sm4738594pab.46.2015.07.22.12.20.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 12:20:47 -0700 (PDT)
In-Reply-To: <xmqqbnf4rohs.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 22 Jul 2015 12:17:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274458>

Junio C Hamano <gitster@pobox.com> writes:

> The former, sort by "time", is interesting, but you need to define
> what to do with various corner cases.  For example, some people may
> have one or more of the following desires:
>
>  * My project did not use tags for a long time, and started using it
>    recently starting from v1.1.0.  The first release only said
>    "Frotz version 1.0.0" in its commit log message.  I retroactively
>    did "git tag -s -m 'Frotz 1.1.0' v1.1.0" on that commit.

Obviously, I meant "git tag -s -m 'Frotz 1.0.0' v1.0.0" here.

>    In such a case, it is likely that I would want the sorting done
>    based on the committer date on the underlying commit, not the
>    tag's tagger date.
>
>  * When a bug is found, it is customary in my project to add a
>    "break-<something>" tag to the commit that introduces the bug
>    (and "fix-<something>" tag to the commit that fixes it).
>
>    When I want to find recently discovered breakages, I want the
>    tags whose names match "break-*" sorted by tagger dates, not the
>    underlying commit's committer dates.

Another use case may be one in which older tags are interesting.  In
other words, you need to be able to sort in reverse, too.

> The necessary ordering machinery to do the above already exists in
> "for-each-ref".  There is a GSoC project that works to unify various
> features spread across "for-each-ref", "branch -l" and "tag -l" and
> make them available to all of the three.

And the above is still true even with reverse-order use case.
