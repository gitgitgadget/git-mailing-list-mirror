From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-pull --tags with no merge candidates case gives confusing error message
Date: Tue, 12 May 2015 10:23:19 -0700
Message-ID: <xmqq38311zi0.fsf@gitster.dls.corp.google.com>
References: <CACRoPnQvNvBv1_wBzWQH6A8XRvWZ+HURvtkqtgYpwjjNXuCERg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 19:23:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsDtv-0007Yb-6G
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 19:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbbELRXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 13:23:22 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37504 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932776AbbELRXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 13:23:21 -0400
Received: by igbsb11 with SMTP id sb11so21148726igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=weF3Zgg4YIRGMzewvn7OgMKBMeUl7cTXZR5ApDNop/k=;
        b=H070qJt9h9iy7tFRsgN/imFNsATCnxPBGYGm9e07CJFfnJK33FXuG0BD1ixlLPx1O2
         1TxJJheS4r8oXv9UdP2WG8AHxHzhXAkBPwFVDRbIvbe3xuKC7kN7Hk84a1GBw86+V4EQ
         5FcBA8+DijJHuThpOYTKE1w4b4GnYySsT8DCcJQ1eQtxpD5aiwKg+YfkQvTy2i0c7sp0
         ZAhgSEDrXKFu1WbniqjxwsIrplgd4eofMsvB8e8mJkRe5Drtab3bBlew1sxBmAqKUH4Q
         SDLglmtKDo57QLPyDpEHdHNpwKlP1D7ha6IArOjXd4bg4AkgaPByVigV3xA8R873psaC
         UhMw==
X-Received: by 10.50.45.103 with SMTP id l7mr5033136igm.41.1431451401337;
        Tue, 12 May 2015 10:23:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id cy11sm1616760igc.14.2015.05.12.10.23.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 10:23:20 -0700 (PDT)
In-Reply-To: <CACRoPnQvNvBv1_wBzWQH6A8XRvWZ+HURvtkqtgYpwjjNXuCERg@mail.gmail.com>
	(Paul Tan's message of "Tue, 12 May 2015 13:59:04 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268859>

Paul Tan <pyokagan@gmail.com> writes:

> This behavior was introduced in 441ed41 ("git pull --tags": error out
> with a better message., 2007-12-28), which stated that:
>
>     In the longer term, it would be a better approach to change the
>     semantics of --tags option to make "git fetch" and "git pull"
>     to:
>     ...
>     Then we would not need to have this separate error message, as
>     the ordinary merge will happen even with the --tags option.
>
> Given that as of c5a84e9 (fetch --tags: fetch tags *in addition to*
> other stuff, 2013-10-30), git-pull --tags will fetch tags in addition
> to the configured refspecs, so if there are no merge candidates, it
> would not be because --tags was specified on the command line.
>
> As such, I wonder if the error message should be removed, since it
> conceals the actual reason of why there are no merge candidates.

I love it when people carefully analyse why the things are in the
way they are, and some things no longer make sense in today's world
order.

I agree 100% with your analysis.  c5a84e9 should have tweaked this
part, but was not careful enough, and made the heuristic used in
441ed41 when diagnosing the error is a bad one now.  It should go.
