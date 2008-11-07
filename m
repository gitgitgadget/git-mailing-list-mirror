From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Fri, 7 Nov 2008 23:12:24 +0100
Message-ID: <20081107221224.GK5158@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth> <20081101220319.1116.50509.stgit@gandelf.nowhere.earth> <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org> <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net> <7v3ai3gugt.fsf@gitster.siamese.dyndns.org> <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net> <7vskq3fdgz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 23:50:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyaAK-0004RV-TV
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbYKGWtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYKGWtn
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:49:43 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:53198 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbYKGWtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:49:42 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D5EDA17288;
	Fri,  7 Nov 2008 23:49:40 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id B182517266;
	Fri,  7 Nov 2008 23:12:46 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 3C1D41F06A; Fri,  7 Nov 2008 23:12:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vskq3fdgz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100356>

On Fri, Nov 07, 2008 at 01:11:40PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > On Fri, Nov 07, 2008 at 12:19:14PM -0800, Junio C Hamano wrote:
> >> I am afraid that this is totally unacceptable, as you yourself mentioned,
> >> the end result is unapplicable with any existing tool and would confuse
> >> viewers like gitk and gitweb.
> >
> > Well, other tools will still have to be taught about a new syntax, if
> > they're going to use the new flag - just like it was for --rename.
> 
> You are mistaken.  For a patch, you are dealing with two different
> parties: producer and consumer.  If you are adding new feature to the
> producer, the output format should be desigend to allow the consumer tell
> that it is something it does not know how to handle.

Agreed.

> Marking a non patch with "diff --git" to trigger the logic to signal the
> beginning of a patch to git-apply (and perhaps other tools) is a non
> starter.

This is not what I meant.

> And for this "we are giving a patch that your git-apply can apply and gitk
> can show, but by the way we also think the whole directory foo moved to
> new location bar" is merely an additional information.  You should still
> be able to apply the patch with tools that are unaware of this new
> directory move detection feature.

I hope I just miss your point.  Letting unaware tools handle such a
patch "the right way" would imply just adding the information "dir foo
moved to bar", and not removing the individual file moves, which goes
in the way of the exact reason why I have started to work on this.

Compare this to the addition of the "file rename" feature (correct me
if I'm wrong): it was added without bothering whether plain old
"patch" can deal with it, and when feeding a git diff to patch(1) I
cannot expect it to DTRT (indeed it applies the content change but not
the rename part, without complaining, and an unsuspecting user would
just be shot in the foot): we are precisely *not* able to apply the
patch with tools that are unaware of this new file rename feature.

This is precisely to limit this problem in the future that I proposed
this "diff extension" stuff in my last mail: limit how the "backward
compatibility" argument can cripple innovation.
