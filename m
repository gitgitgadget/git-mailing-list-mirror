From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 15/16] refs: add LMDB refs backend
Date: Fri, 04 Dec 2015 19:25:36 -0500
Organization: Twitter
Message-ID: <1449275136.3858.2.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-16-git-send-email-dturner@twopensource.com>
	 <xmqqzixpoiyt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 01:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a50fZ-00005N-7o
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 01:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbbLEAZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 19:25:41 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34940 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbbLEAZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 19:25:39 -0500
Received: by igl9 with SMTP id 9so43789490igl.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 16:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=/2FwApsL/VN/Pp28WE0+oTIjEbunxLJ8KyO0tIJpfkU=;
        b=gC3n0L13qvvP/yBOzZluon/hDTbzyBJRvMix3H9rZczGVUx/lm9S8WUCto+18KsOyM
         puvuphtIpkkO9l7nxuEo/a1r47xD4uvBe9UZ/iRKHjKYYCoGmYAEe9/p/hVZ6bhyKRXj
         iB2LKBSfT6XfQ+4LQJh+Tgn3aSRKcjOJdHpMC5zqPSeanCByHx9zv73pokXFR0OTPiDM
         a5qpab6vszxyYkHsR4nk0dsQ6kGXYUrQOPxUw4XL65WHCXwSUKVDNo5NMim1iXi/2faI
         vEZKUlVUI0Mi1wcmFrr/pblf5ERUBFr5yOOxtAG2AoZZbE3LLkrbFprAJGO7Su6k60TA
         apig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/2FwApsL/VN/Pp28WE0+oTIjEbunxLJ8KyO0tIJpfkU=;
        b=HlP76sr4zcfjuQM8+OJQKBj3k3SuOHrfHtJDz7c2pSOqBZFwjYmuvbwxd9CS16zKYX
         BZrhQi6Z5F+0DRJmdxWF1mOGzPEQHMtmfprV0TJDE1a1JKJkROwtSfJU0Eq8Tc2IF+FI
         yIasdIYD5RkQpt2MsJctjrfen293lw00RLIOyWETMVFCuZakUS/E+V2Vl34tN22buOyp
         g13BrSG7m6TkHIJQKxZwk/Msm1zN5Vyd+f0DRuMLZLHkP86bPYe4sQC09qCHRRb0QRG2
         kjLelVp386xJYyWtON37TtDtrEP4bj4KWuGNn1l+CIE7gIax5mDaznFkSPgzUJggs0CF
         gzmQ==
X-Gm-Message-State: ALoCoQlOBtb4B672ofioNFnbEAihliPqf7i9iFp0PHHKQm71CMGTGYp1v5SdMnhAOFWttfJ2ES0UpBm4Ss+FOIQMc1xT/tRd6Q==
X-Received: by 10.50.59.242 with SMTP id c18mr6358295igr.82.1449275139195;
        Fri, 04 Dec 2015 16:25:39 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id c2sm2297562igg.4.2015.12.04.16.25.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Dec 2015 16:25:38 -0800 (PST)
In-Reply-To: <xmqqzixpoiyt.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282024>

On Fri, 2015-12-04 at 16:08 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > +	while (!mdb_ret) {
> > +		if (starts_with(key.mv_data, refname) &&
> > +		    ((char*)key.mv_data)[refname_len - 2] == '/') {
> 
> ERROR: "(foo*)" should be "(foo *)"
> #877: FILE: refs/lmdb-backend.c:514:
> +                   ((char*)key.mv_data)[refname_len - 2] == '/') {
> 
> > +static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
> > +{
> > +	unsigned char osha1[20], nsha1[20];
> > +	char *email_end, *message;
> > +	unsigned long timestamp;
> > +	int tz;
> > +
> > +	/* old (raw) new (raw) name <email> SP time TAB msg LF */
> > +	if (sb->len < 41 || sb->buf[sb->len - 1] != '\n' ||
> > +	    !(email_end = strchr(sb->buf + 40, '>')) ||
> > +	    email_end[1] != ' ' ||
> > +	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
> > +	    !message || message[0] != ' ' ||
> > +	    (message[1] != '+' && message[1] != '-') ||
> > +	    !isdigit(message[2]) || !isdigit(message[3]) ||
> > +	    !isdigit(message[4]) || !isdigit(message[5]))
> > +		return 0; /* corrupt? */
> 
> ERROR: do not use assignment in if condition
> #1024: FILE: refs/lmdb-backend.c:661:
> +       if (sb->len < 41 || sb->buf[sb->len - 1] != '\n' ||

This code is based on code from files-backend.c.  But I can change it
anyway.

I'll also fix the rest, but wait for further review to post.
