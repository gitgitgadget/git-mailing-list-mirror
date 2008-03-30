From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: Possible d/f conflict bug or regression
Date: Sat, 29 Mar 2008 21:29:23 -0400
Message-ID: <3e8340490803291829h6f9c39a5uf4a1b2a4e52103ca@mail.gmail.com>
References: <200803290813.08419.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio Hamano" <junkio@cox.net>,
	krh@redhat.com
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Mar 30 03:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfmNF-00076G-NR
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 03:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbYC3B3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 21:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbYC3B3Y
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 21:29:24 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:65308 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYC3B3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 21:29:24 -0400
Received: by py-out-1112.google.com with SMTP id u52so1389682pyb.10
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 18:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=V0m3qNCTWcea4cWJx4qEGu9T/dkZpkdLFNqOplbfvIc=;
        b=UdGAm4b0DYlCDGOTEPR6iyhVpur+UXPaM5Q4C7JfunXDkBSY8OaSCKHPLfehe82Z46AdacYMlFi1y3wpZeOapxHNyravg6ZsRWQ/RNM5i8Q/oR3x40+glzxW3IYlvS55CBxiJ9gyetxG9LGEXskwaWKJbX6YQDyevR3Chq2Rvio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fjn9Yfl+VTt5QRkWDydDBUvOpfPSHFwoqdRzrGjIUJ1TS+C6C2jMGh20fPniwwwsqNvxSq333HN4T+pAnVzLCX1nC6Jw8fLlshGENpNxFjgSWz1zOKHsm9Jr1XzStFa55/COu/yH6sCKl19WTn7RENESh0BatWJv3VgR9NyMzsM=
Received: by 10.65.93.19 with SMTP id v19mr10167059qbl.74.1206840563412;
        Sat, 29 Mar 2008 18:29:23 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Sat, 29 Mar 2008 18:29:23 -0700 (PDT)
In-Reply-To: <200803290813.08419.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78493>

On Sat, Mar 29, 2008 at 3:13 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Hi,
>
>  When doing something like:
>
>  mkdir testdir &&
>         cd testdir &&
>         touch foo &&
>         git init &&
>         git add . &&
>         git commit -m 'Initial commit.' &&
>         rm foo &&
>         mkdir foo &&
>         git commit -a -m 'Test.'
>
>  I get:
>
>  Initialized empty Git repository in .git/
>  Created initial commit 3f945ca: Initial commit.
>   0 files changed, 0 insertions(+), 0 deletions(-)
>   create mode 100644 foo
>  fatal: unable to index file foo
>
>  I think it's quite bad that it doesn't work.

What behavior would you expect this to have? IMO, it's not entirely
clear what the user means to do if they replace a file with an empty
directory, as an empty directory cannot be added to the index. Even
with a directory with contents, some of the contents may be junk (.o
for example) as far as the user is concerned.

Would a clearer diagnostic be a good solution? Something like:
fatal: foo: file replaced by directory.
Use git rm --cached or git add to specify how this should be handled.

Thanks,

Bryan
