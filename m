From: Deskin Miller <deskinm@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Wed, 11 Feb 2009 23:50:56 -0500
Message-ID: <86d4c5e00902112050m5ce6ec09t8fafd43c19880622@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <86d4c5e00902101910k5512efel2c9165f75d61ba53@mail.gmail.com>
	 <cb7bb73a0902110102k5b7e5a21vd7d0932c6b6ba20e@mail.gmail.com>
	 <200902111018.39699.jnareb@gmail.com>
	 <cb7bb73a0902110154h325ed146h4d1161d4a8dcb1ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 05:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXTYs-0004nu-JC
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 05:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785AbZBLEvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 23:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756768AbZBLEvB
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 23:51:01 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:55597 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713AbZBLEu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 23:50:59 -0500
Received: by an-out-0708.google.com with SMTP id c2so320008anc.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MMIimIcGzKr7BHrHHTQBeFwT0Yo5CB7ZBqF0XM5cVlc=;
        b=Xu0ybNoKsYc0Up+6hy86q5I1wokRnJ1xuBe8VuP2Uv+potyt9JY+fXvAhVyKpg1yFk
         gTux1HrZO6EntsqA0UJ4Qv1xXtwO9WQlf0Oy68Iu6xg+Zhx1E9lMKl1qwdT4XqYG4eZJ
         0zTd060tDs4IlRM0Rdy1YBFF/MvHnsCIh4ZzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fdPBZxCYxEwHhcybdRrIZdYmCgUPr4K5VIiHtiz9esD2uejEifcYxAxZrlxS7SVK7C
         2pZEfEzk0O2m163/InPQwkFHFH4hYJobb7KN2ZUeq+mnJI9jcrwT4hdVA0hUsRAENeLf
         7NID4ioejgh6/xhlLG6Xz1ecYtiFAIvOAvA8g=
Received: by 10.142.148.19 with SMTP id v19mr263143wfd.16.1234414256210; Wed, 
	11 Feb 2009 20:50:56 -0800 (PST)
In-Reply-To: <cb7bb73a0902110154h325ed146h4d1161d4a8dcb1ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109574>

On Wed, Feb 11, 2009 at 04:54, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On Wed, Feb 11, 2009 at 10:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Assuming that you have reflog enabled (yes, it is default now)...
>> So you would have to provide fallback in the case there is no reflog.
>>
>> BTW. "git reflog" is porcelain; it would be better to parse reflog
>> directly, I think.

Agreed on a fallback being necessary; as for parsing the log directly,
that seems fine, but I might be inclined to use git log -g --date=foo
and then parse that.  But that's still using porcelain at some level.

In my copious free time I'm working on a patch to expose reflog
information through git log -g using new --pretty=format: specifiers,
but even my initial attempts to carry reflog information through to
the point in the code where it could be output broke some testcases;
it'll be a long while before I grok what's going on enough to make it
work.  But I digress.

> Does disabling reflog remove old reflogs? IOW, can I check if reflog
> is enabled just by opening the reflog file and assuming reflog isn't
> enabled if it's not there? Falling back to the commit date would still
> work decently.

This seems easy enough to test.  If switching core.logAllRefUpdates
from true -> false doesn't remove the log, though (and why would
git-config delete reflog files?), you could have an old log which just
hasn't been updated for some time, where the branch head might not
appear at all.  But that's just idle speculation without testing the
actual behaviour.

> Since we're only interested in the last reflog date, what we can do is
> to read the last line and get the unix time which is held two places
> before the tab separating the metadata from the log message. Correct?

Looking at the log format I'd say that seems fine.

Glad to see I was thinking clearly, suggesting reflog :)

Deskin Miller
