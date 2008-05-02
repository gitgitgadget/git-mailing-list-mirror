From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Fri, 2 May 2008 08:45:33 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 09:46:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrpy3-0007pn-Ng
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 09:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbYEBHpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 03:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbYEBHpT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 03:45:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:41481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755224AbYEBHpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 03:45:18 -0400
Received: (qmail invoked by alias); 02 May 2008 07:45:16 -0000
Received: from R595c.r.pppool.de (EHLO eeepc-johanness.samsung.router) [89.54.89.92]
  by mail.gmx.net (mp044) with SMTP; 02 May 2008 09:45:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dftsC21gdPjVRtgTblNNYFkngxUJZNaGSdOIW7b
	T6xGF/bUuDgBB/
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80966>

Hi,

On Fri, 2 May 2008, Ping Yin wrote:

> Previously --color-words only allow spaces as words boundary. However, 
> just space is not enough. For example, when i rename a function from foo 
> to bar, following example doesn't show as expected when using 
> --color-words.

Thanks for starting this.

However, as Junio pointed out, it is easier to specify word-characters, 
rather than non-word characters (think TAB), and...

> +static int iswordsboundary(char c)
> +{
> +	return isspace(c) || !!strchr(diff_words_boundary, c);
> +}

this will be called quite some times.  So it would make more sense to have 
an "unsigned char word_characters[256]" and set those entries to 1 that 
are to be interpreted as word characters.

This would allow you also to interpret "0-9A-Za-z" correctly.

Oh, and maybe having "::default" and "::alnum" suffixes interpreted, so 
that I can say "_::alnum" to have C identifiers interpreted as words?

Thanks,
Dscho
