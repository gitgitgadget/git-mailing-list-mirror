From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-config: print error message if the config file cannot
 be read
Date: Tue, 09 Oct 2007 15:30:46 +0200
Message-ID: <470B8286.5060006@viscovery.net>
References: <20071009125102.1305.qmail@054bd0fc8effa5.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfFAq-000375-QB
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXJINav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbXJINau
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:30:50 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40912 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbXJINau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:30:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfFAW-0001Ai-Ne; Tue, 09 Oct 2007 15:30:41 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F261F69F; Tue,  9 Oct 2007 15:30:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071009125102.1305.qmail@054bd0fc8effa5.315fe32.mid.smarden.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60412>

Gerrit Pape schrieb:
> @@ -235,8 +235,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		argv++;
>  	}
>  
> -	if (show_all)
> -		return git_config(show_all_config);
> +	if (show_all) {
> +		if (git_config(show_all_config) == -1)
> +			die("unable to read config file %s: %s",
> +			    getenv(CONFIG_ENVIRONMENT), strerror(errno));

I don't think that this works well: If there are no config files at all, 
then we don't want to see an error - just as if the config file were empty.

Also, I don't think that errno is reliable at this point.

You probably want to see an error message *only* if you have supplied a file 
name with --file.

-- Hannes
