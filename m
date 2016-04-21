From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 09/12] worktree.c: test if branch being rebased in
 another worktree
Date: Thu, 21 Apr 2016 07:37:03 +0700
Message-ID: <CACsJy8CSuy_ZnNNm+w+KjGkz9AF2CLLXcRZ6sTtp-VFOkNA73g@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com> <1461158693-21289-10-git-send-email-pclouds@gmail.com>
 <xmqqh9eww40g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 02:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at2cn-00042D-Em
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 02:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcDUAhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 20:37:35 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35680 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbcDUAhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 20:37:35 -0400
Received: by mail-lf0-f48.google.com with SMTP id c126so51090659lfb.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0enjFllezBpeIt/z0JCapiv5VVfLc3Fq6wPva4n568E=;
        b=q73p7wH1g4+HSw5A3q9irXwq21Vzox2NN9xmINSdfHrX2xcO4oQBirXseaD2CJJwW0
         HRxk3c/QbojnntCP/jZ92iJEcY/di/MDsZ8lS0mMApNz+t1pTD/pIsERWhbpYnwciwZD
         8Y3Dm7QvbXeSimVeCZmmH98Z9gzfD8G9h7lNEKfHln6EYIf9Zc/SdVBwcuCFjq/UQlXc
         CKzKNPs+k/AQPlZTzlIoUAxPVk5Z8VMTqTmb2KNfXnDQanEC0Rx0nIEkHuQgjPipAvIY
         16E37MKf7M0PeYnIcK5rmX9ODKtOcitc9Mdm512cf5IOMOpakBvQeQk4HDqqe71eKg+8
         1KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0enjFllezBpeIt/z0JCapiv5VVfLc3Fq6wPva4n568E=;
        b=MM3sEWg0iuaU0laweWoYlVNUFMYjeZWDfKldhQKM546a0ZOySd3JawJlFdbUuIK+4q
         TabGxgloMqsPNXQbUQh5jdR8UIKEKhDFrsZf8Gi+HGdhr/GEdnJyDvXfo1iLziyzQv3x
         WgeaKRscio3riYDa9xbEEZwcdSCvgh7Hng7FQy7ygYYoQEIq1Y0fyoDWZHUhj4FaQ5L8
         7zLYO64Bxjg/gI456ETIC+Ef8M1PL9AF3QRNbQBv15EsUK0ubmkHXy7RmtaBe1TPK17U
         P5X5mZfUSf1BhmYbRRnMcKnEHxUEaKiELwipdAOtRvfObuzNNyjFlFTtLnU3mj+JEJ9Z
         lLGg==
X-Gm-Message-State: AOPr4FWYyxeegnywzPKpWCYhBY9Nm894Q2aZlmdgEwTveIxJnBb9qenqzRHCjVwCBhquL7P2KALGLalW8o3rxg==
X-Received: by 10.25.22.19 with SMTP id m19mr4996249lfi.118.1461199053360;
 Wed, 20 Apr 2016 17:37:33 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 17:37:03 -0700 (PDT)
In-Reply-To: <xmqqh9eww40g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292091>

On Thu, Apr 21, 2016 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index efcbd8f..6041718 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1111,7 +1111,7 @@ static int checkout_branch(struct checkout_opts *opts,
>>               char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
>>               if (head_ref &&
>>                   (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
>> -                     die_if_checked_out(new->path);
>> +                     die_if_checked_out(new->path, 1);
>>               free(head_ref);
>>       }
>
> So the idea is "if the branch is checked out (or "being worked on"
> even if technically the HEAD is detached, like with 'rebase')
> anywhere, callers of die-if-checked-out in general want to die; but
> for this caller, it is OK if the place the branch is checked out or
> being worked on is in this repository"?
>
> I understand die_if_checked_out() taking that "ignore this one" bit
> may be sensible, but I do not understand why find_shared_symref()
> needs to be told about it.  The change makes the meaning of the
> find_shared_symref() function unclear.  It used to mean "This
> symbolic ref cannot point at the same ref in different worktrees, so
> for a given pair of a symbolic ref and a concrete ref, there can be
> at most one worktree in which the symbolic ref points at that ref".
> That is already a mouthful.  As the worktree structure already have
> "Am I the current worktree?" bit, "ignore" logic can easily be done
> inside die_if_checked_out() and that would help find_shared_symref()
> stay simpler and more focused function, no?

That was the intention when I made find_shared_symref() return struct
worktree * instead of char *. I forget why I changed my mind and not
do so. The only case when find_shared_symref should do this is when a
ref is shared twice, then we need to ignore current worktree from
inside the loop. But that can't happen. Will move this
ignore-current-worktree test to die_if_checked_out().
-- 
Duy
