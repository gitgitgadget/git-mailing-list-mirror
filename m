From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Tue, 4 Mar 2008 15:09:31 +0100
Message-ID: <20080304140930.GA23335@pvv.org>
References: <200803041459.29000.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 15:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYQ1-0001LE-8Z
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 15:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbYCDOqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 09:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbYCDOqW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 09:46:22 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:38018 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbYCDOqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 09:46:21 -0500
X-Greylist: delayed 2209 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2008 09:46:21 EST
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1JWXpj-0000GH-7q; Tue, 04 Mar 2008 15:09:31 +0100
Content-Disposition: inline
In-Reply-To: <200803041459.29000.michal.rokos@nextsoft.cz>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76091>

On Tue, Mar 04, 2008 at 02:59:28PM +0100, Michal Rokos wrote:

> +	while ( ret == -1 )
> +	{
> +		maxsize = (maxsize*3)/2;
> +		s = realloc(s, maxsize);
> +		if (! s) return -1;
> +		ret = vsnprintf(s, maxsize, format, ap);  /* <--- UNSAFE! */
> +	}

This is not generally safe, you cannot call vsnprintf multiple times
with the same ap on all architectures. You need va_copy (or __va_copy,
or VA_COPY, differs a bit between different architectures, especially
one the ones with a broken vsnprintf I guess..)

- Finn Arne
