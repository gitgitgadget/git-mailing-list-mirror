From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Sat, 10 May 2008 16:20:53 +0800
Message-ID: <46dff0320805100120xe967359v62d665fdbaca5e6a@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
	 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
	 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
	 <alpine.DEB.1.00.0805060954470.30431@racer>
	 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
	 <alpine.DEB.1.00.0805071223450.30431@racer>
	 <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 10:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JukKz-0004Zs-CB
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 10:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYEJIU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 04:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbYEJIU7
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 04:20:59 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:40430 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYEJIU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 04:20:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so328603and.103
        for <git@vger.kernel.org>; Sat, 10 May 2008 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KWKg33862m8Hnzkv0LoIROtxA1lqmYjepfIUGewJRVU=;
        b=nCzxpNVF5BswNxVYmucw/fOW2TIkL+FTtlx6M9n3ig93fgPaj6cTNpBmgvpYsmzskFipN3Cd8sEeZMktBpEgR+T+RbDg+S1FhQEsm/DZlm9vsuawH4UgWvRGDxHoPQtY/9urGBOLLsj+uiEkjeM22pzQSnw28OmmFza9jWxMk1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZqpcLZmHdJ0RIn0sqUletVYg/yQtD/NHvi9IJq2ZmLBoRheWqp3ZIcDeJTRtD5fmeLyUDOLPgfvXfPiBhVf7V2RUbxLn/qgzUlyTwB2fet+f/kO24GJfi9MvUDGM6fWjW40v24x1ttl7Xa7zDzvmM7H/hYVRx/MwRCIgTUM3XYM=
Received: by 10.100.194.5 with SMTP id r5mr6716636anf.146.1210407653423;
        Sat, 10 May 2008 01:20:53 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 10 May 2008 01:20:53 -0700 (PDT)
In-Reply-To: <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81656>

On Thu, May 8, 2008 at 3:13 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I haven't tested this at all (this is a lunchtime hack) and have a mild
> suspicion that it may have corner case miscounting (e.g. I blindly
> subtracts 3 from len when dealing with a line that represents a single
> token from the internal diff output --- do I always have 3 there even when
> the original file ends with an incomplete line?  I didn't check), but
> other than that I think this is a lot easier to read and follow.
>
> ---
>
>  diff.c |  216 +++++++++++++++++++++++++++++++--------------------------------
>  1 files changed, 106 insertions(+), 110 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index e35384b..344aaa6 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -351,87 +351,119 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
>        return 0;
>  }
>
> -struct diff_words_buffer {
> -       mmfile_t text;
> -       long alloc;
> -       long current; /* output pointer */
> -       int suppressed_newline;
> +typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
> +
> +struct emit_callback {
> +       struct xdiff_emit_state xm;
> +       int nparents, color_diff;
> +       unsigned ws_rule;
> +       sane_truncate_fn truncate;
> +       const char **label_path;
> +       struct diff_words_data *diff_words;
> +       int *found_changesp;
> +       FILE *file;
>  };
>
> -static void diff_words_append(char *line, unsigned long len,
> -               struct diff_words_buffer *buffer)
> +static size_t diff_words_tokenize(struct emit_callback *ecbdata,
> +                                 char *line, unsigned long len)
>  {
> -       if (buffer->text.size + len > buffer->alloc) {
> -               buffer->alloc = (buffer->text.size + len) * 3 / 2;
> -               buffer->text.ptr = xrealloc(buffer->text.ptr, buffer->alloc);
> +       /*
> +        * This function currently is deliberately done very stupid,
> +        * but passing ecbdata here means that you can potentially
> +        * implement different tokenization rules depending on
> +        * the content (e.g. "gitattributes(5)").
> +        */
> +       int is_space;
> +       char *line0 = line;
> +
> +       if (!len)
> +               return 0;
> +
> +       is_space = isspace(*line);
> +       while (len && (isspace(*line) == is_space)) {
> +               line++;
> +               len--;
>        }
> +       return line - line0;
> +}
> +
> +static void diff_words_append(struct emit_callback *ecbdata,
> +                             char *line, unsigned long len,
> +                             struct strbuf *text)
> +{
> +       /* Skip leading +/- first. */
>        line++;
>        len--;
> -       memcpy(buffer->text.ptr + buffer->text.size, line, len);
> -       buffer->text.size += len;
> +
> +       /*
> +        * Tokenize and stuff the words in.
> +        */
> +       while (len) {
> +               size_t token_len = diff_words_tokenize(ecbdata, line, len);
> +
> +               if (line[0] != '\n') {
> +                       /*
> +                        * A nonempty token has ' ' stuffed in front,
> +                        * so that we can recover the original
> +                        * end-of-line easily.  Stupid, but works.
> +                        */
> +                       strbuf_add(text, " ", 1);
> +                       strbuf_add(text, line, token_len);
> +                       strbuf_add(text, "\n", 1);
> +                       len -= token_len;
> +                       line += token_len;

I still don't understand why a ' '  is prepended. See my comment for
the following part

> +       if (line[1] == ' ') {
> +               /* A token */
> +               line += 2;
> +               len -= 3; /* drop the trailing LF */
> +       } else {
> +               /* A real LF */
> +               line++;
> +               len--;
>        }

I think we can recognize a real LF by that the diff line should be a
single '\n', i.e. line[1] == '\n'. So what's wrong by
s/line[1] == ' '/line[1] != '\n'/ ?

-- 
Ping Yin
