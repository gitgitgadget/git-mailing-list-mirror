From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 13:21:57 +0530
Message-ID: <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com> <7vppxj6thv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 09:52:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVGyx-0002qX-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 09:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab3DYHwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 03:52:39 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:43432 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab3DYHwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 03:52:38 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so3223928ief.35
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mqcYvwOiSKJ1lMriM9CuFP8Oo96bQ9GoYLn1dAbyxpI=;
        b=PjL0LzzDQKyujGmn3gEurv26bp3SIk3nnPKhRi2eQYIECGDv2ytulCZjO+GOVPiHBG
         LV3W2I1Qn+A2RNzK4w6YIyAgq1TGZOSsynr/ey4fjLICcej7Rl6cKfYZ9ztgYn7Enf+n
         xmQD7flRJDlHFilMKxMvNDL0O3rI3Cy092NHYzVJq3MVQ/bWMopsVfykSVnM45fB3BcH
         hpm50AvqI96AW2MRS28QgOabVK6hW6pEh/VmU26ylk2fEkTvt4RPbaIiai/TuK64jyQ1
         KrB9/KXiAamhyFOFa29aSSTzJwVzzx1WY1dDXnWo03ZKcW0tKq51qwk0X9plNEPHKSbg
         /CwQ==
X-Received: by 10.50.66.197 with SMTP id h5mr7655207igt.63.1366876357702; Thu,
 25 Apr 2013 00:52:37 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 00:51:57 -0700 (PDT)
In-Reply-To: <7vppxj6thv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222352>

Okay, so the point I was trying to make is:

The range version of $(git merge-base A B) B is B ^$(git merge-base A
B), and not B --not $(git merge-base --all A B) [which is equivalent
to B ^A or A..B].

Junio C Hamano wrote:
> I dunno.  The description you gave was insufficient for me to answer
> that question.

Sorry about that.  I'll rewrite it as a set of commands:

$ cd /tmp
$ git clone gh:artagnon/clayoven
$ cd clayoven
$ git checkout -b pu master~10
$ echo "foom" >>LICENSE
$ git commit -a -m "Change in pu"
$ git checkout -b rebase.autostash master~5
$ echo "loom" >> clayoven.gemspec
$ git commit -a -m "Change in rebase.autostash"
$ git checkout master
$ git merge pu
$ git checkout rebase.autostash
$ git merge pu
$ echo "quux" >>Gemfile
$ git commit -a -m  "Change 2 in rebase.autostash"
$ git log rebase.autostash ^master
$ git log rebase.autostash --not $(git merge-base --all rebase.autostash master)
$ git log rebase.autostash ^$(git merge-base rebase.autostash master)
$ git diff rebase.autostash ^$(git merge-base rebase.autostash master)

Note that git diff can only take two endpoints so git merge-base --all
is meaningless in this case.

To summarize: B ^(git merge-base A B) [the current ... syntax of git
diff] has no exact equivalent in the log world.  Therefore, no matter
which existing rev spec we overload, we can never get the current ...
for diff in a consistent manner.

We certainly know that 'git diff A~B' is going to be useful, and have
an exact equivalent 'git log A~B' (but I'm not sure how useful it will
be, because I don't work with merges much).  The point is that it can
be overloaded in a consistent manner for other commands like 'rebase
-i' too.

I recently caved to overloading .. [1] because there's so much
resistance to inventing a new rev spec.  I'm not exactly elated with
that.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/222343
