From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Thu, 2 May 2013 01:10:09 +0530
Message-ID: <CALkWK0=Z81f4c1X3uXO4O5q_Dj2hRJjSY-i-aDtZ0KqSyo5Wtg@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-4-git-send-email-artagnon@gmail.com> <CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
 <CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com> <CAMP44s0sRqsmhbv-GA5x0FPc5msouSoGaU_Wg51E0F9bNsmkjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXctc-0001AB-4r
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab3EATkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:40:51 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:64209 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402Ab3EATkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:40:49 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so1663028iak.15
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=H2svxcuudJIFhS5TTPwr1Es4M0duWSOopO/48UQpw4s=;
        b=rh5kr/dy9rCu87KeElDAWgKoJl8ddJ2JA/IPsVUMc2ddV/q0DMlPxUYPVXg/URTrBN
         /6SsJ8sYeP24Mcc3JZ2jfdIY65O3KeXzgVwDSMtQUvqS5KdWo/f7kzEypYAOMmNaZLoG
         sx5JVOLrARX7Qx4HhaG26K5Pdh7IO/tgvYSQrZk9KgwoIYTZhcqzV3QGJPK2sufshzpe
         LsCD9Otwbf/8SJdd8lBewXUMpUwDzMV+2GwGc5Et5/xON3d7HnYtV0UHNAnXYa7Bz2Mw
         U681Qw7MBRbMc6oyrmP/AiBQTw3Rkd1gwXmD70R4u9S8pp0wXix+NcaJ6KTEEYjCscPC
         RDNA==
X-Received: by 10.50.73.65 with SMTP id j1mr2472537igv.49.1367437249387; Wed,
 01 May 2013 12:40:49 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 12:40:09 -0700 (PDT)
In-Reply-To: <CAMP44s0sRqsmhbv-GA5x0FPc5msouSoGaU_Wg51E0F9bNsmkjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223130>

Felipe Contreras wrote:
> On Wed, May 1, 2013 at 1:36 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> This is not a reorganization patch.  I said "simplify": not refactor.
>
> I'd say you should start with a reorganization, and then a simplification.

You don't think I already tried that?  There is no way to sensibly
reorganize the old logic sensibly, in a way that doesn't break
anything.

>> I've changed the entire logic and written expensive comments; and I'm
>> not allowed to remove one comment which I didn't find helpful?
>
> But it is helpful.

Okay, we'll add it back if you feel strongly about it.  I thought it
would be a sore thumb when neither @{N} nor @{upstream} are explained.

>> I'm claiming that there is no functional change at the program level,
>> with the commenting*.  If you want to disprove my claim, you have to
>> write a test that breaks after this patch.
>
> The burden of proof resides in the one that makes the claim, I don't
> need to prove that there are functional changes, merely that you
> haven't met your burden of proof.

Oh, but I have.  All the tests (along with the new ones I added in [1/5]) pass.

Scientific theories stand until you can find one observation that disproves it.

> That being said, perhaps there are no _behavioral_ changes, because
> you are relegating some of the current functionality to dwim_log, but
> the code most certainly is doing something completely different.
> Before, get_sha1_basic recursively called itself when @{-N} resolved
> to a branch name, now, you rely on dwim_log to do this for you without
> recursion, which is nice, but functionally different.

Your point being?  That I shouldn't say "no functional changes"
because the logic is changing non-trivially at this level?

>>> It's not true, there might not be any @{u} in there.
>>
>> This entire structure is a success-filter.  At the end of this, if
>> !refs_found, then there has been a failure.
>
> That's irrelevant, this 'else' case is for !reflog_len, there might or
> might not be @{u} in there.

There's no need to associate one comment with one line of code.
People can see clearly see the failure case following it.

>> The Git project is already suffering from a severe shortage of
>> comments [1], and you're complaining about too many comments?
>
> Irrelevant conclusion fallacy; let's suppose that the Git project is
> indeed suffering from a shortage of comments, that doesn't imply that
> *these* comments in their present form are any good.

Is there anything _wrong_ with the comments, apart from the fact that
they seem to be too big?  I'm saying things that I cannot say in the
commit message.
