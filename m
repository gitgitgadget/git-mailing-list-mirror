From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Change feeds from commit to commitdiff output.
Date: Fri, 11 Jan 2008 03:12:03 -0800 (PST)
Message-ID: <m3sl14mxat.fsf@roke.D-201>
References: <20080110130900.GA9395@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian La Roche <laroche@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 12:12:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDHoW-00018e-RT
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 12:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868AbYAKLML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 06:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757271AbYAKLML
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 06:12:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:52644 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbYAKLMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 06:12:08 -0500
Received: by fk-out-0910.google.com with SMTP id z23so763713fkz.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=I9g4C7zR5FzHmzCd9dPWCaSXZkqCOpp8z2j+mOIJSh4=;
        b=YwkV/tXwZgtnCRKQid5UJUuZRj/WJ7eitCCPK0+MyheFQBaAFax6PyHUv5w1gOpelPrqC+3b8kG8Un6EPXsRN1UFAfbXiwOrlKp+oyvHnOjj6X1471UA1avB81ijDh9+Kw36IJzAtm9i7ZIP7NsH7ewD8O5kTd5N7JzdklXoQVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=aCTeM6aHVUki76l6oyHQtR21FCYDuSR8eFcCxwxVerGY2ey7zJGBmVR6rWSS/uxQ16xEVVoRdXXuKJw70s6xrqZNLnWc+h1Q1Y6eRkJ0ZyU52/q9+ahJvF2XAF3GALlq/ieN52qRU74q6AJLCON9BGkOTwmtkZ/4T3PR8bIXzi4=
Received: by 10.78.204.7 with SMTP id b7mr3571781hug.74.1200049924976;
        Fri, 11 Jan 2008 03:12:04 -0800 (PST)
Received: from roke.D-201 ( [83.8.189.101])
        by mx.google.com with ESMTPS id 5sm4952856nfv.32.2008.01.11.03.12.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Jan 2008 03:12:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0BBBsvp010755;
	Fri, 11 Jan 2008 12:11:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0BBBcb5010751;
	Fri, 11 Jan 2008 12:11:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080110130900.GA9395@dudweiler.stuttgart.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70146>

Florian La Roche <laroche@redhat.com> writes:

> [PATCH] gitweb: Change feeds from commit to commitdiff output.
> 
> Change feeds from displaying the commit to displaying the commitdiff
> output. This way the patches are shown directly and code review is
> done more easily via watching feeds.

First, this changes _link_, and not display (change summary), so the
commit message IMHO should read rather:

	gitweb: Change feeds link from commit view to commitdiff view.
	
	Change feed link from link to commit view to link to commitdiff
	view. This way the patches are shown directly and code review is
	done more easily via watching feeds.

I personally do not use gitweb feeds not feed readers, so I cannot say
if this change truly helps. I just don't know what the "feed watcher"
workflow looks like.


Second, at least for Atom format it is possible to give both 'commit'
and 'commitdiff' view links as alternate links for a feed. That is
something to consider.

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5566,7 +5566,7 @@ XML
>  			or next;
>  
>  		# print element (entry, item)
> -		my $co_url = href(-full=>1, action=>"commit", hash=>$commit);
> +		my $co_url = href(-full=>1, action=>"commitdiff", hash=>$commit);
>  		if ($format eq 'rss') {

-- 
Jakub Narebski
Poland
ShadeHawk on #git
