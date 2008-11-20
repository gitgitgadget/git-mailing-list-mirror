From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT bit
Date: Thu, 20 Nov 2008 22:26:48 +0700
Message-ID: <fcaeb9bf0811200726x1f2956c6k6f2ca16543a0fbc@mail.gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
	 <1222833849-22129-6-git-send-email-pclouds@gmail.com>
	 <20081118113316.GA18610@segfault.peff.net>
	 <7vk5b0vp19.fsf@gitster.siamese.dyndns.org>
	 <7v4p24tq59.fsf@gitster.siamese.dyndns.org>
	 <20081119130223.GA27893@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BRu-0008Tx-QI
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbYKTP0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbYKTP0v
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:26:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:26335 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbYKTP0u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:26:50 -0500
Received: by ug-out-1314.google.com with SMTP id 39so307701ugf.37
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 07:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yR/iuLzUWaOvN18nteNW/8g1i+8jSyXi3e2nWjsW9X4=;
        b=Obm3QI6JxLxeMw5mDu1FVwmThsMz7X1VEpznrMqHwqd+cNGLvyt7zqybRpvamcnMSE
         zWfNAoqe76Rt0Jcu9c3sYgMSc9dXrbMaVdneMcqM9QyEyAYKVC3WGMwA1vOS8a3gS7yy
         FiJknTtu7QGIGSvxlP5YuluTi8tfqK6eIZvws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qXoqAz1Jk7p3VoRzBfIMDGyIIwuBblyyEFS2o6esir51J45icr4tx1QhD/C6Fw0/37
         zQSCI4nK8dLBeeWr9t1qBd/WcXWHp9S1+D/dT2ZpTcmS41xNOinrUNFqZTUyJBD/mMIn
         bTX796KKF6LNduGOoXzd7atQxn8l1DZEWj1eo=
Received: by 10.86.84.5 with SMTP id h5mr1625086fgb.59.1227194808556;
        Thu, 20 Nov 2008 07:26:48 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Thu, 20 Nov 2008 07:26:48 -0800 (PST)
In-Reply-To: <20081119130223.GA27893@segfault.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101452>

On 11/19/08, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 18, 2008 at 06:18:10PM -0800, Junio C Hamano wrote:
>
>  > Having said all that, I wouldn't suggest redoing the patch using >>
>  > redirection.  But change from "touch 1 nondigit" to "touch nondigit 1"
>  > is a bit too subtle to my taste.  Let's write it this way instead:
>
>
> Yes, I also dislike the subtlety, but my "obvious" idea was something
>  like:
>
>   for i in 1 2 sub/1 sub/2; do
>     touch $i
>   done
>
>  which just seemed clunky. But:
>
>
>  > -     touch 1 2 sub/1 sub/2 &&
>  > +     touch ./1 ./2 sub/1 sub/2 &&
>
>
> this is less clunky, and I have confirmed that it solves the problem. I
>  just wasn't clever enough to think of it in the first place. ;)

Thanks for catching. The last half also has the same problem. Another
way is maybe just stay away for those numbers, naming the files by
alphabet. Just wonder if we could have some ways to automatically
catch this kind of bug in the future.

-- 
Duy
