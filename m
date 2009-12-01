From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 6/8] Remove special casing of http, https and ftp
Date: Tue, 1 Dec 2009 10:24:14 -0800
Message-ID: <20091201182414.GK21299@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259675838-14692-7-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXOh-0004TX-EH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbZLASYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZLASYM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:24:12 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:64391 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbZLASYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 13:24:11 -0500
Received: by ywh12 with SMTP id 12so5442509ywh.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:24:17 -0800 (PST)
Received: by 10.101.137.14 with SMTP id p14mr2703631ann.174.1259691857504;
        Tue, 01 Dec 2009 10:24:17 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm156210yxg.46.2009.12.01.10.24.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 10:24:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259675838-14692-7-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134242>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> HTTP, HTTPS and FTP are no longer special to transport code. Also
> add support for FTPS (curl supports it so it is easy).
...
> diff --git a/Makefile b/Makefile
> index 42744a4..be0be87 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1676,7 +1676,19 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
>  
> -git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
> +git-remote-http$X: remote-curl.o http.o http-walker.o $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +
> +git-remote-https$X: remote-curl.o http.o http-walker.o $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +
> +git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +
> +git-remote-ftps$X: remote-curl.o http.o http-walker.o $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)

These should all be hardlinks to a single executable, not duplicate
relinks of the same object files.
  
-- 
Shawn.
