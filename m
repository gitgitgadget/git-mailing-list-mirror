From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] remote.c: refactor get_remote_ref_states()
Date: Mon, 23 Feb 2009 20:05:56 -0500
Message-ID: <20090224010556.GA3847@coredump.intra.peff.net>
References: <76718490902222355v7510d2f9p51ade61d1f257146@mail.gmail.com> <1235377892-96089-1-git-send-email-jaysoffian@gmail.com> <cover.1235368324.git.jaysoffian@gmail.com> <885507eaf920f6b60727db7e712da3560a7fd4c5.1235368324.git.jaysoffian@gmail.com> <20090223065048.GC24517@coredump.intra.peff.net> <76718490902222355v7510d2f9p51ade61d1f257146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbllh-0003pw-4w
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZBXBGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZBXBGA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:06:00 -0500
Received: from peff.net ([208.65.91.99]:34222 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbZBXBF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:05:59 -0500
Received: (qmail 32558 invoked by uid 107); 24 Feb 2009 01:06:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 20:06:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 20:05:56 -0500
Content-Disposition: inline
In-Reply-To: <1235377892-96089-1-git-send-email-jaysoffian@gmail.com> <76718490902222355v7510d2f9p51ade61d1f257146@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111186>

On Mon, Feb 23, 2009 at 02:55:32AM -0500, Jay Soffian wrote:

> I see your hmph and raise you a hmph. :-)
> 
> Well, I _had_ tried as you suggested first, and thought it yuckier. It
> would actually be more like:

OK. My comment was along the lines of "why didn't you think of doing it
this way first?" but apparently you did. ;)

> I'm not sure why passing a flag saying what you want is obfuscating.

It doesn't have to be. But from your description and my cursory look
over the code, it seemed like get_remote_ref_states was really
conflating several unrelated things. So breaking it apart would make
sense for the same reason we have "strlen" and "strchr" as separate
functions and not "string_ops(s, WANT_STRLEN)": the function is our
basic unit of reusable work.

But from your description:

> caller1() {
>   setup_for_get();
>   get_thing_one();
> }

I didn't realize the commonality was actual setup; I thought it was "do
a list of 5 things, but the first 2 are common, and then callers may
want to some mix of the other 3".

So I think your original patch is fine.

-Peff
