From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] Teach fast-import to print the id of each imported
 commit
Date: Tue, 12 Oct 2010 17:06:25 -0500
Message-ID: <20101012220625.GA15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 00:10:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5n2i-0001io-K0
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab0JLWJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 18:09:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57229 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab0JLWJt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 18:09:49 -0400
Received: by qyk5 with SMTP id 5so1020110qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ck1iS2jsPzogf14vzQh/2ILcMSuXKXWWGPS7x3PhW64=;
        b=HHCxJwGDSUh2vvsd1nwOVZvLURV/z8nxO5f4IRqvoLNREFECDkmgYjiY14ZMyifjTh
         JOJ9h0UXy2ZvtpE5yxMFPm30+ICHJuhDHajl8bsrd1AEWpcGocRBzdWb7VW72m0QWLAL
         gFcPzbLeZnMyuErcqgJ3PR0ADWpq4hIjoET3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KTAfk/+qauhYi4re5xF1m5zxLXNjc04ffP4ui4+082CC22lmKJzFsNbX1mVvKM/Q4O
         fTvMi9phLb4I96yKOSu85i9GbZbizOdZLyx1qfFkPbRbFBQ42TAnkatiqvdUnWxhueCm
         xwz0zXXTAM3P8+ycevD5dfwmwPQB2wgZS/IAQ=
Received: by 10.224.74.1 with SMTP id s1mr25516qaj.195.1286921388545;
        Tue, 12 Oct 2010 15:09:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x9sm2951994qco.10.2010.10.12.15.09.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 15:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158883>

David Barr wrote:

> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -92,6 +92,18 @@ OPTIONS
>  	--(no-)-relative-marks= with the --(import|export)-marks=
>  	options.
>  
> +--report-fd=<fd>::
> +	Print the 40-character object name for each commit to
> +	the specified file descriptor before writing it to the
> +	pack.

This aspect (the printing of commit ids) of the report-fd feature is
not used by the current svn-fe3 code.  I'd suggest dropping it or at
least making it optional; marks work pretty well for that purpose and
it is not worth the cost or complication of making the frontend
synchronize with fast-import with every commit.

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -361,6 +361,9 @@ static uintmax_t next_mark;
>  static struct strbuf new_data = STRBUF_INIT;
>  static int seen_data_command;
>  
> +/* Where to report commits */
> +static int report_fd = -1;

This aspect is still useful (for use by the cat command). :)

Thanks.
