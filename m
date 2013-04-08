From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: [PATCH 1/2] bundle: Accept prerequisites without commit messages
Date: Mon, 8 Apr 2013 11:53:03 +0200
Message-ID: <20130408095303.GA10392@blizzard>
References: <1365335596-19917-1-git-send-email-git@cryptocrack.de>
 <7va9pa5k9u.fsf@alter.siamese.dyndns.org>
 <20130408010610.GB24030@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:25:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEsN-0003oz-E9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936014Ab3DHJxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 05:53:10 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:4384 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935977Ab3DHJxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 05:53:08 -0400
Received: from localhost (p57B41489.dip.t-dialin.net [87.180.20.137])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 519e5ee4
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Mon, 8 Apr 2013 11:53:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130408010610.GB24030@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220412>

On Sun, Apr 07, 2013 at 09:06:10PM -0400, Jeff King wrote:
> On Sun, Apr 07, 2013 at 10:21:33AM -0700, Junio C Hamano wrote:
> 
> > As to the order of comparison to match the order on the number line,
> > e.g. write "0 < something" or "negative < 0" to let readers more
> > easily visualize in what relation on the number line the quantity of
> > each side of the comparison stands, here is a reference to a long
> > and amusing thread:
> > 
> >   http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=3912
> 
> I do not necessarily agree with the "always use less-than" style, but as
> a reviewer of this series, it took me an extra minute to figure out what
> was going on because two things changed. If the diff instead looked
> like:
> 
> diff --git a/bundle.c b/bundle.c
> index 505e07e..a9c1335 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -57,7 +57,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
>  		 * followed by SP and subject line.
>  		 */
>  		if (get_sha1_hex(buf.buf, sha1) ||
> -		    (40 <= buf.len && !isspace(buf.buf[40])) ||
> +		    (40 < buf.len && !isspace(buf.buf[40])) ||
>  		    (!is_prereq && buf.len <= 40)) {
>  			if (report_path)
>  				error(_("unrecognized header: %s%s (%d)"),
> 
> then it is immediately obvious that we are only impacting the case where
> buf.len is exactly 40 (and it is even more obvious if you happen to use
> the diff-highlight script, which highlights the single changed
> character).

I changed it for the very same reason -- it took me an extra minute to
figure out what is going on when trying to pinpoint the bug (it was
especially weird since we use "40 <= buf.len" here and "buf.len <= 40"
one line below -- which kind of makes sense now, though). Thanks for the
review (and merging), I won't change operand order in future patches :)

> 
> Just my two cents as a reader of the patch. Other than that, it looks
> correct to me. :)
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
