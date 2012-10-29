From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Teach rm to remove submodules when given with a trailing
 '/'
Date: Mon, 29 Oct 2012 08:11:01 +0100
Message-ID: <508E2C05.9010109@viscovery.net>
References: <508DBF92.9090200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:11:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjVH-00073u-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab2J2HLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 03:11:06 -0400
Received: from so.liwest.at ([212.33.55.24]:47607 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab2J2HLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:11:05 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TSjV0-0007N6-6o; Mon, 29 Oct 2012 08:11:02 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F26021660F;
	Mon, 29 Oct 2012 08:11:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <508DBF92.9090200@web.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208596>

Am 10/29/2012 0:28, schrieb Jens Lehmann:
> +	/* Remove trailing '/' from directories to find submodules in the index */
> +	for (i = 0; i < argc; i++) {
> +		size_t pathlen = strlen(argv[i]);
> +		if (pathlen && is_directory(argv[i]) && (argv[i][pathlen - 1] == '/'))
> +			argv[i] = xmemdupz(argv[i], pathlen - 1);
> +	}
> +
>  	pathspec = get_pathspec(prefix, argv);
>  	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);

That's wrong: Either move the check below get_pathspec() (which normalizes
backslashes to forward-slashes on Windows) or use is_dir_sep().

But isn't it somewhat dangerous to check pathspec for existance in the
worktree without interpreting them? Think of magic pathspec syntax (that
we do not have yet, but which may materialize sometime in the future).

-- Hannes
