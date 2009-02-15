X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] config: Disallow multiple config file locations.
Date: Sun, 15 Feb 2009 13:26:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151324530.10279@pacific.mpi-cbg.de>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 15 Feb 2009 12:26:01 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nahdsCYZnGhBJs17gEJvrg8lx62bRWuVFH2QdmX
	0cKrXsW2lMYOB7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1LYg5U-0006lQ-1F for gcvg-git-2@gmane.org; Sun, 15 Feb 2009
 13:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753518AbZBOMZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009
 07:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbZBOMZk
 (ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:25:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:40978 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753326AbZBOMZk
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 07:25:40 -0500
Received: (qmail invoked by alias); 15 Feb 2009 12:25:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by
 mail.gmx.net (mp069) with SMTP; 15 Feb 2009 13:25:38 +0100
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 15 Feb 2009, Felipe Contreras wrote:

> Either --global, --system, or --file should be used, but not any
> combination.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin-config.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-config.c b/builtin-config.c
> index 83f8b74..e744ad8 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -314,6 +314,16 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
>  
>  	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
>  
> +	{
> +		int config_file_count = use_global_config + use_system_config;
> +		if (given_config_file)
> +			config_file_count++;
> +		if (config_file_count > 1) {
> +			error("only one config file at a time.");
> +			usage_with_options(builtin_config_usage, builtin_config_options);
> +		}
> +	}

Hmm.  Is this a convoluted way to write

	if (use_global_config + use_system_config + !!given_config_file > 1)

or am I misunderstanding anything?

Ciao,
Dscho
