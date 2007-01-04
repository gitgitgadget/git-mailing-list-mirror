From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Thu, 4 Jan 2007 09:58:23 -0800
Message-ID: <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Sasha Khapyorsky" <sashak@voltaire.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 18:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2WrE-0000zl-Gs
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 18:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXADR6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbXADR6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 12:58:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:31252 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbXADR6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 12:58:24 -0500
Received: by wx-out-0506.google.com with SMTP id h28so6342871wxd
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 09:58:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G5Hq2Ah1FOz1kZyQmryy8H/bS15/qfiUy7664jWHyz9u8utRINUVbaHbaR+fvB0EotiLPS4VLM3+rzblAblQ0yCKeOnIGg8/cMtb0vwx0PBUwfFmqitqfGLRznCe4UqCCBuowoPmQ5OI6Ctv0u85NvLq1mG36MdFHpQNj4/K084=
Received: by 10.90.78.9 with SMTP id a9mr255953agb.1167933503745;
        Thu, 04 Jan 2007 09:58:23 -0800 (PST)
Received: by 10.90.83.17 with HTTP; Thu, 4 Jan 2007 09:58:23 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35942>

> If Chris still has that huge .pack & .idx pair, it would be a
> very good guinea pig to try a few things on, assuming that this
> problem is that the pack-check.c feeds a huge blob to SHA-1
> function with a single call.

I do not still have it, but I can pretty easily regenerate it. Should
have it again in another nine hours or so. :)

>  (1) Apply the attached patch on top of "master" (the patch
>      should apply to 1.4.1 almost cleanly as well, except that
>      we have hashcmp(a,b) instead of memcmp(a,b,20) since then),
>      and see what it says about the packfile.  If your suspicion
>      is correct, it should complain about your SHA-1
>      implementation.
>
>  (2) Try tip of "next" to see if its verify-pack passes the
>      check.  Again, if your suspicion is correct, it should, since it
>      uses Shawn's sliding mmap() stuff that will not feed the
>      whole pack in one go.
>
>  (3) I suspect that the tip of "master" should work except
>      verify-pack.  It may be interesting to see how well the tip
>      of "master" and "next" performs on the resulting huge pack
>      (say, "time git log -p HEAD >/dev/null").  I am hoping this
>      would be another datapoint to judge the runtime penalty of
>      Shawn's sliding mmap() in "next" -- I suspect the penalty
>      is either negligible or even negative.

I'll try all of this after the pack is regenerated. Thanks!
