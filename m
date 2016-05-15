From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Sun, 15 May 2016 17:06:22 +0700
Message-ID: <CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 15 12:07:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1sws-0001HL-Oi
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbcEOKGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:06:54 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34779 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbcEOKGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:06:53 -0400
Received: by mail-lf0-f49.google.com with SMTP id m64so106343085lfd.1
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KydU39wN9GzgX+A8dDTxCeXw/7kuk6Fk/gpcWsM5GdQ=;
        b=BWmXyB9uXx/BzhK3F9GWU/92K/u/r1Yr8twfxA81uQLd0/3UxI8elZQ7iQTwA8f3Go
         e3/ErYi6EbiD+D4erRabXgZOJb31IEQjbalDNyDrxS5OR262m10kAapS1fMpNRLJnl8e
         xFEpH9S2WE6rbUEOrcS46Q/R3GmLIw6spBGJ6GJzwJzX3JQJUIuWNXmhfPrWlsqZATqy
         YRgkln04sbJRHq6HNZgQubQo8TCoK4MPnXyos4WzFWRUsrHL0Y1lFIMAsaw2H2g7cuO9
         59DzKyMIqImit3PoVUAWx12+T//EAjzPawKuXncxwTLD79tCGorAV2rNT3KufazIc04H
         dL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KydU39wN9GzgX+A8dDTxCeXw/7kuk6Fk/gpcWsM5GdQ=;
        b=FfqnBbNmfJk/vwDO6dqOp8iSBdkGo9YC2bNdQEB1N/NXZgHmJMQTifGIxwk8KIK0Fv
         aM+raYcUdujsco15YDIJ+E67mixmHrPH17tWUCQ9kATsmkkq19BtyhEcdS+4Dyx+xM4L
         U+faRrvlyHHJpL8SOUBzI9sjpHCFjfd9Kyz8XvqIbY+RKeDOizcBC7mTAtBO7G2YIeUH
         bjZPJ0gftGMiz3magLIVjQMQ4C3IrlY8GMFzM3JrMmOI4IQFGT99kq2NDmrHzjMvBR14
         qyaWKP3LPaphuh7a4Bb8YZzu4s1oQC0GdvHNOwZkREycdEzSwfFkuOPVEe7PCxQ7L3T5
         a5FQ==
X-Gm-Message-State: AOPr4FUA3FLmtQq3VHoaQvzP7nIEyZSS03bdbTypZmNEdVAafSVld98Rgk33U+eGE1nEthsNQLO8LfSxqZ9StQ==
X-Received: by 10.25.162.76 with SMTP id l73mr9751765lfe.45.1463306811852;
 Sun, 15 May 2016 03:06:51 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sun, 15 May 2016 03:06:22 -0700 (PDT)
In-Reply-To: <20160513001936.7623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294647>

On Fri, May 13, 2016 at 7:19 AM, Stefan Beller <sbeller@google.com> wrote:
> After some fruitful discussion[1] in which Junio suggested trying a very
> different route[2] that is more general and not submodule related, I considered
> doing a mock for this.
>
> This lets you label arbitrary pathspecs, e.g. in git.git we may want to have:
>
>     t/t[0-9]*.sh label=tests
>
> such that
>
>     $ git log --author=Beller ":(label=tests)"
>
> would show all commits in which I touched tests.
>
> This has suprisingly few lines of code, as the first 3 patches are refactoring.
> The actual new feature is in the last patch.
>
> This would solve the submodule issues I want to solve, as I can produce a
> .gitattributes like:
>
>     ./submodule1 label=default
>     ./submodule2 label=default
>     ./submodule3 label=optional-feature1
>
> and then I'd instruct the users to clone like this:
>
>     git clone .. superproject
>     cd superproject
>     git submodule update --init :(label:default)
>
> The second part of the submodule series to collapse these three commands
> will come as an extra series later, then.

Yeah. I can see the use of this, even without submodules.

> What annoys me here:
> Attributes can only be set once at the moment, there is no way to collect all
> attributes. If we'd have such a collection feature we would be able to
> configure this:
>
>     *.[ch] label=C,code
>     contrib/** label=oldstuff

Instead of putting everything in under the same attribute name
"label", make one attribute per label? Would this work?

*.[ch] c-group code-group

And the pathspec magic name can be simply "attr", any git attribute
can be used with it, e.g. :(attr:c-group)

> and run this:
>
>     git status ":(label:C oldstuff)"
>
> which would be the equivalent to
>
>     contrib/**.[ch]
>
> as in this proposed implementation the labels which are given within one
> pathspec item are logical AND. To get the logical OR, you'd have to give multiple
> pathspec items, i.e. ":(label:C)" ":(label:oldstuff)"

It's even better if pathspec does not have to deal with combination
logic. Can attr macros deal with that (or if it can't at the moment,
can we improve it)?
-- 
Duy
