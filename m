From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Sun, 24 Aug 2008 22:37:52 +0200
Message-ID: <200808242237.53953.jnareb@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com> <48B1B6F2.5050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 22:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMMY-0003Y0-9M
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYHXUh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbYHXUh6
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:37:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:12390 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYHXUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:37:57 -0400
Received: by ug-out-1314.google.com with SMTP id c2so428461ugf.37
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Tih2hSb/ifZpqlZ7ta05u1MhHUPiHL//gRWEKD8/yos=;
        b=RQ9gqZcxcXseVM9X7Nwuzz4RZwUCJOvsECBW/lYkCRffvhaVKbFFGet4MLdDNM1mRh
         jFzdsTkKP3yE2fCPJRQXl+jPQXL1eNXtD2lctrhjSYG/N01OIGGCaCgqvVNq7EDVjbh5
         la4Ua/VSHMfLPFaf12yYJFdWfwAUX88pdek2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VX/jwePfxwEPMFVdC7g8pxBoa05QhfmNBQW/ly2vph8HTV4kA3eTH/sUk6wcAqjNJB
         sduHRlkwIDXVqCztmeinYUgfFARyqjvuvbSL6rPb+txFvcXYwwVXTLus9viyK12fqMAI
         yZJZX1bHsRBC+jTINn53A1XG/a9Tf37hpaAn0=
Received: by 10.67.101.17 with SMTP id d17mr1733714ugm.40.1219610276092;
        Sun, 24 Aug 2008 13:37:56 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.185])
        by mx.google.com with ESMTPS id j34sm1506812ugc.51.2008.08.24.13.37.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 13:37:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48B1B6F2.5050301@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93564>

Lea Wiemann wrote:
> Giuseppe Bilotta wrote:
> > +			my $git_type = git_get_type($ref);
> > [...]
> > +				$cgi->a({-href => href(action=>$view{$git_type} || $git_type, hash=>$name)}, $name) .
> 
> Since some of this thread seems to be about performance, you might just
> make this a link to action => 'object' (and save the git_get_type call)
> and let gitweb Do The Right Thing when the link is followed.
> 
> [Disclaimer: Haven't read the whole thread, and haven't checked if
> action=object is actually doing the right thing here.]

First, only the first patch (and perhaps second) called git_get_type;
v4 and v5 do not.  Second, link to 'object' action would not do the
right thing; we want either 'shortlog' or 'tag' view, not 'commit'
or 'tag' view.

What this patch does is making ref markers in the log-like views, and
in the commit subject line headers in other view be "hidden links" to
either 'shortlog' (in the case of ref being head/branch, or lightweight
tag), or to 'tag' view in the case of annotated tag.  We rely on the
fact that we know what type of object refs points to (currently it is
only 'commit', which might change, but the fact that we know type of
object for which we show marker would not change), and the fact that
tags point to given object only indirectly, and only tags can point
indirectly (^{} suffix in "git show-ref --dereference", and
"git ls-remote .", and $GIT_DIR/info/refs).


So you could have spared yourself this comment if you have read commit
and the rest of thread more carefully...
-- 
Jakub Narebski
Poland
