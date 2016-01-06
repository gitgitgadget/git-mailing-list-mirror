From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] interpret-trailers: add option for in-place editing
Date: Wed, 6 Jan 2016 15:36:36 +0100
Message-ID: <20160106143635.GI29125@distanz.ch>
References: <1452087258-3893-1-git-send-email-tobias.klauser@zhinst.com>
 <vpqoacylri6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tobias Klauser <tobias.klauser@zhinst.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 06 15:46:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGpMF-0005VA-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 15:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbcAFOqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 09:46:36 -0500
Received: from sym2.noone.org ([178.63.92.236]:55683 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbcAFOqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 09:46:35 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2016 09:46:34 EST
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3pbCtt2LzfzQWhG; Wed,  6 Jan 2016 15:36:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <vpqoacylri6.fsf@anie.imag.fr>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283447>

Thanks for your feedback Matthieu!

On 2016-01-06 at 15:19:45 +0100, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Tobias Klauser <tobias.klauser@zhinst.com> writes:
> 
> > From: Tobias Klauser <tklauser@distanz.ch>
> >
> > Add a command line option --in-place to support in-place editing akin to
> > sed -i.  This allows to write commands like the following:
> 
> Since -i is a common shortcut for --in-place (perl -i, sed -i), it
> probably makes sense to have it here too. OTOH, this is meant for
> scripting and perhaps it's best to force script writters to be verbose.

Yes, I thought this would mainly be used in scripts and thus omitted the
short option.

> > Also add the corresponding documentation and tests.
> 
> This sentence does not harm, but I personnally don't think it's really
> helpfull, as it's already clear by the diffstat right below, and the
> patch itself.

Ok, I can omit it for v2.

> > -static void print_tok_val(const char *tok, const char *val)
> > +static void print_tok_val(FILE *fp, const char *tok, const char *val)
> >  {
> >  	char c = last_non_space_char(tok);
> >  	if (!c)
> >  		return;
> >  	if (strchr(separators, c))
> > -		printf("%s%s\n", tok, val);
> > +		fprintf(fp, "%s%s\n", tok, val);
> >  	else
> > -		printf("%s%c %s\n", tok, separators[0], val);
> > +		fprintf(fp, "%s%c %s\n", tok, separators[0], val);
> >  }
> 
> The patch would be even easier to read if split into a preparatory
> refactoring patch "turn printf into fprintf" and then the actual one.
> But it's already rather clear, so you can probably leave it as-is.

Ok. I have also no problem with splitting it. I'll wait for a feedback
from Junio on what he prefers.

> > -static void print_lines(struct strbuf **lines, int start, int end)
> > +static void print_lines(FILE *fp, struct strbuf **lines, int start, int end)
> 
> Here and below: it would probably be more readable with a more explicit
> name for fp, like "outfile". Especially here:
> 
> > -static int process_input_file(struct strbuf **lines,
> > +static int process_input_file(FILE *fp,
> > +			      struct strbuf **lines,
> 
> Where it's tempting to think that a parameter given to
> process_input_file is ... the input file!

Yes, makes sense. I'll change it to a more concise and readable name
I'd also take "outfile" as you suggest, unless anyone objects.

Thanks
Tobias
