From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: On the many files problem
Date: Tue, 1 Jan 2008 12:31:25 +1300
Message-ID: <46a038f90712311531x17b6d94aua1bac2d3d186f186@mail.gmail.com>
References: <87y7bdweca.fsf@enceladus.ygingras.net>
	 <alpine.LFD.0.9999.0712291055470.2778@woody.linux-foundation.org>
	 <873atjtbmu.fsf@enceladus.ygingras.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Yannick Gingras" <ygingras@ygingras.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:31:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9U6w-0003pm-2A
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 00:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbXLaXb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 18:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbXLaXb2
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 18:31:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16692 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbXLaXb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 18:31:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2344731ugc.16
        for <git@vger.kernel.org>; Mon, 31 Dec 2007 15:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aNCHJfRb1m9TSQfTwXnNd3eQd4srnceNmFDbn8NqGT8=;
        b=kxLDegmFpRamJWkfGypd7F8pdoM5smqr0/S/Vwbzk2ONFMg6Ntu47i8DThscoiqPe0M1yV2RMevy2nvMB0yiYmWEasDGEsCt1LxhZQ+1rIserIBkxSqBiLPInhF/Ng+/y6Ur4EMTbIdFF6Kka8xuvNwYNsGClxA+UlNN8akRpwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e2z4RCDQdOSraJDYj6yakcqriJ9gxd4TV4UNNE1tPi8kjlF3BEsbjPcGwCpUnqTu++VHftrAIEg+ylIk8nnQIw1qYLl5kiDFTqtGY3jzm8SjLqHbVzzMJGkuhujHxkXRu+29Rq/vFfXoXFyKp0XHCOygpxtWu8tfXpkOH+F8Urs=
Received: by 10.67.19.17 with SMTP id w17mr11940946ugi.33.1199143886000;
        Mon, 31 Dec 2007 15:31:26 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Mon, 31 Dec 2007 15:31:25 -0800 (PST)
In-Reply-To: <873atjtbmu.fsf@enceladus.ygingras.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69424>

On Dec 31, 2007 11:13 PM, Yannick Gingras <ygingras@ygingras.net> wrote:
> >    but if you want to check odder cases, try creating a huge
> >    directory, and then deleting most files, and then adding a few
> >    new ones. Some filesystems will take a huge hit because they'll
> >    still scan the whole directory, even though it's mostly empty!
> >
> >    (Also, a "readdir() + stat()" loop will often get *much* worse access
> >    patterns if you've mixed deletions and creations)
>
> This is something that will be interesting to benchmark later on.  So,
> an application with a lot of turnaround, say a mail server, should
> delete and re-create the directories from time to time?  I assume this
> is specific to some file system types.

This is indeed the case. Directories with a lot of movement get
fragmented on most FSs -- ext3 is a very bad case for this -- and
there are no "directory defrag" tools other than regenarating them.
The "Maildir" storage used for many IMAP servers these days shows the
problem.

This (longish) threads has some interesting tidbits on getdents() and
directory fragmentation.
http://kerneltrap.org/mailarchive/git/2007/1/7/235215

cheers,


m
