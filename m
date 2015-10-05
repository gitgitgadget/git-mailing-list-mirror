From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 22/43] refs-be-files.c: add
 do_for_each_per_worktree_ref
Date: Mon, 05 Oct 2015 16:14:33 -0400
Organization: Twitter
Message-ID: <1444076073.5158.10.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-23-git-send-email-dturner@twopensource.com>
	 <56123279.4060605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:14:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjC9u-00039k-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbbJEUOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:14:51 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35171 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbbJEUOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:14:36 -0400
Received: by qkap81 with SMTP id p81so74246282qka.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=1REtbVeJeiso8d1VsyTpxVqSb16URVhTKZCRnhzAsFk=;
        b=OVIL86NQEVdCH3cOehQzCaAMqBFA7OabA5S4kxKNRzxUbuGusYwkLL6rF9wMW7bd/V
         69Ppa1D0kycO99KHqwBSACPCGfpyA4erOQPzlQQdsUlxzTTAY/DWt4mmpBaRC1VJaWVE
         nSD5JsU+/9IeJiKe2TLYuUe4R25a9YxCY16l673ugFF3AVFgrarDNdqL9EkC4RA+2lFE
         OQ5XUJ9o0DoiC8B7BmRHeLFq9tqUsYBxWLHlgvBozzYmsxlCf0JlD3X+4hodISqg41im
         8xUPDkiljWek/q9NktFi5bEgL8XDd0cg19E4N+bK81NAscVjn2g6Vpi+3rAuDaesks0L
         88yQ==
X-Gm-Message-State: ALoCoQnxB3yslV2RAM0JT48ntwb1uUeuDOItylmdoyAIMjz6rS959cgk8b3SIl9BI+A0/MxjuRuJ
X-Received: by 10.55.198.29 with SMTP id b29mr17785522qkj.56.1444076075154;
        Mon, 05 Oct 2015 13:14:35 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id q140sm12030965qha.5.2015.10.05.13.14.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 13:14:34 -0700 (PDT)
In-Reply-To: <56123279.4060605@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279075>

On Mon, 2015-10-05 at 10:19 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:01 AM, David Turner wrote:
> > Alternate refs backends might still use files to store per-worktree
> > refs.  So the files backend's ref-loading infrastructure should be
> > available to those backends, just for use on per-worktree refs.  Add
> > do_for_each_per_worktree_ref, which iterates over per-worktree refs.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs-be-files.c | 15 ++++++++++++---
> >  refs.h          | 11 +++++++++++
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/refs-be-files.c b/refs-be-files.c
> > index eb18a20..dc89289 100644
> > --- a/refs-be-files.c
> > +++ b/refs-be-files.c
> > @@ -587,9 +587,6 @@ static void sort_ref_dir(struct ref_dir *dir)
> >  	dir->sorted = dir->nr = i;
> >  }
> >  
> > -/* Include broken references in a do_for_each_ref*() iteration: */
> > -#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
> > -
> >  /*
> >   * Return true iff the reference described by entry can be resolved to
> >   * an object in the database.  Emit a warning if the referred-to
> > [...]
> > diff --git a/refs.h b/refs.h
> > index 5875fe5..09d140d 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -152,6 +152,12 @@ struct ref_transaction;
> >   */
> >  #define REF_BAD_NAME 0x08
> >  
> > +/* Include broken references in a do_for_each_ref*() iteration */
> > +#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
> 
> Why do you move this definition from refs-be-files.c?

Because the lmdb backend will need it.

> > +
> > +/* Only include per-worktree refs in a do_for_each_ref*() iteration */
> > +#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
> 
> And why do you define this one here instead of in refs-be-files.c?

Because other backends might need it (even though at present lmdb
doesn't).
