From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 5/7] http: init and cleanup separately from http-walker
Date: Sun, 21 Feb 2010 11:57:07 +0100
Message-ID: <20100221105707.GA22534@localhost>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
 <1266721708-1060-6-git-send-email-rctay89@gmail.com>
 <20100221103820.GA5166@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 12:55:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj9V3-0008AI-3O
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 11:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143Ab0BUK5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 05:57:16 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:40724 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab0BUK5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 05:57:15 -0500
Received: by fxm5 with SMTP id 5so1550501fxm.29
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 02:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=6UneYGhS8/BuQbgA2eQo3lhk7AvD8Gms5bFg3LmzVJg=;
        b=c5Ievdn/WvBWi5aUp5up8kpqE7+pIqxNwJumOmTKqiqu0xCSw93zGJ1lE4qAd3642K
         Qn9f9XpMHeNAe+aX2BUs5Bz+REqho2nNlOPRs/vmzJpMrZnlXdg32TcHfzcQlRPY7M4A
         V0KI8fXxdTbLpkhKrO/tWvObayz1MXjdMqoyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=iAFvcPyTN6bjLobaVf7OH6VHz2PG1rd7XlBpE2KQLAS/aRycG2d8AB7ZPsKv6+7Rfj
         Iag+b/twAIJQOxxpLL+Y7tt+COwjgctfle1xmEzp59a8DOZKx4mHdPHZsnphtEUKkqn4
         PhVXOyjOD4zvhvWHRa7Wnlb8Qa6TktCYV2sbs=
Received: by 10.103.126.29 with SMTP id d29mr2421215mun.28.1266749833823;
        Sun, 21 Feb 2010 02:57:13 -0800 (PST)
Received: from darc.lan (p549A7DE9.dip.t-dialin.net [84.154.125.233])
        by mx.google.com with ESMTPS id y2sm9759653mug.19.2010.02.21.02.57.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 02:57:13 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Nj9Up-0005sg-Lh; Sun, 21 Feb 2010 11:57:07 +0100
Content-Disposition: inline
In-Reply-To: <20100221103820.GA5166@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140608>

On Sun, Feb 21, 2010 at 11:38:20AM +0100, Clemens Buchacher wrote:
> On Sun, Feb 21, 2010 at 11:08:26AM +0800, Tay Ray Chuan wrote:
> > diff --git a/http-fetch.c b/http-fetch.c
> [...]
> > @@ -69,7 +70,8 @@ int main(int argc, const char **argv)
> >  		url = rewritten_url;
> >  	}
> >  
> > -	walker = get_http_walker(url, NULL);
> > +	http_init(NULL);
> > +	walker = get_http_walker(url);
> >  	walker->get_tree = get_tree;
> >  	walker->get_history = get_history;
> >  	walker->get_all = get_all;
> 
> You changed the order of get_http_walker and http_init. But

Umh, actually you didn't. Sorry about that.

> 
>         add_fill_function(walker, (int (*)(void *)) fill_active_slot);
> 
> already deals with curl functionality. So even though I think it technically
> doesn't break, I would prefer if this dependency were still expressed in the
> code.
> 
> > @@ -88,6 +90,7 @@ int main(int argc, const char **argv)
> >  "status code.  Suggest running 'git fsck'.\n");
> >  	}
> >  
> > +	http_cleanup();
> >  	walker_free(walker);
> >  
> >  	free(rewritten_url);
> 
> Same as above.

But I think this is still valid.

Clemens
