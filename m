From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 11/19] tree-diff: simplify tree_entry_pathcmp
Date: Tue, 25 Mar 2014 13:23:36 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140325092336.GD3777@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <54aeccfe65926ff00147c3045c5bbae1583d68a7.1393257006.git.kirr@mns.spb.ru>
 <xmqqeh1rp9vz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:25:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSNcE-0000EC-Gp
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 10:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaCYJZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 05:25:46 -0400
Received: from forward7.mail.yandex.net ([77.88.61.37]:46869 "EHLO
	forward7.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaCYJZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 05:25:45 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Mar 2014 05:25:45 EDT
Received: from smtp9.mail.yandex.net (smtp9.mail.yandex.net [77.88.61.35])
	by forward7.mail.yandex.net (Yandex) with ESMTP id 885191C0AEF;
	Tue, 25 Mar 2014 13:20:10 +0400 (MSK)
Received: from smtp9.mail.yandex.net (localhost [127.0.0.1])
	by smtp9.mail.yandex.net (Yandex) with ESMTP id 2A32F15200F8;
	Tue, 25 Mar 2014 13:20:10 +0400 (MSK)
Received: from unknown (unknown [78.25.121.154])
	by smtp9.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2ckdx6zFDq-K8FmSZER;
	Tue, 25 Mar 2014 13:20:09 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 12e5fd73-0fd9-4994-9d7f-b5232a608b4b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395739209; bh=pQRUM8A73a0CEYzEhR56Az1Rv46W3gLNNr40ehwPD9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=aSThpeMOEDIAh1nyyhQl5jclaNfE+6c254FDEKvPVd30IJOyZkZxfN2SsmZvKZNA2
	 KgIONAzvYk+MQuE8EHki6X+3RtfZy2AUMe+eMaEA2ZsvyynK1bTE5VMzw1Uha2vWMe
	 jotGRLrxH+6Iq/wBzpKqqkhWotdH92icz+VlzD3o=
Authentication-Results: smtp9.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WSNa4-0002zv-PD; Tue, 25 Mar 2014 13:23:36 +0400
Content-Disposition: inline
In-Reply-To: <xmqqeh1rp9vz.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245021>

On Mon, Mar 24, 2014 at 02:25:04PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > Since an earlier "Finally switch over tree descriptors to contain a
> > pre-parsed entry", we can safely access all tree_desc->entry fields
> > directly instead of first "extracting" them through
> > tree_entry_extract.
> >
> > Use it. The code generated stays the same - only it now visually looks
> > cleaner.
> >
> > Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >
> > ( re-posting without change )
> 
> Thanks.
> 
> Hopefully I'll be merging the series up to this point to 'next'
> soonish.

Thanks a lot!


> >  tree-diff.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/tree-diff.c b/tree-diff.c
> > index 20a4fda..cf96ad7 100644
> > --- a/tree-diff.c
> > +++ b/tree-diff.c
> > @@ -15,18 +15,13 @@
> >   */
> >  static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
> >  {
> > -	unsigned mode1, mode2;
> > -	const char *path1, *path2;
> > -	const unsigned char *sha1, *sha2;
> > -	int cmp, pathlen1, pathlen2;
> > +	struct name_entry *e1, *e2;
> > +	int cmp;
> >  
> > -	sha1 = tree_entry_extract(t1, &path1, &mode1);
> > -	sha2 = tree_entry_extract(t2, &path2, &mode2);
> > -
> > -	pathlen1 = tree_entry_len(&t1->entry);
> > -	pathlen2 = tree_entry_len(&t2->entry);
> > -
> > -	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
> > +	e1 = &t1->entry;
> > +	e2 = &t2->entry;
> > +	cmp = base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
> > +				e2->path, tree_entry_len(e2), e2->mode);
> >  	return cmp;
> >  }
