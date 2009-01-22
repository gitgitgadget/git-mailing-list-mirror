From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3 2/3] sha1_file: prepare for adding alternates on
 demand
Date: Fri, 23 Jan 2009 00:43:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901230041500.3586@pacific.mpi-cbg.de>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com> <1232659071-14401-2-git-send-email-hjemli@gmail.com> <1232659071-14401-3-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:44:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ9EC-0003vu-Er
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760018AbZAVXnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 18:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759993AbZAVXnX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:43:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:41957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759732AbZAVXnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:43:21 -0500
Received: (qmail invoked by alias); 22 Jan 2009 23:43:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 23 Jan 2009 00:43:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uPnM7okquNlbYTPyX08F8YVY1T4bTwuu08KeH72
	JBO4kBa0WpPMj3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232659071-14401-3-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106803>

Hi,

On Thu, 22 Jan 2009, Lars Hjemli wrote:

> @@ -285,9 +286,10 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
>  
>  	/* Detect cases where alternate disappeared */
>  	if (!is_directory(ent->base)) {
> -		error("object directory %s does not exist; "
> -		      "check .git/objects/info/alternates.",
> -		      ent->base);
> +		if (!quiet)
> +			error("object directory %s does not exist; "
> +			      "check .git/objects/info/alternates.",
> +			      ent->base);
>  		free(ent);
>  		return -1;
>  	}
> [...]
> @@ -2573,3 +2579,11 @@ int read_pack_header(int fd, struct pack_header *header)
>  		return PH_ERROR_PROTOCOL;
>  	return 0;
>  }
> +
> +int add_alt_odb(char *path, int quiet)
> +{
> +	int err = link_alt_odb_entry(path, strlen(path), NULL, 0, quiet);
> +	if (!err)
> +		prepare_packed_git_one(path, 0);
> +	return err;
> +}

FWIW my concern is not at all addressed.  A future user of add_alt_odb() 
(and possibly your users in rare cases, too) can trigger the error that 
suggests looking into the alternates.  Leaving the human user puzzled.

Ciao,
Dscho
