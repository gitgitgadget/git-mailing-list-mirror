From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: GSoC proposal: port pack bitmap support to libgit2.
Date: Thu, 20 Mar 2014 21:38:28 +0800
Message-ID: <CAGqt0zwp2a6wrzLY0KOmH1zd0Bj5wmwvyBjy0j1JDjm3X4cSQg@mail.gmail.com>
References: <CAGqt0zz1W1k92B+XRWEmMEv1=iyej+zi9QUCp2EhA=g+VnCt0g@mail.gmail.com>
	<20140314043404.GD31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 14:38:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQdBC-0001vl-2M
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 14:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbaCTNia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 09:38:30 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:49041 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbaCTNi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 09:38:29 -0400
Received: by mail-ve0-f177.google.com with SMTP id sa20so907387veb.22
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y58+k3Jtp58GehvwSs/aoknuCsQ0QgqTh40sx8CZisg=;
        b=RR/4s1HgI4W4GAjMT5uTQVb6ZAmM7rljOOCiAasewVB69rVoHWPQvLrZ9ZQj2D7rK9
         7O37hmL41SwXfg5kldKd3jHD+4722Slf0vychN76ywD4a175XRO8OptbdvJ2DtSM8IIM
         HZVPvxBbBLmFkiXLMWjWVY8T/hPDNAQ3KCrgexzfpHSP7298CKlQvaW3AR+031JnvdWw
         RU/3zc52bL+6iGk5KqX0NCvQ02ekLIGj6VrayHubCchXIjuvz6exoXDDiKvvyCA+FTgM
         cJUEwx1Ta8tPMkirtRk7tNg4yuRtN1TUoFhaxlcpjK/WrfiF8inlhtqppwMoehnp2H+v
         mWPA==
X-Received: by 10.220.87.211 with SMTP id x19mr88966vcl.68.1395322708327; Thu,
 20 Mar 2014 06:38:28 -0700 (PDT)
Received: by 10.220.89.209 with HTTP; Thu, 20 Mar 2014 06:38:28 -0700 (PDT)
In-Reply-To: <20140314043404.GD31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244549>

Hi,

Sorry for this late reply, I was busy for past few days.

On Fri, Mar 14, 2014 at 12:34 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 12, 2014 at 04:19:23PM +0800, Yuxuan Shui wrote:
>
>> I'm Yuxuan Shui, a undergraduate student from China. I'm applying for
>> GSoC 2014, and here is my proposal:
>>
>> I found this idea on the ideas page, and did some research about it.
>> The pack bitmap patchset add a new .bitmap file for every pack file
>> which contains the reachability information of selected commits. This
>> information is used to speed up git fetching and cloning, and produce
>> a very convincing results.
>>
>> The goal of my project is to port the pack bitmap implementation in
>> core git to libgit2, so users of libgit2 could benefit from this
>> optimization as well.
>>
>> Please let me know if my proposal makes sense, thanks.
>
> You'd want to flesh it out a bit more to show how you're thinking about
> tackling the problem:
>
>   - What are the areas of libgit2 that you will need to touch? Be
>     specific. What's the current state of the packing code? What
>     files and functions will you need to touch?

Firstly I will need to implement bitmap creation in libgit2's
git_packbuilder_* functions (probably also git_odb_write_pack), so
libgit2 could support bitmap creation. Then I will need to change
git_revwalk_* functions to make them use bitmap. Since the operations
that can benefit from bitmap is, if my understanding is correct, all
using the git_revwalk_* functions, having bitmap support in revwalk
functions should be enough.

Files I need to touch probably are: revwalk.c pack-objects.c
If I need to change the API of packbuilder or revwalk functions I will
have to change the callers as well: push.c fetch.c and
transport/smart_protocol.c

I haven't read all the code to put together a list of functions I need
to change, but I think the list will be long.

>
>   - What are the challenges you expect to encounter in porting the code?

The architecture differences between git and libgit2 will probably be
a challenge.

>
>   - Can you give a detailed schedule of the summer's work? What will you
>     work on in each week? What milestones do you expect to hit, and
>     when?

I don't really have a plan, but I'll try to provide a rough schedule.

I'll read the code and try to understand the code, to the point where
I can start to add new code. This will probably take a week. For next
three or four weeks I should be implementing bitmap creation in
packbuilder. Then for the rest of time I will be optimizing revwalk
using bitmap.

>
> -Peff

--

Regards
Yuxuan Shui
