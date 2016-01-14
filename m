From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 20/21] refs: add LMDB refs backend
Date: Thu, 14 Jan 2016 17:30:55 -0500
Organization: Twitter
Message-ID: <1452810655.16226.21.camel@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	 <1452561740-8668-21-git-send-email-dturner@twopensource.com>
	 <20160114205259.GA10440@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 23:31:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJqQa-0004v5-12
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 23:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419AbcANWbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 17:31:31 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36408 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbcANWa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 17:30:58 -0500
Received: by mail-qk0-f177.google.com with SMTP id q19so256392419qke.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=0qjTzWE6jOdiC3i4WB+xhurc6/XvpAsXN+0Y2ayxKJA=;
        b=gQG/qgQepzJ93eF/KmfwCIhpHEfOsSKAoobsqoXWb8BsZWJOHz8OZJjJ3WzVJD7oGr
         pHwGfez+wPhb8RaIgTVkw4Rs9bcaYFvrGi1N1Ky4PBWeU/bA+FiQr/+7JeQ0Sup7laqt
         SWVFEQmtPIGyq5mXQg6RTjmANlaL7WksYGDsQImJ//TkEo6/+HclEJn2SUysbSxsynCX
         fyuows/qNVnmuYiNu4G8T6p8DwMSiaT60+UPYPaGPBhW6zlFapBAZGKkNxtmQbyLsIQy
         /JBK/Xi+pEeDHnq9QcEWoVXs5muftfi+CG13lQduryEJ/+2mjVqCXQHwbwMMG509YW2g
         YzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=0qjTzWE6jOdiC3i4WB+xhurc6/XvpAsXN+0Y2ayxKJA=;
        b=a2DoELmzOPNfddFyNN17xIGV/t+EFdiFjpclSHmGi/wSv0pv/OuFAlTeLQyRMAjXlc
         j9MUTF0Pps9VppHQ2NOZlb7G8hkDzo8N9zmUy/QvC0ARFoc1GfIr5C6fNs/eD9Iicgnm
         PFS/GrzK+hnIBjeLt9vjeddbiN6rHxh7jEnOfYK/nzEZFbGxq+ZjGGJz1QybmutuwNcP
         BQti/brNoI17cKoZbprj2yAYiXipPBfGC8E9usAvJAprpTOCa8iou0oiDeoKa3XMYRWR
         RIgFMa0jaoDj1XNzj+pAdvo+Xjz09bfUHmhT8HIUi5+jJDwHGtaadh5s7/DHd965RtyW
         ENxQ==
X-Gm-Message-State: ALoCoQkSOJsI9VbmlZJx4COCo0IGZ14vWBm7i/zPBMtohLlC4VIXY1f+Lw1GZgU7UXG7CnPQ9OPzJmxTtSZRK5porADVz5mH5g==
X-Received: by 10.55.25.146 with SMTP id 18mr8821836qkz.41.1452810657283;
        Thu, 14 Jan 2016 14:30:57 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id o2sm3343879qkl.15.2016.01.14.14.30.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 14:30:56 -0800 (PST)
In-Reply-To: <20160114205259.GA10440@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284100>

On Thu, 2016-01-14 at 15:52 -0500, Jeff King wrote:
> On Mon, Jan 11, 2016 at 08:22:19PM -0500, David Turner wrote:
> 
> > +static int rename_reflog_ent(unsigned char *osha1, unsigned char
> > *nsha1,
> > +			     const char *email, unsigned long
> > timestamp, int tz,
> > +			     const char *message, void *cb_data)
> > +{
> > +
> > +	const char *newrefname = cb_data;
> > +	MDB_val key, new_key, val;
> > +
> > +	assert(transaction.cursor);
> > +
> > +	if (mdb_cursor_get_or_die(transaction.cursor, &key, &val,
> > MDB_GET_CURRENT))
> > +		die("renaming ref: mdb_cursor_get failed to get
> > current");
> > +
> > +	new_key.mv_size = strlen(newrefname) + 5 + 1 + 8;
> > +	new_key.mv_data = xmalloc(new_key.mv_size);
> > +	strcpy(new_key.mv_data, "logs/");
> > +	strcpy((char *)new_key.mv_data + 5, newrefname);
> > +	memcpy((char *)new_key.mv_data + new_key.mv_size - 8,
> > +	       (const char *)key.mv_data + key.mv_size - 8, 8);
> > +	mdb_put_or_die(&transaction, &new_key, &val, 0);
> > +	mdb_cursor_del_or_die(transaction.cursor, 0);
> > +	free(new_key.mv_data);
> > +	return 0;
> 
> When you re-roll, do you mind avoiding strcpy here? I know that your
> malloc is big enough, but:
> 
>   1. Avoiding strcpy makes auditing easier.
> 
>   2. We can probably come up with a solution that avoids the magic
>      numbers, making it more pleasant to read.
> 
>   3. Manual computation plus a strcpy can be vulnerable to integer
>      overflows in the size (I didn't check the types on MDB_val to
> see
>      if that is feasible or not, but again, it's nice to avoid for
> audit
>      purposes).
> 
> Since we free the memory immediately-ish, I think using a strbuf
> would
> be a good fit. Something like:
> 
>   struct strbuf path = STRBUF_INIT;
>   ...
>   strbuf_addf(&path, "logs/%s", newrefname);
>   strbuf_add(&path, (const char *)key.mv_data + key.mv_size - 8, 8);
>   new_key.mv_size = path.len;
>   new_key.mv_data = path.buf;
>   ... mdb_put, etc ...
>   strbuf_release(&path);
> 
> (I hope I'm reading the 8-byte thing right; should we also be
> asserting
> that key.mv_size >= 8?).

Did both.

> > +static int lmdb_for_each_reflog_ent_order(const char *refname,
> > +					  each_reflog_ent_fn fn,
> > +					  void *cb_data, int
> > reverse)
> > +{
> > +	MDB_val key, val;
> > +	char *search_key;
> > +	char *log_path;
> > +	int len;
> > +	MDB_cursor *cursor;
> > +	int ret = 0;
> > +	struct strbuf sb = STRBUF_INIT;
> > +	enum MDB_cursor_op direction = reverse ? MDB_PREV :
> > MDB_NEXT;
> > +	uint64_t zero = 0ULL;
> > +
> > +	len = strlen(refname) + 6;
> > +	log_path = xmalloc(len);
> > +	search_key = xmalloc(len + 1);
> > +	sprintf(log_path, "logs/%s", refname);
> > +	strcpy(search_key, log_path);
> 
> Ditto here (and for sprintf, too). You can do these with xstrfmt:

OK.

>   log_path = xstrfmt("logs/%s", refname);
>   len = strlen(log_path); /* or use a strbuf to avoid the extra
> strlen */
> 
> The search_key one looks like an extra off-by-one, but the extra byte
> gets used below. So maybe:
> 
>   /* \0 may be rewritten as \1 for reverse search below */
>   search_key = xstrfmt("%s\0", log_path);
> 
> though I think:
> 
>   if (reverse) {
> 	/* explanation ... */
> 	search_key = xstrfmt("%s\1", log_path);
>   } else {
> 	search_key = xstrdup(log_path);
>   }
> 
> might be clearer to a reader. There are a few other sprintfs and
> strcpys, but I think they can all use similar techniques.

OK, I went ahead and did all of these.

Thanks for the review.
