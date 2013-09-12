From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2013, #03; Wed, 11)
Date: Thu, 12 Sep 2013 01:36:45 -0400
Message-ID: <20130912053644.GB1977@sigill.intra.peff.net>
References: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 07:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJzaH-0004w3-05
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 07:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab3ILFgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 01:36:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:51874 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700Ab3ILFgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 01:36:47 -0400
Received: (qmail 30821 invoked by uid 102); 12 Sep 2013 05:36:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 00:36:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 01:36:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234625>

On Wed, Sep 11, 2013 at 04:32:23PM -0700, Junio C Hamano wrote:

> * jk/config-int-range-check (2013-09-09) 5 commits
>   (merged to 'next' on 2013-09-09 at 9ab779d)
>  + git-config: always treat --int as 64-bit internally
>  + config: make numeric parsing errors more clear
>  + config: set errno in numeric git_parse_* functions
>  + config: properly range-check integer values
>  + config: factor out integer parsing from range checks
> 
>  Originally merged to 'next' on 2013-08-22
> 
>  "git config --int section.var 3g" should somehow diagnose that the
>  number does not fit in "int" (on 32-bit platforms anyway) but it
>  did not.

This description is slightly inaccurate since the re-roll. I think it is
now:

  "git config" did not provide a way to set or access numbers larger
  than a native "int" on the platform; it now provides 64-bit signed
  integers on all platforms.

Not a big deal, but it may make your life easier if this description
ends up in the merge commit, and then you later try to write
ReleaseNotes off of it.

It also fixes the mis-detection of 32-bit overflow on certain platforms,
but the only likely way to trigger that was via "config --int" (unless
you are crazy enough to set gc.auto to 2g or something). But now that
git-config is 64-bit that does not even matter, and it is probably not
even worth mentioning in the release notes.

-Peff
