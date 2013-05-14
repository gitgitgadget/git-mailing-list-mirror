From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 15:50:25 -0500
Message-ID: <CAMP44s2B3bFWXZe0aL_GMXe_56MbhSZXf-65rT364nY3shYwUA@mail.gmail.com>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	<7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 22:50:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcMBG-0000Fr-VU
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758425Ab3ENUu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:50:28 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:39254 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3ENUu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:50:27 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so1129713lbd.29
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jH0kMBjdHvJc1QmBP+s+CtdboegkygsfZOvXsfvlnqs=;
        b=sWvDDRlp0xR1FuvezRlGdBMBSSO6evm9Lz6k0gb4tBLl4JWDfErzvacM40v57vfT73
         F9iQCN3gpOwPWV/fy/jkxPgKNIe+vX5UROQvPt7STLBtyqYsjI7VUKx/rvbOGZREAY4R
         j6bUv0Mt2YPBKLd8o/YT4poJWmDho5o7pnlkivzGJvIIzfefJ4PQATH1+mgZfSqIjJla
         dvqYO+KQq0SopfMvtxpOkBMs1+2iLHbD4VcOv3uawaFdhaC1lBXm+oWQl08TyYYp5nAE
         K2lVWAb5ssInLyaRh6nA01pERywgSJa7BR/3nOHDYhf3dWqG0VmpuS5HLJScxmAls5t5
         h48w==
X-Received: by 10.152.3.167 with SMTP id d7mr3957238lad.38.1368564625177; Tue,
 14 May 2013 13:50:25 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 13:50:25 -0700 (PDT)
In-Reply-To: <7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224344>

On Tue, May 14, 2013 at 3:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, May 14, 2013 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> If a clone exists with the old organization (v1.8.2) it will prevent the
>>>> new shared repository organization from working, so let's remove this
>>>> repository, which is not used any more.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>
>>> What happens with and without this patch to an existing user from
>>> 1.8.2 days, when she does what?
>>
>> I already explained it would prevent the new shared repository
>> organization from working, so the old organization would be used; the
>> repositories won't be shared.
>>
>>> A sample answer (to show the level of descriptiveness, not the
>>> content, I am epecting) might go something like "Because the
>>> organization is different, it will barf whenever she tries to
>>> incrementally update from the other side. By removing the old one
>>> 1.8.3 contrib/ does not understand, at least we can unstuck her; she
>>> ends up reimporting the whole history, though."
>>
>> Bazaar won't barf, the repositories will be duplicated, so the shared
>> feature won't work.
>
> But by removing the old incarnation, you are getting rid of the copy
> for which the shared feature will not work, so with patch, "won't
> work" is no longer an issue.  Is the user making a trade-off by
> using Git with this patch?  What is she losing by removal, if
> anything?

No. The way repositories work in bazaar is tricky:

Suppose you have a directory like this:

+* first/second/foo
+* first/second/bar

Both the branch and the repository are on the same directory (hence
+*). We have two branches, and two independent repositories.

And then you have a shared repo:

+ first/
* first/second/foo
* first/second/bar

Now we have a single repository shared between two branches.

But:

+ first/
+* first/second
+* first/second/foo
+* first/second/bar

If there's another repository in-between, neither 'foo' nor 'bar' can
reach 'first', so they are stuck with the repository in 'second',
which is not a shared repository, so they must create their own
repositories, but even if they could use 'second', there still would
be a problem:

+ first/
+* first/second
+* first/second/foo
+* first/second/bar
+* first/third
+* first/third/foo
+* first/third/bar

We want 'second' and 'third' to share to object tree, but we can't.

This patch would remove the old repository ('second' and 'third') so
we have exactly what we want:

+ first/
* first/second/foo
* first/second/bar
* first/third/foo
* first/third/bar

A single bzr repository shared by all the branches and all the repos.

In reality it probably wouldn't be a big deal, because in v1.8.2 users
couldn't clone true bzr repos, but there are some bazaar repos with a
single branch they could clone, and there would be a single duplicated
repo, like this:

+ first/
+* first/second/foo
+* first/third/foo

-- 
Felipe Contreras
