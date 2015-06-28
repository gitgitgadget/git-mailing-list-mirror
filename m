From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sun, 28 Jun 2015 00:32:04 -0700
Message-ID: <xmqqwpyoe1aj.fsf@gitster.dls.corp.google.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 28 09:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z974c-0000gD-Hf
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 09:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbbF1HcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 03:32:10 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36150 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbF1HcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 03:32:08 -0400
Received: by igrv9 with SMTP id v9so12280189igr.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uga814guOGrRIWomidACn48YxpRl7rpP5AIBRi8Hefc=;
        b=ic3ofimZOsEL9IChsySqNofqi8CqytkxoKJM55tT1P29aS/BtgDMXhkc79e34ZORu7
         Pe877RnCcYxI2LnHOax7ZyNMqTzx2F3fm9hO/NI/aJKjB/H1nxwOrVC87m42+2XX2QCs
         cxoKjRMd37Ums4+MIuEum7w7H+X/slDH0h1o28q5sgaYYed5CGWy9k9v2eQd4YAJZNoJ
         VR+WnkeloSqx2XPkXW5ibddTML1QPdYKtTNFEX6cqA6qTAFJj+aB3WnP+H5AAhpBbvsC
         DHGP5anW1q72S+jaluEc5R1vIeyznj+Jzxq2RbCm16u0zbrc/xoi3/jMcPOk2zxZyGCZ
         7EZQ==
X-Received: by 10.50.59.180 with SMTP id a20mr7754725igr.23.1435476727218;
        Sun, 28 Jun 2015 00:32:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:205e:4a52:83c1:a37f])
        by mx.google.com with ESMTPSA id j20sm2704931igt.5.2015.06.28.00.32.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 00:32:05 -0700 (PDT)
In-Reply-To: <558F9854.5080605@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 28 Jun 2015 08:46:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272871>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I understand that the user might make a mistake when marking the initial
> commits, but as soon as bisect says
>
>     Commit <sha1-abbrev> is an ancestor of <sha1-abbrev>, so I
>     will look for the commit that caused the transition from
>     "xyzzy" to "plugh".
>
> then I hope the user will notice and correct her/his mistake.
>
> For example, a session could be started with
>
>     git bisect start --mark=broken <committish> --mark=fixed <committish>

Interesting.

If we extend that line of thought further, maybe we do not even need
to add new/old, fixed/broken, or slow/fast.

You just _always_ say "good" or "bad".  If something is slow, you
say "bad" and if something is fast, you say "good".

If you start "git bisect start maint master" (and as always, "bad"
comes before "good") because some operation is very slow in maint
but somehow is usably fast in master, you are automatically hunting
for a performance fix that you can cherry-pick to the maintenance
track.

No need for "bisect new", "bisect old", or "bisect terms", let alone
"bisect terms --new=fast --old=slow".  The tool just does the right
thing because it already has the information necessary to infer what
the user means by 'good' and 'bad', and the initial topology determines
which transition, either from 'good' to 'bad' or from 'bad' to 'good',
the user is hunting for.

I really like that simplicity.
