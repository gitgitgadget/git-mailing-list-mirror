From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 15:44:51 -0700
Message-ID: <CAGZ79kYx22oYobPxMkC03fGk-E9zaZZd2f+qafESkhcmFog7-w@mail.gmail.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	<1461079290-6523-3-git-send-email-sbeller@google.com>
	<CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	<20160420041827.GA7627@sigill.intra.peff.net>
	<xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
	<xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
	<1461969582.731.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "gitster@pobox.com" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:45:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awH9j-0003BY-GC
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 00:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbcD2Wo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 18:44:58 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35040 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbcD2Wo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 18:44:57 -0400
Received: by mail-ig0-f176.google.com with SMTP id bi2so36779100igb.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PzkFl+A7M/czBHPbO5QnaQG/bIhr1OI5u7FgdP4ark8=;
        b=kgvL7kyzYTTb+/VRvdDm+gncM44nl9uzlBGnTJx0mnezD9IeWpPNxgBjvtdBQ2pFcW
         NARVemokvEqSLA/tqqnAQXblaZq10kgbLXBzbD3ZZjBcyASZQDfCAeYlBuKKtc5UqQs9
         z/8mc6CpU3xNnUxJbLBQDP/3CyC9yw095brnldBps8IneoHEU/JvJ7JPAB8WOwQQc5v6
         Af+rMfhjlOo3vf72jbBfS4CMUqgzgmqJ4Q4q4XFpDq7B+KAVXB1EXw7jqLKmwDBZW01v
         pBRHAufE80YrZ2o+mmuditD7uhuRbH82SahufcKHUiZ6SW4oHEND766ANGeqdZDX4sG3
         42Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PzkFl+A7M/czBHPbO5QnaQG/bIhr1OI5u7FgdP4ark8=;
        b=Sv9ToWk3rvK+7Q7cNMAepqhYwOgk0tawiSqdKARWvN/HYUqj74U/mygkn+kxooyyfb
         DGtir159y3v7C6WHKEqw/HoKrV5oJvv+LNS5J8AdRcl8jxuMJ2UyJ9rOKeoPC8D4rKus
         nc7LLfcrrXrTTo6wFme1CaF4VQ0/X1uhkjHPRD2CYxgZdm004aDPfipaVvL7sV0FTQxV
         ceafxwNgQK9d6G2PQeyrtYMgRfstNY2nWRqb0on3c0kwWlXP5X9H4xsesyzBjFUmCRb/
         m2MtzjduiADECgZn+Y52M4jfk0FlgA1rWwCSzAKnhheOmFbd2Tc2wrci4r1W+zPwcG5x
         wLrA==
X-Gm-Message-State: AOPr4FXZC8rSk4hsbBYxfwdKquvfjYH9TmGwpJeKgAr2Htg9ICSarc+Hul2N6roMur6Mzp0r2dt3KR7q530oqZxs
X-Received: by 10.50.170.68 with SMTP id ak4mr1387009igc.93.1461969891401;
 Fri, 29 Apr 2016 15:44:51 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 29 Apr 2016 15:44:51 -0700 (PDT)
In-Reply-To: <1461969582.731.1.camel@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293064>

> Currently it's an "opt in" knob, so this doesn't make sense to me.

+static int diff_compaction_heuristic = 1;

It's rather an opt-out knob going by the current
origin/jk/diff-compact-heuristic


> If
> we remove the entire knob as is, we can always (fairly easily) add it
> back. I would keep the code inside xdiff as a knob, but set it to
> enable default so that the user config has no knob at the top level but
> the xdiff machinery does (this making a "disable" be relatively small
> patch).

When writing my reply, I thought about people using Git from a binary
distribution with little to no admin rights. They want to have an emergency
knob to disable this thing, but cannot patch/recompile Git.

If you can patch and compile your version of Git, then reverting is easy, so
in that case Junios patch looks good to me.

Thanks,
Stefan

>
> Thanks,
> Jake
