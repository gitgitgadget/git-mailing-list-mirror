From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH/RFC v1 4/5] fast-import.c: cleanup using strbuf_set
 operations
Date: Mon, 9 Jun 2014 15:00:39 -0700
Message-ID: <20140609220039.GB18783@hudson.localdomain>
References: <cover.1402301815.git.jmmahler@gmail.com>
 <b64218c4f2a188c5aeb48a07da01972ef4d0ca33.1402301816.git.jmmahler@gmail.com>
 <CAPig+cRPPN7N+KUHULXxoGHetN8WPtASxnC7L1fe5rFoBFQ4KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:00:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7cW-0003Kl-7H
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbaFIWAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:00:45 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:47192 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbaFIWAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:00:44 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so5457589pbc.2
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Oi7N96K8fIXtLMpF4Y1wLvrVokQ3SZV2gzVEVOL+8MM=;
        b=WNmHNyxvcyVCtGakKs/QZK7aNLbENuERpLShu8Hq/NjShP3vTmv09YQtZ0+hZT4ad4
         zJkXDYqSinm0bEL/oole3F+H4A9kaByZmAvPdaujO1E4LMdcu5IB2s76kZr3XjHOI82i
         kGNmDQ81SVaF45OA21wCUf4wQMLFgAAj2agwVd3c1llgmZj7aMFp0T+X0MYInH+60wDI
         VaU44jyc5N1Bl9ynB+YIa0EhXch2/I7JNpGmCV9gXsXYbh4OU8iYjcftKNdrhzqrk8Mu
         5Jtdt5ZjDzaFDFZZJYpReIcXRtmJj+BzC0y5A5NkpSKXrfzqMfL3cEKGgPDomwTSLcAH
         uDjg==
X-Received: by 10.66.244.176 with SMTP id xh16mr1204529pac.20.1402351243688;
        Mon, 09 Jun 2014 15:00:43 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id pq3sm65747507pbb.57.2014.06.09.15.00.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:00:42 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:00:39 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPig+cRPPN7N+KUHULXxoGHetN8WPtASxnC7L1fe5rFoBFQ4KA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251105>

Eric,

On Mon, Jun 09, 2014 at 06:12:12AM -0400, Eric Sunshine wrote:
> On Mon, Jun 9, 2014 at 4:36 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> > Subject: fast-import.c: cleanup using strbuf_set operations
> 
...
> 
> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> > ---
> >  fast-import.c | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/fast-import.c b/fast-import.c
> > index e8ec34d..c23935c 100644
> > --- a/fast-import.c
> > +++ b/fast-import.c
> > @@ -2741,8 +2741,7 @@ static void parse_new_commit(void)
> >         hashcpy(b->branch_tree.versions[0].sha1,
> >                 b->branch_tree.versions[1].sha1);
> >
> > -       strbuf_reset(&new_data);
> > -       strbuf_addf(&new_data, "tree %s\n",
> > +       strbuf_setf(&new_data, "tree %s\n",
> >                 sha1_to_hex(b->branch_tree.versions[1].sha1));
> >         if (!is_null_sha1(b->sha1))
> >                 strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
> 
> Unlike the cases in patches 3/5 and 5/5 where the strbuf is used or
> returned immediately following the strbuf_set() call, I am not
> convinced that this change is an improvement. This code has the
> general form:
> 
>     strbuf_reset(...);
>     strbuf_add(...);
>     if (condition)
>         strbuf_add(...);
>     strbuf_add(...);
> 
> in which it is clear that the string is being built piecemeal, and
> it's easy for a programmer to insert, remove, or re-order strbuf_add()
> calls.
> 
> Replacing the first two lines with strbuf_set() somewhat obscures the
> fact that the string is going to be built up piecemeal. Plus, the
> change makes it more difficult to insert, remove, or re-order the
> strbuf_add() invocations.
> 
> This isn't a strong objection, but the benefit of the change seems
> minimal or non-existent.
> 
> Ditto for several remaining cases in this patch.
> 
...

This is a great observation that I certainly did overlook.  Using
strbuf_add or strbuf_set to help make it more obvious what the code is
doing.

By the same token, strbuf_set can be used to replace strbuf_add to make
it clear that nothing important was being added to and that the entire
buffer is being replaced.

  struct strbuf mybuf = STRBUF_INIT;

  strbuf_add(&mybuf, ...);  /* Was something there before? */

  strbuf_set(&mybuf, ...);  /* Replace everything. */

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
