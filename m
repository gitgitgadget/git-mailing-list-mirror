From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 19:58:43 +0200
Message-ID: <867inqhyuk.fsf@lola.quinscape.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<20070820174142.GA7943@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 19:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBX7-0007t0-7M
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 19:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXHTR7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 13:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXHTR7A
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 13:59:00 -0400
Received: from main.gmane.org ([80.91.229.2]:52038 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbXHTR67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 13:58:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INBWe-0006J5-JO
	for git@vger.kernel.org; Mon, 20 Aug 2007 19:58:52 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 19:58:52 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 19:58:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Oi9JhozYjAn4MmFBev7/s/t8klo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56230>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Aug 20, 2007 at 06:44:11PM +0200, martin f krafft <madduck@madduck.net> wrote:
>> Why does git bother saving a mode when later it never seems to use
>> it again?
>
> Same applies to git-archive, which generates files with mode 666 and
> directories with 777, while it could follow the modes in the
> repository... or at least, that's what the manpage claims, but facts
> seem to be quite different...

Git had permissions at one point of time.  It makes colloboration with
other people with different umasks a nuisance.  However, not all uses
are colloborative.  So it might be nice to be able to specify
permission/uid/gid policies that do a configurable level of munging
for stuff passed into and out of the index and/or the repositories.

> I also never understood why there were no permissions set on
> directories in trees...

Because directories are not actually tracked.  They are created and
deleted as-needed.

In my proposal for allowing directories to get tracked, permissions of
000 would indicate a tree without a corresponding tracked directory.
Other permissions would correspond to a tracked directory.  I am still
stuck over the representation in the index.

One idea is to unconditionally have an entry "dirname" without
permissions, and optionally "dirname/" with permissions iff the
directory is supposed to be tracked, both to be sorted in
alphabetically.  The idea of the first entry is being able to detect
merge conflicts without extra passes.

But I have not worked on the stuff for a while.

> nor why, while the sha1 for child objects are "packed", the modes
> aren't...

Because a change of the mode of a file will then not cause different
sha1 sums at the file level.

-- 
David Kastrup
