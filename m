From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 10:49:57 +0100
Message-ID: <b77c1dce0902060149j25e76250q76c2368bd3ca5857@mail.gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de>
	 <200902031204.21435.toralf.foerster@gmx.de>
	 <alpine.DEB.1.00.0902031327340.6573@intel-tinevez-2-302>
	 <200902061012.42943.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 10:51:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVNNM-0004LS-3N
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 10:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbZBFJuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 04:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756758AbZBFJuE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 04:50:04 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:39090 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206AbZBFJuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 04:50:00 -0500
Received: by fxm13 with SMTP id 13so986555fxm.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mtUqBpt/b5Ac6ByL+CNj/qHf5OqHTn2iwhgjo+Mh0IU=;
        b=Bi+/AFIBoyTwnpX4hAKZHGa14DhgGwRWZEFS+TIFwjgU5/ErD9sbXBkd4F8u69JugJ
         2kD4g1AXKAPWrJ0Dn/NEVmTWIGFo/kxKE7gw+F9wDCBgqWA0fMqnuHPOhYz7NF4rVv0w
         /yJtjlH+4DWIRR5A7D9tgV2lsjvPcVXhAznSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NhGMrg1EUJh3DIiHbC8s3dRLfeaXZurgFDvj2VhQe9KVKovXZdWaC3VSbPetyyO5ES
         BSvbmqVTH0niujdeCpjJhGV3uAbYdp9Kz0KXIT51hSjGuO6SiUJeL70io7p7C7C2YTAk
         srX35zoHkFTcihFANvi/pp+HfloCCB9nuVuhY=
Received: by 10.181.146.11 with SMTP id y11mr532232bkn.5.1233913797415; Fri, 
	06 Feb 2009 01:49:57 -0800 (PST)
In-Reply-To: <200902061012.42943.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108670>

2009/2/6 Jakub Narebski <jnareb@gmail.com>:
> Make SHA-1 regexp to be turned into hyperlink (the SHA-1 committag)
> to match word boundary at the beginning and the end.  This way we
> reduce number of false matches, for example we now don't match
> 0x74a5cd01 which is hex decimal (for example memory address),
> but is not SHA-1.

Further suggestion: you could also turn the final \b into (\b|\@), so
it skips stuff that might look like a message-id.
Here's an example :
http://perl5.git.perl.org/perl.git/commit/f57255841c18e91c7a719a2400645e39398f3947
(We get loads of this in the Perl repository)

> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f27dbb6..bec1af6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1364,7 +1364,7 @@ sub format_log_line_html {
>        my $line = shift;
>
>        $line = esc_html($line, -nbsp=>1);
> -       if ($line =~ m/([0-9a-fA-F]{8,40})/) {
> +       if ($line =~ m/\b([0-9a-fA-F]{8,40})\b/) {
>                my $hash_text = $1;
>                my $link =
>                        $cgi->a({-href => href(action=>"object", hash=>$hash_text),
> --
> 1.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
"You don't mean odds and ends, you mean des curieux et des bouts",
corrected the manager.
-- Terry Pratchett, Hogfather
