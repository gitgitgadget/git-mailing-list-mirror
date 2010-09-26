From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 06/12] gitweb: allow extra text after action in page header
Date: Sun, 26 Sep 2010 20:11:27 +0200
Message-ID: <201009262011.28211.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 20:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzvhJ-0008BZ-Kn
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 20:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab0IZSLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 14:11:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41945 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0IZSLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 14:11:32 -0400
Received: by fxm3 with SMTP id 3so1450850fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=H7yxSOU0QeFhM1qdjtRiCKdYqD4LjFkdOkJ9I/lSxSY=;
        b=hkrF8yiXkjO0q7wYWzFceNHRf8G8I0pKbMU+NP3l0doWm5RkfgPpG1lehDqhAs7UYK
         aMie26yLB3XuynMLulSggesilKaaXZJTwKs73gqmloF5tvpDTFjAiD/zF7sleQ6rw/3m
         SOAXJzk8sj7B2HJCxsjkfBsZFdUPPnJ2Kh0QU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fWIsHhGQK4Dwi1z/fmTkepMorsVmsDYIjnVqYfGR4W4snjbDmAHLGWTMbdWsoDNzfQ
         oFAq7LQOe2+EVxMvmuIFgo8W5V8agahAhC5nTszUJlt9fxJjxI4xjQpk6pfP+ZqcKMlP
         GeTl3OkDsnrESBI4kG3OZWnGXb3jA3kto+aTQ=
Received: by 10.223.104.11 with SMTP id m11mr6416886fao.50.1285524690819;
        Sun, 26 Sep 2010 11:11:30 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id p2sm2011269fak.46.2010.09.26.11.11.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 11:11:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157247>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> This extra text is intended to 'specify' the action. Therefore, if it's
> present, the action name in the header will be turned into a link to
> the action itself but without specifying any parameter.

What this feature is intended *for*?  I guess it is meant to be used
in the case where there is additional parameter that specifies action,
like e.g. a single remote view, where $action is 'remotes', but there
is extra parameter ('hash_base' is (ab)used for this) that specifies
remote.  Then we want to make 'remotes' in "breadcrumbs" navigation at
top of page to link to generic 'remotes' view.  Isn't it?

But the above is just my guess, covering only case where there is both
$action defined, and 'header_extra' option set.

You need to explain this in the commit message.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e70897e..76cf806 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3514,7 +3514,15 @@ EOF
>  	if (defined $project) {
>  		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
>  		if (defined $action) {
> -			print " / $action";
> +			my $action_print = $action ;
> +			if (defined $opts{'header_extra'}) {

We spell optional named parameter with '-' as prefix, for example
$opts{'-remove_signoff'} in git_print_log(), to be able to use key
without quoting (bareword-like, autoquoting), like $opts{-nohtml}
or $opts{-pad_before}, or $opts{-size}, or $opts{-tag}... though
gitweb is not very consisnte here.

So it should probably be

  +			if (defined $opts{'-header_extra'}) {

or even

  +			if (defined $opts{-header_extra}) {


I also think that we can think of better name for this option than
'header_extra', although what this name could be eludes me.

> +				$action_print = $cgi->a({-href => href(action=>$action)},
> +					esc_html($action));

I don't think we need to run esc_html on action: it is checked that it
is one of specified set of possible values, and it can be ensured that
it neither contains anything than printable characters, not any HTML
special characters.

> +			}
> +			print " / $action_print";
> +		}
> +		if (defined $opts{'header_extra'}) {
> +			print " / $opts{'header_extra'}";

Hmmm...

>  		}
>  		print "\n";
>  	}
> -- 
> 1.7.3.68.g6ec8
> 
> 

-- 
Jakub Narebski
Poland
