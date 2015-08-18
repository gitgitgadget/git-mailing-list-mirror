From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 05/13] ref-filter: implement an `align` atom
Date: Wed, 19 Aug 2015 00:58:43 +0530
Message-ID: <CAOLa=ZRZVDi5F-U=eWGN6+bishR1sx9gHeraiHTZbzUuKUQnnA@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com> <1439923052-7373-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <Karthik.188@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmZV-0005UR-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbbHRT3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:29:15 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33772 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbbHRT3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:29:13 -0400
Received: by obbhe7 with SMTP id he7so149830236obb.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aTcWxGPBgZ57cuRoHH+/o1EsEhvctyrNyA6A2qn4BaU=;
        b=ZjX5i8fUR+gAyO6VaXmJ8LAYtVmoWqgqHzfo4E0iopEKvCUUZR07+vpYyr6C5jFs9k
         dTcRjAT9X/iMVTgi9oVwdLy0FAhkuBDuRGnypW0hNk8otxiOy04rusHxBvN/YtyUWPUh
         qAjuJXJtjtclQCWf0JZAUyveHFJ+JFvSdV7dXJGUbGyQhpcJUQyZhpR7vpPMEBj3Ykth
         vcr8ylcLgRxZdpjkUo3m9F/zNktW8e1TkJWo7I6Slc2Iy6HDyScUi6egjzuFk/mUa6+7
         E9gIIaxwIZQOw+qorbC9ajjiaH2HjfweIs/twWtJ1GuBj6bNQOvBzbsFqMirMdVlhNmH
         o9dg==
X-Received: by 10.60.42.230 with SMTP id r6mr7750156oel.9.1439926152990; Tue,
 18 Aug 2015 12:29:12 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 18 Aug 2015 12:28:43 -0700 (PDT)
In-Reply-To: <1439923052-7373-6-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276158>

This needs to be squashed in:

diff --git a/Documentation/git-for-each-ref.txt
b/Documentation/git-for-each-ref.txt
index fe7889c..0a89f29 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -129,7 +129,7 @@ color::

 align::
        Left-, middle-, or right-align the content between %(align:..)
-       and %(end). Followed by `:<width>>,<position>`, where the
+       and %(end). Followed by `:<width>,<position>`, where the
        `<position>` is either left, right or middle and `<width>` is
        the total length of the content with alignment. If the
        contents length is more than the width then no alignment is

