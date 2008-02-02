From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sat, 2 Feb 2008 19:47:23 +0100
Message-ID: <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
	 <1201975757-13771-1-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802021815510.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 02 19:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLNPC-0001BD-Br
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 19:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbYBBSrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 13:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbYBBSrY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 13:47:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:52287 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYBBSrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 13:47:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1641780wah.23
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 10:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Y2OJ5JEXt5Xq9Qjrva4mE//pI3oF6+5w41o0KIsCtjQ=;
        b=dGFPaeIfpeRZ+SaTP+v3gVIoN0wHBttUF0Xde+aEL5GilWFFk/N2rSlxTrhCWR+e/ktwrh/AyDsw9vwOCmpRrxAb1+rlqLUXqS6LxR81woqy2uzm5YZBF+odDW7WD5Tb0RvE882+WmP7zTQRBr7bv9G3+Z927XGwA8L7SYRimzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LAl0lSWhEZr5hFPcVFbASK+mXUH+TFbkx3CENaKEU45ZUoiPY2/OTtDWYeW9mmPGdxZ5kGzvk5z+eoFFoyLOpnIu7OGLBmRjZL1ZFBfeFY+baeh+59DuLz4aniasJsxpao34wuBcaWKl90j5RkV9TWWp/lz2Jo8Z4kzX3XmK2VQ=
Received: by 10.114.137.2 with SMTP id k2mr5343108wad.104.1201978043532;
        Sat, 02 Feb 2008 10:47:23 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Sat, 2 Feb 2008 10:47:23 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802021815510.7372@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72297>

On Feb 2, 2008 7:19 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 2 Feb 2008, Lars Hjemli wrote:
>
> > +     if (len < 10 || buf[len - 1] != '\n' || strncmp(buf, "GITDIR: ", 8))
>
> Sorry, missed that earlier: How about
>
>         if (!len || buf[len-1] != '\n' || prefixcmp(buf, "GITDIR: "))
>
> instead?  (buf does not need be NUL terminated for the prefixcmp(), since
> we just made sure it is LF terminated)

That's true, although it feels a bit too clever for me ;-)

Maybe this as a compromise?

	static char buf[PATH_MAX + 9];  /* "GITDIR: " + "\n"  */
...
	if (!len || buf[len - 1] != '\n')
		return NULL;
	buf[len - 1] = '\0';
	if (prefixcmp(buf, "GITDIR: "))
		return NULL;

--
larsh
