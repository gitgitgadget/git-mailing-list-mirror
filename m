From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Include links to feeds in HTML header only for =?utf-8?q?=27200=09OK=27?= response
Date: Sat, 18 Dec 2010 22:48:39 +0100
Message-ID: <201012182248.40731.jnareb@gmail.com>
References: <20101218195848.16201.67691.stgit@localhost.localdomain> <4D0D1529.6030806@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Dec 18 22:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU4eA-0002PI-8c
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 22:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245Ab0LRVsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 16:48:50 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:50978 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199Ab0LRVst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 16:48:49 -0500
Received: by bwz16 with SMTP id 16so2173813bwz.4
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 13:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jURLuN5KEB0Rkhs9zlkrRNN8bykb8GIOCXilam7iqbg=;
        b=Qvov/P8Yj2FyXEu7YAe9tjWMqRfy40laZeyhtztZcQfwIsMi+wFXH6/hGXEzIfVdAs
         3mkHSG+Qz15W0c088x3KoH7Wi8MKI4f+wo0hidg83bBxKynPXOOKeBlCmFfXZKy+INt0
         x++1C1ipyg6FGimmZ0gcdoqAKbrgbs0jmNaaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GGqMsPHh/LhrNllL07WOeA+atdRzgTS+cYWDgHf9hHOBMyDPncAAEaZo0piCJLrJfJ
         YA6esHiuf0MPxoSR1HBC/hCltvKp8AVsJdDQEbFoO8MX++1k7XWnrZiRzZCvbLGpnO6V
         YvfltFgT1j6BWIcJv1TaM4kw6sju3piAJty04=
Received: by 10.204.76.207 with SMTP id d15mr2034893bkk.104.1292708927687;
        Sat, 18 Dec 2010 13:48:47 -0800 (PST)
Received: from [192.168.1.13] (abvc21.neoplus.adsl.tpnet.pl [83.8.200.21])
        by mx.google.com with ESMTPS id v1sm2643436bkt.5.2010.12.18.13.48.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Dec 2010 13:48:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D0D1529.6030806@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163937>

J.H. wrote:

> I've no objection, you can add a sign-off from me.

Errr... sign-off or ack?  Signed-off-by is about provenance of code...

> On 12/18/2010 12:02 PM, Jakub Narebski wrote:
> > To do that, generating "<link />"s to feeds were refactored into
> > print_feed_meta() subroutine, to keep nesting (indent) level in
> > git_header_html() low.  This has also the advantage of making code
> > more clear.
> > 
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   89 +++++++++++++++++++++++++++-------------------------
> >  1 files changed, 47 insertions(+), 42 deletions(-)
> > 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index d521c93..d965cda 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3479,6 +3479,51 @@ sub get_page_title {
> >  	return $title;
> >  }
> >  
> > +sub print_feed_meta {
> > +	if (defined $project) {
> > +		my %href_params = get_feed_info();
> > +		if (!exists $href_params{'-title'}) {
> > +			$href_params{'-title'} = 'log';
> > +		}
> > +
> > +		foreach my $format qw(RSS Atom) {
> > +			my $type = lc($format);
> > +			my %link_attr = (
> > +				'-rel' => 'alternate',
> > +				'-title' => esc_attr("$project - $href_params{'-title'} - $format feed"),
> > +				'-type' => "application/$type+xml"
> > +			);
> > +
> > +			$href_params{'action'} = $type;
> > +			$link_attr{'-href'} = href(%href_params);
> > +			print "<link ".
> > +			      "rel=\"$link_attr{'-rel'}\" ".
> > +			      "title=\"$link_attr{'-title'}\" ".
> > +			      "href=\"$link_attr{'-href'}\" ".
> > +			      "type=\"$link_attr{'-type'}\" ".
> > +			      "/>\n";
> > +
> > +			$href_params{'extra_options'} = '--no-merges';
> > +			$link_attr{'-href'} = href(%href_params);
> > +			$link_attr{'-title'} .= ' (no merges)';
> > +			print "<link ".
> > +			      "rel=\"$link_attr{'-rel'}\" ".
> > +			      "title=\"$link_attr{'-title'}\" ".
> > +			      "href=\"$link_attr{'-href'}\" ".
> > +			      "type=\"$link_attr{'-type'}\" ".
> > +			      "/>\n";
> > +		}
> > +
> > +	} else {
> > +		printf('<link rel="alternate" title="%s projects list" '.
> > +		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
> > +		       esc_attr($site_name), href(project=>undef, action=>"project_index"));
> > +		printf('<link rel="alternate" title="%s projects feeds" '.
> > +		       'href="%s" type="text/x-opml" />'."\n",
> > +		       esc_attr($site_name), href(project=>undef, action=>"opml"));
> > +	}
> > +}
> > +
> >  sub git_header_html {
> >  	my $status = shift || "200 OK";
> >  	my $expires = shift;
> > @@ -3528,48 +3573,8 @@ EOF
> >  			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
> >  		}
> >  	}
> > -	if (defined $project) {
> > -		my %href_params = get_feed_info();
> > -		if (!exists $href_params{'-title'}) {
> > -			$href_params{'-title'} = 'log';
> > -		}
> > -
> > -		foreach my $format qw(RSS Atom) {
> > -			my $type = lc($format);
> > -			my %link_attr = (
> > -				'-rel' => 'alternate',
> > -				'-title' => esc_attr("$project - $href_params{'-title'} - $format feed"),
> > -				'-type' => "application/$type+xml"
> > -			);
> > -
> > -			$href_params{'action'} = $type;
> > -			$link_attr{'-href'} = href(%href_params);
> > -			print "<link ".
> > -			      "rel=\"$link_attr{'-rel'}\" ".
> > -			      "title=\"$link_attr{'-title'}\" ".
> > -			      "href=\"$link_attr{'-href'}\" ".
> > -			      "type=\"$link_attr{'-type'}\" ".
> > -			      "/>\n";
> > -
> > -			$href_params{'extra_options'} = '--no-merges';
> > -			$link_attr{'-href'} = href(%href_params);
> > -			$link_attr{'-title'} .= ' (no merges)';
> > -			print "<link ".
> > -			      "rel=\"$link_attr{'-rel'}\" ".
> > -			      "title=\"$link_attr{'-title'}\" ".
> > -			      "href=\"$link_attr{'-href'}\" ".
> > -			      "type=\"$link_attr{'-type'}\" ".
> > -			      "/>\n";
> > -		}
> > -
> > -	} else {
> > -		printf('<link rel="alternate" title="%s projects list" '.
> > -		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
> > -		       esc_attr($site_name), href(project=>undef, action=>"project_index"));
> > -		printf('<link rel="alternate" title="%s projects feeds" '.
> > -		       'href="%s" type="text/x-opml" />'."\n",
> > -		       esc_attr($site_name), href(project=>undef, action=>"opml"));
> > -	}
> > +	print_feed_meta()
> > +		if ($status eq '200 OK');
> >  	if (defined $favicon) {
> >  		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
> >  	}
> 
> 

-- 
Jakub Narebski
Poland
