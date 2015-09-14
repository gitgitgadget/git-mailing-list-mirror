From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Mon, 14 Sep 2015 10:41:45 -0700
Message-ID: <xmqqwpvsx5ie.fsf@gitster.mtv.corp.google.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
	<CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:42:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXlI-0007kw-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbbINRls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:41:48 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32913 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbINRlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:41:47 -0400
Received: by pacex6 with SMTP id ex6so150124548pac.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4Bixc2CCUMaumrhANoDHgqlwl3ccdcKTj6kE+5+bCDI=;
        b=Ql03bLdI2Att6D49PRBLHn46R8szUm8cuDsf+GJ3wJMWWt4pyaJvKF2XeZkWEiaVds
         l7D6rw+tWbY9n+K0rCSrE2RF7MeQOH6wiMYN+v44NigPu+M7+yw9pasov6/LKdri0u7y
         3bUb0WzQyLb8SK9OLkq/DlxI1S+CfHpSTl6sQS/w/qZaOj2fHIZsqG9FNhxMLHPrwXCg
         xivl/JCGP4pqxiyE2Tdv5f/clgPkWa2Ubiu1UpXIZYFtMo/UcHbljieZd5pt813LNWbH
         r7AsmjV+cavIlGHGjA3dKhED69W3RWcJbY+JRb+Y2kiI+OoQZ/kx0A4WqMzSOhBtk9aP
         gKqw==
X-Received: by 10.66.220.2 with SMTP id ps2mr36665919pac.128.1442252507338;
        Mon, 14 Sep 2015 10:41:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id fe8sm17449068pab.40.2015.09.14.10.41.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:41:46 -0700 (PDT)
In-Reply-To: <CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
	(Mike Rappazzo's message of "Mon, 14 Sep 2015 08:20:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277850>

Mike Rappazzo <rappazzo@gmail.com> writes:

> On Sat, Sep 12, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +struct worktree_list *get_worktree_list()
>>
>> Can we be more concise and call this get_worktrees()?
>
> I prefer 'get_worktree_list' because I also added the 'get_worktree'
> function, and I wanted to differentiate
> the function names.

I'd say that plural can be differentiating enough; it probably is a
matter of taste.  How often do external callers want to call
get_worktree() and not get_worktrees()?

>>> diff --git a/worktree.h b/worktree.h
>>> new file mode 100644
>>> index 0000000..2bc0ab8
>>> --- /dev/null
>>> +++ b/worktree.h
>>> @@ -0,0 +1,48 @@
>>> +#ifndef WORKTREE_H
>>> +#define WORKTREE_H
>>> +
>>> +struct worktree {
>>> +       char *path;
>>> +       char *git_dir;
>>> +       char *head_ref;
>>> +       unsigned char head_sha1[20];
>>> +       int is_detached;
>>> +       int is_bare;
>>> +};
>>> +
>>> +struct worktree_list {
>>> +       struct worktree *worktree;
>>> +       struct worktree_list *next;
>>> +};
>>
>> I don't care too strongly, but an alternate approach (which I probably
>> would have taken) would be to have get_worktrees() simply return an
>> array of 'struct worktree' objects, hence no need for the additional
>> 'struct worktree_list'.

I do not think we are using this to hold thousands of worktree
objects in core.  Adding "struct worktree *next" pointer to the
worktree object itself would probably be sufficient for the need of
codepaths that want to enumerate and iterate over them and that
would be another way to lose the extra structure.
