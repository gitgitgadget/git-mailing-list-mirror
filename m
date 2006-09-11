From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 11:01:49 -0400
Message-ID: <9e4733910609110801p19ab39q5ef62bb60b89abb5@mail.gmail.com>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
	 <20060911142644.32313.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 17:02:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMnIH-0000a8-9M
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 17:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWIKPBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 11:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWIKPBu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 11:01:50 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:44336 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751134AbWIKPBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 11:01:50 -0400
Received: by py-out-1112.google.com with SMTP id n25so2248718pyg
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 08:01:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FQgUSGQ+Y8Mtd3jqXcsMEAPDxDjCvn5ZR4F6IVpw0mAEulu71Zk/GWoKM8hLgqjJf0I+dFP+CnrMN69y3R1nXJnCYllu/auUjCjzLI/vn1X2I+Dw41MM+KIaxbdVwPqKMzPy+lSVZ5Ehs+hZIBqKDKlBd0/dCZE5A6QNchnP2sk=
Received: by 10.35.72.1 with SMTP id z1mr9017687pyk;
        Mon, 11 Sep 2006 08:01:49 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Mon, 11 Sep 2006 08:01:48 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060911142644.32313.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26852>

On 11 Sep 2006 10:26:44 -0400, linux@horizon.com <linux@horizon.com> wrote:
> > Could we do a cache of the refs that stores the stat information for
> > each of the files under .git/refs plus the sha1 that the ref points
> > to?  In other words this cache would do for the refs what the index
> > does for the working directory.  Reading all the refs would mean we
> > still had to stat each of the files, but that's much quicker than
> > reading them in the cold-cache case.  In the common case when most of
> > the stat information matches, we don't have to read the file because
> > we have the sha1 that the file contains right there in the cache.
>
> Well, that could save one of two seeks, but that's not *much* quicker.
> (Indeed, a git ref would fit into the 60 bytes of block pointer space
> in an ext2/3 inode if regular files were stuffed there as well as symlinks.)

Does everyone hate my idea of putting the sha in the file name and
using the directory structure as a simple database with locking? No
one made any comments.

------------------------------------------------
Here's a hack, instead of of putting the sha inside the file, put the
sha into the filename.

master_86a8534ba23a5532f6d0ddd01ecd8f02f662cf78

Now you can just do a directory listing and get all of the data
quickly. To keep the existing porcelain working add a symlink.

ln -s master_86a8534ba23a5532f6d0ddd01ecd8f02f662cf78 master

You might want the sha1 encoded names in a new director
-- 
Jon Smirl
jonsmirl@gmail.com
