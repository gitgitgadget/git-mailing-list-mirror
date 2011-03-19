From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sat, 19 Mar 2011 16:18:26 +0100
Message-ID: <201103191618.29826.jnareb@gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0xvV-0006Sv-9d
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab1CSPSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 11:18:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62989 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab1CSPSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 11:18:43 -0400
Received: by fxm17 with SMTP id 17so4465672fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QobBUSEI9E3MqaAB68czvkb1BD/fu2TcXLPKk9TcP9s=;
        b=Ep1siQ+vC1eaQvFO5W8Lw/27DJI/NVSL0mkSQJoQguoMb/sYaY34RrD+KEK2cy7hmb
         0SLSXYsPM4Mm7cvfukXIx2znPVSvsENCZdOgUZCFiCr6EjrMcgFU1l1HuMFisV25XKz+
         zwhNCJEwKdEd/Xb6jvygKD+gwSbinkG7kN/Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=T3i3V1c5jrluOKfc6M8PBaRvx/sUpRqxch0mC4cZqbf6DfN+IBsjEPyprjb20n04Ma
         J70PYMJ9j3KmKd6jtUFH6iNhd1YJFnUCx3PEqOTt0+IlzgMoOSDNCWjRx0Fl9zDylIuF
         O4zu9Rlwh43x45TC0nNF62G3j1MZqK2uC3SkY=
Received: by 10.223.14.137 with SMTP id g9mr2696799faa.2.1300547921923;
        Sat, 19 Mar 2011 08:18:41 -0700 (PDT)
Received: from [192.168.1.13] (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id k5sm1591027faa.15.2011.03.19.08.18.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 08:18:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169436>

On Sat, 19 Mar 2011, Kevin Cernekee wrote:

> With this feature enabled, all timestamps are shown in the local
> timezone instead of GMT.  The timezone is taken from the appropriate
> timezone string stored in the commit object.

[...]
> In the case of 'commit', 'commitdiff' and 'tag' views, gitweb used to
> print both GMT time and time in timezone of author/tagger/committer:
> 
>    Fri, 18 Mar 2011 01:28:57 +0000 (18:28 -0700)
> 
> With localtime enabled, the times will be swapped:
> 
>    Thu, 17 Mar 2011 18:28:57 -0700 (01:28 +0000)

First, currently the localtime part is needed only to have "atnight"
warning.  I wonder if with 'localtime' feature enabled gitweb should
show GMT time, or is it not necessary.

With 'localtime' it could simply be

     Thu, 17 Mar 2011 18:28:57 -0700

either marked with "atnight" as whole, or only time (see below).

> Local times between 00:00 and 05:59, inclusive, will still be printed
> in red ("atnight" style) in these views.

Second, from above description it is not clear which part of date is
marked with "atnight" style when 'localtime' feature is enabled.

Is the whole localtime part marked, and GMT left not marked:

     Thu, 17 Mar 2011 18:28:57 -0700 (01:28 +0000)
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Or perhaps only the local _time_ is marked with "atnight" style:

     Thu, 17 Mar 2011 18:28:57 -0700 (01:28 +0000)
                      ^^^^^^^^

Or perhaps whole date now uses "atnight" style:

     Thu, 17 Mar 2011 18:28:57 -0700 (01:28 +0000)
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


[...]
> @@ -3928,22 +3945,48 @@ sub git_print_section {
>  	print $cgi->end_div;
>  }
>  
> -sub print_local_time {
> -	print format_local_time(@_);
> -}
> -
> -sub format_local_time {
> -	my $localtime = '';
> -	my %date = @_;
> -	if ($date{'hour_local'} < 6) {
> -		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> -			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
> +# Returns an RFC 2822 timestamp string, which may contain HTML.

I'm not sure if we need to write about it being RFC2822-like format;
it is just implementation detail.

Perhaps

  +# Returns formatted date and time, outputs HTML.

It is important if it is HTML or not, to know if it needs to be esc_html
or not.

> +# If $use_localtime is 0, don't do anything special.
> +# If $use_localtime is 1, add an alternate HH:MM timestamp in parentheses at
> +# the end.

See comment below.

>             If $feature{'localtime'} is enabled this looks like: 
> +#   Thu, 17 Mar 2011 18:28:57 -0700 (01:28 +0000)
> +# Otherwise, it looks like:
> +#   Fri, 18 Mar 2011 01:28:57 +0000 (18:28 -0700)
> +# If $use_localtime is 1, this will also apply the "atnight" style to
> +# local times between 00:00 and 05:59.

I would really prefer to split this patch in two: first refactor 
date-printing code, introducing and using timestamp_html subroutine,
with no changes in output, and leave introducing 'localtime' feature
for a second patch.

> +sub timestamp_html {
> +	my %date = %{$_[0]};
> +	my $use_localtime = $_[1];

Why not use

   	my ($date, $use_localtime) = @_;

and $date->{'rfc2822_local'} instead of $date{'rfc2822_local'}?


Also with current code the calling convention for timestamp_html (or 
format_timestamp_html, or format_date_html) looks like this:

  print     " [" . timestamp_html(\%ad, 0) . "] "

or

  print     timestamp_html(\%wd, 1)

This would require anyone who stumbles upon on a calling site to have
to refer to definition of this function to understand it.

In many other places we use "named parameters" for such boolean flags;
then the calling convention could be

  timestamp_html(\%date)

or

  timestamp_html(\%date, -long=>1)

(or -localtime=>1, or -atnight=>1, etc.).  

We can also/instead provide timestamp_short_html and timestamp_long_html
so one can write

  timestamp_short_html(%date)

and

  timestamp_long_html(%date)

-- 
Jakub Narebski
Poland
