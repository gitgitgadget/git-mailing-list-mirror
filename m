From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 18:18:12 -0500
Message-ID: <20160216231811.GA18634@sigill.intra.peff.net>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
 <20160216192231.GA16567@sigill.intra.peff.net>
 <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
 <20160216204954.GC27484@sigill.intra.peff.net>
 <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
 <20160216223451.GB9014@sigill.intra.peff.net>
 <CAPig+cS+i5QfpUbs8T+CqcDkC4ybaTygE9bguiqQMNgV4JhDOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:18:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVot5-0005x4-6Z
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbcBPXSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:18:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:43683 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756250AbcBPXSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:18:14 -0500
Received: (qmail 8485 invoked by uid 102); 16 Feb 2016 23:18:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 18:18:14 -0500
Received: (qmail 32258 invoked by uid 107); 16 Feb 2016 23:18:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 18:18:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 18:18:12 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cS+i5QfpUbs8T+CqcDkC4ybaTygE9bguiqQMNgV4JhDOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286453>

On Tue, Feb 16, 2016 at 05:49:19PM -0500, Eric Sunshine wrote:

> On Tue, Feb 16, 2016 at 5:34 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Feb 16, 2016 at 04:09:53PM -0500, Eric Sunshine wrote:
> >> My initial reaction was negative due to the heavy review burden this
> >> series has demanded thus far, however, my mind was changing even as I
> >> composed the above response. In retrospect, I think I'd be okay seeing
> >> a v6, for the following reasons:
> >>
> >> - I already ended up reviewing the the suggested new changes pretty
> >> closely as a side-effect of reading your proposal.
> >>
> >> - It would indeed be nice to avoid introducing
> >> strbuf_split_str_omit_term() in the first place; thus one less thing
> >> to worry about if someone ever takes on the task of retiring the
> >> strbuf_split interface.
> >>
> >> - It should be only a minimal amount of work for Karthik, thus
> >> turnaround time should be short.
> >>
> >> So, I think I'm fine with it, if Karthik is game.
> >
> > I started to write up a commit message for my proposed change. But it
> > did make me think of a counter-argument. Right now we parse
> > "%(align:10,middle)" but do not allow "%(align: 10, middle)".
> >
> > Should we? Or perhaps: might we? If the answer is yes, we are likely
> > better off with strbuf_split, because then we are only a strbuf_trim()
> > away from making that work.
> 
> I also considered the issue of embedded whitespace very early on when
> reading your initial proposal, but didn't mention anything about it
> due to a vague recollection from one of the early reviews (or possibly
> a review of one of Karthik's other patch series) of someone (possibly
> Junio) saying or implying that embedded whitespace would not be
> supported. Unfortunately, I can't locate that message (assuming it
> even exists and wasn't a figment of my imagination).

Yeah, I could not find any relevant reference (though I didn't spend all
that long digging).

For reference, I rebuilt Karthik's series on top of my proposal, and the
changes are fairly minor. I pushed it to:

  git://github.com/peff/git.git jk/tweaked-ref-filter

The tbdiff is below. Hopefully having that done makes it easier to
decide based on the outcome, rather than the pain of rebasing. :)

To be honest, though, I am now on the fence, considering the possible
whitespace issue.

 1:  92de9c7 < --:  ------- strbuf: introduce strbuf_split_str_omit_term()
 2:  4845dc5 < --:  ------- ref-filter: use strbuf_split_str_omit_term()
