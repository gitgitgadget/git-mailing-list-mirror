From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] Allow helpers to report in "list" command that
 the ref is unchanged
Date: Wed, 5 Aug 2009 23:03:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052258440.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050056000.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYndu-0002Xx-8L
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbZHEVDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZHEVDS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:03:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:42354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751095AbZHEVDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:03:18 -0400
Received: (qmail invoked by alias); 05 Aug 2009 21:03:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 05 Aug 2009 23:03:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fySoGOMzfTcIDxk4vm8tzAJQe96nWm5rMyDQXZZ
	s3fcKPbP/26NeG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908050056000.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124983>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> +			if (strstr(eon + 1, "unchanged")) {

I guess we'll want to have a helper like this already:

	static int has_attribute(const char *tail, const char *attr) {
		int len;

		if (!tail)
			return 0;

		len = strlen(attr);
		for (;;) {
			const char *space = strchrnul(tail, ' ');
			if (len == space - tail && !strncmp(tail, attr, len))
				return 1;
			if (!*space)
				return 0;
			tail = space + 1;
		}
	}

This guards against attributes that are substrings of other attributes.  
(You want to future-proof the attributes system, after all, i.e. handle 
helpers returning attributes unknown to the current Git.)

Ciao,
Dscho
