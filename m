X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 22:16:55 -0700
Message-ID: <7v3b9766rc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
	<7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
	<20061028034206.GA14044@spearce.org>
	<Pine.LNX.4.64.0610272109500.3849@g5.osdl.org>
	<7vwt6l9etn.fsf@assigned-by-dhcp.cox.net>
	<20061028072146.GB14607@spearce.org>
	<20061028084001.GC14607@spearce.org>
	<7vfyd88d6s.fsf@assigned-by-dhcp.cox.net>
	<20061029035025.GC3435@spearce.org>
	<7vejsr68y9.fsf@assigned-by-dhcp.cox.net>
	<20061029043818.GA3650@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 05:17:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061029043818.GA3650@spearce.org> (Shawn Pearce's message of
	"Sun, 29 Oct 2006 00:38:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30414>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge32f-0006FL-Dz for gcvg-git@gmane.org; Sun, 29 Oct
 2006 06:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965015AbWJ2FQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 01:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWJ2FQ6
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 01:16:58 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38051 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S965015AbWJ2FQ5
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 01:16:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029051656.NELN13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 01:16:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id g5H01V00R1kojtg0000000 Sun, 29 Oct 2006
 01:17:01 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> So how about pack-X{40}.volatile that marks an eligible one for
>> repacking?
>
> Then anyone who has an existing pack would need to create that
> file first as soon as they got this newer version of Git... not
> very upgrade friendly if you ask me.

Ah, I mixed things up completely.  You're right.  Having .keep
leaves that pack as is (and lack of matching .keep causes it to
be repacked -- people do not have .keep so everything should be
repacked as before).

>> Then we can make "pack-objects --unpacked" to pretend the ones
>> with corresponding .volatile as if the objects in them are
>> loose, without breaking backward compatibility.
>
> Currently I'm changing --unpacked= to match without needing quoting.
> I'm allowing it to match an exact pack name or if it starts with
> "pack-" and matches the last 50 ("pack-X{40}.pack") of the pack name.

I think is a very sane thing to do (I should have done that from
the beginning).  I do not like "the last 50", but I do not have
objection to make it take either full path or just the filename
under objects/pack/ (so not "the last 50" but "filename w/o
slash").
