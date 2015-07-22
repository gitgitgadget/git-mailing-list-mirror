From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: Passing a number as an option to git tags for displaying latest tags
Date: Wed, 22 Jul 2015 12:17:19 -0700
Message-ID: <xmqqbnf4rohs.fsf@gitster.dls.corp.google.com>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Halil =?utf-8?B?w5Z6dMO8cms=?= <halilozturk55@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:17:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzWB-00080L-Ic
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbbGVTRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2015 15:17:22 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34436 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbGVTRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:17:22 -0400
Received: by pdbbh15 with SMTP id bh15so97521452pdb.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=tKcHrdKTvjGWPDRcgNwPEJgjlFhClaBztC7YSPgzrSc=;
        b=RcZeh3cxPELPf88tOBDScYdVTUo4DVaorffMDe2oow6dTpwLhdoz2QtSerjWe1YzYH
         R+woEyVFGxJ8Ri6Uh98h6ZcNqX+mml2z8IGzZc3JOXhk6MEkyljoJ49lARlseXt1JSdt
         Y2oehPtWkx4fY1GDEcGjHsKbIt0H2Sq3l9IlYUEZ5PWPKVY1+WWL1RonR2uSgrR3jC7H
         df+FTTs/TRYPAskVVRc7ITrU18FyvgVrccevO2crowkyaugP+yiZmiqbZ7K3qEh26qvJ
         ItH2K+xiImifiaK9FLEtfYBVFJpHfngCJ4igjziKMsVSiQG5e/U1dSmRh8bGSJywsq/H
         kChQ==
X-Received: by 10.70.123.72 with SMTP id ly8mr9194026pdb.134.1437592641503;
        Wed, 22 Jul 2015 12:17:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id ky17sm4743143pab.31.2015.07.22.12.17.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 12:17:20 -0700 (PDT)
In-Reply-To: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
	("Halil =?utf-8?B?w5Z6dMO8cmsiJ3M=?= message of "Wed, 22 Jul 2015 13:17:45
 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274456>

Halil =C3=96zt=C3=BCrk <halilozturk55@gmail.com> writes:

> Passing a number as an option to "git tags" command should display la=
test tags.
>
> e.g. "git tags -5" will display last 5 tags only.

I think this conflates two unrelated things.

 - Ordering tags not by refnames (i.e. default) but by "time".

 - Limiting the output by count.

The latter is what "| head -n 5" and/or "| tail -n 5" are for, so it
would be at most "nice to have"; I am indifferent in the sense that
I won't work on it, but I'd take a look if somebody sent a patch
that was cleanly done.

The former, sort by "time", is interesting, but you need to define
what to do with various corner cases.  For example, some people may
be have one or more of the following desires:

 * My project did not use tags for a long time, and started using it
   recently starting from v1.1.0.  The first release only said
   "Frotz version 1.0.0" in its commit log message.  I retroactively
   did "git tag -s -m 'Frotz 1.1.0' v1.1.0" on that commit.

   In such a case, it is likely that I would want the sorting done
   based on the committer date on the underlying commit, not the
   tag's tagger date.

 * When a bug is found, it is customary in my project to add a
   "break-<something>" tag to the commit that introduces the bug
   (and "fix-<something>" tag to the commit that fixes it).

   When I want to find recently discovered breakages, I want the
   tags whose names match "break-*" sorted by tagger dates, not the
   underlying commit's committer dates.

The necessary ordering machinery to do the above already exists in
"for-each-ref".  There is a GSoC project that works to unify various
features spread across "for-each-ref", "branch -l" and "tag -l" and
make them available to all of the three.
