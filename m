Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43FC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243462469C
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582908318;
	bh=ezdSyKSzMGPVN5VQNESm+R7p1T/P1YrHagPI7yvUhiE=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=rVCh2+pvH1gqwTpAkG49cuIr+Hcaxc0Zl5QECKW5PlehqC22bJ8Ocjq58CNJXxvCX
	 rt6IH+knJ5ZIPnaeh6L8QvxD2QgrVS+njyWqenZpzO3uB85bGrKhlXXdttZsOzSP9S
	 uPf0WuWB9W01suYVd5oKn6vxczC7/EaxvMVrWF+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1QpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:45:16 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:45422 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgB1QpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 11:45:16 -0500
Received: by mail-lj1-f171.google.com with SMTP id e18so4008855ljn.12
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QhrjAJxSjZb19m/BPe0r48o77E2W8Aa1kU13y18EuXo=;
        b=gXSp3cTlZmbmjfRs5DZCybdOySlzpvrtPvVYmM1/X24e100XgwNt0R1iDJZbnukxJC
         iikZ8IFu1JVEJO1UE/GQmbP7Ae/UcsL9VbH7ZVIJZC8gxucCiqOFjqFXo3p/5PFWhKHj
         k6QJ8rixr9aftqOsnNtAkTMTlbRAgea9HFexA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QhrjAJxSjZb19m/BPe0r48o77E2W8Aa1kU13y18EuXo=;
        b=I8spZYDM9zK4bSpamZSXRkisVtuMHEJ8CmK3fBj8x/fFJdO7PanK4SYUG0i8vJ3ez/
         4QcWVBSpiQXP5MRrgg0sB6Y7wtcVJuosfHTIteHDcDUx6fTUqV+hfUEDNxpN4gzBbI8w
         k4/AIM4ZAqQEWtwATBUqdyHloLqU1+lt0rrs8DMkWXXwQoSkNZ2nlQkCZQDhyk/x9DR6
         vjQD5Vc8tE3Rb/2gXHZ1DGWGuE7nnEAGE3vWnY9LZN8OGB9+LEOdBq1Eplorc+vGqhIF
         7gIlPLLy8jgwqmTK3a8hlZC5jA0dzxgl82KNlRsCkILb0JvTqGZ4PLIdCTDhZt4VdyBr
         PfvA==
X-Gm-Message-State: ANhLgQ0yx+4Pnsq871mU5CzwLwSL+/ku87aZKsBYWAfqD7AMohbJGFg+
        PNthnPXLuQFYhkJXUUfQ3HFUAzmJxSQ=
X-Google-Smtp-Source: ADFU+vtf5CZHM0NpaJrJWS9udXMK7T9aUpltrqKyUZHjQjEIusE0g0VHxpRV7CM9rv/RkgP/+mxHJQ==
X-Received: by 2002:a2e:b536:: with SMTP id z22mr3330208ljm.259.1582908313567;
        Fri, 28 Feb 2020 08:45:13 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a25sm5347058lfi.53.2020.02.28.08.45.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 08:45:12 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id e3so4010448lja.10
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 08:45:12 -0800 (PST)
X-Received: by 2002:a2e:5850:: with SMTP id x16mr514795ljd.209.1582908312163;
 Fri, 28 Feb 2020 08:45:12 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Feb 2020 08:44:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com>
Message-ID: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com>
Subject: Signed commit regression?
To:     Junio Hamano C <gitster@pobox.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suspect this may be due to gpg updates, not git, but I'm about to
leave for the airport in an hour and don't have time to look into it
more closely right now.

Because of the imminent travel, I did a "git pull" on my laptop, and
it doesn't have all the pgp keys I have on my desktop. It was a signed
tag, but the pull results in:

  commit bfeb4f9977348daaaf7283ff365d81f7ee95940a
  merged tag 'zonefs-5.6-rc4'
  No signature
  Merge: 45d0b75b98bf 0dda2ddb7ded
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   5 minutes ago

      Merge tag 'zonefs-5.6-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs

      Pull zonefs fixes from Damien Le Moal:
       "Two fixes in here:
    ....

and notice the "No signature". It's entirely wrong. There _is_ a
signature, it's just that we don't have the key.

And the "No signature" thing is particularly unhelpful, because it now
doesn't show us what key is missing, like it used to.

"git verify-tag" still works correctly:

  [torvalds@xps13 linux]$ git verify-tag FETCH_HEAD
  gpg: Signature made Fri 28 Feb 2020 12:03:36 AM PST
  gpg:                using EDDSA key 913EFF2D612BE1C00CC97738DDA1CDD2C5DA1876
  gpg: Can't check signature: No public key

and shows the key ID, and properly says "Can't check signature" (which
is very very different from "No signature").

This is a big regression. The "No signature" message really is
completely incorrect, and is very very wrong indeed.

I suspect it's due to this commit:

  72b006f4bf ("gpg-interface: prefer check_signature() for GPG verification")

but as mentioned I don't have the ability to really dig deeper right now.

                Linus
