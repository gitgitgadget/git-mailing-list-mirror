From: "David Frech" <nimblemachines@gmail.com>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Mon, 9 Jul 2007 21:16:41 -0700
Message-ID: <7154c5c60707092116p70aaeb8l90cda9265311b999@mail.gmail.com>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com>
	 <20070710031036.GA9045@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 06:16:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I879a-0001e7-Ui
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 06:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbXGJEQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 00:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbXGJEQn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 00:16:43 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:1844 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbXGJEQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 00:16:42 -0400
Received: by nz-out-0506.google.com with SMTP id s18so890702nze
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 21:16:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VcK5K5Gy3wzG5K6BLf//kgDscUB2cThZO5O1YYOGMo2y1ZttAPtxnHj+KLxo2c7gbZvN+zBikqKXERa5xHUVktHQ8YPzjTSGWHOxruE3b4LN0WgmB8ufWGh/E29Mb4cXIoPGiWQ1qBmUyRGOEU0/5tcNAwvYqYMEZqTt4wKC6p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S15JXzAM5EmSjClSSicfeUlE0azezKb4TKe6lczHyTLyU/r+cn/mH/NTO4Gosbe038eXGzSYeo23xOygt4bjRYvU9raMKJ5SDZ08mTXLffHyLJqcNWRMi2YH/gtvlX2XGCXTAfhFTPPbOz4bDj73juKF83V2cgadusX5V0+pEuk=
Received: by 10.114.195.19 with SMTP id s19mr3782640waf.1184041001955;
        Mon, 09 Jul 2007 21:16:41 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Mon, 9 Jul 2007 21:16:41 -0700 (PDT)
In-Reply-To: <20070710031036.GA9045@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52038>

This should do nicely! Thank you!

Now my challenge is that the svn dump doesn't *actually* say "rename
a/ to b/"; it says "copy a/ to b/; delete a/", so I have to infer the
rename.

But your patch makes my import possible, and it wasn't before!

Cheers,

- David

On 7/9/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Some source material (e.g. Subversion dump files) perform directory
> renames without telling us exactly which files in that subdirectory
> were moved.  This makes it hard for a frontend to convert such data
> formats to a fast-import stream, as all the frontend has on hand
> is "Rename a/ to b/" with no details about what files are in a/,
> unless the frontend also kept track of all files.
>
> The new 'R' subcommand within a commit allows the frontend to
> rename either a file or an entire subdirectory, without needing to
> know the object's SHA-1 or the specific files contained within it.
> The rename is performed as efficiently as possible internally,
> making it cheaper than a 'D'/'M' pair for a file rename.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
>  David Frech <david@nimblemachines.com> wrote:
>  > Git can track file renames implicitly. If I delete and then add (under
>  > a different name) the same content, git will figure that out.
>  >
>  > But if a directory was renamed, I have no way to tell fast-import
>  > about it. I can't delete the directory (using a 'D' command) and then
>  > add it back (with a different name) with all its contents, because my
>  > source material (an svn dump file) doesn't tell me, at that point,
>  > about all the files involved because nothing about them has changed.
>  >
>  > fast-import knows about the contents of the directory I want to
>  > rename, but doesn't give me a primitive to do the rename. Is this
>  > something we need to add? My frontend could keep track of this, but I
>  > would duplicating work that fast-import is already doing.
>
>  Does the following do the trick for you?  It is also available
>  from my fastimport.git master branch:
>
>         git://repo.or.cz/git/fastimport.git      master
>         http://repo.or.cz/r/git/fastimport.git   master
>
>  Yes, it passes all tests...
>
[patch elided]
