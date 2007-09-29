From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] --color and --no-color git-log options don't need diffs to be computed.
Date: Sat, 29 Sep 2007 10:02:47 -0700
Message-ID: <7v4phdl808.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
	<20070929123724.01BB045EC@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 19:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibfib-0007vL-R9
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 19:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbXI2RC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 13:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756215AbXI2RC6
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 13:02:58 -0400
Received: from rune.pobox.com ([208.210.124.79]:36554 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbXI2RC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 13:02:58 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C5C4B13DDD0;
	Sat, 29 Sep 2007 13:03:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D9E0313DCB4;
	Sat, 29 Sep 2007 13:03:16 -0400 (EDT)
In-Reply-To: <20070929123724.01BB045EC@madism.org> (Pierre Habouzit's message
	of "Sat, 29 Sep 2007 14:35:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59480>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>  revision.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 33d092c..0dee835 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1209,8 +1209,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  
>  			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
>  			if (opts > 0) {
> -				if (strcmp(argv[i], "-z"))
> -					revs->diff = 1;
> +				revs->diff = strcmp(argv[i], "-z")
> +					&& strcmp(argv[i], "--color")
> +					&& strcmp(argv[i], "--no-color");
>  				i += opts - 1;
>  				continue;
>  			}

Aside from the "don't override the option that is already set"
comment from David, I am somewhat unhappy that this piece
already knows too much about which option to diff potentially
changes the output (but not commits us to produce the diff) and
which option causes us to actually produce output.
