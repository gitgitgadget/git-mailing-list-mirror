From: Johan Herland <johan@herland.net>
Subject: Re: git-note -C changes commit type?
Date: Wed, 12 Feb 2014 10:50:50 +0100
Message-ID: <CALKQrgdnGhc-y3WMf+zej4M+O4NMhLKusE-N6dX_xKVViZmQzA@mail.gmail.com>
References: <1392139407.12790.7.camel@kirk>
	<CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
	<xmqqvbwlnqi1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joachim Breitner <mail@joachim-breitner.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 10:51:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDWT9-0007af-9a
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 10:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbaBLJu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 04:50:58 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:35724 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaBLJu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 04:50:56 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WDWT0-00013y-8c
	for git@vger.kernel.org; Wed, 12 Feb 2014 10:50:54 +0100
Received: from mail-pb0-f53.google.com ([209.85.160.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WDWSz-000Bfr-I1
	for git@vger.kernel.org; Wed, 12 Feb 2014 10:50:54 +0100
Received: by mail-pb0-f53.google.com with SMTP id md12so8988435pbc.40
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 01:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LRxKBueq9bwsdJCfJm33d6C5lGoRjwES+41r0A2C3kE=;
        b=VGHzg6eFBYlytoT0WWu/4leN/7W8ddYQzdh3tVcdhDP7z58v+M/u2ykUp4HPAX7bUG
         oMFPyCyZrKGq4YJ0OFc2aPNvYBzH7O9Swx3cQNze2FUMoplIk3y6EWODqdE1UmovY3xe
         2XZp6mPCOAKweejxcVfDyOHgyIy4p+WqcxU3ZG85SoY874Y1UgHyRZoLNTJlwaJ3Y1lW
         GXohRwUZQbW1A0wrGRJOkbZFA0B6y5d+e/GeDc9VWAr9OSlglRFzQRpQN/G0R4jH8kW2
         btImcZAtcGZthmfoE0DBzFQL+WW3fFskcr9WW4MFr8WTzNuKgyya3wwL8VcGGp/Uo6Tq
         i4rw==
X-Received: by 10.68.138.165 with SMTP id qr5mr50739480pbb.123.1392198650498;
 Wed, 12 Feb 2014 01:50:50 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Wed, 12 Feb 2014 01:50:50 -0800 (PST)
In-Reply-To: <xmqqvbwlnqi1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241978>

On Wed, Feb 12, 2014 at 1:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> There is currently no way the "git notes" commands will allow you to
>> store the 3d7de37 commit object directly as a note. There is also
>> (AFAICS) no easy workaround (git fast-import could've been a
>> workaround if it did not already require the first N/notemodify
>> argument to be a blob object). The best alternative, off the top of my
>> head, would be to write your own program using the notes.h API to
>> manipulate the notes tree directly (or - suboptimally - use other
>> low-level Git operations to do the same).
>
> Even worse. I do not think such a non-blob object in the notes tree
> does not participate in the reachability at all, so you won't be
> able to fetch "refs/notes/whatever" and expect to get a useful
> result.

s/non-blob/non-(blob-or-tree)/

Any object type that is deemed reachable by reference from a regular
git tree object will also be usable (as far as reachability goes) in a
notes tree.

> I do not think storing the raw bits of commit object as a
> blob in the notes tree is useful behaviour, either.  The command
> probably should refuse to get anything non-blob via that option.

Patch coming up...

> Perhaps the notes entry should just note the object name of whatever
> commit it wants to refer to in a *blob*?

Agreed.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
