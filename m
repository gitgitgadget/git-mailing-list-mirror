From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: return non-zero status on missing ref tips
Date: Thu, 11 Sep 2014 21:58:45 -0700
Message-ID: <CAPc5daXMMpqtH=DwLLXgHXVfHThN5MfHwn6dPK6OaZvAQGXT_Q@mail.gmail.com>
References: <1409177412.15185.3.camel@leckie> <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com> <1409343480.19256.2.camel@leckie>
 <20140829203145.GA510@peff.net> <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
 <20140909220709.GA14029@peff.net> <20140912033830.GA5507@peff.net> <20140912042939.GA5968@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 06:59:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSIx9-0001P7-5v
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 06:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbaILE7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 00:59:09 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34444 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaILE7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 00:59:08 -0400
Received: by mail-lb0-f182.google.com with SMTP id v6so212944lbi.41
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 21:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PRqZ1J5YoUmAn40M55CMTFtMR8UXaYb8fssHpktaHYM=;
        b=OSuEY1ITTVOAUUAtWMl7e2fmvA5mbXv53JuJ//faF11avZTfJwX79iUfjAQDiYvtOh
         U7qaI52pT80GmppGt3BKQmtBUag54sG3Bo+Tyuf6UfHpoRmGfwVGJQKBaFE4iBOW62h4
         VMAq6D+6x0DOoQUgd8PRkL3jfwCv0Lcw2eRVdyD8qQ3hriJryoLVRxPcOA1jRdqM8k5V
         OMVk11PQuOmEi5zGaFKV32qEEnznV41TFGBittnnOYvCAA5XiIj3WWCMIZPXLJzOd46/
         bVA2MwYa/Vo1HaaXnPfHyenWy+La1dW4Vj7Aw6RcD7QsgVxeTSDBwN8m7ww4B0JWYzze
         pMYQ==
X-Received: by 10.152.8.165 with SMTP id s5mr5979858laa.3.1410497945999; Thu,
 11 Sep 2014 21:59:05 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Thu, 11 Sep 2014 21:58:45 -0700 (PDT)
In-Reply-To: <20140912042939.GA5968@peff.net>
X-Google-Sender-Auth: 9xV5pWH7FB3aH83BE3Zq3HwPIkI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256899>

On Thu, Sep 11, 2014 at 9:29 PM, Jeff King <peff@peff.net> wrote:
> [+cc mhagger for packed-refs wisdom]
>
> If we only have a packed copy of "refs/heads/master" and it is broken,
> then deleting any _other_ unrelated ref will cause refs/heads/master to
> be dropped from the packed-refs file entirely. We get an error message,
> but that's easy to miss, and the pointer to master's sha1 is lost
> forever.

Hmph, and the significance of losing a random 20-byte object name that
is useless in your repository is? You could of course ask around other
repositories (i.e. your origin, others that fork from the same origin,
etc.), and having the name might make it easier to locate the exact
object.

But in such a case, either they have it at the tip (in which case you
can just fetch the branch you lost), or they have it reachable from
one of their tips of branches you had shown interest in (that is why
you had that lost object in the first place). Either way, you would be
running "git fetch" or asking them to send "git bundle" output to be
unbundled at your end, and the way you ask would be by refname, not
the object name, so I am not sure if the loss is that grave.

Perhaps I am missing something, of course, though.
