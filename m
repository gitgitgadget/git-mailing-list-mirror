From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Create Gitweb::Escape module
Date: Sat, 5 Jun 2010 11:22:10 +0200
Message-ID: <201006051122.12565.jnareb@gmail.com>
References: <1275642437-4846-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 11:20:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKpXy-00016n-Mq
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 11:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650Ab0FEJT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 05:19:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:6532 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627Ab0FEJT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 05:19:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1106099fga.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=spJKMJqoe4RKARm7Z2GUDmhpOaYfWc2lg3nmmY5ifcU=;
        b=WyMdYoq4FP8IhMoVPm5j/Uty6OOcU9/KeVj2HZ28tNstuYBh5HPy2AkluzKyC9QDoF
         T6s0pcEY9b4yRdCLFR5WDusSx+b9LV8tHGAbILzTigenrwZXHzaeUatuCjAHIYswJXsn
         4O/RKjkRIJp6jj2bV3R7q6rv0KegZWNeE8VnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Slzo6iGyy9aamYCiIjGuqPMGNkLXGXsWJ4Zhe5xLj8tf+WHsE95mfwkLTp9U3hrvsf
         afY1zPee58+Mj7DsrI9mG6wTSln+sqEvzdG6XtPSRcu78Tm6u7CVP/G2nKVGMATbmRmf
         lNF87UJP5t+to9NfoL/oYfg6VWLIfjRKb6YLw=
Received: by 10.103.81.29 with SMTP id i29mr4113946mul.109.1275729594001;
        Sat, 05 Jun 2010 02:19:54 -0700 (PDT)
Received: from [192.168.1.15] (abvt177.neoplus.adsl.tpnet.pl [83.8.217.177])
        by mx.google.com with ESMTPS id 25sm3075573mul.54.2010.06.05.02.19.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 02:19:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1275642437-4846-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148463>

On Fri, 4 June 2010, Pavan Kumar Sunkara wrote:

> Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
> to store all the quoting/unquoting and escaping subroutines
> regarding the gitweb.perl script.

<del>
I would ask if it wouldn't be simpler to just have Gitweb::Util
for all auxiliary / helper subroutines...

...if not for the fact that to avoid circular dependencies you would
have, most probably, split this module further into
 * Gitweb::Escape::CGI
 * Gitweb::Escape::HTML
and perhaps move 'unquote' to Gitweb::Git or Gitweb::Escape::Git.
Then Gitweb::Escape could just import both.
</del>

Errr... sorry.  I guess that either Gitweb::Config nor Gitweb::Request
needs to include Gitweb::Escape.

Note that 'Escape' part of name is not entirely correct, because some of
subroutines mentioned below deal with _quoting_ / _unquoting_, not with
escaping / unescaping.

> 
> Subroutines moved:
> 	to_utf8
> 	esc_param
> 	esc_url
> 	esc_html
> 	esc_path
> 	quot_cec
> 	quot_upr
> 	unquote
> 	untabify
> 
> Subroutines yet to move: (Contains not yet packaged subs & vars)
> 	None
> 
> Update gitweb/Makefile to install gitweb modules alongside gitwe
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
>  gitweb/Makefile             |    1 +
>  gitweb/gitweb.perl          |  157 +--------------------------------------
>  gitweb/lib/Gitweb/Escape.pm |  175 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+), 156 deletions(-)
>  create mode 100644 gitweb/lib/Gitweb/Escape.pm

