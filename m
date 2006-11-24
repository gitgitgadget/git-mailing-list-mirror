X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] config option core.showroot to enable showing the diff of the root commit
Date: Fri, 24 Nov 2006 10:04:11 +0100
Message-ID: <slrnemddcb.ggq.Peter.B.Baumann@xp.machine.xx>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <7v64d8y4tu.fsf@assigned-by-dhcp.cox.net> <slrnemaqt1.esn.Peter.B.Baumann@xp.machine.xx> <7virh5khrc.fsf@assigned-by-dhcp.cox.net> <slrnemcc0b.ncc.Peter.B.Baumann@xp.machine.xx> <7vejrthf2y.fsf@assigned-by-dhcp.cox.net> <7vzmahfx6q.fsf@assigned-by-dhcp.cox.net> <slrnemd98k.a3v.Peter.B.Baumann@xp.machine.xx> <7vlkm1cjht.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Fri, 24 Nov 2006 09:05:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 59
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32201>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWzZ-0002Zh-SB for gcvg-git@gmane.org; Fri, 24 Nov
 2006 10:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934521AbWKXJE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 04:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934522AbWKXJE6
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 04:04:58 -0500
Received: from main.gmane.org ([80.91.229.2]:4537 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934521AbWKXJEy (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 04:04:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnWzG-0002XY-ML for git@vger.kernel.org; Fri, 24 Nov 2006 10:04:46 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 10:04:46 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 24 Nov 2006 10:04:46 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-11-24, Junio C Hamano <junkio@cox.net> wrote:
> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
> writes:
>
>> One question, what's the difference between git-log -p and
>> git-whatchanged -p?
>> ...
>> As you can see, the root commit isn't shown. Is this intentional?
>
> Some historical background.
>
> The traditional command do do log-minded things was whatchanged
> and it was implemented as
>
> 	git rev-list $revision_args -- $path_limits |
>         git diff-tree --stdin --pretty -r $format_args
>
> and whatchanged did not give --root to diff-tree by default.
> And 'diff-tree' does not show --pretty logs when there is no
> diff to be shown (which still is true today and is a useful
> behaviour), hence no mention of the root commit.
>
> On the other hand, "git-log" traditionally looked like this:
>
> 	git rev-list --pretty $revision_args 
>
> Back then, there was no path_limits nor even diff options to
> it.
>
> Later, Linus (with help from others) made the revision walk
> machinery as callable inside programs other than "rev-list",
> eliminating the need to pipe rev-list into diff-tree to perform
> log-minded things.  That enriched what "git log" can do, and
> mostly made "whatchanged" a redundant command.  As you may have
> noticed, there isn't much difference between these two commands
> in builtin-log.c; their differences are solely what default
> options for diff and revision machinery are used and are meant
> to match the traditional behaviour of these commands.
>
> So there shouldn't be any differences, really, when you override
> their defaults with the likes of -p.
>
> Honestly speaking, I do not think there was _any_ consciously
> designed intention to handle root commits, either to make these
> commands behave identically or differently; regarding parentless
> commits, they just behave the way they happen to behave, because
> root commits were not something either Linus nor I were
> interested in.
>
> Given the recent discussion, however, the intention now should
> be that Porcelain level commands should default to do --root
> (i.e.  when asked to do "diff" to show how a commit without a
> parent differs from its nonexistent parent, show diff with
> emptiness).
>

Ah. I see. Thanks for the clarification.

Peter
