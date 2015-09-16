From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: "Medium" log format: change proposal for author != committer
Date: Tue, 15 Sep 2015 23:54:10 -0700
Message-ID: <CA+P7+xqhJKGmxC=35bRvdKSj=nKRhfH9SqhR9ryrcBDknH-Y=w@mail.gmail.com>
References: <robbat2-20150915T214920-375711965Z@orbis-terrarum.net> <xmqq8u87t9jb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 08:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc6bz-0001hZ-7h
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 08:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbbIPGyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 02:54:31 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34371 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbIPGya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 02:54:30 -0400
Received: by igcpb10 with SMTP id pb10so29583478igc.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XI+dAYgfrH9zAHcayCklvnF8rG/ya77PQ95tz37HF4k=;
        b=NP6opRaxenbrPvV/pJDWNXDTKiELNHsi1VHJRbWTzg0CV3MmdsbF23TwwjlixdmxL0
         edlRAs6xiHEFWzG4EMlvSQnUf9V4k4Wm7dcecxTGSCpOPNxuqw9j4Iw7eJI2NPWSv2V5
         kfRlXdNoA/JKjFZponYRIMDrAigC9y6D6hXVS1WwB6KGufvQMuTrMYp6bxO5dGsPuKcY
         j0vnleDLadNVZZOg1eDZqBzwQcDW+q8/mRWdRJ8D8jjUlP4NRwa2QPcNxqiQ9CdM5E89
         W5E6joXYGBNk/iPqTbshZiVQyGZmwlw8Vo7+9Vo4aPlg4goXjgtHjHAeX4IPwwhSo7CV
         AZrg==
X-Received: by 10.50.178.145 with SMTP id cy17mr13337810igc.92.1442386469940;
 Tue, 15 Sep 2015 23:54:29 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Tue, 15 Sep 2015 23:54:10 -0700 (PDT)
In-Reply-To: <xmqq8u87t9jb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278005>

On Tue, Sep 15, 2015 at 6:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * Enhance the "--pretty=format:" thing so that the current set of
>    hardcoded --pretty=medium,short,... formats and your modified
>    "medium" can be expressed as a custom format string.
>
>  * Introduce a configuration mechanism to allow users to define new
>    short-hand, e.g. if you have this in your $HOME/.gitconfig:
>
>         [pretty "robin"]
>                 format = "commit %H%nAuthor: %an <%ae>%n..."
>

Afiak there is already support for this.. from "git help config":

pretty.<name>
Alias for a --pretty= format string, as specified in git-log(1). Any
aliases defined here can be used just as the built-in pretty formats
could. For example, running git config pretty.changelog "format:* %H
%s" would cause the invocation git log --pretty=changelog to be
equivalent to running git log "--pretty=format:* %H %s". Note that an
alias with the same name as a built-in format will be silently
ignored.

>    and run "git log --pretty=robin", it would behave as if you said
>    "git log --pretty="format:commit %H%nAuthor: %an <%ae>%n...".
>

So this should already be supported... but to support "robinsformat"
we'd need to be able to "show committer only if different from
author"... Not sure how that would work.

>  * (optional) Replace the hardcoded implementations of pretty
>    formats with short-hand names like "medium", "short", etc. with a
>    built-in set of pretty.$name.format using the configuration
>    mechanism.  But we need to make sure this does not hurt
>    performance for common cases.
>

This part obviously hasn't been done, I don't know if any particular
format is not expressable today by the pretty syntax or not..

But at least configuration does work. I use it as part of displaying the

Fixes: <sha1> ("name")

used by the upstream kernel for marking bug fixes of known commits.

Thus the only real thing would be implementing a % modifier which
allows showing commiter if it's not the same as author. (or vise
versa) Ideally we could take work from the ref-filter library and the
proposed "%if" stuff but I don't tihnk this was actually implemented
yet, and I don't know if that would even work in the pretty modifiers.

Regards,
Jake
