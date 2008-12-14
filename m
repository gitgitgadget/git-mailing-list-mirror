From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on pathinfo-style project URLs
Date: Mon, 15 Dec 2008 00:20:48 +0100
Message-ID: <200812150020.53370.jnareb@gmail.com>
References: <1229195421.3943.8.camel@mattlaptop2.local> <m3tz97g329.fsf@localhost.localdomain> <1229219030.3360.44.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0IA-0006Qs-TV
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbYLNXVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbYLNXVG
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:21:06 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:45599 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYLNXVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:21:05 -0500
Received: by ewy10 with SMTP id 10so2734548ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 15:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5bnbPXANUBCloOvYZafY7xZpntAOmX+dK25Kk8iKNrw=;
        b=apYCw72d7B89LMY+rXAe4GEEi8px6/OIj5f8qVfQ8/G42eaoFHCml+fEM2EgbUFrXf
         bCZXPu4FVjMooYtJoWi/91b9pUldHYLWuXAeicD9FYVgwF9lY096QwCjpHR76+duBKqQ
         4cP1mZmBU0VB3K2G3xrwAvhPByEhNUNcpdV24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XjX/hobpDBY3/dYWOqhs21p+Ze+LcGRa3aQqWvOqGowlMtO3xo2je5Cgrm9GaLVb61
         tViCxH7Q1GdffJy03hgZEZHvmLNNsZJGvi3QkppkyKBF1eAUxgzRuv994OD5/PXkQMax
         VXxPsebsTtjEGqJ4FeYylShxnC1pSwJdsLTtA=
Received: by 10.210.51.18 with SMTP id y18mr6990429eby.103.1229296861980;
        Sun, 14 Dec 2008 15:21:01 -0800 (PST)
Received: from ?192.168.1.11? (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 7sm481482eyb.51.2008.12.14.15.20.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 15:21:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1229219030.3360.44.camel@mattlaptop2.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103105>

On Sun, 14 Dec 2008, Matt McCutchen wrote:
> On Sat, 2008-12-13 at 13:47 -0800, Jakub Narebski wrote:
> >
> > Errr... I see that it adds trailing slash only for project-only
> > path_info links, but the commit message was not entirely clear for me.
> 
> I will clarify the message.

It would be nice (e.g. to have example URL with trailing slash ensured).

[...]
> > > @@ -829,8 +834,8 @@ sub href (%) {
> > >  		}
> > >  	}
> > >  
> > > -	my $use_pathinfo = gitweb_check_feature('pathinfo');
> > > -	if ($use_pathinfo) {
> > > +	my @use_pathinfo = gitweb_get_feature('pathinfo');
> > 
> > Why not name those variables for better readability?
> > 
> > +       my ($use_pathinfo, $trailing_slash) = gitweb_get_feature('pathinfo');
> 
> I'll do that.

Note that you wouldn't need that if you decide that it makes sense
(and doesn't have disadvantages) to *always* add trailing slash to
the end of path_info for some kinds of gitweb links.

> > > +	if ($use_pathinfo[0]) {
> > >  		# try to put as many parameters as possible in PATH_INFO:
> > >  		#   - project name
> > >  		#   - action
> > > @@ -845,7 +850,12 @@ sub href (%) {
> > >  		$href =~ s,/$,,;
> > >  
> > >  		# Then add the project name, if present
> > > -		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
> > > +		my $proj_href = undef;
> > > +		if (defined $params{'project'}) {
> > > +			$href .= "/".esc_url($params{'project'});
> > > +			# Save for trailing-slash check below.
> > > +			$proj_href = $href;
> > > +		}
> > >  		delete $params{'project'};
> > >  
> > >  		# since we destructively absorb parameters, we keep this
> > > @@ -903,6 +913,10 @@ sub href (%) {
> > >  			$href .= $known_snapshot_formats{$fmt}{'suffix'};
> > >  			delete $params{'snapshot_format'};
> > >  		}
> > > +
> > > +		# If requested in the configuration, add a trailing slash to a URL that
> > > +		# has nothing appended after the project path.
> > > +		$href .= '/' if ($use_pathinfo[1] && defined $proj_href && $href eq $proj_href);
> > >  	}
> > 
> > The check _feels_ inefficient.  I think (but feel free to disagree) that
> > it would be better to use something like $project_pathinfo, set it
> > when adding project as pathinfo, and unset if we add anything else as
> > pathinfo.
> 
> I considered doing that, but I decided that not having to litter the
> preceding code with manipulation of $project_pathinfo outweighed
> whatever negligible performance difference there might be.

On the other hand, with having boolean variable named for example
$trailing_slash or $add_trailing_slash, you can set it to appropriate
value by default (should project list URL: http://example.com/ have
trailing slash), and at [almost] each 'delete $params{<param>}' either
set it to true, or set it to false. This way it would be easy to
extend to have trailing slash also for example for OPML link
http://example.com/opml/ or not have it and use http://example.com/opml

I think it is not only more efficient, but is also more flexible.
Admittedly it is also more complicated...
 
> > > +		if ($use_pathinfo[0]) {
> > >  			$action .= "/".esc_url($project);
> > > +			# Add a trailing slash if requested in the configuration.
> > > +			$action .= '/' if ($use_pathinfo[1]);
> > 
> > Hmmm... let me check something... you rely on the fact that $project
> > doesn't end with slash, while I think (but please check it) that it
> > can end with slash if it is provided by CGI query.
> 
> You are right; in fact, this is already a problem for the strict_export
> check.  Gitweb should probably strip trailing slashes when it reads the
> "p" parameter.  I will submit a separate patch for that.

That would be nice. TIA.

-- 
Jakub Narebski
Poland
