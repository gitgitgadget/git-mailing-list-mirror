From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] remote show: fix the -n option
Date: Mon, 9 Jun 2008 17:35:13 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806091733230.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5kN6-0003ft-JW
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 18:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbYFIQgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 12:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbYFIQgf
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 12:36:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:51573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751024AbYFIQge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 12:36:34 -0400
Received: (qmail invoked by alias); 09 Jun 2008 16:36:32 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 09 Jun 2008 18:36:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hYdx1L/8hiXa3tKOatbnxEPP88HYLO+NSZ5zQKa
	AXj0H5hM7n21E/
X-X-Sender: gene099@racer
In-Reply-To: <484D5322.6050309@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84400>

Hi,

On Mon, 9 Jun 2008, Olivier Marin wrote:

> diff --git a/builtin-remote.c b/builtin-remote.c
> index c49f00f..efe74c7 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -421,10 +421,10 @@ static void show_list(const char *title, struct path_list *list)
>  
>  static int show_or_prune(int argc, const char **argv, int prune)
>  {
> -	int dry_run = 0, result = 0;
> +	int no_query = 0, result = 0;

Just for the record (not that I think anybody will care): I do not like 
this change.

> @@ -442,21 +442,23 @@ static int show_or_prune(int argc, const char **argv, int prune)
>  		struct transport *transport;
>  		const struct ref *ref;
>  		struct strbuf buf;
> -		int i, got_states;
> +		int i;
>  
>  		states.remote = remote_get(*argv);
>  		if (!states.remote)
>  			return error("No such remote: %s", *argv);
> -		transport = transport_get(NULL, states.remote->url_nr > 0 ?
> -			states.remote->url[0] : NULL);
> -		ref = transport_get_remote_refs(transport);
> -		transport_disconnect(transport);
>  
>  		read_branches();
> -		got_states = get_ref_states(ref, &states);
> -		if (got_states)
> -			result = error("Error getting local info for '%s'",
> -					states.remote->name);

And I do not like this change either.  It proliferates the "we just die() 
and do not care about reusing the code where die()ing is not desired" 
paradigm.

Sad,
Dscho
