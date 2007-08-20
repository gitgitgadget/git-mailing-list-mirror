From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 22:39:57 +0200
Message-ID: <853ayeos82.fsf@lola.goethe.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<20070820174142.GA7943@glandium.org>
	<867inqhyuk.fsf@lola.quinscape.zz>
	<20070820181357.GA8264@glandium.org>
	<86zm0mgicy.fsf@lola.quinscape.zz>
	<20070820184829.GA8617@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INE3W-0002Hi-7h
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763948AbXHTUkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbXHTUkG
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:40:06 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:48414 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763948AbXHTUkE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2007 16:40:04 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id DE7561F563B;
	Mon, 20 Aug 2007 22:40:00 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id CBF7E212FAC;
	Mon, 20 Aug 2007 22:40:00 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-046-034.pools.arcor-ip.net [84.61.46.34])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id AE4B419B323;
	Mon, 20 Aug 2007 22:40:00 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A56C31C36605; Mon, 20 Aug 2007 22:39:57 +0200 (CEST)
In-Reply-To: <20070820184829.GA8617@glandium.org> (Mike Hommey's message of "Mon\, 20 Aug 2007 20\:48\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4014/Mon Aug 20 21:33:05 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56253>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Aug 20, 2007 at 08:40:13PM +0200, David Kastrup <dak@gnu.org> wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> 
>> > On Mon, Aug 20, 2007 at 07:58:43PM +0200, David Kastrup <dak@gnu.org> wrote:
>> >> > I also never understood why there were no permissions set on
>> >> > directories in trees...
>> >> 
>> >> Because directories are not actually tracked.  They are created and
>> >> deleted as-needed.
>> >
>> > I don't see why it would prevent to have a permission set to
>> > it... the permission technically can be recorded in the parent tree,
>> > along its sha1. Filesystems are also like this.
>> 
>> No, they aren't.  Filesystems don't create and delete directories on
>> the fly.  If we record any information about a directory, deleting it
>> automagically would not be appropriate since we would lose information
>> that has not been explicitly deleted.
>
> git doesn't magically create directories either. It actually stores
> something about them: the hash of the tree object that represents
> them.

The tree object is not a representation of the directory in the file
system.  It is a hierarchical hash in the repository, stored for
efficiency reasons.

> And it has permissions associated with these hashes.

No, with the files.  Think again: the link between file system and
repository is the index, and the current index format has no
representation for trees or directories.

So git _can't_ store any information about a _directory_, since no
information about directories passes through the index.

> (...)
>> > I think i wasn't clear enough... I just wondered why the format for tree
>> > entries is something like (if you'd write it in perl):
>> > sprintf "%06o %s\0%s", $mode, $file, pack("H[40]", $sha1)
>> 
>> Now I am sure I don't get your point.
>
> See what a raw tree object looks like:
> git-cat-file tree 708453d64796eb617cb8a1602959e00356693315

Well, a tree is a container for files (which in turn consist of their
permissions, file names, and blobs).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
