From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 0/2] gitweb: die_error (error handling) improvements
Date: Mon, 13 Dec 2010 08:55:22 +0100
Message-ID: <201012130855.23013.jnareb@gmail.com>
References: <20101213004259.9475.87376.stgit@localhost.localdomain> <4D058228.7040905@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 08:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS3G1-00075Y-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 08:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab0LMHzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 02:55:35 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:61438 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab0LMHzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 02:55:35 -0500
Received: by bwz16 with SMTP id 16so6308922bwz.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 23:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0vDOsSa6/V6sUi57wmhVbbLCWxnHU941PuRj0KOxmaA=;
        b=v8JR10fza+YJv6CwyubYy2pBEBpRjHVzOUtXCJtkYiJHYaSJkk89Py4m66twneH7QY
         Ug75hGIS0rsGqYlyv3MT6DKec7r9F/uwLgTt80T1zIkRf2gVdDWU6AJsLaoCehTfqU27
         tRABTO2xlUiDR1fXYjV4o7Mdg0GTY2BdBQNuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wbEIaX917EB+Db+WHBzPttDVRtsIZVY0jouo4jf2Xjy6d5GTj2uSebUZ91AVOQZy0k
         ak0My4x/f7TUEZjWttwIkpjbdxX4tGus+VvYHWmxLkMKkO8s8m1tdZQ6SU1btC5C+0nf
         /I5j9NEnfaUZlkDw0RCpIAIi7GePnUT5ih3xY=
Received: by 10.204.85.29 with SMTP id m29mr3364854bkl.176.1292226933644;
        Sun, 12 Dec 2010 23:55:33 -0800 (PST)
Received: from [192.168.1.13] (abwq106.neoplus.adsl.tpnet.pl [83.8.240.106])
        by mx.google.com with ESMTPS id v25sm2888663bkt.6.2010.12.12.23.55.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 23:55:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D058228.7040905@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163522>

On Mon, 13 Dec 2010, J.H. wrote:
> On 12/12/2010 04:46 PM, Jakub Narebski wrote:

> > The following two patch series changes improve error / exception
> > handling in gitweb, preparing the way for gitweb output caching, but
> > useful even without it.
> > 
> > I'm sending this patch series early to gather feedback on possible
> > ways of improving error / exception handling in gitweb.
> 
> Personally, instead of another band-aid over this problem, and adding
> (or further legitimizing) goto statements inside gitweb I'd much *MUCH*
> rather we actually put in the work to actually clean this up.

That's not band-aid, that's using Perl exception mechanism.  Gitweb
uses die_error() like one would ordinarily use "die".
 
> This is the direction I'm heading in, which I mentioned in an earlier
> e-mail.

Well, then how do you want to handle errors?  Note that die_error calls
are sometimes nested quite deep in the call stack, so using return value
to denote errors and checking it is rather out of question: it would
significantly increase complexity of code for no gain.

Nevertheless I'll take a look how it is solved in other web applications
written in Perl, like SVN::Web or CPAN Hubble.
 
> There are a *LOT* of disadvantages to the eval mechanism in perl.  It's
> the standard but gitweb is getting more and more complex, and eval is
> simplistic.  Couple that with the complexity and uncertainty that things
> like goto add to the code, I would *MUCH* rather not see this series go
> in, as I think it is the wrong approach to fixing this.

eval / die is not like goto, but like exception mechanism in other
languages.  I'd prefer to use Try::Tiny or TryCatch, but we have this
"no extra dependencies" policy for gitweb.
-- 
Jakub Narebski
Poland
