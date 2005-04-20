From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Wed, 20 Apr 2005 07:55:52 -0400
Message-ID: <20050420115547.GI29945@abridgegame.org>
References: <20050418210436.23935.qmail@science.horizon.com> <1113869248.23938.94.camel@orca.madrabbit.org> <42645969.2090609@qualitycode.com> <1113874931.23938.111.camel@orca.madrabbit.org> <4264677A.9090003@qualitycode.com> <1113950442.29444.31.camel@orca.madrabbit.org> <42658E38.1020406@qualitycode.com> <1113951972.29444.42.camel@orca.madrabbit.org> <426594F9.4090002@tupshin.com> <1113959503.29444.91.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tupshin Harper <tupshin@tupshin.com>,
	Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Wed Apr 20 13:58:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DODpk-0005rA-Nt
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 13:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVDTMB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 08:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVDTMB2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 08:01:28 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:63296 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261516AbVDTMA4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 08:00:56 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DODo8-0000aQ-RP; Wed, 20 Apr 2005 07:55:52 -0400
To: Ray Lee <ray-lk@madrabbit.org>
Mail-Followup-To: Ray Lee <ray-lk@madrabbit.org>,
	Tupshin Harper <tupshin@tupshin.com>,
	Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
Content-Disposition: inline
In-Reply-To: <1113959503.29444.91.camel@orca.madrabbit.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 06:11:43PM -0700, Ray Lee wrote:
> > second patch:
> > replace ./hello.c [A-Za-z_0-9] world universe
> 
> Aha! Okay, I now see at least part of issue: we're using different
> definitions of 'token.' Yours is quite sensible, in that it matches the
> darcs syntax. However, I'm claiming a token is defined by the file's
> language, and that a replace patch on anything but a token as per those
> language standards is a silly thing.

The trouble is that a token based on language standards is also wrong,
unless your file at all times is syntactically correct.  It also means (for
C in particular) that the result of the token replace isn't uniquely
determined by the combination of the token replace patch and the file it
applies to, since you need parse any header files in order to tokenize the
C file.  In the case of header files, it may not be possible to tokenize
them uniquely, since they may tokenize differently depending on what other
header files are included before them.  And of course, none of this may be
possible if you haven't run autoconf and configure, since you may not
actually *have* the header files in the first place...

In a (reasonably) general-purpose tool like darcs, I think it's better to
stick with a simpler definition of token that doesn't require a complete
integrated development environment.

It's also true that often you want to modify headers and string contents
simultaneously with the change of the code itself.  When I replace
get_pseudowavefunction with get_atomic_orbital, I also want to modify

// We call get_pseudowavefunction to get the atomic orbital...

and

printf("Error in get_pseudowavefunction!\n");
-- 
David Roundy
http://www.darcs.net
