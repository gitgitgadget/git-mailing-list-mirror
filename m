From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 25/44] refs.h: document make refname_is_safe and add
 it to header
Date: Tue, 13 Oct 2015 14:32:41 -0400
Organization: Twitter
Message-ID: <1444761161.7234.7.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-27-git-send-email-dturner@twopensource.com>
	 <561CB3C4.1010208@alum.mit.edu> <561CCC63.8050604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm4NV-00019A-AY
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 20:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbbJMScp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 14:32:45 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32961 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbJMSco (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 14:32:44 -0400
Received: by qkas79 with SMTP id s79so12440453qka.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 11:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Cujfd1JXurtneL95JQ7KT2BHty2u/iYSAZrrloQg1yA=;
        b=PcerACAcpAki9XWLwufFItKC4g4vZVcPCKrPH0BVyYMEzlv5qzC27Sd5mx9+p6Vy3u
         uOwQyLbr3AeYLEkTW7HN7L7r//RqfmWYe/WgAUH1YNdXAkJzbmoh1t4hnCRS+xGDKwvo
         DaMFuWoUFas4N87VED+aRsKjO2AmgchsUxNbRaresG6yxZerII3h+Ct1iuKuB+GpsJRc
         LsFiFAEmIdxxfuPL2huXFviwm1T9RVkor5iW+q/FSEMkLnBbwnHPvwYeCQrHikO1iEEP
         XnvyNDDTiTRYWZzskJAqGwMJJavOWxZoao6Ma72gNaqdYiAT8qCxhxGc/pSYXgeGviQa
         fEDA==
X-Gm-Message-State: ALoCoQlN6s00wfQ7vck1PpNe+rp/Mt5Y8rAuSPPyK6Qk1DR0vDQl4tkrUPX5Ab+kyFAsYvWEyine
X-Received: by 10.55.212.157 with SMTP id s29mr41682726qks.100.1444761163485;
        Tue, 13 Oct 2015 11:32:43 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id f189sm1703624qhe.1.2015.10.13.11.32.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 11:32:42 -0700 (PDT)
In-Reply-To: <561CCC63.8050604@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279511>

On Tue, 2015-10-13 at 11:18 +0200, Michael Haggerty wrote:
> On 10/13/2015 09:33 AM, Michael Haggerty wrote:
> > On 10/12/2015 11:51 PM, David Turner wrote:
> >> This function might be used by other refs backends
> >>
> >> Signed-off-by: David Turner <dturner@twopensource.com>
> >> ---
> >>  refs.h | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/refs.h b/refs.h
> >> index fc8a748..7a936e2 100644
> >> --- a/refs.h
> >> +++ b/refs.h
> >> @@ -348,6 +348,17 @@ int verify_refname_available(const char *newname, struct string_list *extra,
> >>  			     struct string_list *skip, struct strbuf *err);
> >>  
> >>  /*
> >> + * Check if a refname is safe.
> >> + * For refs that start with "refs/" we consider it safe as long they do
> >> + * not try to resolve to outside of refs/.
> >> + *
> >> + * For all other refs we only consider them safe iff they only contain
> >> + * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
> >> + * "config").
> >> + */
> >> +int refname_is_safe(const char *refname);
> >> +
> >> +/*
> >>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
> >>   * REF_NODEREF: act on the ref directly, instead of dereferencing
> >>   *              symbolic references.
> >>
> > 
> > The previous commit deleted this comment from where it previously
> > appeared in refs-be-files.c. It would make more sense to squash this
> > commit onto that one so it's clear that you are moving the comment
> > rather than creating a new comment out of thin air.
> 
> Also, after this commit the prototype for this function appears twice in
> refs.h.

Will squash and fix.
