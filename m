From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git-note -C changes commit type?
Date: Tue, 11 Feb 2014 21:16:44 -0800
Message-ID: <8E256253-7470-4195-9A62-489870530915@gmail.com>
References: <1392139407.12790.7.camel@kirk> <CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com> <xmqqvbwlnqi1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Joachim Breitner <mail@joachim-breitner.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 06:16:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDSBo-0002s2-AD
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 06:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbaBLFQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 00:16:48 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40788 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaBLFQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 00:16:47 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so8740732pab.38
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 21:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=yfE9tGGejV6ATNmeEJKQNg65LqpjiNPgYv5PhwQqLa0=;
        b=dn2XjW4KPS9nR8yePWZqPhYd0buJNMnzx6GeJyoEezv8vsDX32oXb+Xnptk2tR3xqm
         sNJS7Xo5NAZ3mQoZajrNZPV3VXv14mmE2qJTHs5jh5XSFEY6M7nATUSssWRG73/wIJni
         Nwr7ZBUiVhrnsJQ2XaTdUCiqLLbHrW148lhqEql2+rlaEfHibCFjKpBcDVFaAfpREo/g
         nxQYgU/fjNoHXciwx+cpgGyomnXqqUJ51/AUcALTbHF156hQQ1xxdsd2QS5Mt9kCk1Bc
         gyca4n6A4KXvSuOdCmTwjlyIhJu8nMwFL6opQx5RUFbd1zXk9gSlQLmOHdDo4Y+1C8nb
         /neA==
X-Received: by 10.68.131.202 with SMTP id oo10mr48585505pbb.35.1392182206750;
        Tue, 11 Feb 2014 21:16:46 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id nz11sm21373899pab.6.2014.02.11.21.16.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Feb 2014 21:16:46 -0800 (PST)
In-Reply-To: <xmqqvbwlnqi1.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241971>

On Feb 11, 2014, at 16:06, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
>
>> There is currently no way the "git notes" commands will allow you to
>> store the 3d7de37 commit object directly as a note. There is also
>> (AFAICS) no easy workaround (git fast-import could've been a
>> workaround if it did not already require the first N/notemodify
>> argument to be a blob object). The best alternative, off the top of  
>> my
>> head, would be to write your own program using the notes.h API to
>> manipulate the notes tree directly (or - suboptimally - use other
>> low-level Git operations to do the same).
>
> Even worse. I do not think such a non-blob object in the notes tree
> does not participate in the reachability at all, so you won't be
> able to fetch "refs/notes/whatever" and expect to get a useful
> result.  I do not think storing the raw bits of commit object as a
> blob in the notes tree is useful behaviour, either.  The command
> probably should refuse to get anything non-blob via that option.

It would be nice if it let you store a tree or a blob, but I agree  
that it should complain about anything non-blob by default and if tree  
were to be allowed, that should require a special option.

If you do manually construct a notes tree that has a 'tree' entry  
instead of a blob, as soon as you add a new note, that 'tree' gets  
turned back into a blob again.  I was trying to attach a 'tree' as my  
note a while back and decided not to pursue it further after I found  
it got transformed into a 'blob' on the next notes modification.
