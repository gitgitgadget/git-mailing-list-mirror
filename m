From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix 'Use of uninitialized value' error in href()
Date: Fri, 31 Jul 2009 10:30:50 +0200
Message-ID: <200907311030.52643.jnareb@gmail.com>
References: <200907310824.42953.jnareb@gmail.com> <1249022929-21037-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 10:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWnPl-0000f2-02
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 10:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbZGaIYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 04:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbZGaIYZ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 04:24:25 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:42614 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbZGaIYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 04:24:24 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so1337124ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2fG+jPgBhxtv8t9a3ipg1wF2kT1kwo+rl60nAGQ4et8=;
        b=JYeer6QgjAn+FTfw42BnJio69Tcqg18RbTpDp+Br8pmd27NSLun0w+rq1q51xcvdvW
         ESHXZtQJkw0WdP3VVcn8X9cUAvbA0T/34ndNHPfnkC2ka+1mDaYloOesd77KGdg8INYy
         uBm5xuQJng8m+lWsDaKCusE/XkUVgvH1L8eGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=s8+YPDa/E53PS6+1TAukp+Tx9qbjbCZXny6bKlxXYQK9RC1WD1GItRkIcRhgfTfbsM
         eGaeAe0bfRv2m0K5TFKp8qeob3QsQitD+RRq+GMQLamXTPsPi33V1hiiN6GEFYoe3ZTt
         jG/o83xYmC/kh3yjBqWSiHoPZ7yaKwJyWXwBc=
Received: by 10.211.168.4 with SMTP id v4mr482061ebo.82.1249028664069;
        Fri, 31 Jul 2009 01:24:24 -0700 (PDT)
Received: from ?192.168.1.13? (abvk103.neoplus.adsl.tpnet.pl [83.8.208.103])
        by mx.google.com with ESMTPS id 28sm2414064eye.24.2009.07.31.01.24.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 01:24:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1249022929-21037-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124511>

On Fri, 31 July 2009, Giuseppe Bilotta wrote:

> Equality between file_parent and file_name was being checked without a
> preliminary check for existence of the parameters.
> 
> Fix by wrapping the equality check in appropriate if (defined ...),
> rearranging the lines to prevent excessive length.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> The funny thing is that I seem to get the error for something as simple
> as a commit view (_any_ commit view, for the matter), but I wasn't able
> to reproduce it from the shell, which is why I'm not adding a testcase.

Gaaah! A Heisenbug! ;-)

Well, it worth fixing if it is real case scenario.

> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7fbd5ff..37120a3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -940,10 +940,13 @@ sub href {
>  			if (defined $params{'hash_parent_base'}) {
>  				$href .= esc_url($params{'hash_parent_base'});
>  				# skip the file_parent if it's the same as the file_name
> -				delete $params{'file_parent'} if $params{'file_parent'} eq $params{'file_name'};
> -				if (defined $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
> -					$href .= ":/".esc_url($params{'file_parent'});
> -					delete $params{'file_parent'};
> +				if (defined $params{'file_parent'}) {
> +					if (defined $params{'file_name'} && $params{'file_parent'} eq $params{'file_name'}) {

or, to reduce line length even more:

  +					if (defined $params{'file_name'} &&
  +					    $params{'file_parent'} eq $params{'file_name'}) {

> +						delete $params{'file_parent'};
> +					} elsif ($params{'file_parent'} !~ /\.\./) {
> +						$href .= ":/".esc_url($params{'file_parent'});
> +						delete $params{'file_parent'};
> +					}
>  				}
>  				$href .= "..";
>  				delete $params{'hash_parent'};
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