It's a pity that git cannot tell us here that it is straight code
movement (moving code block from one file to the other)...

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b30ac48..9e54983 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -12,7 +12,6 @@ use warnings;
>  use CGI qw(:standard :escapeHTML -nosticky);
>  use CGI::Util qw(unescape);
>  use CGI::Carp qw(fatalsToBrowser set_message);
> -use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
> @@ -27,6 +26,7 @@ use lib __DIR__ . "/lib";
>  
>  use Gitweb::Config;
>  use Gitweb::Request;
> +use Gitweb::Escape;
>  
>  BEGIN {
>  	CGI->compile() if $ENV{'MOD_PERL'};
> @@ -762,161 +762,6 @@ sub validate_project {
>  	}
>  }
>  
> -# decode sequences of octets in utf8 into Perl's internal form,
> -# which is utf-8 with utf8 flag set if needed.  gitweb writes out
> -# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
> -sub to_utf8 {

[cut]

> diff --git a/gitweb/lib/Gitweb/Escape.pm b/gitweb/lib/Gitweb/Escape.pm
> new file mode 100644
> index 0000000..f6ea209
> --- /dev/null
> +++ b/gitweb/lib/Gitweb/Escape.pm
> @@ -0,0 +1,175 @@
> +#!/usr/bin/perl
> +#
> +# Gitweb::Escape -- gitweb's quoting/unquoting, escaping package
> +#
> +# This program is licensed under the GPLv2
> +
> +package Gitweb::Escape;
> +
> +use strict;
> +use warnings;
> +use Exporter qw(import);
> +
> +our @ISA = qw(Exporter);

This line is not necessary if you are using 'use Exporter qw(import);'


This code:

  use Exporter;
  our @ISA = qw(Exporter);

is equivalent to (safer)

  use Exporter;
  use base qw(Exporter);

The section "Exporting without inheriting from Exporter" of
Exporter(3pm) manpage says that using

  use Exporter qw(import);

allows to avoid inheriting our package from Exporter.

> +our @EXPORT = qw(&to_utf8 &esc_param &esc_url &esc_html &esc_path &quot_cec &quot_upr &unquote &untabify);

Please try to not introduce such long likes.  Perhaps:

  +our @EXPORT = qw(&to_utf8 &esc_param &esc_url &esc_html &esc_path
                    &quot_cec &quot_upr &unquote &untabify);

Also ampersands are not needed there, and I think hat they are not used
usually, so it would be:

  +our @EXPORT = qw(to_utf8 esc_param esc_url esc_html esc_path
                    quot_cec quot_upr unquote untabify);

But note also comment below about splitting this file further.

> +
> +use Encode;

Perhaps empty line between 'use Exporter;' (using outside Perl modules)
and 'use Gitweb::Config;' would help readibility of code, hmmm...?

Also, don't you need 'use CGI;' or 'use CGI qw(:escapeHTML);' here, to
have access to CGI::escape (to be more exact CGI::Util::escape, but
imported by CGI to CGI::escape) and CGI::escapeHTML?

> +use Gitweb::Config;

I personally would say here explicitely

  +use Gitweb::Config qw($fallback_encoding);

to make it clear that we need only this single one config variable.

> +use Gitweb::Request;

As it is shown below, this is not necessary.

> +
> +# decode sequences of octets in utf8 into Perl's internal form,
> +# which is utf-8 with utf8 flag set if needed.  gitweb writes out
> +# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning

s/at beginning/at beginning of XXX/;

> +sub to_utf8 {
> +	my $str = shift;
> +	return undef unless defined $str;
> +	if (utf8::valid($str)) {
> +		utf8::decode($str);
> +		return $str;
> +	} else {
> +		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> +	}
> +}

This single one uses $fallback_encoding from Gitweb::Config.

> +
> +# quote unsafe chars, but keep the slash, even when it's not
> +# correct, but quoted slashes look too horrible in bookmarks
> +sub esc_param {
> +	my $str = shift;
> +	return undef unless defined $str;
> +	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
> +	$str =~ s/ /\+/g;
> +	return $str;
> +}
> +
> +# quote unsafe chars in whole URL, so some charactrs cannot be quoted
> +sub esc_url {
> +	my $str = shift;
> +	return undef unless defined $str;
> +	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
> +	$str =~ s/\+/%2B/g;
> +	$str =~ s/ /\+/g;
> +	return $str;
> +}

Hmmm... why this difference?  esc_url() should differ from esc_param()
only in that esc_url() escapes less (it should not escape query
parameter delimites).  It seems like 452e225 (gitweb: fix esc_param,
2009-10-13) by Giuseppe Bilotta missed fixing esc_url(), isn't it?

Might be worth fixing upfront (in a separate commit, of course).  Could
you do this, please?

> +
> +# replace invalid utf8 character with SUBSTITUTION sequence
> +sub esc_html {
> +	my $str = shift;
> +	my %opts = @_;
> +
> +	return undef unless defined $str;
> +
> +	$str = to_utf8($str);
> +	$str = $cgi->escapeHTML($str);

We can use 'CGI::escapeHTML;' here, and avoid dependency on
Gitweb::Request.

This change probably should be done in a separate cleanup patch,
preceding this one.

> +	if ($opts{'-nbsp'}) {
> +		$str =~ s/ /&nbsp;/g;
> +	}
> +	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
> +	return $str;
> +}
> +
> +# quote control characters and escape filename to HTML
> +sub esc_path {
> +	my $str = shift;
> +	my %opts = @_;
> +
> +	return undef unless defined $str;
> +
> +	$str = to_utf8($str);
> +	$str = $cgi->escapeHTML($str);

Same here.

> +	if ($opts{'-nbsp'}) {
> +		$str =~ s/ /&nbsp;/g;
> +	}
> +	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
> +	return $str;
> +}

Those two subroutines use to_utf8(), which in turn uses
$fallback_encoding.

> +
> +# Make control characters "printable", using character escape codes (CEC)
> +sub quot_cec {
[...]
> +}
> +
> +# Alternatively use unicode control pictures codepoints,
> +# Unicode "printable representation" (PR)
> +sub quot_upr {
[...]
> +}

> +# git may return quoted and escaped filenames
> +sub unquote {
[...]
> +}

Note that this subroutine is about neither CGI nor HTML, but about
unquoting and unescaping output of git commands.  Just FYI.

> +
> +# escape tabs (convert tabs to spaces)
> +sub untabify {
> +	my $line = shift;
> +
> +	while ((my $pos = index($line, "\t")) != -1) {
> +		if (my $count = (8 - ($pos % 8))) {
> +			my $spaces = ' ' x $count;
> +			$line =~ s/\t/$spaces/;
> +		}
> +	}
> +
> +	return $line;
> +}
> +
> +1;

Good work!
-- 
Jakub Narebski
Poland
