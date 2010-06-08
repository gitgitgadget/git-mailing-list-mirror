From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Tue, 8 Jun 2010 14:46:20 +0200
Message-ID: <201006081446.22587.jnareb@gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 14:46:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLyCW-0006zb-Dz
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 14:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab0FHMqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 08:46:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:12641 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0FHMqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 08:46:34 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1417576fgb.1
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bMLdApgcz2EVAX3sDaziXGDAeFOaFfrDzfWT1MKfCCM=;
        b=mSn8fT74pRVEVp/0yp7hlboqm3HYHcVa3l5iMV25IGNtp0eBouFrD8COBFqyQoDURG
         NeKQdqSc3lsxboJbMT7QpkmXhFZhgtzZB8XdUhoKDhPyQcwkVAwZ9XtSDWmBKDYN9MNu
         iCftQRHYYoT6TJlhcViq2OZbNz7a8JncmeZUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D2x2xViYV6a1bg+Yqky4qWq0Uvwv0n9ltiWp1fER0TdFf8Ay3ahv2NwYEvPQ+wLTc7
         337V7EOl9fR1m3+xCu9R1G5Nt5LDMahwQUxjNxatfwByu9ISBAEzU3YPLggVY53cGl/C
         Ef6gHNxOdlpkriiMLc40P00lrX5wZHbhm0fcw=
Received: by 10.204.160.134 with SMTP id n6mr7404776bkx.0.1276001192085;
        Tue, 08 Jun 2010 05:46:32 -0700 (PDT)
Received: from [192.168.1.15] (abvo94.neoplus.adsl.tpnet.pl [83.8.212.94])
        by mx.google.com with ESMTPS id z17sm24458117bkx.6.2010.06.08.05.46.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 05:46:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148666>

A few generic comments about this whole series.


First, when you are sending larger patch series (and I think this series
of 4 patches qualify), you should provide cover letter, [RFC/PATCH 0/4]
in this case, describing the series.  git-format-patch has --cover-letter
option to make it easier to write such cover letters.  I could then write
generic comments about whole series as comments to cover letter...


Second, all those commits about splitting gitweb should perhaps be
reorganized (rebased).  Currently you have 'create Gitweb::Config',
'create Gitweb::Git', 'move subs to Gitweb::Config'; if Gitweb::Git
was created before Gitweb::Config, you would not need two commits
to create Gitweb::Config (to be exact even more than two, as not all
subroutines are moved, as you write yourself).


Third, and I think most important, is that the whole splitting gitweb into
modules series seems to alck direction, some underlying architecture
design.  For example Gitweb::HTML, Gitweb::HTML::Link, Gitweb::HTML::String
seems to me too detailed, too fine-grained modules.

It was not visible at first, because Gitweb::Config, Gitweb::Request and to
a bit lesser extent Gitweb::Git fell out naturally.  But should there be
for example Gitweb::Escape module, or should its functionality be a part of
Gitweb::Util?  Those issues needs to be addressed.  Perhaps they were
discussed with this GSoC project mentors (via IRC, private email, IM), but
we don't know what is the intended architecture design of gitweb.

Should we try for Model-Viewer-Controller pattern without backing MVC
(micro)framework?  (One of design decisions for gitweb was have it working
out of the box if Perl and git are installed, without requiring to install
extra modules; but now we can install extra Perl modules e.g. from CPAN
under lib/...).  How should we organize gitweb code into packages
(modules)?

Perhaps having gitweb.perl, Gitweb::Git, Gitweb::Config, Gitweb::Request,
Gitweb::Util and Gitweb would be enough?  Should it be Gitweb::HTML or
Gitweb::View?  Etc., etc.,...

That is a very important question.


On Mon, 7 June 2010, Pavan Kumar Sunkara wrote:

> Subject: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
>

This summary doesn't tell us much.  What subroutines, or what kind of
subroutines were moved to Gitweb::Config?  Why they were moved, and why
they weren't there from beginning (perhaps it would be better to simply
reorder patches, to have creation of Gitweb::Git before creation of
Gitweb::Config)?  Why can they be moved now?

Not all of those questions can be answered in summary (subject line for
email), but it should tell us what this commit is about.

> Subroutines moved:
> 	gitweb_get_feature
> 	gitweb_check_feature
> 	filter_snapshot_fmts
> 	configure_gitweb_features

I can find which subroutines were moved from the patch itself.  What
I cannot find without good commit message is _why_ do you feel they
belong in Gitweb::Config (unless it is obvious), and why they can be
moved now and why they could not be moved earlier.

> 
> Subroutines yet to move: (Contains not yet packaged subs & vars)
> 	feature_bool
> 	feature_avatar
> 	feature_snapshot
> 	feature_patches

Why they can't be moved; what is missing?  That is the question that commit
message should answer, or at least hint about / point the direction.

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

> diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.pm
> index fdab9f7..3810fda 100644
> --- a/gitweb/lib/Gitweb/Config.pm
> +++ b/gitweb/lib/Gitweb/Config.pm
> @@ -10,13 +10,16 @@ use strict;
>  use warnings;
>  use Exporter qw(import);
>  
> -our @EXPORT = qw(evaluate_gitweb_config $version $projectroot $project_maxdepth $mimetypes_file
> +our @EXPORT = qw(evaluate_gitweb_config gitweb_check_feature gitweb_get_feature configure_gitweb_features
> +                 filter_snapshot_fmts $version $projectroot $project_maxdepth $mimetypes_file $git_avatar
>                   $projects_list @git_base_url_list $export_ok $strict_export $home_link_str $site_name
>                   $site_header $site_footer $home_text @stylesheets $stylesheet $logo $favicon $javascript
>                   $GITWEB_CONFIG $GITWEB_CONFIG_SYSTEM $logo_url $logo_label $export_auth_hook
>                   $projects_list_description_width $default_projects_order $default_blob_plain_mimetype
>                   $default_text_plain_charset $fallback_encoding @diff_opts $prevent_xss $maxload
> -                 %avatar_size %known_snapshot_formats %known_snapshot_format_aliases %feature);
> +                 %avatar_size %known_snapshot_formats %feature @snapshot_fmts);

I think it would be better to have exported subroutines separated from
exported variables at least in that exported variables should begin on new
line.  This way it would be easier to see what was added, and (sometimes)
what was removed.

I had to look carefully to notice that you have removed the
%known_snapshot_format_aliases variable.  This was not mentioned in the
commit message.  There was no reason for removing it given in the commit
message (probably it was removed because it is internal to gitweb, and is
used only for backward compatibility with older configs... but it might be
not so internal, and might be useful and should be exported).

> +
> +use Gitweb::Git qw($git_dir);

O.K.


> +sub gitweb_get_feature {
[...]
> +	# project specific override is possible only if we have project
> +	if (!$override || !defined $git_dir) {
> +		return @defaults;
> +	}

Note that '!defined $git_dir' is a bit of hack, to check whether we are in
git repository and if we can run per-repository config.  This probably
could be solved better... but I don't mean that you would have to solve it.
It can be left for later.

-- 
Jakub Narebski
Poland
