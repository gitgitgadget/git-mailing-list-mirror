From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Sat, 22 Feb 2014 16:14:33 +0700
Message-ID: <CACsJy8Cyf6Mu3q1VWH7srCK4m=+UgR4m7RiNkMv-nr8eF4YAJA@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8DnjQyzY2ym7=fAQzThuhMuFzGLuKc35JJXn5FfB7r4Gg@mail.gmail.com>
 <87fvnbhdn7.fsf@fencepost.gnu.org> <877g8nh6k8.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 22 10:16:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8gg-0001XD-32
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbaBVJPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:15:10 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:48755 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaBVJPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:15:06 -0500
Received: by mail-qg0-f46.google.com with SMTP id e89so9908642qgf.5
        for <git@vger.kernel.org>; Sat, 22 Feb 2014 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=meb/NjuTWl7nlF25g68+0wmzYroNBgFgXcSz2y1Uz1c=;
        b=Y7msOFNSjc9p3Bi5w4XNAJCbJJLU2gjmt03TtNK9fK6/SIgQhnjTnj3RIBzyjmOVDB
         xWrqv7WCtgVJ9MTI2m8JxTIcxiQumUaMKzT1gvvRq6cKfHIlyLS0e8tAhGL7pLZmygaw
         oZPmtQlBEJBzkc76MmK1K7syJCi8IZL4WXyh6/w6bhaGNqw79iwpJ3hkcqUwsKud3vp4
         wIs0VK2q4ruqpTRI6uQSBbZE281CaBNIwZQz2ahxyTjMjKAAeYNPVaYM6Rl4TVRAyvIZ
         J51ahPv79UYPfDdyf/sL+A9nlobSXzbZcjeerfNNGtDYL3cNG1T90s0HgZ8apagoSm8a
         hpKw==
X-Received: by 10.140.84.40 with SMTP id k37mr8860066qgd.98.1393060503318;
 Sat, 22 Feb 2014 01:15:03 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 22 Feb 2014 01:14:33 -0800 (PST)
In-Reply-To: <877g8nh6k8.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242513>

On Sat, Feb 22, 2014 at 3:53 PM, David Kastrup <dak@gnu.org> wrote:
> David Kastrup <dak@gnu.org> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> OK with git://git.savannah.gnu.org/emacs.git we have
>>>
>>>  - a 209MB pack with --aggressive
>>>  - 1.3GB with --depth=50
>>>  - 1.3GB with --window=4000 --depth=32
>>>  - 1.3GB with --depth=20
>>>  - 821MB with --depth=250 for commits --before=2.years.ago, --depth=50
>>> for the rest
>>>
>>> So I don't think we should go with your following patch because the
>>> size explosion is just too much no matter how faster it could be. An
>>> immediate action could be just make --depth=250 configurable and let
>>> people deal with it. A better option is something like "3 repack
>>> steps" you described where we pack deep depth first, mark .keep, pack
>>> shallower depth and combine them all into one.
>>>
>>> I'm not really happy with --depth=250 producing 209MB while
>>> --depth=250 --before=2.year.ago a 800MB pack. It looks wrong (or maybe
>>> I did something wrong)
>>
>> That does look strange: Emacs has a history of more than 30 years.  But
>> the Git mirror is quite younger.  Maybe one needs to make sure to use
>> the author date rather than the commit date here?

I think commit date is fine because it covers a large portion of
objects (649946 per total 739990) and it does not (or should not)
affect object ordering in pack-objects/rev-list.

> Another thing: did you really use --depth=250 here or did you use
> --aggressive?  It may be that the latter also sets other options?

I can't use --aggressive because I need to feed revisions directly to
pack-objects. --aggressive also sets --window=250. Thanks for
checking. My machine will have another workout session.
-- 
Duy
