From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v9 0/7] refs backend preamble
Date: Tue, 21 Jul 2015 16:43:24 -0400
Organization: Twitter
Message-ID: <1437511404.30911.21.camel@twopensource.com>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
	 <55AEA998.60501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHeNs-0005NT-VB
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbbGUUnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:43:25 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34444 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbGUUnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 16:43:24 -0400
Received: by qkfc129 with SMTP id c129so98419228qkf.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 13:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=QJFlN2eSCv9rUvWegS/4+0cHJv0C9eMLrfAK2IP0gGo=;
        b=WWE40JYFisnmtNzzaC/Hb4QqKiVSHMQ2CfyY6bdf4awVJNpyTm7TNhpWALxAPuZMMd
         153dA7wyDTw7Bww45xOmNZX5Z/fhv8Ux2Vc0jGJR91MXItnwHTywBCUmGO8nxMKiFfZ+
         3F5Meau+H/kxT9CfTm+NkhrvG1eLJ+79LF0uqrJRuTdX6OVAo/QX067vXO5bEY78Yofl
         WswuN6o0l5olF6X2CV+dT2P/VLg/fwEhQ4zjACfQNtYELFcB1pqKBoOG3vmisBpPNtM4
         uLXWFUGp0ub5m8TZnhk+ULK+uv5mNNOeGLgssXZTom0mCrJQuLml3yvGfr2EsUYAS3jM
         pOPw==
X-Gm-Message-State: ALoCoQkO9XfsZijsef0d06iR/YnGiUwucnDOHGHINiXsMOo/NOU2hGzW25YMX9PVQkPsuzLJ03A5
X-Received: by 10.140.42.98 with SMTP id b89mr57855349qga.78.1437511403484;
        Tue, 21 Jul 2015 13:43:23 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f31sm9080120qgf.19.2015.07.21.13.43.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 13:43:22 -0700 (PDT)
In-Reply-To: <55AEA998.60501@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274415>

On Tue, 2015-07-21 at 13:20 -0700, Michael Haggerty wrote:
> On 07/21/2015 08:44 AM, David Turner wrote:
> > This reroll addresses Michael Haggerty's comments:
> > 
> > - Error messages are now in the form error: reason
> > - We no longer unnecessarily set errno in write_ref_to_lockfile
> > - Corrected a spelling error in the new docs and another in the tests
> > - Corrected some copypasta in a test.
> 
> Isn't it sobering that, every time one looks at source code, one finds
> things that could be improved? (Not just yours but all source code!)

Indeed.

> Happily it seems like the items are getting ever more trivial, and
> either with or without the last round of suggestions I think the code is
> correct and is a nice step forward.
> 
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Off topic: I wonder whether sooner or later we will need a
> 
>     git reflog remove <ref>
> 
> to delete an existing reference's reflog entirely without deleting the
> reference and without assuming a filesystem backend. (Note that this is
> different than `git reflog expire`, which leaves the empty reflog file
> around and thus doesn't undo a --create-reflog.) But perhaps there is no
> call for that operation. In a pinch a user could delete the reference
> and recreate it to get rid of its reflog.

Some of the tests do delete reflogs (manually), and the refs backend
code has a test driver that performs that operation (along with some
others).  I could move git reflog remove out of that driver and into git
reflog, but I'm reluctant to do it just for the tests.  If there's a
non-test reason for it, I'll be happy to.

I've pushed a new version of this series to
https://github.com/dturner-tw/git/ on the pluggable-refs-preamble
branch.  The new version addresses Michael's comments from this around,
and makes a variable static as you suggested (and said you would squash
in).

Junio, now that Michael has marked this as reviewed, do you want to pull
from github, or do you want me to send a re-roll to the mailing list?

Thanks.
