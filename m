From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 17:45:44 -0700
Message-ID: <7v64x91mfb.fsf@assigned-by-dhcp.cox.net>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
	<7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
	<7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
	<87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org>
	<7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net>
	<046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 02:46:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaNYd-0001Wz-6U
	for gcvg-git@gmane.org; Tue, 24 May 2005 02:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEXAqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 20:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEXAqi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 20:46:38 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:412 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261251AbVEXApu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 20:45:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524004544.MDYC23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 20:45:44 -0400
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org> (Chris
 Wedgwood's message of "Mon, 23 May 2005 17:31:02 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "CW" == Chris Wedgwood <cw@f00f.org> writes:

CW> On Mon, May 23, 2005 at 05:25:32PM -0700, Junio C Hamano wrote:
>> Then you would use '-z'.  (10) becomes NUL which your path
>> cannot have inside.  So do (12) and (14).

CW> Sure, I guess I meant to what would happen when not using '-z'?  Will
CW> something notice this early on barf and tell me to use '-z' or will
CW> BadThings(tm) just come bite me at some (possibly) later stage?

Embedded spaces in path is _always_ safe.  And I think with the
current code unless you are using rename detection, your path
with embedded TABs are also OK (but do not depend on it).

If you are using rename detetion, your rename source path is
truncated at the first TAB and your rename destination path has
the remainder of the source path, with an extra TAB, prepended
to it.  Nothing as far as I know would detect and warn that
situation.  If you have an embedded LF, then you are SOL,
period.  Just do not do it.

I _could_ add a code to diff-helper to barf if your path have an
embedded TAB in it, but I am not sure if that is worth it.  Also
I _could_ add a code to diff-raw output routine to barf if your
path have these problematic characters in it and you are not
using '-z'.  I think the latter makes quite a lot of sense.

The design comes from this reasoning (third point of "a few
results"); please look in your archive if you care about the
details.

    To:	git@vger.kernel.org
    Subject: Re: updated design for the diff-raw format.
    Date:	Sat, 21 May 2005 16:17:33 -0700
    Message-ID: <7vll68dv8y.fsf@assigned-by-dhcp.cox.net>

    (second of the replayed message, with blessing from Linus)

