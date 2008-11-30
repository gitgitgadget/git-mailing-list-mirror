From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: patch view
Date: Sun, 30 Nov 2008 02:06:21 +0100
Message-ID: <200811300206.23240.jnareb@gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 02:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6aoD-0006kZ-94
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 02:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbYK3BG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 20:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbYK3BG0
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 20:06:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:23439 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbYK3BG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 20:06:26 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2296061ugf.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 17:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Wl+CEf38DMcPVX4TUMxJgLH60woAoh73ivNRiyMhVgs=;
        b=fFx16gF1vb4OA2EeNhJbAVWLpUJ5X9pDBJxZc549joiPEXXmUfyMRaSgbnun6fTxxf
         ix/m/TIw7Vs1kw2od2VGlDR8F4qfPADzKd52Y+TOOmDoQe/qFFG6cLiSj24W/wTbbINB
         cwz/W6mRwGAimlCswL+AFKMJDsqwFGZqdXwmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Eoeo2XGxK5yIfCs6i4N+7tZVCqCtIN93Ghhy5BSHwcdohuUSsFtAgmWacLfHzmd8Ym
         P22dLOu7KHrdTuOaRqs17SjOpB19wKxqPK+lIw3d0zTQ/OKedRWjzmdUTc1i3oNibV2o
         tDje944d0dksNeYoBD1HpHqfyUf7xhGETX5ss=
Received: by 10.66.250.17 with SMTP id x17mr2045303ugh.67.1228007184101;
        Sat, 29 Nov 2008 17:06:24 -0800 (PST)
Received: from ?192.168.1.11? (abvs96.neoplus.adsl.tpnet.pl [83.8.216.96])
        by mx.google.com with ESMTPS id o24sm4655003ugd.31.2008.11.29.17.06.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 17:06:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101942>

On Sat, 29 Nov 2008, Giuseppe Bilotta wrote:

> I recently discovered that the commitdiff_plain view is not exactly
> something that can be used by git am directly (for example, the subject
> line gets duplicated in the commit message body after using git am).

That's because gitweb generates email-like format "by hand", instead
of using '--format=email' or git-format-patch like in your series. On
the other hand that allows us to add extra headers, namely X-Git-Tag:
(which hasn't best implementation, anyway) and X-Git-Url: with URL
for given output.
 
> Since I'm not sure if it was the case to fix the plain view because I
> don't know what its intended usage was, I prepared a new view,
> uncreatively called 'patch', that exposes git format-patch output
> directly.

Perhaps 'format_patch' would be better... hmmm... ?

Actually IMHO both 'commitdiff' and 'commitdiff_plain' try to do two
things at once. First to show diff _for_ a commit, i.e. equivalent of
"git show" or "git show --pretty=email", perhaps choosing one of
parents for a merge commit. Then showing commit message for $hash has
sense. The fact that 'commit' view doesn't show patchset, while
'commitdiff' does might be result of historical situation.

Second, to show diff _between_ commits, i.e. equivalent of 
"git diff branch master". Then there doesn't make much sense to show
full commit message _only_ for one side of diff. IMHO that should be
main purpose of 'commitdiff' and 'commitdiff_plain' views, or simply
'diff' / 'diff_plain' future views.


What 'patch' view does, what might be not obvious from this description
and from first patch in series, is to show diffs for _series_ of
commits. It means equivalent of "git log -p" or "git whatchanged".
It might make more sense to have plain git-format-patch output, but it
could be useful to have some kind of 'git log -p' HTML output.

So even if 'commitdiff' / 'commitdiff_plain' is fixed, 'patch' whould
still have its place.


By the way, we still might want to add somehow X-Git-Url and X-Git-Tag
headers later to 'patch' ('patchset') output format.

> 
> The second patch exposes it from commitdiff view (obviosly), but also
> from shortlog view, when less than 16 patches are begin shown.

Why this nonconfigurable limit?

> 
> Giuseppe Bilotta (2):
>   gitweb: add patch view
>   gitweb: links to patch action in commitdiff and shortlog view
> 
>  gitweb/gitweb.perl |   35 +++++++++++++++++++++++++++++++++--
>  1 files changed, 33 insertions(+), 2 deletions(-)

Thank you for your work on gitweb
-- 
Jakub Narebski
Poland
