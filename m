From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/17] revert: Eliminate global "commit" variable
Date: Tue, 12 Jul 2011 12:45:18 -0500
Message-ID: <20110712174518.GB14120@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:45:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgh1Y-0006n9-L4
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab1GLRp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:45:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39443 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab1GLRp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:45:27 -0400
Received: by iwn6 with SMTP id 6so4840270iwn.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=o7YsZeswCH3A17OTQShCb0eZDVZdCwdwaxsznphZaz8=;
        b=XLvxEawl2PsKAPUhFHtrD3yj5kk8KgxZm3d+fkeB8ab8FEyhy8G25VzrRBR4aOGrSN
         ijeUuMCWxpFzSGl5IxanMcBo7bEZjdpMGC5AwmHuhgiM9VbVHFw7mQRsvMWwD94HxXBJ
         zIdCTxeqkxmrIA8WEPy+7Pawnl3uu0kPevV5c=
Received: by 10.42.19.69 with SMTP id a5mr185278icb.184.1310492727121;
        Tue, 12 Jul 2011 10:45:27 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id fw9sm8431597ibb.64.2011.07.12.10.45.24
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 10:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176957>

Ramkumar Ramachandra wrote:

> Since we want to develop the functionality to either pick or revert
> individual commits atomically later in the series, make "commit" a
> variable to be passed around explicitly as an argument for clarity.

The above explanation is not so clear to me, but the patch looks good.
Isn't the idea something like

	commit = grab_a_nice_commit();
	res = do_pick_commit();

being just an unpleasant API relative to

	res = do_pick_commit(grab_a_nice_commit());

because in the latter it is more obvious which commit is being
cherry-picked?  Likewise with the functions it calls.

Or perhaps the idea is that eventually we will want to expose something
like do_pick_commit to other translation units, but a static variable
like "commit" would not be appropriate for exposing.  Or that we save
a word of global memory.  Or that this way if do_pick_commit or a
function it calls ever ends up recursing by mistake it won't get
broken.  Or that we can use multiple threads some day.  Or...

Oh, the uncertainty! :)  It is not clear to me what any of the above
have to do with wanting the functionality to replay an individual
commit atomically.  By the way, what does pickiing or reverting a
commit atomically mean, and how is it different from ordinary
cherry-picks?
