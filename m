From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Fri, 11 Sep 2015 14:52:06 -0700
Message-ID: <xmqqbnd8zks9.fsf@gitster.mtv.corp.google.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-3-git-send-email-rappazzo@gmail.com>
	<xmqqk2rx0w54.fsf@gitster.mtv.corp.google.com>
	<CANoM8SUGmb=fSFqF4DTuW2F5oPVaim-=SP76rqwwqtzcsNQf=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:52:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaWEw-0005WG-8Q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 23:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbbIKVwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 17:52:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35567 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbbIKVwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 17:52:08 -0400
Received: by pacfv12 with SMTP id fv12so87018061pac.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QNq+WJN6tuUefw0NS0LkJLxmgInrae3z6RZJ+x1+xqE=;
        b=vLCkQ9gVyEPbrflRzYZ4P9xBV6ooAPVG6UU6RygQBtqIYPqUPZwmzpZITB9YyTBjGD
         BPPG7I1vP9eqWRmu8pzNYuk+WMu4Dg5Ebe+Obnv6KZYR0XagLfXYwaLALKIoy1diZFY3
         qXc4q8pZeW4NyKNr5gz1HuDwGWet/XFQK1fwoRcnd4r6aLxJ7dhZnvX9BEdcfT/mka6X
         0YKvcSPGTPy5K5U9QyhOeJVcghhCgtQjYGVex+szx4gWII4DW5L6kpkTgH2HZVs25dQo
         gxwxfE4/efomEyRic/5W3urDUJDoiBzyxCrQjtTqfw6jra4Ivqw2h4TQU/SM5yAeuWv2
         Axog==
X-Received: by 10.66.248.72 with SMTP id yk8mr2167541pac.112.1442008327700;
        Fri, 11 Sep 2015 14:52:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id un2sm2170217pac.28.2015.09.11.14.52.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 14:52:07 -0700 (PDT)
In-Reply-To: <CANoM8SUGmb=fSFqF4DTuW2F5oPVaim-=SP76rqwwqtzcsNQf=g@mail.gmail.com>
	(Mike Rappazzo's message of "Fri, 11 Sep 2015 17:43:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277700>

Mike Rappazzo <rappazzo@gmail.com> writes:

> On Fri, Sep 11, 2015 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Rappazzo <rappazzo@gmail.com> writes:
>>
>>> The code formerly in branch.c was largely the basis of the
>>> get_worktree_list implementation is now moved to worktree.c,
>>> and the find_shared_symref implementation has been refactored
>>> to use get_worktree_list
>>>
>>
>> Copying the bulk of the function in 1/3 and then removing the
>> original here made it somewhat hard to compare what got changed in
>> the implementation.
>>
>> I _think_ the code structure in the end result is more or less
>> right, though.
>
> Should I squash these first two commits together in the next series?

Mashing the two into one patch would not help anybody, I would
suspect.

I didn't try this myself, but if I were doing this and if I were
aiming for perfection, then I would probably try to split it even
finer.  Refactor the original while both the callers and the helpers
are still inside branch.c (hence the early steps in the series will
not benefit worktree.c at all---worktree.c may not even exist in
them yet), move refactored helpers to worktree.[ch] (and at this
step you may not even have get_worktree() etc. yet), and then use
that refactored helper while writing new functions in worktree.c.
