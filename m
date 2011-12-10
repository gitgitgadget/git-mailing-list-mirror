From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating
 submodules"
Date: Sat, 10 Dec 2011 00:19:06 -0600
Message-ID: <20111210061906.GA11326@elie.hsd1.il.comcast.net>
References: <20111109174027.GA28825@book.fritz.box>
 <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box>
 <loom.20111210T062013-538@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 07:19:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZGHJ-0005W2-CF
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 07:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab1LJGTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 01:19:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54294 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab1LJGTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 01:19:16 -0500
Received: by iakc1 with SMTP id c1so5357935iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 22:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SEdeRIw1N/u3sT3n84brAPsyKuvucmyCwl2M4bNVI+k=;
        b=V9756YXzvH/e4CqLBgUC7HNNc2/uy4Uq7Ifi7ZgYrMc321vyU2itsWPzsBXkk02tTh
         uFJeQi/4eG8J00TNHRFV6PywJqqYbhIITcYA3iv2mVwsv/vGgaWihfXjeHD92VbFmcxL
         gb83H40ETiDW23/rUFopjkQIRzPA0sTqivS4w=
Received: by 10.50.163.97 with SMTP id yh1mr6264437igb.37.1323497956094;
        Fri, 09 Dec 2011 22:19:16 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v18sm41813439ibh.4.2011.12.09.22.19.14
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 22:19:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20111210T062013-538@post.gmane.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186725>

(restoring cc list)
Hi Leif,

Leif Gruenwoldt wrote:

> If I understand the description of "floating submodules", it's something I have 
> been wanting for a while now! The lack of it is currently a deal breaker for 
> using submodules within my organisation.
>
> Our use case is as follows.
[...]
>                                                 When one of the products is in 
> heavy development we often need to do a lot of work in the common repos. Having 
> to increment the sha1 of the submodules to track the latest tip would be overly 
> arduous.

What happens when a bug was introduced in this period of heavy development
and someone wants to look back in the development history and build each
version to find which introduced the bug?

If I were part of such a project, I would be tempted to follow one of two
rules.  Either

 A. Each commit of productA strives to work with the latest version of
    the common code possible.  Which version of the common code that was
    tested against gets recorded (perhaps by some record-submodule-versions-
    and-commit script, or even a pre-commit hook) so others can
    reproduce the results.

or

 B. Occasionally (e.g., daily or weekly) the "baseline" version of the
    common code that can be relied on gets bumped, and each commit of
    productA should work with that version and all later versions for a
    while.  Everyday development might typically happen with the tip
    version of the common code which may be faster, have more
    bugfixes, and otherwise be more pleasant to work with, but commits
    should work against the baseline version as well.  When it is time
    to bump the baseline, that fact gets recorded (in a separate
    commit).

    For this, the '[submodule "<name>"] ignore' setting described in
    gitmodules(5) might be helpful.

Though of course other variations are possible.

Would you be able to try out using Heiko's patch for a while, adapt it
to your needs as necessary, and let us know how it goes?

Thanks very much, and good luck,
Jonathan
