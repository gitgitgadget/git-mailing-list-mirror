From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Thu, 15 Jan 2015 18:05:46 +1100
Message-ID: <CAGyf7-HMsBnim5yoOgyNJ2=HNpnW8ftvitarMc6UO-zTLfQkBA@mail.gmail.com>
References: <20150114115130.GA5677@inner.h.apk.li>
	<20150114124936.GC30383@peff.net>
	<20150114143946.GE13247@inner.h.apk.li>
	<xmqqmw5lb7ho.fsf@gitster.dls.corp.google.com>
	<CAGyf7-EL03E8oFcuDzGcmN4bKQhroHw-T4Azm4mb0QX9F40RFw@mail.gmail.com>
	<20150115063806.GH13247@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Users <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 08:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBeV6-0007zz-6N
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 08:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbbAOHFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 02:05:48 -0500
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36344 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751175AbbAOHFr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 02:05:47 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]) (using TLSv1) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVLdmyh/agwVBQcKXWVyA7fg1XHtNAVSO@postini.com; Wed, 14 Jan 2015 23:05:47 PST
Received: by mail-oi0-f41.google.com with SMTP id i138so11133164oig.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 23:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/d4xm6csm0NzlB9Thbadv6eu78omcEt84uIJ+tfezew=;
        b=AokRe49pa5NrMYgQs5yewBijlrCGI57NO3nlrss5A6ROOmw4hhFCta5kOrcqgZ2BKx
         GFkOtPkRNIuLptkmc+SR2wzesutNVgNJR/nY29T15M2TD7XQpkSla69a7FNFChyIBYjv
         45OEF5UziPwtKSyoI6SALkrnhYVsP2kIKxtx6W3m94qZn3lMdNHmgqwTm08UTfQE05VH
         ripr+MjnvGWDrUgm9IOdl4VS1CzgMMdLhlE+W4fOn0+XBLYeNjq9+VGrgTzbpymlPufa
         2PN5iglSrHbjjPo62rnLTLGpfI6zUnm+riu8CsNuUBK/f8uYB+lFGlQe/fZaEtZe9X2O
         pZHQ==
X-Gm-Message-State: ALoCoQn83oZE7D1LB9TpFGuS6aeYxLXTzouNRV+0zTcQ9Aj9CmZnImQxu4C23ZojSdZQJllzMt2uCzIhTs3bE3m/uqcTT6qqLhWNhAZTRw6jfBZXItgRUh5HEbs6JZ8WQwRKVlLNNV8bewAQSo42KlerfK9jwtJHcg==
X-Received: by 10.60.132.74 with SMTP id os10mr4950896oeb.63.1421305546383;
        Wed, 14 Jan 2015 23:05:46 -0800 (PST)
X-Received: by 10.60.132.74 with SMTP id os10mr4950890oeb.63.1421305546280;
 Wed, 14 Jan 2015 23:05:46 -0800 (PST)
Received: by 10.182.98.225 with HTTP; Wed, 14 Jan 2015 23:05:46 -0800 (PST)
In-Reply-To: <20150115063806.GH13247@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262463>

On Thu, Jan 15, 2015 at 5:38 PM, Andreas Krey <a.krey@gmx.de> wrote:
> On Thu, 15 Jan 2015 12:23:00 +0000, Bryan Turner wrote:
> ...
>> > Guess in the dark: "ls -l .git/objects/pack"
>> > Do you see any .keep files?
>
> Lots of. :-(
>
>> I'm one of the Stash developers and just noticed this thread. If the
>> repository in question has been forked via Stash there likely _will_
>> be .keep files. Stash uses alternates for forks, so it's possible, by
>> deleting those kept packs and pruning objects (which you've already
>> done I see) that you will corrupt, or have already corrupted, some
>> number of the forks.
>
> There are a few forks in this stash instance, but the repository in
> question is neither the source nor the destination of any.
>
> So, git seems to be mostly out of the equation now (gc and repack
> apparently doing what they are supposed to do), and the question
> moves to 'how can stash let such a repo grow to that size'.
>
>
>> (At the moment Stash packs "garbage" into a "dead
>> pack" which it flags with a .keep, to ensure forks don't lose access
>> to objects that once existed upstream that they still reference.)
>
> Does it do so in any case even if there is no actual fork? That would
> explain a lot - we are daily (force-)pushing new commit in there (and
> potentially big ones) that become garbage the next day, and should
> be cleaned up rather fast.

No, Stash will only do that in a repository which has been forked. In
any non-forked repository, Stash does not interact with garbage
collection in any way. Auto GC is left enabled, and all pruning
settings are left at their defaults. The default pruning interval is
two weeks, so if your development approach is rebase-heavy you may
need to adjust them.

What are the contents of some of those .keep files? If they're written
by Stash they contain a message saying so. ("GENERATED BY ATLASSIAN
STASH - DO NOT REMOVE")

>
> (We're pulling them into another non-stash repo for longer-term keeping -
> these are backups of dev repos in the form of git stash commits including
> untracked files.)
>
> Andreas
>
> --
> "Totally trivial. Famous last words."
> From: Linus Torvalds <torvalds@*.org>
> Date: Fri, 22 Jan 2010 07:29:21 -0800
