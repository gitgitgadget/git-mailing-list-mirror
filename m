From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 12/27] refs: forbid cross-backend ref renames
Date: Wed, 24 Feb 2016 15:48:41 -0500
Organization: Twitter
Message-ID: <1456346921.18017.25.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-13-git-send-email-dturner@twopensource.com>
	 <CACsJy8B0Lt8Eq4GqSCKyA08g0Vvu-1B6dDjpkNmRre3M8DebDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:48:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgMf-00018A-PD
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbcBXUso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:48:44 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34821 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbcBXUsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:48:43 -0500
Received: by mail-qg0-f47.google.com with SMTP id y89so24331231qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 12:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=OW18X9K25bVQJTagpEQxlw/Nf1qjP93HrxVNL/ukUnY=;
        b=eZS+hvCnBN//E1KcEQL55lrEj4GgNYcUR1Yp091ClgQuSWbcBy1OCqo5oGeDW8NPln
         6IwLUBbuGkSaL8v9X/u20ur42C5TxpqG6c4zAYk4Ee6Vs31ZfKp9W8HKyOVz2N+RFhJD
         LU+DnSWZsqkOWSgUDar/AYwcrz2CNgB1Hn8PrmmkIfGLBFUW5u20bRzjBjsA6jfMPYOj
         C/kbQ5Toi359XtTmDybyNmxiBSVIebWBf4EY5RoAqIEIV3Csuou2S9+YmUNyjRD1DQme
         TXeqk/ws/YFnRQeHSLBPxdGXqCdi/Qk0TVuAnwTmdwS+Vr+sMTlm40J9ULE3srx2LAei
         tluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=OW18X9K25bVQJTagpEQxlw/Nf1qjP93HrxVNL/ukUnY=;
        b=gAmxRNyv030mZOnLAh7cTaQc+kg19bnWuzUPhlALf+VG3zoTy99oenox6k6mNx9WSr
         dI463gWVSx39775A/DJOLxjonSZgHAUky3kv2YOo6IWOZM9lWNeFwFg5cFM1Tbxgnk66
         jwiwqHXPlNVMInYhxrasbtDIPHLIu++7ZQ/SkqDlaY78Vi6CL+osRvjXK5VpOjTgcQvc
         TvSGn7L5tV77RCTgAWVKlxgkv4ZKfJ6Na+JwjomeGnWXAh7S+667ZPek73POGxFYLgGW
         QjPZCeXFrGNJFwMRrqp8z4os98Q026ZDzQtwM33bj0QVDCYcbBH3sADeHzOlXstn3UYJ
         5Yow==
X-Gm-Message-State: AG10YOREU4xkyqV5/Z6jovNjHu9akx3VLAkAPFWyUSbB9tOBfNampFAC0nHL37WdXsuHwA==
X-Received: by 10.140.176.19 with SMTP id w19mr54167808qhw.59.1456346922755;
        Wed, 24 Feb 2016 12:48:42 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z132sm1941408qka.14.2016.02.24.12.48.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 12:48:41 -0800 (PST)
In-Reply-To: <CACsJy8B0Lt8Eq4GqSCKyA08g0Vvu-1B6dDjpkNmRre3M8DebDg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287226>

On Sat, 2016-02-20 at 11:30 +0700, Duy Nguyen wrote:
> On Thu, Feb 18, 2016 at 12:17 PM, David Turner <
> dturner@twopensource.com> wrote:
> > This would be pretty weird, but since it will break, we should
> > prevent
> > it.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/refs.c b/refs.c
> > index f5754f2..8eb04da 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1306,5 +1306,11 @@ int delete_refs(struct string_list
> > *refnames)
> > 
> >  int rename_ref(const char *oldref, const char *newref, const char
> > *logmsg)
> >  {
> > +       if ((ref_type(oldref) == REF_TYPE_NORMAL) !=
> > +           (ref_type(newref) == REF_TYPE_NORMAL)) {
> > +               error(_("Both ref arguments to rename_ref must be
> > normal "
> > +                       "(or both must be per
> > -worktree/pseudorefs)"));
> > +               return -1;
> 
> You can do return error(...);
> 
> > +       }
> >         return the_refs_backend->rename_ref(oldref, newref,
> > logmsg);
> 
> LMDB backend can't deal with per-worktree rename. So either forbid
> per-worktree rename here too, or fall back to files backend.

Will do, thanks.
