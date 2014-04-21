From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] blame: use a helper to get suitable blame_date_width
Date: Mon, 21 Apr 2014 10:20:44 -0700
Message-ID: <xmqqfvl6a9ar.fsf@gitster.dls.corp.google.com>
References: <cover.1398059411.git.worldhello.net@gmail.com>
	<17454bdfbd4e0e1516a64f75deabddb427792e99.1398059411.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 19:21:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcHu2-0000Ov-HW
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 19:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbaDURUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 13:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbaDURUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 13:20:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F947CE32;
	Mon, 21 Apr 2014 13:20:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UMHZsEPdB8wAXvGzfi/vmvpuYzE=; b=siRbf/
	yRpxKCfCg9g8EYB/vfI8X6xFryJj+C8zStCbH7Q6fGcSoEUnNmInYVdsClG4i2M4
	oas4xG+9JZWNcw5g/pYC9w1fM+wW8/cNDSTBzs6HWfWLDwd6IfQJaO4Prim+PSlU
	YEzkcRkEIAQ9ekrgxIH1DqaS9J1Q+bdizQ6tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HUASgF9XtV7a0BWvl/H2nQWmZr38QyJG
	tYMOg4zTu1FMzOaj2GusfLaPXEq2MTahMTcyBqaBONXWs2q0syhd+t7jRHvlxs2u
	P2lYwFlv1+AMtohlTtKbDECBhhfwAjmXaCL2aWk7gmd1vE4CeHScFjq3q44EC3k1
	TJdopbvs7fc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEBD27CE31;
	Mon, 21 Apr 2014 13:20:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEEBA7CE27;
	Mon, 21 Apr 2014 13:20:46 -0400 (EDT)
In-Reply-To: <17454bdfbd4e0e1516a64f75deabddb427792e99.1398059411.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Mon, 21 Apr 2014 14:02:04 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46EDA8FA-C979-11E3-B1F8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246613>

Jiang Xin <worldhello.net@gmail.com> writes:

> When show date in relative date format for git-blame, the max display
> width of datetime is set as the length of the string "Thu Oct 19
> 16:00:04 2006 -0700" (30 characters long).  But actually the max width
> for C locale is only 22 (the length of string "x years, xx months ago").
> And for other locale, it maybe smaller.  E.g. For Chinese locale, only
> needs a half (16-character width).
>
> Add a helper function date_relative_maxwidth() to date.c, which returns
> the suitable display width for the relative date field in different
> locale.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/blame.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)

That does not seem to have the helper in date.c immediately next to
the definition of show_date_relative(), as the above log message
claims, does it?

I was hoping that you would respond with a set of counter-arugments
to shoot the suggestion down.  Here are a few obvious ones:

 - By inlining the implementation of show_date_relative() in the new
   helper function, we would end up having to maintain two copies of
   every format strings.

 - Even if we don't inline the logic and duplicate the format
   strings, and call show_date_relative() with some predetermined
   offsets instead, e.g.

	static int date_relative_maxwidth(void)
	{
                struct timebuf = STRBUF_INIT;
		struct timeval now;
                static int maxwidth = 0;

                gettimeofday(&now, NULL);

                /* in the future */
                show_date_relative(now->tv_sec + 100, 0, &now, &timebuf);
                maxwidth = maxwidth < timebuf.len ? timebuf.len : maxwidth;
                strbuf_reset(&timebuf);

		/* seconds ago */
                show_date_relative(now->tv_sec - 89, 0, &now, &timebuf);
                maxwidth = maxwidth < timebuf.len ? timebuf.len : maxwidth;
                strbuf_reset(&timebuf);

                ...
	}

   we still end up hardcoding the logic in the code.

 - There is no guarantee that these predetermined offsets would
   produce the longest possible timestamp for the target language
   with these gettext strings.  In a language where the noun
   "second" takes a lot longer shape for singular than the plural
   (e.g. "1 SECOND" vs "2 SEC", perhaps), checking for 89 seconds
   ago may not produce the longest string for "%lu seconds ago".
   The approach, "we compute everything for translators", sounds
   nice in theory, but may not work well in practice and the worst
   part is that there is no way for translators to work it around,
   unlike your original patch.

So after sleeping on the idea overnight, I think I like the
simplicity of your original patch better.  It just needs to be
explained well for translators to understand.

Sorry for making you go off exploring in a strange direction.

When msgmerge is run to update XX.po with a new version of git.pot,
does it destroy comments an earlier translator placed in XX.po, or
are they kept intact?  What I am wondering is if we can do something
like this:

    In code:

        blame_date_width = strtoul(_("22 (C)"), NULL, 10) + 1; /* add the null */

    In git.pot:

        #. This string encodes the preferred maximum display width for a
        #. relative timestamp in "git blame" output.  For C locale, "4 years,
        #. 11 months ago", which takes 22 places, is the longest among various
        #. forms of relative timestamps, but your languate may need more or
        #. fewer display columns.  If "zh_CN" locale needs 14 display columns to
        #. hold any relative timestamp in the reasonably near past, for
        #. example, translate this string as "14 (zh_CN)".
        msgid "22 (C)"
        msgstr ""

    In de.po:
        #. This string encodes the preferred maximum display width for a
        #. relative timestamp in "git blame" output.  For C locale, "4 years,
        #. 11 months ago", which takes 22 places, is the longest among various
        #. forms of relative timestamps, but your languate may need more or
        #. fewer display columns.  If zh_CN locale needs 14 display columns to
        #. hold any relative timestamp in the reasonably near past, for
        #. example, translate this string as "14 (zh_CN)".
	#.
	#. In de locale, "vor %lu Jahren, und %lu Monaten" is the
        #. longest and fits within 28 display columns.
        msgid "22 (C)"
        msgstr "28 (de)"

where the instructions for tranlators to various languages come from
git.pot and the translator to a specific language can describe which
variant in the language described in XX.po is the longest.  For that
to work well, the last two lines in the comment an earlier "de"
translator added need to be preserved across msgmerge, though.
