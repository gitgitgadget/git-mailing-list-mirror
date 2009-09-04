From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/8] Use a clearer style to issue commands to remote
 helpers
Date: Fri, 4 Sep 2009 12:40:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041236290.4605@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0909032213200.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:40:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWDK-0007gq-4U
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933595AbZIDKkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933437AbZIDKkH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:40:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:45170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756650AbZIDKkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:40:06 -0400
Received: (qmail invoked by alias); 04 Sep 2009 10:40:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 04 Sep 2009 12:40:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lmWANnTRlEUjStVHUtmmP9Qyhd7n1AJCIvt0saT
	iBx8rmTkxHsJm/
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.2.00.0909032213200.28290@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127707>

Hi,

On Thu, 3 Sep 2009, Daniel Barkalow wrote:

> This style is overkill for some commands, but it's worthwhile to use
> the same style to issue all commands, and it's useful to avoid
> open-coding string lengths.

Why do I have to study the patch to find out what "this style" is?  And 
why do you not even _try_ to convince people that "it's worthwhile", say, 
by giving some example?

> 
> diff --git a/transport-helper.c b/transport-helper.c
> index 4684877..b1ea7e6 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -37,7 +37,10 @@ static struct child_process *get_helper(struct transport *transport)
>  		die("Unable to run helper: git %s", helper->argv[0]);
>  	data->helper = helper;
>  
> -	write_in_full(data->helper->in, "capabilities\n", 13);
> +	strbuf_addstr(&buf, "capabilities\n");
> +	write_in_full(helper->in, buf.buf, buf.len);
> +	strbuf_reset(&buf);
> +

If you use that paradigm more often, why not rather introduce something 
like

	void strbuf_flush(struct strbuf *buf, int fd) {
		write_in_full(fd, buf->buf, buf->len);
		strbuf_reset(buf);
	}

instead of violating the DRY principle?

Ciao,
Dscho
