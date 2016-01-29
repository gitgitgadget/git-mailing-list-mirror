From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: fast-import fails in read-only tree
Date: Fri, 29 Jan 2016 09:28:44 -0500
Message-ID: <jwv7fisxyhz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwvfuxhz72e.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160129060802.GA23106@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 15:29:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPA30-0001g5-0A
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 15:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbcA2O3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 09:29:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:49379 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbcA2O3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 09:29:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aPA2l-0001TH-TG
	for git@vger.kernel.org; Fri, 29 Jan 2016 15:29:00 +0100
Received: from 76-10-146-127.dsl.teksavvy.com ([76.10.146.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 15:28:59 +0100
Received: from monnier by 76-10-146-127.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 15:28:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 76-10-146-127.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:rwCiVCxdYyUNuskr5FqlHBrB45Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285076>

>> I recently discovered that "git fast-import" signals an error if used in
>> a tree to which we do not have write-access, because it tries to create
>> a "objects/pack/tmp_pack_XXX" file even before starting to process
>> the commands.
> The primary goal of fast-import is to write that packfile.  It kind of
> sounds like you are using the wrong tool for the job.

Yes, I realize that.  But in some cases it's the best tool available.
`fast-import' is very close to being a "generic access API" which can be
used instead of something like libgit.  I think it'd be good to push it
yet a bit closer.

My earlier "cat-blob applied to a tree" issue is another such case.

> Can you elaborate on what you are sending to fast-import (preferably
> with a concrete example)?

I'm sending a stream of "progress <foo>; cat-blob <foo>", basically.

The concrete example is in [BuGit](https://gitlab.com/monnier/bugit),
see for example https://gitlab.com/monnier/bugit/commit/3678dcb8830a9c79c6f3404d75d63e6dd07bfe4c

> There may be a way to accomplish the same thing with read-only tools
> like cat-file.

Yes, I switched to using "cat-file --batch" instead, but it's less
convenient (I can't intersperse ad-hoc info in the output, the way I can
with "progress" in fast-import) and there are cases where the list of
files I need to extract cannot be determined without first looking at
some of those extracted files (I currently have been able to avoid
this in BuGit, luckily).

If I could use "cat-blob" on directories, there would be even more cases
where I'd want to use fast-import for read-only operations to reduce the
number of Git processes I fork.


        Stefan
