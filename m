From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [RFC PATCH] builtin-apply: prevent non-explicit permission
	changes
Date: Fri, 2 Jan 2009 01:17:20 +0300
Message-ID: <20090101221720.GA5603@myhost>
References: <20081230235357.GA12747@myhost> <7vfxk3npuc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 23:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIVsQ-0007Jc-70
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 23:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbZAAWR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 17:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbZAAWR2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 17:17:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:45295 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbZAAWR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 17:17:28 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2209370fgg.17
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 14:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=TwYoEBO3C4pw0M1vyQyXWu5sfDLIr3TN6WKNsU3wKwo=;
        b=q+wiaEJ/V7ggOhN2CjYuCBSuDSJDUjk0ArxnufXlEfYknTEU2XB/VydZ/VEWPH8BAm
         I3J41x8ag7zWOEljqLSo1RbOspMNQliLIHtJGn1c7Al0aS50Dqt9c3v9LrIQOfXTLFUY
         WhVQgoq+PLs7ikOdpiOAksEPt6FKqlTEiwLmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IwGhaZBbh+AoVAt+mqIJzLoJkYdvkn/qMsAoef58g4FOteu+1vRWtO35DRNPe+I2xq
         H9Cgq9TPhiJGXPKUvubPuQIDu0xBzHvBnGW0L5g8WNg0B1XE/qoxpA6iuNvhi7a6myz/
         nUctFr7rg53CkRD3mU6oniRD6Xcf6MgEk42xk=
Received: by 10.86.51.10 with SMTP id y10mr10097851fgy.9.1230848244812;
        Thu, 01 Jan 2009 14:17:24 -0800 (PST)
Received: from smtp.gmail.com ([91.78.102.214])
        by mx.google.com with ESMTPS id d4sm7288655fga.51.2009.01.01.14.17.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jan 2009 14:17:23 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Fri, 02 Jan 2009 01:17:20 +0300
Content-Disposition: inline
In-Reply-To: <7vfxk3npuc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104335>

On 05:00 Thu 01 Jan     , Junio C Hamano wrote:
> Alexander Potashev <aspotashev@gmail.com> writes:
> 
> >  builtin-apply.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index 07244b0..071f6d8 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -630,7 +630,7 @@ static int gitdiff_index(const char *line, struct patch *patch)
> >  	memcpy(patch->new_sha1_prefix, line, len);
> >  	patch->new_sha1_prefix[len] = 0;
> >  	if (*ptr == ' ')
> > -		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
> > +		patch->old_mode = strtoul(ptr+1, NULL, 8);
> >  	return 0;
> >  }
> >  
> > @@ -2447,6 +2447,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
> >  	if (st_mode != patch->old_mode)
> >  		fprintf(stderr, "warning: %s has type %o, expected %o\n",
> >  			old_name, st_mode, patch->old_mode);
> > +	patch->new_mode = st_mode;
> 
> Can you do this unconditionally, overwriting whatever we read from the
> patch header metainfo lines?

Do you mean overwriting of 'patch->new_mode' right after patch parsing?
If so, there would be yet another call to 'stat' to get the permissions
of the existing file (that is not very good).

I'm not very familiar with Git sources.

Also, I don't understand what are the permissions in 'index ...' lines
for (e.g. "index fc3c3a4..066a4ac 100644"), my patch simply drops them:
> > -		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
> > +		patch->old_mode = strtoul(ptr+1, NULL, 8);
...not completely drops, probably we should cross out this line
completely (I don't know whether it breaks something).

					Alexander
