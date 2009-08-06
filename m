From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: surprising error message in parse_opt_with_commit
Date: Thu, 6 Aug 2009 12:34:14 -0700
Message-ID: <20090806193413.GJ1033@spearce.org>
References: <e1a5e9a00908061227n67a878f5tb2d5130582b4fd44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:34:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8jI-0002lt-5u
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555AbZHFTeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756548AbZHFTeN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:34:13 -0400
Received: from george.spearce.org ([209.20.77.23]:36241 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbZHFTeN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:34:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 31F07381FD; Thu,  6 Aug 2009 19:34:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <e1a5e9a00908061227n67a878f5tb2d5130582b4fd44@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125112>

Tim Harper <timcharper@gmail.com> wrote:
>  610 int parse_opt_with_commit(const struct option *opt, const char
> *arg, int unset)
>  611 {
>  612 	unsigned char sha1[20];
>  613 	struct commit *commit;
>  614
>  615 	if (!arg)
>  616 		return -1;
>  617 	if (get_sha1(arg, sha1))
>  618 		return error("malformed object name %s", arg);
>  619 	commit = lookup_commit_reference(sha1);
>  620 	if (!commit)
>  621 		return error("no such commit %s", arg);
>  622 	commit_list_insert(commit, opt->value);
>  623 	return 0;
>  624 }
> 
> It appears the get_sha1 call is returning true, causing the 'malformed
> object name' error to be returned.  However, it seems that ideally
> since efabdfb is not malformed (it would be a valid ref if it
> existed), the execution path should continue to line 619, receive no
> commit, and fail on 621.

get_sha1 is responsible for expanding an abbreviated ID to the
full ID.  If it can't do the expansion, it errors out.  The code
is correct as-is, though the error message on 618 is a bit odd.

-- 
Shawn.
