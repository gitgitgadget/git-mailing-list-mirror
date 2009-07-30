From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: suppress 'Use of uninitialized value' error
Date: Fri, 31 Jul 2009 01:00:40 +0200
Message-ID: <200907310100.42786.jnareb@gmail.com>
References: <1248988540-8971-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 01:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWecT-0005iM-VR
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 01:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbZG3XAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 19:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZG3XAx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 19:00:53 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:61459 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbZG3XAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 19:00:52 -0400
Received: by ewy10 with SMTP id 10so1148852ewy.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m9DJfiKde+JvJlKp22EnCxJXmcIg2reNuR/7Ft8qAMk=;
        b=eZ3TcEvsrz1jIJpjbohal1CHOeGfYHX8P/a30O5BwPmPpuSgOKL6VDOXzg0PWBm8Hh
         5ccFtNmSNUSUag44JtDslE+YFRNKELKm01w5GqxJx16boZqK61JM5rQZaWZ/TygcbVtm
         mRzKXs1d3xtLP3nRD/Ck6QJGOfyT0uWTSQTjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MYCZL67U/EEnXfYjmMIpblTmVdyhw/IUHy10VJEwIIfLkxT9KBH4h1nYPnFcaRVxDP
         2VpRRSJN3/VbfNHjq0Fe1YFi2n+LG+/TJeFVXnkDPcdPTJ9pW2X+rPBedM7jXeHPu1ex
         oADFmlznNhFyDtt/iJOs1TRk0MXlOAGZ4TLyA=
Received: by 10.210.89.7 with SMTP id m7mr260255ebb.14.1248994850320;
        Thu, 30 Jul 2009 16:00:50 -0700 (PDT)
Received: from ?192.168.1.13? (abvk103.neoplus.adsl.tpnet.pl [83.8.208.103])
        by mx.google.com with ESMTPS id 10sm1021045eyz.21.2009.07.30.16.00.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 16:00:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1248988540-8971-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124485>

On Thu, 30 July 2009, Giuseppe Bilotta wrote:

Thanks for catching this.

However... First, the subject should be more specific and less generic.  
At least provide where 'Use of uninitialized' value was generated, e.g.:

  Subject: [PATCH] gitweb: Fix 'Use of uninitialized value' error in href()

or a bit shorter

  Subject: [PATCH] gitweb: Fix 'Use of uninitialized value' in href()

Second, it would be nice to have more detailed description in the body
of a commit message, in this case stating when mentioned error occur:

  This warning was generated when 'hash_parent_base' parameter was
  defined, and either 'file_name' or 'file_parent' was not defined.

Note that from above description you can notice that you protect against
'file_parent' being not defined, but not against 'file_name', so you
should I think write why it is not a problem:

  In gitweb code 'file_parent' is used only if 'file_name' is filled.

Well... almost.  This does not cover href(..., -replay=>1) with hand
crafted broken/invalid gitweb URL.  BTW. a question for you: how did
you detect/found this breakage?  I don't think gitweb generates such
broken links (with 'hash_parent_base' but not 'file_parent') normally,
but I might be mistaken.

Third, we would probably want to have additional case in t/t9500 test
to protect against regression here.  But that is not as important,
I think.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Otherwise, for what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> The patch could have been a one-liner by adding the defined check at
> line 943, but that pushed the line to 120 char, so I decided for this
> slightly more complex form.

That is IMHO a good solution.  Better not abuse 'if' modifier form.

> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7fbd5ff..c7f257e 100755
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
> +					if ($params{'file_parent'} eq $params{'file_name'}) {
> +						delete $params{'file_parent'};
> +					} else if ($params{'file_parent'} !~ /\.\./) {
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
