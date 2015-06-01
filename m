From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Mon, 1 Jun 2015 10:54:28 +0900
Message-ID: <20150601015428.GA24214@kroah.com>
References: <20150601001759.GA3934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gaston Gonzalez <gascoar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 03:55:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzEwR-0005l3-04
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 03:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065AbbFABy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 21:54:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47492 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbbFAByz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 21:54:55 -0400
Received: from localhost (p2208095-ipngn17401marunouchi.tokyo.ocn.ne.jp [153.224.29.95])
	by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25197A04;
	Mon,  1 Jun 2015 01:54:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20150601001759.GA3934@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270372>

On Mon, Jun 01, 2015 at 09:17:59AM +0900, Greg KH wrote:
> Hi all,
> 
> I received the patch attached below as part of a submission against the
> Linux kernel tree.  The patch seems to have been hand-edited, and is not
> correct, and patch verifies this as being a problem:
> 
> $ patch -p1 --dry-run < bad_patch.mbox 
> checking file drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> patch: **** malformed patch at line 133:                skb_put(skb, sizeof(struct ieee80211_authentication));
> 
> But git will actually apply it:
> $ git am -s bad_patch.mbox
> Applying: staging: rtl8192u: ieee80211: Fix sparse endianness warnings
> 
> But, there's nothing in the patch at all except the commit message:
> 
> $ git show HEAD
> commit f6643dfef5b701db86f23be9ce6fb5b3bafe76b6
> Author: Gaston Gonzalez <gascoar@gmail.com>
> Date:   Sun May 31 12:17:48 2015 -0300
> 
>     staging: rtl8192u: ieee80211: Fix sparse endianness warnings
>     
>     Fix the following sparse warnings:
>     
>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32: warning: incorrect type in assignment (different base types)
>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32:    expected restricted __le16 [usertype] frame_ctl
>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32:    got int
>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50: warning: invalid assignment: |=
>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50:    left side has type restricted __le16
>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50:    right side has type int
>     
>     Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> $ git diff HEAD^
> $ 
> 
> Any ideas what is going on here?  Shouldn't 'git am' have failed?
> 
> Oh, I'm using git version 2.4.2 right now.
> 
> I've asked Gaston for the original patch to verify before he hand-edited
> it, to verify that git wasn't creating something wrong here, as well.

Gaston sent me his original patch, before he edited it, and it was
correct, so git is correctly creating the patch, which is good.  So it's
just a 'git am' issue with a broken patch file.

thanks,

greg k-h
