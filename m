From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v4] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Wed, 06 Jan 2016 10:13:44 +0100
Message-ID: <1452071624.2668.21.camel@kaarsemaker.net>
References: <1451552227.11138.6.camel@kaarsemaker.net>
	 <20160105211206.GA12057@spirit>
	 <CAPig+cRufd4qOwZRpw2TR39npkRGg=7S+7YwfSu6EvRR95kRSA@mail.gmail.com>
	 <1452043212.5562.18.camel@kaarsemaker.net>
	 <CAPig+cThSHKBiUk5CmtE59mci3JLMv7QPNfHZAYmkqQvZHHofA@mail.gmail.com>
	 <CAPig+cQ7MineqezZXxpfAotVwoM9Ju1qwVGpEnEh9qNKBF1Pjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGkAG-00043c-4E
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 10:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbcAFJNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 04:13:52 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38742 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbcAFJNs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 04:13:48 -0500
Received: by mail-wm0-f54.google.com with SMTP id b14so66093545wmb.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=kIZ7MmoC3BYK51vX4CnjoBPQsJInCRY+lijGE0DrF9s=;
        b=EGDy3c8zTfoXzc23EofHuyHum0OoGHqOwvu/0G3wD7JeRELmZJHD51qdfFGZKO359u
         YGfqSBkAUx3uNpwrg7UxZZ5N76SLxKi9ljF+vm/F8zc2ob7hh006H5vZpeq3kVAm6+ZL
         pfCakr4fKdoZG13gtcvkI1A41/S+ODylKPccWjfBtM4FGnGuLXlCtg6r0O+SanmZFtCb
         MKV32rVKeKuwLK4oy4GIu6uTrdKO2PGH7otUffqv4TurqHK9s1rq49n08YlCBgLnsXAF
         Mijo7yuJw9iYidarfxJSKYMUNThUfurxETjlNYiZiNxrY1OjyW61PmdwIuLOfS407Y8A
         e64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=kIZ7MmoC3BYK51vX4CnjoBPQsJInCRY+lijGE0DrF9s=;
        b=lcm99PMmSe98FR7tESvOlNDyQfEcxndoDgbDtezP0bWY1bhOxJ6rBMl0yFo+Z3JTkX
         s5LQCbW/PT4GHTBEsJrB0rk85+7rivBoUf4pv/6zd4am4Oh3dNcwWO6N15ZCfUtQHncL
         QzPhw5yPGfBmhbEsqlD68d12M/yFy0JJ2Ng307HQATz1z4eaC1S8v+u1dlDfPlspZcVr
         Akp693SPygS7WHZkefb38HnjDiRbR4g/Lrz8EYZPjAvuzRNsQx84p+GDU2NSbVaZUFFM
         tPmG8yRoVOZ6O/blPLmi5fmsj7yi554rOQv0U1qUxJkMD0d9mxRQUuiMIIjhuzg9SIFF
         vnTg==
X-Gm-Message-State: ALoCoQljd4IustHg76jdhuXzVfKBbrNCE810R/JLs3FQ5QWD3jOV9Is/g0oMEMsvA0CYcNWKI7ar6L2MlENc+rNU+hewduwjuw==
X-Received: by 10.195.13.129 with SMTP id ey1mr65576296wjd.132.1452071626970;
        Wed, 06 Jan 2016 01:13:46 -0800 (PST)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id gj2sm94909069wjb.40.2016.01.06.01.13.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 01:13:46 -0800 (PST)
In-Reply-To: <CAPig+cQ7MineqezZXxpfAotVwoM9Ju1qwVGpEnEh9qNKBF1Pjg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283424>

On di, 2016-01-05 at 20:52 -0500, Eric Sunshine wrote:
> On Tue, Jan 5, 2016 at 8:28 PM, Eric Sunshine <
> sunshine@sunshineco.com> wrote:
> > On Tue, Jan 5, 2016 at 8:20 PM, Dennis Kaarsemaker
> > <dennis@kaarsemaker.net> wrote:
> > > On di, 2016-01-05 at 20:05 -0500, Eric Sunshine wrote:
> > > > Hmm, this test is successful for me on OS X even without the
> > > > reflog-walk.c changes applied.
> > > > 
> > > > And this test actually fails (inversely) because it's expecting
> > > > a
> > > > failure, but doesn't get one since the command produces the
> > > > expected
> > > > output.
> > > 
> > > That's... surprising to say the least. What's the content of
> > > 'actual',
> > > and which git.git commit are you on?
> > 
> > % cat t/trash\ directory.t1410-reflog/actual
> > b60a214 refs/tests/tree-in-reflog@{0}: Restoring to commit
> > 140c527 refs/tests/tree-in-reflog@{1}: Forcing tree
> > b60a214 refs/tests/tree-in-reflog@{2}: Creating ref
> > %
> > 
> > This is with only the t/t1410-reflog.sh changes from your patch
> > applied atop current 'master' (SHA1 7548842).
>
> By the way, the segfault does occur for me on Linux and FreeBSD.
> 
> And, in all cases, on all tested platforms, with the full patch
> applied, both tests behave sanely (in the expected fashion). So, even
> though the crash doesn't manifest everywhere, the fact that the tests
> are meaningfully testing it on the "affected" platforms may mean that
> it's not worth worrying about why it doesn't segfault on OS X.
> 
> (Of course, practicality aside, one might want to satisfy one's
> intellectual curiosity about why it behaves differently on OS X.)

The only explanation I can think of (and that's with practically no
knowledge of OS X internals) is that OS X's memory allocation strategy
is unlucky. Git is definitely writing to a location it should not write
to. On linux and freebsd this is unallocated memory, so you get a
segfault. On OS X, it happens to be memory actually allocated by git,
resulting not in a segfault but in silent corruption of other in-memory
data. I would argue that this is a much worse result, even though in
this small test that corruption seems to not trigger a crash.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
