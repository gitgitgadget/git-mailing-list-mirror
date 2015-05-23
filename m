From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/3] using stat() to avoid re-scanning pack dir
Date: Sat, 23 May 2015 08:19:03 +0700
Message-ID: <CACsJy8BjFM_OecoVU9DV3GmJafatSR2yPt6Xb6dETEpYjc1ODA@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net> <7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C551975B851@C111KXTEMBX51.ERF.thomson.com> <20150522235116.GA4300@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: steve.norman@thomsonreuters.com,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 23 03:19:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvy6H-0000gA-KA
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 03:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbbEWBTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 21:19:35 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33156 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314AbbEWBTf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 21:19:35 -0400
Received: by igbpi8 with SMTP id pi8so4021502igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 18:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pn9mn/jzG5/pBZaNFqrGDIO2v4jQXpwkiGA9XQcCUu8=;
        b=yw0P2vsrxIfyue9CCb2XVGJxntGAcCG1Q4sFyEVRspr6iV87k2iN+rXYZEz4Zm44e9
         Tn/Ts3C+lvtKQY4DvW05+v6D7SEnrfPsDiPQUYZThpXUVhruVA+ynVQneQoNZFwkJv+6
         I6jIYiAWgIwDYemaF9ssz9eOzB58rq1XT3o3JvuZ9p+XkIhKh46u1KN8L6WuQ68hbd1g
         g8QDHBYlJgn9QDG8ORscpwaUamEKxnc7NtfuXt5vFmCBhtcyDRp2KA2xRTM1mAG9LBV2
         u25LxTx0NUWzMtUMpb9CeFEInhoKjQBV7OlvEDe04jUILT8+d4a8NADypYnuNbya7k1l
         SYdQ==
X-Received: by 10.107.47.216 with SMTP id v85mr14211527iov.86.1432343974259;
 Fri, 22 May 2015 18:19:34 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Fri, 22 May 2015 18:19:03 -0700 (PDT)
In-Reply-To: <20150522235116.GA4300@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269787>

On Sat, May 23, 2015 at 6:51 AM, Jeff King <peff@peff.net> wrote:
> The other problem is that I'm not sure stat data is enough to notice
> when a directory changes. Certainly the mtime should change, but if you
> have only one-second resolution on your mtimes, we can be fooled.

mtime may or may not change. I based my untracked-cache series
entirely on this directory mtime and did some research about it. For
UNIXy filesystems on UNIXy OSes, mtime should work as you expect. FAT
on Windows does not (but FAT on Linux does..). NTFS works fine
according to some MS document. No idea about CIFS. But people often
just do open operation of a time and this racy is not an issue. It is
only an issue on the busy server side, and you can make sure you run
on the right fs+OS.
-- 
Duy
