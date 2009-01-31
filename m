From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 1/2] gitweb: make static files accessible with PATH_INFO
Date: Sat, 31 Jan 2009 02:14:47 +0100
Message-ID: <200901310214.49247.jnareb@gmail.com>
References: <1233139832-24124-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 02:16:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4TF-0005Ai-52
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 02:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZAaBO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 20:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbZAaBO5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 20:14:57 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:32544 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbZAaBO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 20:14:56 -0500
Received: by fk-out-0910.google.com with SMTP id f33so662191fkf.5
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 17:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9fZKc529ZNcBLQKV2OexIXZmGhSMWiXqYsIfR4J/T/w=;
        b=AcFU7+J+d0X3i9rIyvW2Usxcv5GWEqdKRsRZNhu3Ks81+K2ohQlYUuIxZDEL0W6JAD
         08DOPbfN0IvhM0Y/qgWKQNcLMWw6i7n+kzwPWUNoCamq091c4sQhj1bGmxaDeH3/nwjn
         Y5FNSnJWpWr8V10ZUVevX6dDMp1JEJc9Hw0ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KpXXZyuXsi/DYnJo2DVPfcx1YOw/b74kctz6E6G3IfaVFa/SSI/pM8Gk7zYsYkUy52
         F1eByT4zOLgwx0jRaTfAiWFIXX/iofoW9KfD7Vo4V9znytwmswIxYu5Md/KGvgdkLJ9T
         bCyuFibMLBbPLIcqq1GbP548kg5gU2Ljj3Urc=
Received: by 10.181.208.15 with SMTP id k15mr645312bkq.13.1233364494445;
        Fri, 30 Jan 2009 17:14:54 -0800 (PST)
Received: from ?192.168.1.13? (abwh184.neoplus.adsl.tpnet.pl [83.8.231.184])
        by mx.google.com with ESMTPS id 12sm2082760fks.25.2009.01.30.17.14.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 17:14:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1233139832-24124-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107896>

On Wed, 28 Jan 2009, Giuseppe Bilotta wrote:

> When gitweb is invoked with PATH_INFO and links to static files such as
> the CSS and favicon/shortcut icon are relative URLs with relative paths
> (as is the case when using the default Makefile), these files are not
> accessible beyond the project list and summary page (e.g. in shortlog or
> commit view).
> 
> Fix this by adding a <base> tag pointing to the script's own URL, that
> ensure that all relative paths will be based on this.

I think it is a very good idea, good patch (now with esc_url, just in
case, even though I think it should be needed), and commit message has
all info that it should have. But I think that it could be phrased
better: instead of one long sentence, perhaps split it into few
sentences, each dealing with one issue. Something like below:

-- >8 --
Gitweb links to a few static files: CSS stylesheet, favicon/shortcut
icon and git logo.  When links to those files are given by relative
URLs with relative paths (not starting with '/'), and gitweb is invoked
with (non empty) PATH_INFO, these files are not accessible beyond
projects list and 'summary' view for a project (e.g. in 'shortlog' or
'commit' view).  Default Makefile rules use base filenames for those
static files.

Fix this by adding <base> element pointing to script's own URL,
which ensures that all relative paths relative URLs will be resolved
correctly.
-- 8< --

Gaaahhh... I think this version could be better, but I cannot think
how it should look like...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 931db4f..f7aaf9a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2901,6 +2901,11 @@ sub git_header_html {
>  <meta name="robots" content="index, nofollow"/>
>  <title>$title</title>
>  EOF
> +# the stylesheet, favicon etc urls won't work correctly with path_info unless we
> +# set the appropriate base URL

BTW. I think there should be independent patch making those comments
indented properly...

> +	if ($ENV{'PATH_INFO'}) {
> +		print "<base href='".esc_url($my_url)."' />\n";

Errr... here we use ' as attribute delimiter, while everywhere else
we use "; I don't know if esc_url deals correctly with this... it does
as neither " nor ' is in "allowed" list, but I'd personally use

+		print '<base href="'.esc_url($my_url).'" />'."\n";


> +	}
>  # print out each stylesheet that exist
>  	if (defined $stylesheet) {
>  #provides backwards capability for those people who define style sheet in a config file
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
