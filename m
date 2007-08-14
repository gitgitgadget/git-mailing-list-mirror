From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: squelch empty diffs even more
Date: Tue, 14 Aug 2007 16:52:15 -0700
Message-ID: <7vvebhad3k.fsf@assigned-by-dhcp.cox.net>
References: <46C21A25.2040304@lsrfire.ath.cx>
	<7v643hbyao.fsf@assigned-by-dhcp.cox.net>
	<46C22F7C.1000502@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Aug 15 01:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL6Bf-0004A7-3X
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 01:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbXHNXwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 19:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbXHNXwS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 19:52:18 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58465 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbXHNXwR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 19:52:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814235216.JIZY325.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 19:52:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bzsG1X0071kojtg0000000; Tue, 14 Aug 2007 19:52:16 -0400
In-Reply-To: <46C22F7C.1000502@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Wed, 15 Aug 2007 00:41:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55864>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hmm.  Like this?
>
> The patch adds a new diff_options bitfield member, no_index, that
> is used instead of the special value of -2 of the rev_info field
> max_count to indicate that the index is not to be used.  This makes
> it possible to pass that flag down to diffcore_skip_stat_unmatch(),
> which only has one diff_options parameter.
>
> This could even become a cleanup if we removed all assignments of
> max_count to a value of -2 (viz. replacement of a magic value with
> a self-documenting field name) but I didn't dare to do that so late
> in the rc game..
>
> The no_index bit, if set, then tells diffcore_skip_stat_unmatch()
> to not account for any skipped stat-mismatches, which avoids the
> suggestion to run git-status.

Yeah, I've always hated that -2 magic hack, and I think this is
the right way to go.  Dscho?