--:  ------- >  1:  29177cc ref-filter: use string_list_split over strbuf_split
 3:  040e9ce =  2:  ed284bc ref-filter: bump 'used_atom' and related code to the top
 4:  c7eb061 =  3:  2a99777 ref-filter: introduce struct used_atom
 5:  c3e24cf =  4:  b18f23b ref-filter: introduce parsing functions for each valid atom
 6:  0b7fe83 =  5:  e5221cc ref-filter: introduce color_atom_parser()
 7:  ffb3afe !  6:  454af9c ref-filter: introduce parse_align_position()
    @@ -32,21 +32,21 @@
      	const char *name;
      	cmp_type cmp_type;
     @@
    - 			align->position = ALIGN_LEFT;
    - 
    - 			while (*s) {
    + 			string_list_split(&params, valp, ',', -1);
    + 			for (i = 0; i < params.nr; i++) {
    + 				const char *s = params.items[i].string;
     +				int position;
     +
    - 				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
    + 				if (!strtoul_ui(s, 10, (unsigned int *)&width))
      					;
    --				else if (!strcmp(s[0]->buf, "left"))
    +-				else if (!strcmp(s, "left"))
     -					align->position = ALIGN_LEFT;
    --				else if (!strcmp(s[0]->buf, "right"))
    +-				else if (!strcmp(s, "right"))
     -					align->position = ALIGN_RIGHT;
    --				else if (!strcmp(s[0]->buf, "middle"))
    +-				else if (!strcmp(s, "middle"))
     -					align->position = ALIGN_MIDDLE;
    -+				else if ((position = parse_align_position(s[0]->buf)) >= 0)
    ++				else if ((position = parse_align_position(s)) >= 0)
     +					align->position = position;
      				else
    - 					die(_("improper format entered align:%s"), s[0]->buf);
    - 				s++;
    + 					die(_("improper format entered align:%s"), s);
    + 			}
 8:  0f0e596 !  7:  0779954 ref-filter: introduce align_atom_parser()
    @@ -43,18 +43,19 @@
     +static void align_atom_parser(struct used_atom *atom, const char *arg)
     +{
     +	struct align *align = &atom->u.align;
    -+	struct strbuf **v, **to_free;
    ++	struct string_list params = STRING_LIST_INIT_DUP;
    ++	int i;
     +	unsigned int width = ~0U;
     +
     +	if (!arg)
     +		die(_("expected format: %%(align:<width>,<position>)"));
    -+	v = to_free = strbuf_split_str_omit_term(arg, ',', 0);
     +
     +	align->position = ALIGN_LEFT;
     +
    -+	while (*v) {
    ++	string_list_split(&params, arg, ',', -1);
    ++	for (i = 0; i < params.nr; i++) {
    ++		const char *s = params.items[i].string;
     +		int position;
    -+		const char *s = v[0]->buf;
     +
     +		if (!strtoul_ui(s, 10, &width))
     +			;
    @@ -62,13 +63,12 @@
     +			align->position = position;
     +		else
     +			die(_("unrecognized %%(align) argument: %s"), s);
    -+		v++;
     +	}
     +
     +	if (width == ~0U)
     +		die(_("positive width expected with the %%(align) atom"));
     +	align->width = width;
    -+	strbuf_list_free(to_free);
    ++	string_list_clear(&params, 0);
     +}
     +
      static struct {
    @@ -130,32 +130,32 @@
      			continue;
     -		} else if (match_atom_name(name, "align", &valp)) {
     -			struct align *align = &v->u.align;
    --			struct strbuf **s, **to_free;
    +-			struct string_list params = STRING_LIST_INIT_DUP;
    +-			int i;
     -			int width = -1;
     -
     -			if (!valp)
     -				die(_("expected format: %%(align:<width>,<position>)"));
     -
    --			s = to_free = strbuf_split_str_omit_term(valp, ',', 0);
    --
     -			align->position = ALIGN_LEFT;
     -
    --			while (*s) {
    +-			string_list_split(&params, valp, ',', -1);
    +-			for (i = 0; i < params.nr; i++) {
    +-				const char *s = params.items[i].string;
     -				int position;
     -
    --				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
    +-				if (!strtoul_ui(s, 10, (unsigned int *)&width))
     -					;
    --				else if ((position = parse_align_position(s[0]->buf)) >= 0)
    +-				else if ((position = parse_align_position(s)) >= 0)
     -					align->position = position;
     -				else
    --					die(_("improper format entered align:%s"), s[0]->buf);
    --				s++;
    +-					die(_("improper format entered align:%s"), s);
     -			}
     -
     -			if (width < 0)
     -				die(_("positive width expected with the %%(align) atom"));
     -			align->width = width;
    --			strbuf_list_free(to_free);
    +-			string_list_clear(&params, 0);
     +		} else if (starts_with(name, "align")) {
     +			v->u.align = atom->u.align;
      			v->handler = align_atom_handler;
 9:  d3dc384 !  8:  792c89a ref-filter: align: introduce long-form syntax
    @@ -45,8 +45,8 @@
     --- a/ref-filter.c
     +++ b/ref-filter.c
     @@
    + 		const char *s = params.items[i].string;
      		int position;
    - 		const char *s = v[0]->buf;
      
     -		if (!strtoul_ui(s, 10, &width))
     +		if (skip_prefix(s, "position=", &s)) {
10:  3ae28b5 =  9:  019fee7 ref-filter: introduce remote_ref_atom_parser()
11:  06c70af = 10:  f6e4f5a ref-filter: introduce contents_atom_parser()
12:  c9db181 = 11:  0a84b70 ref-filter: introduce objectname_atom_parser()
