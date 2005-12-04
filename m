From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Sun, 04 Dec 2005 13:07:42 -0800
Message-ID: <43935A9E.2060602@zytor.com>
References: <28409.1133564908@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 22:07:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej15K-00008f-52
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 22:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVLDVHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 16:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVLDVHr
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 16:07:47 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35795 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932352AbVLDVHr
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 16:07:47 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB4L7gvd006946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Dec 2005 13:07:43 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <28409.1133564908@lotus.CS.Berkeley.EDU>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13191>

Jason Riedy wrote:
> +
> +int gitsetenv(const char *name, const char *value, int replace)
> +{
> +	int out;
> +	size_t namelen, valuelen;
> +	char *envstr;
> +
> +	if (!name || !value) return -1;
> +	if (!replace) {
> +		char *oldval = NULL;
> +		oldval = getenv(name);
> +		if (oldval) return 0;
> +	}
> +
> +	namelen = strlen(name);
> +	valuelen = strlen(value);
> +	envstr = malloc((namelen + valuelen + 2) * sizeof(char));
> +	if (!envstr) return -1;
> +
> +	memcpy(envstr, name, namelen);
> +	envstr[namelen] = '=';
> +	memcpy(envstr + namelen + 1, value, valuelen);
> +	envstr[namelen + valuelen + 1] = 0;
> +
> +	out = putenv(envstr);
> +
> +	free(envstr);
> +	return out;
> +}

Wouldn't this be a good case for using alloca()?

	-hpa
