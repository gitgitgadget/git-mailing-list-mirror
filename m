From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: filter escapes from longer commit titles that break firefox
Date: Mon, 20 Apr 2009 02:32:35 -0700 (PDT)
Message-ID: <m3r5znpt5g.fsf@localhost.localdomain>
References: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 11:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvptE-0007SQ-4T
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 11:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbZDTJcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 05:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbZDTJci
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 05:32:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:10808 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZDTJch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 05:32:37 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1030259wah.21
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=eks5SCVlDysJJAJZOmANvkTSI+PKyo/bkSGNVVB3KIE=;
        b=gKrfkLWWp0XpLlld8+Skr4HgOzLgDQFKaFzm7iM843j3MQ/1WILknocrZUyhOGB+B5
         OdJcAl5tTRZ8DVaoH+YLYI7+6poLnbYm4fxt6oZG37/OTqmbZZwX+NvbDNe27ADNta/z
         aXNmXZm2kR7iOCcvmnop7F3bJojk71Gy0BECw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=h1wIYZAPnIQGQmiz+cVGYdgtd+da3cv04LUnp5olm7N00zW8ppUuLRjU6Acbiy2/7B
         YLYEg5+eYf1dW3fVYVTs6rCWIZ17gbhExZ7GnlGv0TZ6z6IzyVrxqGT2e06Pa+/h7H2R
         1vUkO1DngC6JNPFyTYCQap80C5aeviMjEd8d8=
Received: by 10.114.67.2 with SMTP id p2mr3207238waa.208.1240219956829;
        Mon, 20 Apr 2009 02:32:36 -0700 (PDT)
Received: from localhost.localdomain (abwc215.neoplus.adsl.tpnet.pl [83.8.226.215])
        by mx.google.com with ESMTPS id n20sm21770589pof.10.2009.04.20.02.32.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 02:32:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3K9WT0P002545;
	Mon, 20 Apr 2009 11:32:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3K9WRKY002541;
	Mon, 20 Apr 2009 11:32:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116952>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> If there is a commit that ends in ^X and is longer in length than
> what will fit in title_short, then it doesn't get fed through
> esc_html() and so the ^X will appear as-is in the page source.
> 
> When Firefox comes across this, it will fail to display the page,
> and only display a couple lines of error messages that read like:
> 
>    XML Parsing Error: not well-formed
>    Location: http://git ....
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

This is an issue for when project doesn't follow sanity (control
characters in commit message) nor commit message conventions of git
(limiting length of first line of commit message to 60-70 characters).

But I do not think that the solution presented here is good solution
for this problem.  chop_and_escape_str is meant as _output_ filter,
because it generates (can generate) fragment of HTML.  It is not a
good solution to use it for shortening in intermediate representation
of %co{'title'}.

And I think that issue might be a bug elsewhere in gitweb if we have
text output which is not passed through esc_html... or bug in CGI.pm
if the error is in not escaping of -title _attribute_ (attribute
escaping has slightly different rules than escaping HTML, and should
be done automatically by CGI.pm).


So thanks for noticing the issue, but NAK on the solution.

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 33ef190..e686e82 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2470,7 +2470,7 @@ sub parse_commit_text {
>  	foreach my $title (@commit_lines) {
>  		$title =~ s/^    //;
>  		if ($title ne "") {
> -			$co{'title'} = chop_str($title, 80, 5);
> +			$co{'title'} = chop_and_escape_str($title, 80, 5);
>  			# remove leading stuff of merges to make the interesting part visible
>  			if (length($title) > 50) {
>  				$title =~ s/^Automatic //;
> -- 
> 1.6.2.3
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
