From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] rev list add option accepting revision constraints on standard input
Date: Tue, 05 Sep 2006 15:10:54 -0700
Message-ID: <7vpseaarrl.fsf@assigned-by-dhcp.cox.net>
References: <44FDECD1.2090909@shadowen.org>
	<20060905215157.GA29172@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 00:11:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKj8d-0004m9-7g
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWIEWK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWIEWK5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 18:10:57 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17297 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965201AbWIEWKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 18:10:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905221055.TRJC4015.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 18:10:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JmAv1V00x1kojtg0000000
	Tue, 05 Sep 2006 18:10:56 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060905215157.GA29172@shadowen.org> (Andy Whitcroft's message
	of "Tue, 5 Sep 2006 22:51:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26494>

Andy Whitcroft <apw@shadowen.org> writes:

> Add a --stdin flag which causes rev-list to additionally read
> its stdin stream and parse that for revision constraints.

> +/*
> + * Parse revision information, filling in the "rev_info" structure,
> + * revisions are taken from stream.
> + */
> +static void setup_revisions_stream(FILE *stream, struct rev_info *revs)
> +{
> +	char line[1000];
> +	const char *args[] = { 0, line, 0 };
> +
> +	while (fgets(line, sizeof(line), stream) != NULL) {
> +		line[strlen(line) - 1] = 0;
> +
> +		if (line[0] == '-')
> +			die("options not supported in --stdin mode");
> +
> +		(void)setup_revisions(2, args, revs, NULL);
> +	}
> +}

Is calling setup_revisions() on the same revs like this many
times safe?  I do not think so, especially what is after the
primary "for()" loop in the function.

I was sort-of expecting that you would instead replace that
primary for() loop in setup_revisions() with some sort of
callback...
