From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 2/2] read-tree: migrate to parse-options
Date: Thu, 25 Jun 2009 08:55:26 +0200
Message-ID: <4A431F5E.6070109@viscovery.net>
References: <1245817672-25483-2-git-send-email-bebarino@gmail.com> <1245906361-20644-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 08:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJis5-0002ry-29
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 08:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbZFYGzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 02:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZFYGzd
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 02:55:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56643 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbZFYGzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 02:55:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MJirn-0001NM-2i; Thu, 25 Jun 2009 08:55:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 690E555DD; Thu, 25 Jun 2009 08:55:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1245906361-20644-1-git-send-email-bebarino@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122181>

Stephen Boyd schrieb:
> @@ -8,7 +8,10 @@ git-read-tree - Reads tree information into the index
>  
>  SYNOPSIS
>  --------
> -'git read-tree' (<tree-ish> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
> +'git read-tree' [--index-output=<file>] <treeish>
> +'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
> +		[-u [--exclude-per-directory=<gitignore>] | -i]]
> +		[--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]

Multi-line synopsis must begin with [verse].

If you write more than one mode of operation, the subsequent text should
better reference them, but the current text does not do that. I think it
is OK if you leave only the second, particularly because the first is only
a subset of the second.

> +	opts.update = update ? 1 : 0;
> +	opts.index_only = index_only ? 1 : 0;
> +	opts.trivial_merges_only = trivial_merges_only ? 1 : 0;
> +	opts.aggressive = aggressive ? 1 : 0;
> +	opts.verbose_update = verbose ? 1 : 0;
> +	opts.reset = reset ? 1 : 0;
> +	stage = opts.merge = (reset || merge || prefix_set) ? 1 : 0;

I don't think that the bitfields of struct unpack_trees_options are cast
in stone. IMHO it is fine to make them regular struct members, so that you
can take their address for read_tree_options and these foo ? 1 : 0 become
unnecessary.

-- Hannes
