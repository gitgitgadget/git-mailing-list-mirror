From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 2/2] git status: show relative paths when run in a subdirectory
Date: Thu, 8 Nov 2007 11:53:48 +1100
Message-ID: <ee77f5c20711071653x6a1fe8f8peb8ac2714941d2bb@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
	 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
	 <Pine.LNX.4.64.0711080011170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipven-0005Kg-Lz
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbXKHAxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166AbXKHAxv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:53:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:47080 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351AbXKHAxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:53:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2216144rvb
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 16:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FOFORA3G8o0nXP1oBnV9mOTTMeD+tt01B+Y8vz0QjPw=;
        b=rOkHBS0hYnwOLk1XUCWsO+BbBqugLfCflNclMLnSfENyv+YhVJqtczLwIUBq2MlSPfAbY0/zqC9a5/7cBsGeN/MmK46h7vXTH5BO5xurwcjWs78HTSr9n7i0JAuLDcBz0fjelyQdn3+a2eEIsqd5XRzI7RdEenVDhQW1qU8Q64s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l0eqneTYoFz/Id6kosRC6GK6K9y0BtSRvfbzCBnGkSG3Yr4DdsTfaMKcqxJShjobUvM28/J4YZnJAK6xXDByZTy6Bq9xCtM46NNDJKIqI4agxh2SAf/p7kyMUxaKk3L4duzYzJDCRoIzWFE6HxoCys9lj6150WhHvbfBFFHHVHw=
Received: by 10.141.211.13 with SMTP id n13mr392948rvq.1194483228918;
        Wed, 07 Nov 2007 16:53:48 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Wed, 7 Nov 2007 16:53:48 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711080011170.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63917>

On Nov 8, 2007 11:12 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>         This looks a bit ugly because quote_crlf() is now also called
>         on the untracked files, which are not NUL terminated.
>
>         Maybe someone has an idea how to do this more elegantly.
>
>  builtin-runstatus.c |    1 +
>  wt-status.c         |   50 ++++++++++++++++++++++++++++++++++++++++++--------
>  wt-status.h         |    1 +
>  3 files changed, 44 insertions(+), 8 deletions(-)

Tested, and looks good.

Now that I play with it, though, it seems that a few other bits of git
need updating to handle relative paths okay:

$ cd gitweb/test
$ rm ../../wt-status.h
    [oops, what a silly thing to do -- better checkout the latest
revision of it]
$ git status
# On branch next
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    ../../wt-status.h
no changes added to commit (use "git add" and/or "git commit -a")
$ git checkout HEAD ../../wt-status.h
fatal: git-ls-files: cannot generate relative filenames containing '..'
    [grr....]
$ cd ../..
$ git checkout HEAD .
    [that works]



Dave.
