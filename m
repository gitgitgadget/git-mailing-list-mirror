From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] tree-walk: simplify via strnncmp()
Date: Mon, 16 Jun 2014 13:18:06 -0700
Message-ID: <20140616201806.GO8557@google.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
 <571d131f6ebeadb33999fe086656cb642710fb6f.1402945507.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdM8-0008Nl-GG
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbaFPUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:18:11 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41945 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbaFPUSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:18:09 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so4900077pab.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=x5iv4J2g7xFkqX9JdFW1dDIPRKl+nslDUzCTaCiAQw8=;
        b=wZwt8lY8zxV/jhYDVBuIHQqbqkxYXQkKJiD48OKSvLKS4Z6mYkyaS9JJmW2MUdj90P
         p0vSvz2jFOx2ycqGMa0QzUUO5da6FubIDzed2ln6VWKeoXuHQfrbKRXqgCB0dA/hQDAY
         Bkgj2IpTuLyb0rnqDjZMgpFprz0zhzMMLTxLTZJsdiF/ZoV37IYTfsCBNddeQVudzRrt
         A1+unHJLQYDn0aTAff+BwNaLfF5EktTIr5WGYFsd5DDyTUU5NIhOS8Cmk0BOBYDDQXwM
         nvc4dMedrBxiRpzrWiAPxoC5FH1Qa4jKZeJMf5p/I5KnndmtOPCz2d39DeeA1jBtJrM7
         0hoA==
X-Received: by 10.68.229.68 with SMTP id so4mr26660194pbc.110.1402949888706;
        Mon, 16 Jun 2014 13:18:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gr10sm20278312pbc.84.2014.06.16.13.18.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 13:18:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <571d131f6ebeadb33999fe086656cb642710fb6f.1402945507.git.jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251817>

Jeremiah Mahler wrote:

> --- a/tree-walk.c
> +++ b/tree-walk.c
[...]
> @@ -174,7 +164,7 @@ static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
>  	 * scanning further.
>  	 */
>  
> -	int cmp = name_compare(a, a_len, b, b_len);
> +	int cmp = strnncmp(a, a_len, b, b_len);

This changes behavior: the old version would only have 0 < cmp if
'a' comes after 'b', while the new version always has 0 < cmp when
a != b.
