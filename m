From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Fri, 9 Nov 2012 10:14:34 +0800
Message-ID: <CAMPhdO8Sy8ZuXyWbvch+fXzbSVdmwC69a-KaLBRBGX8MVGxv_A@mail.gmail.com>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
 <5097C190.80406@drmicha.warpmail.net> <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
 <5097CFCB.7090506@drmicha.warpmail.net> <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
 <20121108190944.GO15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 03:15:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWe7i-0003cr-5R
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 03:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab2KICO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 21:14:56 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:37695 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab2KICO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 21:14:56 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so2630846lag.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 18:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4yIQTcWnWpcYzaxvadV35V0wIAvj2U74FN7U+H52Vmo=;
        b=OWBOWmQmlCu6BvD3ha5CGXAdPJyohnzFJSSRDeo5qv6uuuLgSia2/ppuqrEkCPIUAK
         g008MvFfXY+kiM1bV9nBvZxrIsGlMp3Ae54sefY9bZnCSJPymMrNZnQkS2hkFrFV/N/F
         oSL7QSSNGApXFkn1ZnZrgNnKhPRykClC+17v/ZoZNVrJ2CLdhFJPO8gP7xOA4R6dqvjE
         9lB9F2G1Lh1PZ5ofNUEp1b1KRGNl6o3c6RtPnArjKKBYDWdRQ7/U7E9Sh8ZmQ5r/UjUO
         2uyDsMhFLhdRTzp3DeD5so936GgCCnp6EOpaJvFX4wWUDkSt0HliWCosxW5cmMUOTxiY
         +4JA==
Received: by 10.152.106.171 with SMTP id gv11mr9469402lab.26.1352427294712;
 Thu, 08 Nov 2012 18:14:54 -0800 (PST)
Received: by 10.114.75.1 with HTTP; Thu, 8 Nov 2012 18:14:34 -0800 (PST)
In-Reply-To: <20121108190944.GO15560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209199>

On Fri, Nov 9, 2012 at 3:09 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 06, 2012 at 08:58:35AM +0800, Eric Miao wrote:
>
>> > So, then the question is: What do you know/have? Is your patch the
>> > output of "git format-patch", "git diff", or just some sort of diff
>> > without any git information?
>>
>> That doesn't matter, all the info can be obtained from the SHA1 id, the
>> question is: do we have a mechanism in git (or hopefully we could add)
>> to record the patchset or series the patch belongs to, without people to
>> guess heuristically.
>>
>> E.g. when we merged a series of patches:
>>
>>   [PATCH 00/08]
>>   [PATCH 01/08]
>>   ...
>>   [PATCH 08/08]
>>
>> How do we know this whole series after merged when only one of these
>> commits are known?
>
> Others have described how you can infer this structure from the history
> graph, but as you noted, the graph does not always match the series that
> was sent, nor does it contain some of the meta information about the
> cover letter, associated discussions, etc.
>
> If you want to track the mapping between mailed patches (or any other
> form of changeset id) to commits, you can put it in git in one of two
> places:
>
>   1. In a pseudo-header at the end of the commit message. E.g., you
>      could use the message-id of the cover letter as a unique identifier
>      for the changeset, and put "Changeset: $MID" at the end of each
>      commit message. Then you can use "--grep" to find other entries
>      from the same changeset.
>
>   2. You can use git-notes to store the same information outside of the
>      commit message. This doesn't get pushed around automatically with
>      the history, but it means your commit messages are not polluted,
>      and you can make annotations after the commits are set in stone.
>
> I do not use Gerrit, but I recall that they do something like (1) to
> mark changesets. For git development, one of the contributors does (2)
> to point notes at mailing list threads (I think he uses a script to
> match up mails and commits after the fact).

Thanks Jeff, this is the answer I'm looking for, really appreciated to
get it explained so clearly.

>
> But fundamentally the idea of "this is a set of logical changes" is not
> represented in git's DAG. It's up to you to store changeset tokens
> if you care about them.

Sure, I completely understand and agree we should keep git simple enough.
