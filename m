From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v8 1/3] gitweb: add `status` headers to git_feed() responses.
Date: Fri, 30 Mar 2012 16:21:50 +0100
Message-ID: <201203301721.52657.jnareb@gmail.com>
References: <201203282328.08876.jnareb@gmail.com>  <4958e06536924de10105bb453d88e8f4c28bb8c1.1333024238.git.wking@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 17:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDdee-0005v5-D5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 17:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab2C3PWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 11:22:16 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48382 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab2C3PWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 11:22:14 -0400
Received: by wejx9 with SMTP id x9so432471wej.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+YrM6w9S+oZkoQihTXbFHN9d8bjqUa5zqRJUjC5WfwI=;
        b=pMm3EX2aGT49UPfFehd/I1CJTCe/65/9v6PvKPhqlHhPyqxNs/XJV8xHLuwLMqty44
         kaENd4TCcihcJ809fahAU187ZV/dnXgI1BHuJTTWIfB5jjza+fvZfF34ImhQ44C3v8/k
         +JqC4k/jzuUeWbYDsy/+BzYGwZf6C/RbrWbS43rv5xCFwWBq1EMue6uyZnJ4eSQ63qoJ
         2A/uzY4PNq/gP/mn+wxAzJoA1ejlvKPfszpc7Mi/Y5g3D2WmpJgmR1m8PSY8bGr9Rr5T
         h1uWmnNvISZqbF98LQrHOvUFHFpKy+fc38IdJvfOAw3mN2iLWbRO7L7wM806uQwlaHn4
         TZtA==
Received: by 10.180.107.101 with SMTP id hb5mr8458700wib.3.1333120929691;
        Fri, 30 Mar 2012 08:22:09 -0700 (PDT)
Received: from [192.168.1.13] (addb154.neoplus.adsl.tpnet.pl. [79.184.53.154])
        by mx.google.com with ESMTPS id j3sm11490233wiw.1.2012.03.30.08.22.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 08:22:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4958e06536924de10105bb453d88e8f4c28bb8c1.1333024238.git.wking@drexel.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194366>

On Thu, 29 Mar 2012, W. Trevor King wrote:

> The git_feed() method was not setting a `Status` header unless it was
> responding to an If-Modified-Since request with `304 Not Modified`.
> Now, when it is serving successful responses, it sets status to
> `200 OK`.

Nice.  This change is IMHO worth applying even without the rest of series.
So

  Acked-by: Jakub Narebski <jnareb@gmail.com>

You _might_ also add that this change would allow robust testing of
If-Modified-Since request handling in gitweb, but it is not really
necessary.

> 
> Signed-off-by: W Trevor King <wking@drexel.edu>
> ---
>  gitweb/gitweb.perl |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a8b5fad..041da17 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7841,11 +7841,13 @@ sub git_feed {
>  		print $cgi->header(
>  			-type => $content_type,
>  			-charset => 'utf-8',
> -			-last_modified => $latest_date{'rfc2822'});
> +			-last_modified => $latest_date{'rfc2822'},
> +			-status => '200 OK');
>  	} else {
>  		print $cgi->header(
>  			-type => $content_type,
> -			-charset => 'utf-8');
> +			-charset => 'utf-8',
> +			-status => '200 OK');
>  	}
>  
>  	# Optimization: skip generating the body if client asks only
> -- 
> 1.7.3.4

-- 
Jakub Narebski
Poland
