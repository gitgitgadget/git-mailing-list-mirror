From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] remote: introduce and fill branch->pushremote
Date: Mon, 13 Jan 2014 16:52:52 +0530
Message-ID: <CALkWK0ncSLza3Q0PSZ0oTZqB2YxjgGSqA7QYxk2+rN_77BKZMA@mail.gmail.com>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
 <1389546666-17438-4-git-send-email-artagnon@gmail.com> <20140113083421.GA18531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 13 12:23:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2fcH-0008M7-W0
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 12:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbaAMLXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 06:23:34 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:41126 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbaAMLXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 06:23:32 -0500
Received: by mail-ig0-f176.google.com with SMTP id j1so4168710iga.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 03:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J1wt2v3iYs4cFhwGqULmvXIbwux1n0pgCJxMNJGaPFE=;
        b=GTWMv7FGKuPpjlCVj0VC4ik11FeUCp4g4/NrGsXxgYNQZ9IvYywOa5sXLnxA4enont
         iryLeydxCDJZBLnI5PH9V8TTLR3M5KLReB4TQ6kIjHT+yecuYul3dqsFSfSf+fuzyuYa
         4Y1dUNCNkeyE0lXTNVo5zNyY2IFy2q0agg2hjPUCT50opZqBufslEtN/sSPmgLSxSViz
         dUU/YXb+py10CctGYZ/l2ASlO7KY4mR5fPT6mKQypLbAkP8uCZvJ9srn+jEJP6qqZ0lY
         snVDvnRb24EeNlbpS6njeLbU4wNKK0noxBDT80DQzQ4vItGT5R9AJmW5EOnOpB2KegNZ
         kxDg==
X-Received: by 10.50.20.67 with SMTP id l3mr18232560ige.16.1389612212326; Mon,
 13 Jan 2014 03:23:32 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Mon, 13 Jan 2014 03:22:52 -0800 (PST)
In-Reply-To: <20140113083421.GA18531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240358>

Jeff King wrote:
>   2. If the current branch has a branch.*.pushremote set, but we want to
>      know where a _different_ branch would be pushed, we have no way to
>      access remote.pushdefault (it gets overwritten in the hunk above).
>
>      @{upstream} does not have this problem, because it is _only_
>      defined if branch.*.remote is set. There is no such thing as
>      defaulting to a "remote.default" (or "origin") there, and we never
>      need to look at default_remote_name.
>
>      For @{publish}, though, I think we will want that default. The
>      common config will be to simply set "remote.pushdefault", rather
>      than setting up "branch.*.pushremote" for each branch, and we would
>      want @{publish} to handle that properly.

Not sure I understand what the problem is. Let's say we have two
branches: "master", and "side" with remote.pushdefault = ram,
branch.*.remote = origin, and branch.side.pushremote = peff. Now, when
I query master's pushremote, I get "ram" and when I query side's
pushremote, I get "peff"; all the logic for falling-back from
branch.*.pushremote to remote.pushdefault to branch.*.remote is in
branch_get(), so I need to do nothing extra on the caller-side. From
the caller's perspective, why does it matter if the pushremote of a
particular branch is due to branch.*.pushremote or remote.pushdefault?
