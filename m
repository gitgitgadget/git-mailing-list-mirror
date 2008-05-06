From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 3/3] log and rev-list: add --graph option
Date: Tue, 6 May 2008 00:01:36 -0700
Message-ID: <20080506070135.GA24803@adamsimpkins.net>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net> <1209897414-10091-2-git-send-email-adam@adamsimpkins.net> <1209897414-10091-3-git-send-email-adam@adamsimpkins.net> <1209897414-10091-4-git-send-email-adam@adamsimpkins.net> <7vtzhcgci1.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 09:02:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtHC4-0001Gk-PG
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 09:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYEFHBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 03:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYEFHBo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 03:01:44 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:56468 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYEFHBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 03:01:44 -0400
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 9B5E21B6B2E;
	Tue,  6 May 2008 03:01:39 -0400 (EDT)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 776861B6AE3;
	Tue,  6 May 2008 03:01:39 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 2334F14100C2; Tue,  6 May 2008 00:01:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtzhcgci1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81341>

On Mon, May 05, 2008 at 11:41:58PM -0700, Junio C Hamano wrote:
> Adam Simpkins <adam@adamsimpkins.net> writes:
> 
> > diff --git a/builtin-rev-list.c b/builtin-rev-list.c
> > index 476a870..f868290 100644
> > --- a/builtin-rev-list.c
> > +++ b/builtin-rev-list.c
> > ...
> > @@ -96,9 +98,50 @@ static void show_commit(struct commit *commit)
> >  		pretty_print_commit(revs.commit_format, commit,
> >  				    &buf, revs.abbrev, NULL, NULL,
> >  				    revs.date_mode, 0);
> > -		if (buf.len)
> > -			printf("%s%c", buf.buf, hdr_termination);
> > +		if (revs.graph) {
> > ...
> > +		} else {
> > +			if (buf.len) {
> > +				fwrite(buf.buf, sizeof(char), buf.len, stdout);
> > +				putchar('\n');
> 
> Now hdr_termination can never be NUL, iow you broke "rev-list -v -z"?

Whoops.  Sorry about that.  I didn't notice the "-v" option.

(BTW, I don't think the "-z" option comes into play here.  Just
"rev-list -v" by itself results in a NUL character after each entry
instead of a newline.)

> I'll squash in a minimum fix, because otherwise this breaks existing
> tests.

Thanks!

-- 
Adam Simpkins
adam@adamsimpkins.net
