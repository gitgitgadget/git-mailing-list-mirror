From: Stefan Zager <szager@chromium.org>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Wed, 19 Mar 2014 09:57:02 -0700
Message-ID: <CAHOQ7J9c_ZfzYEmO861Oa64YZeArQQBMnah1yWAkChME7dA+TA@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
	<CACsJy8BOZa6vJU_s9sxYrtSdpL-4PDTpbo6r6TC8z2LD1GtkMQ@mail.gmail.com>
	<CAHOQ7J_Wmjo6AJRQra2UDWX3WRboD+-4SaGCHYOUgRR+NyUX4A@mail.gmail.com>
	<CACsJy8A7ESSjfHqr96_yYjNsE-A1Sf=8+rmRfGrjML0+fCWTTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 17:57:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQJnj-0007hR-RY
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 17:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933896AbaCSQ5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 12:57:06 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:36501 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933853AbaCSQ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 12:57:04 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so8579123oag.41
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EjViOux3BmBFrr68dHhdubB6wM73wwQuyzfQ5fqfmNY=;
        b=SxNDa2wm2Qij7VI5fTHp0mPsmw8UqPafqcYVfwFJT6dG34jd3OJErg839NBKIW34A4
         zLk08Hk/l2Ni60NRwa1B6wJWnUKNfxqPHS0vx2pmuus+lN+vrG09o0JWExp4wmPkdlt8
         sWPiNvcL6B3FS/AVYmaIup5agnu2wsxD0hsDm93sMIvn8cmrtGQKNEab99lLYOE3bHPD
         s2xfSU0y//Bm6GJzSDGsEHXvF5PG+OS5JsEs7W0wi3EgBDxQlMezj2FLMeB/L+Cd8xu0
         3Fg96xMLEznJrriaKfeoSSqJcfXT/Pc19jh2x5J6xE3r3gsAwLyC1NJ1SM0z0U1n4z/M
         4eNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EjViOux3BmBFrr68dHhdubB6wM73wwQuyzfQ5fqfmNY=;
        b=UAeHXeS77a30DrXmkEG/uG30uxeti2oA7Ml5HxLdc9JhJBboKy1iktPyH+TW1r/yhX
         00GlNEk9rh6Umq2YWNNI2VasIslGBkxhrJ1q3LqNdw+o8ssaLn/BT6czJBBemSpAEbSs
         ReQ5FYXcGqslIA3vNec2XAcXHUHofp7Y02d9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EjViOux3BmBFrr68dHhdubB6wM73wwQuyzfQ5fqfmNY=;
        b=D+OQ21g4jPt5LxVDyXwMzYdWgaalqyNsL5bfZrq1SS394Xp8NSmP4+DyNxqQ1hx1EP
         lEjoa7AuNmm390s4/CXhJbV/H9z3ojM0pDW0WmicnaxKy9PV6fCQpDRRpmRgcvki18fO
         NCg0nBywGOn1taQ3UCeCh/mRQJMgEhHiWikGIVvtI2OmaK4Y1CJZrsWJ/KxqntvyPPPX
         CJLPsIA0AcvzTgIEHzStG3gfoqXcLBABLDAFs/JQqQb6el28aNaj06NGjDulaG1caELk
         jI74of9bBL/094SxMgx8lHSUnRB8gacfd6oLWLfuGRztnqNmbuKuppdhdL4V78R+x9Th
         ImoQ==
X-Gm-Message-State: ALoCoQmtcqEyF6sFbIsSPcKyqfMe+Gmxvj9YyYHcUtdpjfw1w1rizHOTXgMZmOFE98aNZOVd7zbHpiiozSJRRyJQGH+5uLgsCxiiX2n38uKpMaMR1ydssVg0QgotEmpDZ9DHo7dc8RgKmWgC2bPqicwur//xkofj4WmyMrH6ciQ5CDBIye9ADnH0E9Tv8EprFBVXR2SDabwG
X-Received: by 10.182.19.164 with SMTP id g4mr1938089obe.58.1395248223161;
 Wed, 19 Mar 2014 09:57:03 -0700 (PDT)
Received: by 10.182.233.201 with HTTP; Wed, 19 Mar 2014 09:57:02 -0700 (PDT)
In-Reply-To: <CACsJy8A7ESSjfHqr96_yYjNsE-A1Sf=8+rmRfGrjML0+fCWTTg@mail.gmail.com>
X-Google-Sender-Auth: AdBs6whSdk9ePr8LdpR4AiqLCLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244459>

On Wed, Mar 19, 2014 at 3:28 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 19, 2014 at 2:50 PM, Stefan Zager <szager@chromium.org> wrote:
>>
>> I suppose it would be possible to fix the immediate problem just by
>> using one fd per thread, without a new pread implementation.  But it
>> seems better overall to have a pread() implementation that is
>> thread-safe as long as read() and pread() aren't interspersed; and
>> then convert all existing read() calls to pread().  That would be a
>> good follow-up patch...
>
> I still don't understand how compat/pread.c does not work with pack_fd
> per thread. I don't have Windows to test, but I forced compat/pread.c
> on on Linux with similar pack_fd changes and it worked fine, helgrind
> only complained about progress.c.
>
> A pread() implementation that is thread-safe with condition sounds
> like an invite for trouble later. And I don't think converting read()
> to pread() is a good idea. Platforms that rely on pread() will hit
> first because of more use of compat/pread.c. read() seeks while
> pread() does not, so we have to audit more code..

Using one fd per thread is all well and good for something like
index-pack, which only accesses a single pack file.  But using that
heuristic to add threading elsewhere is probably not going to work.
For example, I have a patch in progress to add threading to checkout,
and another one planned to add threading to status.  In both cases, we
would need one fd per thread per pack file, which is pretty
ridiculous.

There really aren't very many calls to read() in the code.  I don't
think it would be very difficult to eliminate the remaining ones.  The
more interesting question, I think is: what platforms still don't have
a thread-safe pread implementation?
