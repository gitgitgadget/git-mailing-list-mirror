From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 08:27:14 -0800
Message-ID: <43A19962.2000202@zytor.com>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 15 17:27:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emvx9-0003PT-1j
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 17:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVLOQ1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 11:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVLOQ1c
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 11:27:32 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33967 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750799AbVLOQ1b
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 11:27:31 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBFGRFSJ008495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Dec 2005 08:27:16 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13703>

Johannes Schindelin wrote:
> This makes git-check-ref-format fail for "HEAD". Since the check is only
> executed when creating refs, the existing symbolic ref is safe.

> diff --git a/refs.c b/refs.c
> index bda45f7..293bfe7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -332,6 +332,11 @@ int check_ref_format(const char *ref)
>  		if (ch == '.' || bad_ref_char(ch))
>  			return -1;
>  
> +		/* do not allow "HEAD" as ref name */
> +		if (ch == 'H' && (!strcmp(cp, "EAD") ||
> +					!strncmp(cp, "EAD/", 4)))
> +			return -1;
> +
>  		/* scan the rest of the path component */
>  		while ((ch = *cp++) != 0) {

If you're have to open-code it, you might want to just do it all the way:

if (ch == 'H' && cp[0] == 'E' && cp[1] == 'A' && cp[2] == 'D' &&
     (cp[3] == '\0' || cp[3] == '/'))

	-hpa
