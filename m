From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: gravatar support
Date: Sat, 20 Jun 2009 12:57:43 +0200
Message-ID: <200906201257.44486.jnareb@gmail.com>
References: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 12:58:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHyGk-0000WQ-Tw
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 12:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbZFTK5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 06:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbZFTK5r
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 06:57:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:15008 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbZFTK5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 06:57:46 -0400
Received: by fg-out-1718.google.com with SMTP id 16so729253fgg.17
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=S/TYf0opMLX/P/MQp2WucDBluvaQtNaJp8TG9juywpY=;
        b=HInppeqhjXludvKtAJzbQCHDdd6mY646XgfSUr3NsPUU/xBjA2zZ0LjCwoTv1Zy3MX
         0O3+ItoRLuZ9CssCvYuou3e1k12wzmN2/bAOScNPKOHrZ1i+I9CM1Lr9zcT3nw0SVUKL
         vS8i8cNmhOM8zpPdIJBVjtLR5tIg0boQGZb9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jmq8tefY+3Qx+pMHLHQmRI/Vi6vriBA5GRhmAhpQswvEc3W+XIl2f7EsLtLZC8607V
         A6H6w+SgY94P5W5FAr63VBk0JkoJ3N6frzqcL7w9VKuoXj9Ohr0KWKs64U4HIFcZKDqC
         mOh1MDtJ2gbLVzvrk9vHWeN7Z/DzSRp7VQ7Ho=
Received: by 10.86.90.2 with SMTP id n2mr4081380fgb.61.1245495467698;
        Sat, 20 Jun 2009 03:57:47 -0700 (PDT)
Received: from ?192.168.1.13? (abwr61.neoplus.adsl.tpnet.pl [83.8.241.61])
        by mx.google.com with ESMTPS id 12sm7167715fgg.25.2009.06.20.03.57.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 03:57:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121940>

On Fri, 19 June 2009, Giuseppe Bilotta wrote:

> Introduce gravatar support by adding the appropriate img tag next to
> author and committer in commit, shortlog and log view.

You have added gravatar support also to 'history' view, which you
should mention here.  By the way, I have noticed that there is no
gravatar support in 'commitdiff' view... which probably means that,
as Junio said, this would require some refactoring and factoring out
common code.

> 
> The feature is disabled by default, and depends on Digest::MD5, which
> is available in most Perl installations.

I wonder if there should be mentioned that if Digest::MD5 is not 
installed, the feature will not be used...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.css  |    4 ++++
>  gitweb/gitweb.perl |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 48 insertions(+), 7 deletions(-)
> 
> Changes from the previous version include gravatar use in history view,
> CSS use and the possibility to override the feature on a per-project basis.

There are a few other 'code' changes...

> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index a01eac8..ca716e6 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -28,6 +28,10 @@ img.logo {
>  	border-width: 0px;
>  }
>  
> +img.gravatar {
> +	vertical-align:middle;
> +}
> +

That is good enough CSS class name for now, but in the future we might
want to use more generic name: avatar, personal_avatar, personal_icon;
or something like that.

>  div.page_header {
>  	height: 25px;
>  	padding: 8px;
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1e7e2d8..c06356b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -365,6 +365,21 @@ our %feature = (
>  		'sub' => \&feature_patches,
>  		'override' => 0,
>  		'default' => [16]},
> +
> +	# Gravatar support. When this feature is enabled, views such as
> +	# shortlog or commit will display the gravatar associated with
> +	# the email of the committer(s) and/or author(s). Please note that
> +	# the feature depends on Digest::MD5.
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'gravatar'}{'default'} = [1];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'gravatar'}{'override'} = 1;
> +	# and in project config gitweb.gravatar = 0|1;
> +	'gravatar' => {
> +		'sub' => sub { feature_bool('gravatar', @_) },
> +		'override' => 0,
> +		'default' => [0]},

Nice.  I think it can be on per-project basis decision whether to
use avatars or not.  For example if project uses fake emails, etc.

[...]
> +# insert a gravatar for the given $email at the given $size if the feature
> +# is enabled
> +sub git_get_gravatar {
> +	if ($git_gravatar_enabled) {
> +		my ($email, $size, $whitespace) = @_;
> +		$whitespace = 0 unless defined($whitespace);
> +		$size = 32 if (!defined($size) || $size <= 0);
> +		return "<img class=\"gravatar\" src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
> +		       md5_hex(lc $email) . "&amp;size=$size\" />" . ($whitespace ? "&nbsp;" : "");
> +	} else {
> +		return "";
> +	}
> +}

I don't like this change.  I don't like it at all.

First, there is an issue of having two _independently_ optional
parameters.  Using 'undef' / not passing parameter to use default value
is IMVHO an anti-pattern; it is a bit unwieldy / ugly to call it with
$whitespace set while using default value for $size.

Second, I think it is better to avoid such boolean parameters like
$whitespace, because you don't know from call site what it means
to pass 1 there (in C we would use constant instead of 1 here).

Both of above are solved in current gitweb code (at least in some
places) by passing hash of (named) optional parameters.  So the call
(if not for last note for this issue) would look like the following:

  git_get_gravatar($co->{'author_email'}, -size => 16, -whitespace => 1);

Third, rather than formatting with '&nbsp;' (ugh, just like formatting
with tab and enter in word processors) I'd rather use (if possible)
CSS style for that; something like margin-right, or padding-right...
if it would work, of course.  But see also note below.


Last but not least, but after thinking about it a bit more I think now
that those optional parameters are entirely too low level, too close to
implementation.  What matters is not the size (which you would then need
to change in every and each callsite) and adding &nbsp; after image.
What matters is whether to use double size, and whether gravatar image
is on the left side or on the right side of text it is referring to.

You would be then able to easily chose small/large size from hash of
possible sizes (mentioned %avatar_size), and just add appropriate class
differentiator for left/right hand side gravatar.

So the call would look like the following:

  git_get_gravatar($co->{'author_email'}, -large => 0, -position => 'left');

or

  git_get_gravatar($co->{'author_email'}, -small => 1, -padding => 'right');

or something like that[1] (-large, -small, -double_size, -inline, ...;
-position, -padding, -justify, -pad, -space, -separate, ...).

[1] Naming is unfortunately hard.  Fortunately we can change it later.

> +
>  sub git_print_authorship {
>  	my $co = shift;
>  
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
>  	print "<div class=\"author_date\">" .
> +	      git_get_gravatar($co->{'author_email'}, 16, 1) .
>  	      esc_html($co->{'author_name'}) .
>  	      " [$ad{'rfc2822'}";
>  	if ($ad{'hour_local'} < 6) {

That is a very good idea to add it to git_print_authorship.  This should
take care of many other places, and many views, I think.  But you should
check if it wouldn't make gravatar appear in unwanted places.

> @@ -4145,7 +4179,7 @@ sub git_shortlog_body {
> @@ -4196,7 +4230,7 @@ sub git_history_body {
> @@ -4352,7 +4386,7 @@ sub git_search_grep_body {
> @@ -5095,8 +5129,9 @@ sub git_log {

This would really, really be easier with log-like view refactoring. This
is on my TODO list for gitweb for a quite long time...

> @@ -5183,7 +5218,8 @@ sub git_commit {

-- 
Jakub Narebski
Poland
