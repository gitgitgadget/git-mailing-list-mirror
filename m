From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Fri, 7 Nov 2008 21:39:52 +0100
Message-ID: <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth> <20081101220319.1116.50509.stgit@gandelf.nowhere.earth> <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org> <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net> <7v3ai3gugt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 21:41:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyY9C-0002xY-VJ
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 21:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYKGUkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 15:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbYKGUkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 15:40:16 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:42097 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbYKGUkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 15:40:15 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6B86F17B52F;
	Fri,  7 Nov 2008 21:40:13 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4960917B599;
	Fri,  7 Nov 2008 21:40:13 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6E0F11F06A; Fri,  7 Nov 2008 21:39:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v3ai3gugt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100330>

On Fri, Nov 07, 2008 at 12:19:14PM -0800, Junio C Hamano wrote:
> I am afraid that this is totally unacceptable, as you yourself mentioned,
> the end result is unapplicable with any existing tool and would confuse
> viewers like gitk and gitweb.

Well, other tools will still have to be taught about a new syntax, if
they're going to use the new flag - just like it was for --rename.

That makes me think that it could be interesting to have a header
telling which diff extensions it is using.  It could even be
interesting to come with a cross-vc convention, which would ease the
interchange of modern patch files (I suppose some other tools already
have their own extensions for file renames).

What about some hint like the following ?

|extended diff features: git:rename git:binary git:filetypes
|extended diff features: git:unixperms git:dir-rename

Maybe we could leave "filetype" and "unixperms" out, since these do
not replace an information that would otherwise be present in a
standard diff anyway, and would just be ignored by a tool not
supporting them.


> I think it would be a much better approach to emit a hint that talks about
> directory rename in a format that does not fool usual "patch" application
> tools.  E.g.
> 
> |directory moved with similarity index 82%
> |rename from ppc
> |rename from foo
> |diff --git a/ppc/sha1.h b/foo/sha1.h
> |similarity index 85%
> |rename from ppc/sha1.h
> |rename to foo/sha1.h
> |index  9b34f76..8fce4b7 100644
> |--- ppc/sha1.h
> |+++ foo/sha1.h
> |@@ ...

So you're favoring the "patch is not textually splittable approach".
Don't you think it would be good to add some sort of hint about this
as a patch header ?

> IOW, do not add anything that begins with "diff --git" if it is not a
> patch.

OK.
