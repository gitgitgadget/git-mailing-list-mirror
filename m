From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 5/3] Alternative --dirstat implementation, based on
 diffstat analysis
Date: Tue, 12 Apr 2011 08:08:28 -0700
Message-ID: <BANLkTi=yYU+v1Xx_YO6kpC8+1ukOdwb6SQ@mail.gmail.com>
References: <7vtye834al.fsf@alter.siamese.dyndns.org> <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
 <201104121122.56870.johan@herland.net> <201104121126.49881.johan@herland.net> <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:08:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9fD5-0004iS-A7
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 17:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab1DLPIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 11:08:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60402 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756705Ab1DLPIt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 11:08:49 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3CF8m07024941
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 12 Apr 2011 08:08:48 -0700
Received: by iwn34 with SMTP id 34so6724637iwn.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 08:08:48 -0700 (PDT)
Received: by 10.42.240.202 with SMTP id lb10mr7924972icb.297.1302620928123;
 Tue, 12 Apr 2011 08:08:48 -0700 (PDT)
Received: by 10.231.33.199 with HTTP; Tue, 12 Apr 2011 08:08:28 -0700 (PDT)
In-Reply-To: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
X-Spam-Status: No, hits=-102.88 required=5 tests=AWL,BAYES_05,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171396>

On Tue, Apr 12, 2011 at 7:46 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I don't hate the idea, but I do hate the "use a config option"
> part. Or rather, I hate the fact that it's the _only_ way to do it
> (and the particular config name you chose).

Oh, and one thing strikes me: I think the fast dirstat gave reasonable
values when you had mixed text and binary (in the kernel tree, look
for the Documentation/logo.gif file, for example: it changed to the
Tasmanian devil in one release).

Have you checked what happens to that when you use the diffstat one?
Because binary files are done very differently (byte-based counts).

So check out

   git show --dirstat 3d4f16348b77efbf81b7fa186a18a0eb815b6b84

with and without your change. The old dirstat gives

  44.0% Documentation/
  55.9% drivers/video/logo/

which is at least not completely insane.

The reason I bring this up is because I think this was an issue at one
point, and one of the statistics things (--stat or --numstat or
--dirstat) gave absolutely horrid values (basically comparing "bytes
changed" for binaries with "lines changed" for text files). Resulting
in totally skewed statistics.

                       Linus
