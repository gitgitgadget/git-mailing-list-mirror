From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Do not chop HTML tags in commit search result
Date: Wed, 13 Feb 2008 11:16:15 -0800 (PST)
Message-ID: <m3bq6kd5vq.fsf@localhost.localdomain>
References: <ae63f8b50802130937mddf9df9re2a95bee44661ee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jean-Baptiste Quenot" <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:17:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPN6E-0007T2-Cw
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 20:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbYBMTQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 14:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbYBMTQU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 14:16:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:39070 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYBMTQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 14:16:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so830632ugc.16
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 11:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=8jOExXvRb4HOpwEcdfhtcWNDNxd5GwwmhQH1EvJVg2E=;
        b=h3XmhSrINPSUg2DlxyttYZIzw0JxqJEB795W9T47pP+p1ALLKZu/f4FfDKlscO89n8vmzuZmmsHFQHevLFi7kyqZ+tJ9iFRahjDVJtwwKC80msNQvOvRE3CXzdrg5KspatbfHE96/eXkTOifO5B6O9A/D02kwgZsiADBrejg5GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Ri+w9eUfEW9ewS3GBFBAjJyN6GOiSi79tpiIxjKrFOkDrwamR84OuaqTsLYzlEAcLD49279tVONAFkw6wR6KFU/t/p9VoCnV1mu5yL1R6eEo5qVTM0R9pCht+7ME9SkEndhSLs28nSlz38HUVFMD+cdihUL6WVNlsJHKCI2qxxw=
Received: by 10.66.240.12 with SMTP id n12mr2308337ugh.9.1202930176907;
        Wed, 13 Feb 2008 11:16:16 -0800 (PST)
Received: from localhost.localdomain ( [83.8.196.88])
        by mx.google.com with ESMTPS id l22sm3763972uga.30.2008.02.13.11.16.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 11:16:15 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1DJGA4Y006296;
	Wed, 13 Feb 2008 20:16:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1DJG9KC006293;
	Wed, 13 Feb 2008 20:16:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ae63f8b50802130937mddf9df9re2a95bee44661ee3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73813>

"Jean-Baptiste Quenot" <jbq@caraldi.com> writes:

> Thanks for Git! It's a great program.  I encountered an annoying bug
> with gitweb 1.5.4.1, when searching for commits, if the search string
> is too long, the generated HTML is munged leading to an ill-formed
> XHTML document.
> 
> Here is the patch, hope it helps:

It would be better if the patch wasn't wrapped and whitespace
corrupted.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ae2d057..2c0b990 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3780,7 +3780,10 @@ sub git_search_grep_body {
>                                 my $trail = esc_html($3) || "";
>                                 $trail = chop_str($trail, 30, 10);
>                                 my $text = "$lead<span class=\"match\">$match</span>$trail";
> -                               print chop_str($text, 80, 5) . "<br/>\n";
> +                               # Do not chop $text as match can be long, and we don't want to
> +                               # munge HTML tags!
> +                               #print chop_str($text, 80, 5) . "<br/>\n";
> +                               print $text . "<br/>\n";
>                         }
>                 }
>                 print "</td>\n" .

While this might be good bigfix, I think it is not a good solution. If
we select to show only neighbourhood of the match, we should probably
chop trailing text, or both leading (cutting at beginning) and
trailing, perhaps even match if it is overly long.

Or we could alternatively show all lines of commit message, and only
mark matching fragment... but that I think would have to wait for
refactoring of generation of log-like views (log, shorlog, history,
rss) in gitweb.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
