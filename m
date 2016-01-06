From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v4] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Wed, 06 Jan 2016 02:20:12 +0100
Message-ID: <1452043212.5562.18.camel@kaarsemaker.net>
References: <1451552227.11138.6.camel@kaarsemaker.net>
	 <20160105211206.GA12057@spirit>
	 <CAPig+cRufd4qOwZRpw2TR39npkRGg=7S+7YwfSu6EvRR95kRSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:20:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGcmR-0007Fl-6C
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 02:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbcAFBUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 20:20:18 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33381 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcAFBUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 20:20:15 -0500
Received: by mail-wm0-f47.google.com with SMTP id f206so43426996wmf.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 17:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=nCYPhUoc76SvDvtsfir5tn7yXAabydwSF8+suachR6k=;
        b=fbhIDuE/HP0mI13+K8BlHpQZTl26GlhdICMDKAED2/ZybZ/9P4cuU07LoO/DyoHBZS
         lAD6bNkxZBbqSKoAiZ6OnsmYdEkdWZhPIwUIxf4dowJJGJOTrlz66n4dyfq1b7huDu5N
         x1ooRYxQRLmlU3j1wSVzoM+Edj85J8gsBG3gbRkot0kRykOx3PdZ0QzC8L8TGvmM9ZUB
         WkW5y/WgQJ9sCcMFVTY5HEwMP3CgKy8+VhBx0G65alY7MvklmVL4NiBO3oY8ph9TrxDS
         scOvDFxFyp8eChWeQd5RUxOlYmh7BQFA7MCwMLa48RneeKquyEjqIUBGgraZPeTMBZB6
         OwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=nCYPhUoc76SvDvtsfir5tn7yXAabydwSF8+suachR6k=;
        b=MtOSTsJhs9mGlECC3LekC0AgOwzFJOiv8u55fe2vaLMEn37JI9nSNQNZAOZK15lLuo
         f4WGaKmhoHY25bWCqsZf5KQMiL0tEBgIOjm2L08/W7fsm4EcwQ8pzTDZDY1IexoWxcy+
         /qJMNLyWMwkbUnVCoTJiQG0d3hpwRpoGIOyF3Pml62r08hftsPXNS0UVUwZ+fnZfHJdA
         TFsXBhSxnFO6uKZNtt9xvJCP+c5ppZUg4qzvGu4ZURzTVpIItvDuaCskdsw5UTjRcYA6
         KEp6xabanVhJ0XvI/CrRrqMiMDuDMhBKbh81JsCpoYp2b+MVfAV3cF0GNYG4pa13ipeE
         NAQA==
X-Gm-Message-State: ALoCoQltAhV8dBNWskfxHe4sFAKFMSn61KfbGr2ZX67LPWK1cZTl7jpp5Y9uOvcWr90tQSa4YQwQ83Ush07nSGWyKLEInVYREw==
X-Received: by 10.194.240.67 with SMTP id vy3mr105806886wjc.168.1452043213884;
        Tue, 05 Jan 2016 17:20:13 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id q4sm93835541wja.6.2016.01.05.17.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 17:20:13 -0800 (PST)
In-Reply-To: <CAPig+cRufd4qOwZRpw2TR39npkRGg=7S+7YwfSu6EvRR95kRSA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283413>

On di, 2016-01-05 at 20:05 -0500, Eric Sunshine wrote:
> On Tue, Jan 5, 2016 at 4:12 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
> > git reflog (ab)uses the log machinery to display its list of log
> > entries. To do so it must fake commit parent information for the
> > log
> > walker.
> > 
> > For refs in refs/heads this is no problem, as they should only ever
> > point to commits. Tags and other refs however can point to
> > anything,
> > thus their reflog may contain non-commit objects.
> > 
> > To avoid segfaulting, we check whether reflog entries are commits
> > before
> > feeding them to the log walker and skip any non-commits. This means
> > that
> > git reflog output will be incomplete for such refs, but that's one
> > step
> > up from segfaulting. A more complete solution would be to decouple
> > git
> > reflog from the log walker machinery.
> > 
> > Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> > ---
> > diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> > @@ -325,4 +325,17 @@ test_expect_success 'parsing reverse reflogs
> > at BUFSIZ boundaries' '
> > +test_expect_success 'no segfaults for reflog containing non-commit
> > sha1s' '
> 
> Nit: It's kind of strange for a test title to talk about not
> segfaulting; that's behavior you'd expect to be true for all tests.
> Perhaps describe it as "non-commit reflog entries handled sanely" or
> something.

To paraphrase what Junio said earlier in this thread: tests determine
what is sane behavior, so using the word 'sanely' isn't really
appropriate. This is a regression test to make sure we don't
accidentally reintroduce behavior that segfaults, which I think is an
easy mistake to make with the current code, so I think the title is
appropriate.

> > +       git update-ref --create-reflog -m "Creating ref" \
> > +               refs/tests/tree-in-reflog HEAD &&
> > +       git update-ref -m "Forcing tree" refs/tests/tree-in-reflog
> > HEAD^{tree} &&
> > +       git update-ref -m "Restoring to commit" refs/tests/tree-in
> > -reflog HEAD &&
> > +       git reflog refs/tests/tree-in-reflog
> > +'
> 
> Hmm, this test is successful for me on OS X even without the
> reflog-walk.c changes applied.
> 
> > +test_expect_failure 'reflog with non-commit entries displays all
> > entries' '
> > +       git reflog refs/tests/tree-in-reflog >actual &&
> > +       test_line_count = 3 actual
> > +'
> 
> And this test actually fails (inversely) because it's expecting a
> failure, but doesn't get one since the command produces the expected
> output.

That's... surprising to say the least. What's the content of 'actual',
and which git.git commit are you on?

> By the way, it may make sense to combine these two tests. If a
> segfault occurs, the actual output likely will not match the expected
> output, thus the test will fail anyhow (unless the segfault occurs
> after all output).

I kept them separate to show that while this no longer segfaults, it's
still not the correct output, but showing correct output is a much
bigger project.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
