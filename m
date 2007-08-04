From: David Kastrup <dak@gnu.org>
Subject: Re: possible bug in git apply?
Date: Sat, 04 Aug 2007 22:08:12 +0200
Message-ID: <857iobdpw3.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rob@landley.net
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Aug 04 22:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHPvA-0005CK-UB
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 22:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765601AbXHDUIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 16:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765462AbXHDUIR
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 16:08:17 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:44397 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764110AbXHDUIR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 16:08:17 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 84CA71F58C2;
	Sat,  4 Aug 2007 22:08:15 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 6F948ABAEC;
	Sat,  4 Aug 2007 22:08:15 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 51ED91FB029;
	Sat,  4 Aug 2007 22:08:15 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 132F71C4F932; Sat,  4 Aug 2007 22:08:12 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm> (david@lang.hm's message of "Sat\, 4 Aug 2007 12\:45\:23 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54901>

david@lang.hm writes:

> On Saturday 04 August 2007 2:03:59 pm Rob Landley wrote:
>> Signed-off-by: Rob Landley <rob@landley.net>
>> Amiga part Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Move architecture-specific Documentation into a common subdirectory.
>
> I really, really, really hate git.
>
> Ok, on my laptop I just noticed that "git apply" of the patch didn't
> complain but it also left the empty subdirectories it moved stuff
> out of.  (I don't believe this happened on the version of git I was
> using on my previous laptop, which ate itself a month and change
> ago, but obviously I can't check.)
>
> There is no "git rmdir".  "git rm" refuses to delete the directory
> without -r.  "git rm -r Documentation/x86_64" listed (as just deleted) all
> the files that the patch already moved out of the directory.
>
> Am I missing something obvious here?

Committing the change?

> since git doesn't track directories, only content (per the big
> discussion recently) I beleive that doing a checkout would leave Rob
> without the directories that he emptied out, so shouldn't git apply
> also clear the directories to end up in the same state?

Yes, once he commits.  As long as git keeps files tracked in that
directory, there is no reason for it to delete it.

I agree that it is hard to come up with a good logic for this sort of
thing.  git-add checks the _current_ state of a file into the index.
git-rm can actually do the same only by actually _deleting_ the
working copy.  So when should git try deleting the directory?
Probably when the directory becomes empty in the index, for
consistency.  Too bad that the index does not contain any information
about directories at all, so there is no good way to figure this
particular point in time out efficiently.

I guess that git rather attempts deleting the directory when the tree
in the _repository_ rather than the index becomes empty.  And for that
you need to commit.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
