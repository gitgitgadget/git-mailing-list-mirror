From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page.,
 take two
Date: Tue, 15 Nov 2005 19:45:12 -0800
Message-ID: <437AAB48.7090904@zytor.com>
References: <20051116002318.A46C55BF97@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 04:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcEEv-000094-MW
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbVKPDpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 22:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVKPDpU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:45:20 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37573 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965217AbVKPDpR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 22:45:17 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAG3jCgg014378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Nov 2005 19:45:13 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <exon@op5.se>
In-Reply-To: <20051116002318.A46C55BF97@nox.op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12002>

Andreas Ericsson wrote:
>  
> +static void show_man_page(char *git_cmd)
> +{
> +	char *page;
> +
> +	if (!strncmp(git_cmd, "git", 3))
> +		page = git_cmd;
> +	else {
> +		int page_len = strlen(git_cmd) + 4;
> +
> +		page = malloc(page_len + 1);
> +		strcpy(page, "git-");
> +		strcpy(page + 4, git_cmd);
> +		page[page_len] = 0;
> +	}
> +
> +	execlp("man", "man", page, NULL);
> +}
> +

The way this made it into the actual tree was to call /usr/bin/man, but 
still using execlp().  This is clearly bogus.  There *ARE* good reasons 
to use PATH resolutions for this, since man is one of the interactive 
commands the user may want to wrapper.

So please drop PATH_TO_MAN that made it into the repository and revert 
to the original patch.

	-hpa
