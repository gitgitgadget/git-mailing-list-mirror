From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/12] merge.conflictstyle: choose between "merge" and
 "diff3 -m" styles
Date: Sat, 30 Aug 2008 11:42:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808301141160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <1220056963-2352-2-git-send-email-gitster@pobox.com> <1220056963-2352-3-git-send-email-gitster@pobox.com> <1220056963-2352-4-git-send-email-gitster@pobox.com> <1220056963-2352-5-git-send-email-gitster@pobox.com>
 <1220056963-2352-6-git-send-email-gitster@pobox.com> <1220056963-2352-7-git-send-email-gitster@pobox.com> <1220056963-2352-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:38:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMuI-0006xO-Mt
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYH3JhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 05:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbYH3JhF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:37:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:35768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753400AbYH3JhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:37:04 -0400
Received: (qmail invoked by alias); 30 Aug 2008 09:37:01 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 30 Aug 2008 11:37:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jZd8kgJ1jnbj5rfItha4/207Z0TYkI6EjIyzR3a
	l9odm5IdcO9kRP
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1220056963-2352-8-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94368>

Hi,

On Fri, 29 Aug 2008, Junio C Hamano wrote:

> diff --git a/builtin-merge-file.c b/builtin-merge-file.c
> index 1e92510..f009e73 100644
> --- a/builtin-merge-file.c
> +++ b/builtin-merge-file.c
> @@ -15,6 +15,15 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  	int ret = 0, i = 0, to_stdout = 0;
>  	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
>  	int merge_style = 0;
> +	int nongit;
> +
> +	prefix = setup_git_directory_gently(&nongit);
> +	if (!nongit) {
> +		/* Read the configuration file */
> +		git_config(git_xmerge_config, NULL);
> +		if (git_xmerge_style > 0)
> +			merge_style = git_xmerge_style;

Did you not mean ">="?  In the future, the default merge style could very 
well change...

Ciao,
Dscho
