From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 01:14:58 +0100
Message-ID: <200901280114.59388.jnareb@gmail.com>
References: <1233062946-22395-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 01:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRy6Y-0001Tu-4J
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbZA1APF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbZA1APE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:15:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:27207 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZA1APC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:15:02 -0500
Received: by fg-out-1718.google.com with SMTP id 13so335159fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jEGOkAXRrIuehFlh5GWSDk0fVeog7jw2J5L+YmHSKVY=;
        b=OFK6hw/DVgrO1NVJqKutVQFclCVBtXm40sGWPrU8HrFVXVeOrV8PY6BjJpwvlqKxUo
         gr94KKL++ZzwxczyUUSF3AU2gbdPOutP+xR00SJrS3fFhUKYfA+06HLk9OqndDyYw61f
         Uytbti1QFUX75+rvBInnaHkgm3vdKmTsxMNV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jsOc0CHIIm6fgjy6zYjxL/EaOOsrc6K0OpS0Cbz08jJHIDN3uX7FC3nvCeSgg0PUae
         JBufBs9nV3OVLNJ5xxJ0F8NhzKaSr2PpTujUtUW7Ma19FeltYSWpm/k/Dllk3nMNGbhK
         s/5R0IsKOvYbl62EFjCQsGuEUr07h8wLjgHH0=
Received: by 10.86.29.8 with SMTP id c8mr1360822fgc.67.1233101699935;
        Tue, 27 Jan 2009 16:14:59 -0800 (PST)
Received: from ?192.168.1.15? (abvq8.neoplus.adsl.tpnet.pl [83.8.214.8])
        by mx.google.com with ESMTPS id 4sm1219157fge.45.2009.01.27.16.14.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 16:14:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1233062946-22395-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107430>

On Tue, 27 Jan 2009, Giuseppe Bilotta wrote:

> When PATH_INFO is defined, static files such as the defalt CSS or the
                                                      default

> shortcut icon are not accessible beyond the summary page (e.g. in
> shortlog or commit view).
> 
> Fix this by adding a <base> tag pointing to the script base URL.

By the way, I have thought that it would conflict with use path_info
for 'blob_plain' action to have links work in document... but I forgot
that then we do not use gitweb HTML header...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> Of course, last time I forgot that the BASE href is supposed to be
> absolute. While Opera apparently has no problem with it being relative,
> other browsers such as Firefox are stricter about it.

Errrr... I think you are talking about _full_ vs. _absolute_, not
_absolute_ vs. _relative_, see below.

> 
>  gitweb/gitweb.perl |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 931db4f..411b1f6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2901,6 +2901,14 @@ sub git_header_html {
>  <meta name="robots" content="index, nofollow"/>
>  <title>$title</title>
>  EOF
> +# the stylesheet, favicon etc urls won't work correctly with path_info unless we set the appropriate base URL

Errr... could you please break this line to not have it overly long?

> +	if ($ENV{'PATH_INFO'}) {
> +		my $base = $my_url;

Hmmm...

  our $my_url = $cgi->url(); # = $cgi->url(-full);
  our $my_uri = $cgi->url(-absolute => 1);

> +		my $sname = $ENV{'SCRIPT_NAME'};
> +		$base =~ s,\Q$sname\E$,,;
> +		$base .= "/";

I don't think that is required; neither of $my_url and $my_uri ends
with '/' after stripping path info:

  our $path_info = $ENV{"PATH_INFO"};
  if ($path_info) {
  	$my_url =~ s,\Q$path_info\E$,,;
  	$my_uri =~ s,\Q$path_info\E$,,;
  }

and if BASE is a document, then relative URLs are resolved using
dirname of BASE, I guess, as
  http://www.w3.org/TR/html401/struct/links.html#edef-BASE
contains in example:
  <BASE href="http://www.aviary.com/products/intro.html">

See also RFC1808 (Relative Uniform Resource Locators), section
4.  Resolving Relative URLs:

   Step 6: The last segment of the base URL's path (anything
           following the rightmost slash "/", or the entire path if no
           slash is present) is removed and the embedded URL's path is
           appended in its place.[...]

Besides, if you strip SCRIPT_NAME, then you are left with document
root; this means that if git-logo.png etc. are in the same directory
as gitweb.cgi, they won't be found.  For example for me it doesn't
work correctly (I have git-logo.png along gitweb.cgi, which is in
/cgi-bin/gitweb/... and thanks to symlinks also in /gitweb/).


By the way, according to documentation $cgi->url() should *not*
contain path_info; you have to use $cgi->url(-path_info=>1) for
that... strange.

> +		print "<base href=\"$base\"/>\n";

Just in case, to be compatible with both XHML and HTML, we should use

+		print "<base href=\"$base\" />\n";

...if not for the fact that surrounding code doesn't use this way...

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
