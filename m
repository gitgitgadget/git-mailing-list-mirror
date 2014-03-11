From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 19:39:00 -0700
Message-ID: <CAJo=hJt6zoJ=53JNUT6fLXM+5_4Af8enE67z3Ozv4DOz1jU1Eg@mail.gmail.com>
References: <531D9B50.5030404@alum.mit.edu> <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
 <20140310155230.GA29801@sigill.intra.peff.net> <531E2986.8050604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 11 03:39:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNCbK-0004j1-2N
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 03:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbaCKCjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 22:39:25 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:45742 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbaCKCjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 22:39:23 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so260312wib.10
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vblGWFTzvA9pNHNvZX7OxotKdnUh8/XQtSYB7gTaSbc=;
        b=E5m7vUfZk6NnxWJ/Czclvu+wmR2L8zl1gsXPh8dCeOTDtZg//nPi9QXEngV8/4lHf6
         6VMTPqXBM4UGay9iNZYeojzd2fj31zkF95zMOy9lxtfREr4fWznZ3yyewwqTSR4l0e03
         Ii3Qkg5pBK8hYTcLcOL6uwJ4SCovpXfoAZ3bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=vblGWFTzvA9pNHNvZX7OxotKdnUh8/XQtSYB7gTaSbc=;
        b=MFo1stVQCYV0ZKh18L2vqwpy/j0PN0+kVVWrZatXWGZ4yMSIMjOX/Vdyh7vjAgp92s
         5OCCeN3hM+zXJaWYFDrpO/3oL8vcRGW3Pl566hXXfRwPL+xyeyVTD0JseAelNKsCftbQ
         s8hZ3SZgIzP2Xy3u8RkKAoQAuPpPO9lMPlDebu8zt5TGli//KNyXNd4LNnvSJ4o9l8SR
         TUPbUt4CoYjggyEO2Y4PPGFM4cQn7aoppLS858gn7hIdpqjECP6wJC2V+tI3MrTVnopM
         U0XXuDZBGCqFzcYyTml7ebGWcQ3Dop4hOlpuiFDw8Zxr+zTXfG9dbTSWgjOK34Rf84p1
         Fuvg==
X-Gm-Message-State: ALoCoQl22YVCR+ObD85ouJe6LWGT4+MMVUXW+4vLRwqlNtE41HN7KyETZKuVF3W7fibyxb04GxQW
X-Received: by 10.180.87.164 with SMTP id az4mr984406wib.2.1394505562036; Mon,
 10 Mar 2014 19:39:22 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Mon, 10 Mar 2014 19:39:00 -0700 (PDT)
In-Reply-To: <531E2986.8050604@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243837>

On Mon, Mar 10, 2014 at 2:07 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/10/2014 04:52 PM, Jeff King wrote:
>> On Mon, Mar 10, 2014 at 07:30:45AM -0700, Shawn Pearce wrote:
>>
>>>> * Store references in a SQLite database, to get correct transaction
>>>>   handling.
>>>
>>> No to SQLLite in git-core. Using it from JGit requires building
>>> SQLLite and a JNI wrapper, which makes JGit significantly less
>>> portable. I know SQLLite is pretty amazing, but implementing
>>> compatibility with it from JGit will be a big nightmare for us.
>>
>> That seems like a poor reason not to implement a pluggable feature for
>> git-core. If we implement it, then a site using only git-core can take
>> advantage of it. Sites with JGit cannot, and would use a different
>> pluggable storage mechanism that's supported by both. But if we don't
>> implement, it hurts people using only git-core, and it does not help
>> sites using JGit at all.
>
> I think it's important to distinguish between two types of backend:
>
> * Exotic backends, optimized for servers, or embedded systems, or other
> controlled environments where the person deploying Git can decide about
> the whole technology stack.  Here I say let a thousand flowers bloom.
> If user A wants to try an Oracle backend and only uses JGit, there's no
> need for him to implement the equivalent backend for git-core or libgit2.

FWIW I have been running JGit derived servers using Google Bigtable
for reference storage for years. So yes in this sort of environment
let people do what they think is best for them.

> * Mainstream backends, intended for use by end-users on their
> workstations and notebooks.  Such backends will be pretty worthless if
> they are not supported more or less universally, because one user will
> want to use the command line and Eclipse, another Visual Studio and
> TortoiseGit, a third will use GitHub for Mac plus a bunch of shell
> scripts written by his IT department.  A backend that is not supported
> by the big three Git implementations (git-core, libgit2, and JGit) will
> probably be rejected by users.  Realistically there will be at most a
> couple of mainstream backends--in fact probably usually a single
> established one and occasionally a single next-generation one waiting
> for people to migrate slowly to it.  For mainstream backends I think it
> is important for the implementations to plan and coordinate ahead of
> time to make sure everybody's concerns are addressed.

Yes, this was my real concern. Eclipse users using EGit expect EGit to
be compatible with git-core at the filesystem level so they can do
something in EGit then switch to a shell and bang out a command, or
run a script provided by their project or co-worker. Build systems
often integrate with Git to e.g. embed `git describe` output into the
binary. In mainstream use cross compatibility of the tools within a
single working directory is something that I think users have come to
expect.

> It sounds to me like Shawn is saying "please don't make a SQLite-based
> backend the new default git-core backend" and Peff is saying "there is
> no reason that a Git hosting service shouldn't experiment with a
> SQLite-based backend".  I see no contradiction there [1].

Yes. :-)

> Also, please remember that I'm not advocating a SQLite backend or any
> other at this time.  I'm only refactoring code to open the way for
> *future* flamefests :-)
>
> Michael
>
> [1] There might of course be a technical argument about whether a
> SQLite-based backend would be SO AWESOME for end-users that switching to
> it would be worth the extra inconvenience for the JGit folks.
> Personally I'm skeptical.

If it was really that amazing, yes, we would probably support it in
JGit for those that need that amazing.

But I tend to think we can (usually) find a simpler format that would
provide many of the same benefits with less of the drawbacks of
locking the data up into SQLLite's file format. I'm with Peff, I kind
of like the fact that most of the Git data is easy to inspect by hand,
or with some simple tools written in Git's source tree. Starting with
"go get this other SQLLite tool first then write this code" is a lot
less fun.
