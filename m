From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 10:21:16 +0200
Message-ID: <471868FC.20409@viscovery.net>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iin6x-0007gz-AK
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbXJSIVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbXJSIVX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:21:23 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40614 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbXJSIVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:21:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iin6O-0006PN-I4; Fri, 19 Oct 2007 10:21:04 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DDB6A546; Fri, 19 Oct 2007 10:21:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20071019073938.GN14735@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61672>

Shawn O. Pearce schrieb:
> $ git fetch jc
> ...
> ==> git://repo.or.cz/alt-git.git
>  * tag junio-gpg-pub ......................... (new)
>  * tag v1.5.0 .......................... (tag moved)
> 
> $ git fetch me
> ...
> ==> git://repo.or.cz/git/spearce.git
>  * branch gitk -> spearce/gitk ............... (new)
>  * branch maint -> spearce/maint
>  * branch master -> spearce/master
>  * branch next -> spearce/next
>  * branch pu -> spearce/pu ......... (forced update)
>  * branch todo -> spearce/todo ............... (new)
> 
> The width of the terminal is computed to produce the ... padding.

I like the wording of the status tags.

But the padding does not convince me. How does this look on very wide
terminals? Maybe use 80 as a maximum?

> +		if (ws_cols) {
> +			size_t n = strlen(status) + strlen(remote_name) + 2;
> +			if (op)
> +				n += 1 + strlen(op);
> +			if (local_name)
> +				n += 1 + strlen(local_name);
> +			n = ws_cols - n - strlen(reason) - 4;
> +			fputc(' ', stderr);
> +			while (n--)
> +				fputc('.', stderr);

			while (n-- > 0)

otherwise you're screwed if your terminal is too narrow.

> +static void determine_window_size(void)
> +{

#ifdef TIOCGWINSZ

> +	struct winsize ws;
> +	if (!ioctl(2, TIOCGWINSZ, &ws))
> +		ws_cols = ws.ws_col;

#endif

> +}

Pretty please. We don't have TIOCGWINSZ on Windows.

-- Hannes