On Wed, Aug 19, 2015 at 12:07 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which left-, middle-, or right-aligns the
> content between %(align:..) and %(end).
>
> It is followed by `:<width>,<position>`, where the `<position>` is
> either left, right or middle and `<width>` is the size of the area
> into which the content will be placed. If the content between
> %(align:) and %(end) is more than the width then no alignment is
> performed. e.g. to align a refname atom to the middle with a total
> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>
> We now have a `handler()` for each atom_value which will be called
> when that atom_value is being parsed, and similarly an `at_end`
> function for each state which is to be called when the `end` atom is
> encountered. Using this implement the `align` atom which aligns the
> given strbuf by calling `strbuf_utf8_align()` from utf8.c
>
> This is done by assigning a 'handler' function to each atom_value and
> a related 'at_end' function for each state. The align_handler()
> defined uses strbuf_utf8_align() from utf8.c to perform the alignment.
>
> Add documentation and tests for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  8 +++++
>  ref-filter.c                       | 73 ++++++++++++++++++++++++++++++++++++++
>  t/t6302-for-each-ref-filter.sh     | 48 +++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index e49d578..fe7889c 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -127,6 +127,14 @@ color::
>         Change output color.  Followed by `:<colorname>`, where names
>         are described in `color.branch.*`.
>
> +align::
> +       Left-, middle-, or right-align the content between %(align:..)
> +       and %(end). Followed by `:<width>>,<position>`, where the
> +       `<position>` is either left, right or middle and `<width>` is
> +       the total length of the content with alignment. If the
> +       contents length is more than the width then no alignment is
> +       performed.
> +
>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
> diff --git a/ref-filter.c b/ref-filter.c
> index 74532d3..ecbcc5a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -10,6 +10,7 @@
>  #include "quote.h"
>  #include "ref-filter.h"
>  #include "revision.h"
> +#include "utf8.h"
>
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>
> @@ -53,16 +54,27 @@ static struct {
>         { "flag" },
>         { "HEAD" },
>         { "color" },
> +       { "align" },
> +       { "end" },
> +};
> +
> +struct align {
> +       align_type position;
> +       unsigned int width;
>  };
>
>  struct ref_formatting_state {
>         struct ref_formatting_state *prev;
>         struct strbuf output;
> +       void (*at_end)(struct ref_formatting_state *state);
> +       void *cb_data;
>         int quote_style;
>  };
>
>  struct atom_value {
>         const char *s;
> +       struct align *align;
> +       void (*handler)(struct atom_value *atomv, struct ref_formatting_state **state);
>         unsigned long ul; /* used for sorting when not FIELD_STR */
>  };
>
> @@ -626,6 +638,36 @@ static inline char *copy_advance(char *dst, const char *src)
>         return dst;
>  }
>
> +static void align_handler(struct ref_formatting_state *state)
> +{
> +       struct align *align = (struct align *)state->cb_data;
> +       struct strbuf s = STRBUF_INIT;
> +
> +       strbuf_utf8_align(&s, align->position, align->width, state->output.buf);
> +       strbuf_reset(&state->output);
> +       strbuf_addbuf(&state->output, &s);
> +       free(align);
> +}
> +
> +static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
> +{
> +       struct ref_formatting_state *new;
> +
> +       push_new_state(state);
> +       new = *state;
> +       new->at_end = align_handler;
> +       new->cb_data = atomv->align;
> +}
> +
> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
> +{
> +       struct ref_formatting_state *current = *state;
> +       if (!current->at_end)
> +               die(_("format: `end` atom used without a supporting atom"));
> +       current->at_end(current);
> +       pop_state(state);
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -654,6 +696,7 @@ static void populate_value(struct ref_array_item *ref)
>                 int deref = 0;
>                 const char *refname;
>                 const char *formatp;
> +               const char *valp;
>                 struct branch *branch = NULL;
>
>                 if (*name == '*') {
> @@ -719,6 +762,34 @@ static void populate_value(struct ref_array_item *ref)
>                         else
>                                 v->s = " ";
>                         continue;
> +               } else if (skip_prefix(name, "align:", &valp)) {
> +                       struct align *align = xmalloc(sizeof(struct align));
> +                       char *ep = strchr(valp, ',');
> +
> +                       if (ep)
> +                               *ep = '\0';
> +
> +                       if (strtoul_ui(valp, 10, &align->width))
> +                               die(_("positive width expected align:%s"), valp);
> +
> +                       if (!ep || !strcmp(ep + 1, "left"))
> +                               align->position = ALIGN_LEFT;
> +                       else if (!strcmp(ep + 1, "right"))
> +                               align->position = ALIGN_RIGHT;
> +                       else if (!strcmp(ep + 1, "middle"))
> +                               align->position = ALIGN_MIDDLE;
> +                       else
> +                               die(_("improper format entered align:%s"), ep + 1);
> +
> +                       if (ep)
> +                               *ep = ',';
> +
> +                       v->align = align;
> +                       v->handler = align_atom_handler;
> +                       continue;
> +               } else if (!strcmp(name, "end")) {
> +                       v->handler = end_atom_handler;
> +                       continue;
>                 } else
>                         continue;
>
> @@ -1297,6 +1368,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>                 if (cp < sp)
>                         append_literal(cp, sp, state);
>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
> +               if (atomv->handler)
> +                       atomv->handler(atomv, &state);
>                 append_atom(atomv, state);
>         }
>         if (*cp) {
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 505a360..b252a50 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -81,4 +81,52 @@ test_expect_success 'filtering with --contains' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'left alignment' '
> +       cat >expect <<-\EOF &&
> +       refname is refs/heads/master  |refs/heads/master
> +       refname is refs/heads/side    |refs/heads/side
> +       refname is refs/odd/spot      |refs/odd/spot
> +       refname is refs/tags/double-tag|refs/tags/double-tag
> +       refname is refs/tags/four     |refs/tags/four
> +       refname is refs/tags/one      |refs/tags/one
> +       refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       refname is refs/tags/three    |refs/tags/three
> +       refname is refs/tags/two      |refs/tags/two
> +       EOF
> +       git for-each-ref --format="%(align:30,left)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'middle alignment' '
> +       cat >expect <<-\EOF &&
> +       | refname is refs/heads/master |refs/heads/master
> +       |  refname is refs/heads/side  |refs/heads/side
> +       |   refname is refs/odd/spot   |refs/odd/spot
> +       |refname is refs/tags/double-tag|refs/tags/double-tag
> +       |  refname is refs/tags/four   |refs/tags/four
> +       |   refname is refs/tags/one   |refs/tags/one
> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       |  refname is refs/tags/three  |refs/tags/three
> +       |   refname is refs/tags/two   |refs/tags/two
> +       EOF
> +       git for-each-ref --format="|%(align:30,middle)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'right alignment' '
> +       cat >expect <<-\EOF &&
> +       |  refname is refs/heads/master|refs/heads/master
> +       |    refname is refs/heads/side|refs/heads/side
> +       |      refname is refs/odd/spot|refs/odd/spot
> +       |refname is refs/tags/double-tag|refs/tags/double-tag
> +       |     refname is refs/tags/four|refs/tags/four
> +       |      refname is refs/tags/one|refs/tags/one
> +       |refname is refs/tags/signed-tag|refs/tags/signed-tag
> +       |    refname is refs/tags/three|refs/tags/three
> +       |      refname is refs/tags/two|refs/tags/two
> +       EOF
> +       git for-each-ref --format="|%(align:30,right)refname is %(refname)%(end)|%(refname)" >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.5.0
>



-- 
Regards,
Karthik Nayak
