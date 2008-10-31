From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:41:15 -0700
Message-ID: <20081031234115.GD14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:42:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3dO-0003YB-F1
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbYJaXlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYJaXlR
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:41:17 -0400
Received: from george.spearce.org ([209.20.77.23]:59657 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbYJaXlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:41:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 68BF338360; Fri, 31 Oct 2008 23:41:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7viqr873x7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99681>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> Although I'd be Ok with either GPL + gcc exception on whatever core-ish
> (i.e. what will be necessary for libgit2; "blame" would not count) pieces
> I have in C-git codebase,

Someday I'm going to come back to you and ask for "blame" in libgit2.
Its an important function to be able to execute for an end-user.
Look at "git gui blame", its a major feature of the GUI.

If your blame implementation will never be available except under
the GPL then either it should be clean-room rewritten under the
library's license, or maybe there is a "libgitblame" that is GPL
and can be optionally linked with libgit2 and a GPL'd application
to get blame support.

>"can be linked with anything" allows a gaping
> hole to the library, which I'm a bit hesitant to swallow without thinking.
> 
> E.g.  our read_object() may look like this:
> 
>          void *read_object(const object_name_t sha1,
>                            enum object_type *type,
>                            size_t *size)
>          {
>                  ...
>          }
> 
> 
> but an extension a closed-source person may sell you back may do:
> 
>         +typedef void *read_object_fn(const object_name_t,
>         +                             enum object_type *,
>         +                             size_t *);
>         +read_object_fn read_object_custom = NULL;
>          void *read_object(const object_name_t sha1,
>                            enum object_type *type,
>                            size_t *size)
>          {
>         +       if (read_object_custom != NULL)
>         +               return read_object_custom(sha1, type, size);
>                 ...
>          }
> 
> I.e. use the supplied custom function to do proprietary magic, such as
> reading the object lazily from elsewhere over the network.  And we will
> never get that magic bit back.

As a maintainer I'd never accept such a patch.  I'd ask for the
code under read_object_custom, or toss the patch on the floor.
But that doesn't stop them from distributing the patched sources
like above, keeping the fun bits in the closed source portion of
the executable they distribute.

Maybe I just think too highly of the other guy, but I'd hope that
anyone patching libgit2 like above would try to avoid it, because
they'd face merge issues in the future.
 
> Although no license asks this, my wish is that if somebody built on top of
> what I wrote to make the world a better place, I'd like the same access to
> that additional code so that I too can enjoy the improved world.  Because
> almost all of my code in git.git are under GPLv2, in reality I do not have
> any access to your software as long as you do not distribute your
> additional code that made the world a better place, which is a bit sad.

IMHO, its a flaw of the GPL.  GitHub anyone?  Heck, even Google uses
a lot of GPL'd software internally (yes, we have Linux desktops and
servers) but not all of the software we distribute internally goes
external, so not all of our patches are published.  *sigh*

I've actually stayed awake at night sometimes wondering what the
world would be like if the GPL virual clause forced the source code
for a website to be opened, or forced you to publish your code
even if you never distribute binaries beyond "you" (where "you"
is some mega corp in many countries with many employees).

-- 
Shawn.
