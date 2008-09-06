From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb pathinfo improvements
Date: Sat, 6 Sep 2008 13:55:44 +0200
Message-ID: <cb7bb73a0809060455n78145ccdw99beeebbd7e0439a@mail.gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809061322.31094.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 14:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbwSU-0008Qj-Pv
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 14:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbYIFLzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 07:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbYIFLzr
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 07:55:47 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:32811 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbYIFLzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 07:55:46 -0400
Received: by yx-out-2324.google.com with SMTP id 8so461142yxm.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1ahl14La4iguhpiwt6hmwDQqCOrXrTwVrUV148dsMO0=;
        b=tC5V7wEOQuEWoJhKcirqAEHfOqaamtfbeTApMHGAd+3gPHf47VazAUYI++PSiIysfA
         htql0R7UCSPptwGImhFB+M1NEJllTLuBbBU0AWFPlRLqf2pvTDrUZgLEalUEsPYLB9VF
         Z1B0Rz2VRSjlPJDDdBnDj2vN3AmBl8Q45IG2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ez5UHL1AoXW11UXt/h85+NLZdg5xlDmcin615ywGR3gtCj+/Kb31ETprnKzy2B1VeZ
         R32q6h8cQYRZEfnJUrz7v4xLFNb14EzzZkC4kgNW0gIJ6KQB6xx/0J2JzrNcgWzUoV71
         sGqTi3lV5JTrVGYCLJr/74UG/h8t81RgQ3aQw=
Received: by 10.151.108.5 with SMTP id k5mr3614328ybm.226.1220702144684;
        Sat, 06 Sep 2008 04:55:44 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Sat, 6 Sep 2008 04:55:44 -0700 (PDT)
In-Reply-To: <200809061322.31094.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95070>

On Sat, Sep 6, 2008 at 1:22 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Below there is table of contents / shortlog of this series, which I
> think is a good practice to include in cover letter describing the
> series:
>
> Table of contents:
> ==================
>  * [PATCH 1/5] gitweb: action in path with use_pathinfo
>  * [PATCH 2/5] gitweb: use_pathinfo filenames start with /
>  * [PATCH 3/5] gitweb: parse parent..current syntax from pathinfo
>  * [PATCH 4/5] gitweb: use_pathinfo creates parent..current paths
>  * [PATCH 5/5] gitweb: remove PATH_INFO from $my_url and $my_uri

Yes, I really have to learn proper behaviour when sending a patchest.
I'll make treasure of yours and Junio's hints on the matter 8-)

I'll probably have to resend this patch series anyway, since I've
already found a quirk for which an additional patch is ready, and the
double-dot-filename thing you mention below needs fixing as well.

BTW, is there a way to automate this summary generation when using
format-patch or send-email?

> The problem with fitting more parameters in pathinfo is first backwards
> compatibility (this is not strict requirement, but we would rather not
> make existing bookmarked pathinfo URLs invalid), and second with
> ordering those parameters and detecting when one parameter ends and
> next one begins (which is made more complicated by the fact that some
> parameters, like action or hash/hash_base can be skipped).
>
> This trouble with fitting parameters in pathinfo creates some
> limitations and tradeoffs. For example (optionally!) embedding
> the action in the pathinfo, by putting it after project and before
> hash/hash_base (usually refname) and filename makes old-style
> $project/$branch lead to incorrect view. This also means that we have
> to be careful about creating pathinfo links, either by always putting
> an action, or using full ref name (which I think we do anyway to avoid
> tag/head ambiguities); or doing it only in the case of possible
> conflict i.e. branch named like one of gitweb actions.

Yes, this was something that got me thinking for a while. I've tried
as hard as possible to preserve backwards compatibility, and old-style
paths should still work correctly except for projects whose branched
are named exactly like gitweb actions.

> Using ':' or ':/' to separate branch name (hash or hash_base) from
> filename doesn't lead to problems, as pathinfo is split on _first_
> occurrence of ':', and refnames cannot contain ':'. Using '..' to
> separate $hash_parent_base:$file_parent from $hash_base:$filename
> is IMVHO a very good idea... but when creating pathinfo links we have
> to consider filenames with '..' in them; an example is there in git
> repository: "t/t5515/refs.master_.._.git" file. Then we probably want
> to fallback on CGI query/CGI parameters. NOTE: I have not read the
> patch yet, perhaps it does this.

Actually, this was not a case I had taken into consideration (a
filename with two dots). It should be straightforward to change the
link-creation code to switch to CGI parameters in this case. Should I
change the corresponding patch, or would it be enough to add a patch
to the series clearing this issue?

> By the way, this is perhaps slightly outside the issue of this series,
> but having a..b syntax would tempt to handcraft gitweb URLs for
> equivalents of "git log a..b", "git log a...b" and "git diff a...b",
> neither of which works yet.

I do have a patch to that effect for the shortlog action:
http://git.oblomov.eu/git/commitdiff/refs/heads/gitweb/shortlog and
you can see it in effect on my gitweb with links such as
http://git.oblomov.eu/git/master..gitweb/pathinfo.


-- 
Giuseppe "Oblomov" Bilotta
