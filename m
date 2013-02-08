From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/6] graph: output padding for merge subsequent parents
Date: Fri, 8 Feb 2013 19:31:26 +0000
Message-ID: <20130208193026.GA1024@river>
References: <cover.1360267849.git.john@keeping.me.uk>
 <b98eb2bfe2b022ddf1afbe9f7123accfe068e8c9.1360267849.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Dale R. Worley" <worley@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:32:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3tg6-00009t-95
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 20:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760481Ab3BHTbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 14:31:44 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:38553 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760434Ab3BHTbn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 14:31:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D7630CDA57C;
	Fri,  8 Feb 2013 19:31:42 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RD3-kcpq9sAK; Fri,  8 Feb 2013 19:31:42 +0000 (GMT)
Received: from river (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 17B60CDA330;
	Fri,  8 Feb 2013 19:31:31 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <b98eb2bfe2b022ddf1afbe9f7123accfe068e8c9.1360267849.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215805>

[Moved from the thread where this was initially posted to reply to the
series.]

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> This works, but if we know we're not going to enter the while loop, it
> seams even easier to do this:
> 
> --- a/graph.c
> +++ b/graph.c
> @@ -1227,7 +1227,17 @@ void graph_show_commit(struct git_graph *graph)
>         if (!graph)
>                 return;
>  
> -       while (!shown_commit_line && !graph_is_commit_finished(graph)) {
> +       /*
> +        * When showing a diff of a merge against each of its parents, we
> +        * are called once for each parent without graph_update having been
> +        * called.  In this case, simply output a single padding line.
> +        */
> +       if (graph_is_commit_finished(graph)) {
> +               graph_show_padding(graph);
> +               return;
> +       }
> +
> +       while (!shown_commit_line) {

This looks good to me.  I'll amend locally and re-send in a few days
after giving others a chance to comment.


John
