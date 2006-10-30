X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 00:51:54 -0800
Message-ID: <7vlkmyw5hx.fsf@assigned-by-dhcp.cox.net>
References: <92622.251.qm@web31812.mail.mud.yahoo.com>
	<200610300905.04454.jnareb@gmail.com>
	<7vy7qyw6w6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 08:52:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vy7qyw6w6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 30 Oct 2006 00:21:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30488>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeSsB-0007Vg-BU for gcvg-git@gmane.org; Mon, 30 Oct
 2006 09:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751931AbWJ3Iv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 03:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWJ3Iv4
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 03:51:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54493 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1751931AbWJ3Ivz
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 03:51:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030085155.GAFZ6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 03:51:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gYrb1V00S1kojtg0000000 Mon, 30 Oct 2006
 03:51:36 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> ..., without
>> resolving the strange filenames problem (it would be nice if somebody was
>> to send code; well Junio send patch to address core git filename quoting
>> issue).
>
> Having showed that patch, I do not think it is a good way to go.
>
> I think the UI layer like gitweb should have freedom to choose
> its own pathname handling, and should read from -z output.
>
> The git plumbing is agnostic to the character encoding issues,
> and does not care what character set pathnames are encoded, and
> what character set the file contents are encoded.  These are
> very project specific and should be handled per project.

Side note.

There is one action item for shorter term I realized we would
need.  We need to make patch-id generation use unquoted
filenames, so that no matter how differently we might
reimplement quote_c_style() later, we would get the same
patch-id from the diff between the same two trees.  Currently I
think it hashes the quoted filename that appear on ---/+++ lines
(and "rename from"/"rename to" lines as well, but usually you do
not use -M/-C when computing the patch-id, so these are not
really an issue).

I think longer term plan for git should include standardizing on
how pathname encoding and content encoding are handled at the UI
layer.

And that plan _should_ eventually include the textual diff part.
But textual diff has a machine readability requirements, so we
need to proceed very carefully.  I think the patch I sent out
earlier is probably good enough if we only care about utf-8, but
would not correctly handle other sane pathname encodings such as
extended UNIX code (let alone broken but still widely used
encodings such as MS-Kanji aka Shift_JIS).

