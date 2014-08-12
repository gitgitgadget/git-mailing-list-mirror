From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] mailsplit.c: remove dead code
Date: Tue, 12 Aug 2014 18:38:38 +0200
Message-ID: <53EA430E.8050905@web.de>
References: <1407791481-17410-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Beller <stefanbeller@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 18:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHF6X-00084W-FF
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 18:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbaHLQjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 12:39:15 -0400
Received: from mout.web.de ([212.227.17.11]:54975 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbaHLQjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 12:39:12 -0400
Received: from [192.168.178.27] ([79.250.177.36]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LhvyA-1WdHZo3C2U-00nDNf; Tue, 12 Aug 2014 18:39:06
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1407791481-17410-1-git-send-email-stefanbeller@gmail.com>
X-Provags-ID: V03:K0:Jh22quEh73iP6Xsfc+XMDllNCF+HzXb8DQev88IemKiliE7fY5r
 9NjYWC9onnh+9hnW6cyl6a1YsqPHI+B1dX+dHdpSBXC/R735I78whpXE6KKBZRqQIt7Gvdb
 8cZYiez9OvJKWd8hqLQRlBn2fR4ehIDFvZKUFliKlb76IcEYs9RxkHU02FwmxCVx2X5uUDC
 gu+uUbTn5P7cCi/8vYlfQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255155>

Am 11.08.2014 um 23:11 schrieb Stefan Beller:
> This was found by coverity. (Id: 290001)
>
> the variable 'output' is only assigned to a value inequal to NUL,
> after all gotos to the corrupt label.
> Therefore we can conclude the two removed lines are actually dead code.

After reading the above for the first time I thought it meant the 
opposite of what's actually going on.  Perhaps it's the placement of 
"only", the comma or a flawed understanding of grammar on my part?

In any case, there is only one way to reach the label named corrupt, and 
the variable named output is always NULL if that branch is taken.  That 
means the removed code was a no-op.  With those two lines gone you also 
don't need to initialize output anymore, by the way.

And since there is only a single goto, you could move the three 
remaining error handling lines up to the if statement.  Keeping 
condition and dependent code together would be an improvement, I think.

> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>   builtin/mailsplit.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 06296d4..b499014 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -93,8 +93,6 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
>   	return status;
>
>    corrupt:
> -	if (output)
> -		fclose(output);
>   	unlink(name);
>   	fprintf(stderr, "corrupt mailbox\n");
>   	exit(1);
>
