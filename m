From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] transport-helper: do not request symbolic refs to remote
 helpers
Date: Thu, 22 Jan 2015 17:06:38 +0900
Message-ID: <20150122080638.GA9546@glandium.org>
References: <1421631307-20669-1-git-send-email-mh@glandium.org>
 <xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
 <20150122070301.GA18195@glandium.org>
 <xmqqbnlruurk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 09:07:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YECn6-0005ww-9z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 09:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbbAVIGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 03:06:50 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:50701 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbbAVIGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 03:06:48 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YECmk-0002WS-5D; Thu, 22 Jan 2015 17:06:38 +0900
Content-Disposition: inline
In-Reply-To: <xmqqbnlruurk.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262808>

On Wed, Jan 21, 2015 at 11:41:51PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Note the most important part is actually between the parens: that only
> > happens when the remote helper returns '?' to the `list` command, which
> > non-git remotes helpers (like git-remote-hg or git-remote-bzr) do.
> > git-remote-testgit also does, so if you only apply the test parts of the
> > patch, you'll see that the test fails.
> >
> > remote-curl probably doesn't hit the problem because it's not returning
> > '?' to `list`.
> 
> Hmm, that suggests that the new codepath should be taken only when
> the remote helper says '?' (does it mean "I dunno"? where are these
> documented, by the way?)

in Documentation/gitremote-helpers.txt

> , yes?  It wasn't immediately obvious from
> the patch text that it was the case.

The patch changes the behavior in all cases, because it didn't feel
necessary to have a different behavior between the "normal" case and the
'?' case: it makes sense to request the ref being pointed at than the
symbolic ref in every case. Moreover, this makes existing non-git
remote-helpers work without having to modify them to provide a refspec
for HEAD (none of the 5 mercurial remote-helpers I checked do). The
paragraph before last in the commit message mentioned this in maybe not
very clear terms.

Mike
