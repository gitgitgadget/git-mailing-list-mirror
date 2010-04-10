From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] wt-status: collect ignored files
Date: Sat, 10 Apr 2010 03:48:14 -0400
Message-ID: <20100410074814.GB12567@coredump.intra.peff.net>
References: <1270885256-31589-1-git-send-email-gitster@pobox.com>
 <1270885256-31589-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 09:48:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VQp-0004Pt-4E
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab0DJHsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:48:38 -0400
Received: from peff.net ([208.65.91.99]:56375 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab0DJHsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:48:37 -0400
Received: (qmail 16959 invoked by uid 107); 10 Apr 2010 07:48:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 03:48:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 03:48:14 -0400
Content-Disposition: inline
In-Reply-To: <1270885256-31589-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144530>

On Sat, Apr 10, 2010 at 12:40:54AM -0700, Junio C Hamano wrote:

> +	if (s->show_ignored_files) {
> +		dir.nr = 0;
> +		dir.flags = DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
> +		fill_directory(&dir, s->pathspec);
> +		for (i = 0; i < dir.nr; i++) {
> +			struct dir_entry *ent = dir.entries[i];
> +			if (!cache_name_is_other(ent->name, ent->len))
> +				continue;
> +			if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
> +				continue;
> +			string_list_insert(ent->name, &s->ignored);
> +			free(ent);
> +		}
> +	}
> +

Why not use DIR_COLLECT_IGNORED, which would mean we only have to
traverse the directory tree once?

-Peff
