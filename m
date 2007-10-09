From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-config: handle --file option with relative pathname
 properly
Date: Tue, 09 Oct 2007 15:20:36 +0200
Message-ID: <470B8024.2050106@viscovery.net>
References: <20071009124932.1184.qmail@395d4a80f3eafd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfF10-00016O-7n
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbXJINUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbXJINUk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:20:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23857 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbXJINUk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:20:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfF0g-0006ho-2I; Tue, 09 Oct 2007 15:20:30 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4DF0569F; Tue,  9 Oct 2007 15:20:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071009124932.1184.qmail@395d4a80f3eafd.315fe32.mid.smarden.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60410>

Gerrit Pape schrieb:
> @@ -189,7 +189,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
>  			if (argc < 3)
>  				usage(git_config_set_usage);
> -			setenv(CONFIG_ENVIRONMENT, argv[2], 1);
> +			if (argv[2][0] == '/')

Please use is_absolute_path() here.

> +				name = argv[2];
> +			else
> +				name = name ? prefix_filename(name, strlen(name), argv[2]) : argv[2];

Can't you avoid this ternary here? There's already an 'if' with the same 
'else' branch.

> +			setenv(CONFIG_ENVIRONMENT, name, 1);
>  			argc--;
>  			argv++;
>  		}

-- Hannes
