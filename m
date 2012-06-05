From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Wed, 06 Jun 2012 00:17:27 +0200
Message-ID: <1920266.XH2GkcxZYT@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <4FCDC894.7000905@viscovery.net> <20120605090702.GA27376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 00:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc24W-0000ZA-Nb
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 00:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab2FEWRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 18:17:46 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45936 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab2FEWRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 18:17:31 -0400
Received: by wibhn6 with SMTP id hn6so4385642wib.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=I+hLgJ6WifNVALzNgRli0RFL5UZLGbrzYBSP0OcQgQM=;
        b=lE+Ai3CstMhYbdu8GmvQI54it6xbcBapyEeId/Tb5jQNlBT/pOzptZ976GZyssFpjt
         3rT0KMFmTXfKYhJqzan3Ju6N1VysaNZt/A64NypPOQyh7RVVm4HDgrnxs+ZnxS1sGGj/
         1PvrG9mC8WDsXGl/Or2A6G9aS3biNGgYWzyYkYzBpxzr71+4vdIvViDnp1NWUqxeYA3f
         XjBKvIMFvhEVNC2aQB5fzGlRUEY+TQPzYG+mtNfHeJhZcsO8m7Aeqtg7YEtDuhE57xAI
         6rKq4Sx44qGqAtuje/uPoMM+5qMIlM7W9N3k9RTCODItQqdg21RtB/LlcRUt2lMdY4yf
         S5yw==
Received: by 10.216.214.155 with SMTP id c27mr6444515wep.116.1338934650267;
        Tue, 05 Jun 2012 15:17:30 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id gv7sm437393wib.4.2012.06.05.15.17.28
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Jun 2012 15:17:29 -0700 (PDT)
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <20120605090702.GA27376@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199295>

On Tuesday 05 June 2012 05:07:02 Jeff King wrote:
> Florian, does that mean that making the svn helper start to use
> --cat-blob-fd at all is a potential regression for Windows? 

Actually I don't know. I'm don't know a lot about Windows support in git at 
all. 
I created the pipe, because the current vcs-svn/* code requires it for 
importing svn dumps. I can't explain yet why it requires it.

> The
> fast-import documentation says that the cat-blob output will go to
> stdout now. Does it even work at all now? 

stdout is connected to the parent, while the new pipe connects it's two 
childs..
It works.

> I don't really know or
> understand all of the reasons for cat-blob-fd to exist in the first
> place.

Good point.

> 
> I expect one answer might be "well, the svn remote helper does not work
> at all on Windows already, so there's no regression". But this affects
> all fast-import calls that git's transport-helper makes. Are there
> other ones that use import, and would they be affected by this? 
> 
> For that matter, isn't this a backwards-incompatible change for other
> third-party helpers? Won't they need to respect the new
> GIT_REPORT_FILENO environment variable? Do we need the helper to specify
> "yes, I am ready to handle cat-blob-fd" in its capabilities list?

I think whenever the remote helper uses some specific commands of fast-import 
it needs the cat-blob-fd to read feedback, but I haven't digged into that 
yet..

--
Florian Achleitner
