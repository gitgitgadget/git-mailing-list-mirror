From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: gravatar support
Date: Fri, 19 Jun 2009 13:24:58 +0200
Message-ID: <200906191325.00248.jnareb@gmail.com>
References: <1245405495-7712-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 13:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHcDi-000713-Ab
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 13:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbZFSLZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 07:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbZFSLZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 07:25:09 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:62320 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbZFSLZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 07:25:08 -0400
Received: by bwz9 with SMTP id 9so1674836bwz.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3GfGLVhU3Qhfq23Q4rQKiy/WCptQxRCzKjPLKrj1h90=;
        b=aYBYbyhbAnnT9baaWrBtR138G9oC2YOvQz3L1ohDQJdVfHKYwH46DSFr3ugn4NTxCK
         X5oVZLmktumAh9SCq9TebOCZbV0XHYzbG9d6aW40wD+uIlJl1rThYtpM1Ahr1+gT+mQY
         1iuYXJ+MmA+TljYxxSJfbM6Kxh717GglKFpZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=V/nqrMmiYC1CTUgUXozETG7PkKUrTmYPhgf8GHALSZH76Pjyav2Fjk3uAvuc/MJiha
         zUkqrOwE+gSjsPgNBcbKx2MtdsP4kVTKDOaRBdBU0mqp1XHV2JGQyJJA2OCEpeJfD8v2
         eZyayah6fNrk1E/PHfjyNG+WEN+xF7ppEz3Ho=
Received: by 10.204.117.17 with SMTP id o17mr2455543bkq.145.1245410709449;
        Fri, 19 Jun 2009 04:25:09 -0700 (PDT)
Received: from ?192.168.1.13? (abvl170.neoplus.adsl.tpnet.pl [83.8.209.170])
        by mx.google.com with ESMTPS id 1sm5836778fkt.27.2009.06.19.04.25.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 04:25:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245405495-7712-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121896>

On Fri, 19 June 2009, Giuseppe Bilotta wrote:

> Introduce gravatar support by adding the appropriate img tag next to
> author and committer in commit, shortlog and log view.
> 
> The feature is disabled by default, and depends on Digest::MD5.

Digest::MD5 is core Perl module and (in, I guess, most cases)
installed together with Perl.

You might want to mention it in the commit message.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   41 ++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1e7e2d8..9f40070 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -365,6 +365,18 @@ our %feature = (
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
> +	# Project specific override is not supported.
> +	'gravatar' => {
> +		'override' => 0,
> +		'default' => [0]},

Yet another global feature without project specific override.  Hmmm...
I wonder if project specific and global (non-overridable) features 
should be separated.  But it is question for a separate commit.

Question: why it is not overridable (why project specific override
is not supported for this feature)?  Some projects may use Gravatars,
some might not, although I guess that usually it is deployment specific
feature.

>  );
>  
>  sub gitweb_get_feature {
> @@ -814,6 +826,9 @@ $git_dir = "$projectroot/$project" if $project;
>  our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> +# check if gravatars are enabled and dependencies are satisfied
> +our $git_gravatar_enabled = gitweb_check_feature('gravatar') && (eval { use Digest::MD5 qw(md5_hex); 1; });

I would use line break here:

  +our $git_gravatar_enabled = gitweb_check_feature('gravatar') && 
  +    (eval { use Digest::MD5 qw(md5_hex); 1; });

or

  +our $git_gravatar_enabled = gitweb_check_feature('gravatar')
  +    && (eval { use Digest::MD5 qw(md5_hex); 1; });


I really like the fact that we do not include Digest::MD5 if it is not
required (if feature is not tuned on).

> +
>  # dispatch
>  if (!defined $action) {
>  	if (defined $hash) {
> @@ -4123,6 +4138,19 @@ sub git_project_list_body {
>  	print "</table>\n";
>  }
>  
> +# insert a gravatar for the given $email at the given $size if the feature
> +# is enabled
> +sub git_get_gravatar {
> +	if ($git_gravatar_enabled) {
> +		my ($email, $size) = @_;
> +		$size = 32 if $size <= 0;

You would probably want to protect against $size being undefined:

  +		$size = 32 if (!defined($size) || $size <= 0);

Because currently when you are not passing size parameter to use 
default size you would get the following warning:

  Use of uninitialized value in numeric le (<=) ...

Did you run the t9500, adding test enabling gravatars?  

Hmmm... perhaps we should add test with all possible features turned
on (unless they need extra configuration... oh, so it isn't as easy
as I initially thought to add this...).

> +		return "<img src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
> +		       md5_hex($email) . "&amp;size=$size\" style=\"vertical-align:middle\" />";

Hmmm... 'style="vertical-align:middle"' or 'class="gravatar"' (plus 
addition to CSS)?

> +	} else {
> +		return "";
> +	}
> +}
> +


[...]
> @@ -4145,7 +4173,7 @@ sub git_shortlog_body {

> +		      "<td>" . git_get_gravatar($co{'author_email'}, 16) . "&nbsp;<i>" . $author . "</i></td>\n" .

> @@ -5095,8 +5123,9 @@ sub git_log {

> +		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i>&nbsp;" .
> +		      git_get_gravatar($co{'author_email'}, 16) .
> +		      "<br/>\n</div>\n";

> @@ -5183,7 +5212,8 @@ sub git_commit {

> +	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_gravatar(lc $co{'author_email'}) . "</td></tr>\n" .

> +	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_gravatar(lc $co{'committer_email'}) . "</td></tr>\n";

Hmmm... why use 'lc' here and not in other places?  Also gravatars are
not shown in 'history' view, but I guess that could wait for proper
refactoring of all log-like views/actions to use common infrastructure.

Those all look nice with the *default* font sizes.  But as the size of
gravatar is used when constructing gravatar URL, to pass to gravatar.com
I don't see how this problem can be resolved...  Beside making it 
configurable, I guess...

-- 
Jakub Narebski
Poland
