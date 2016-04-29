From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 19:21:48 -0400
Organization: Twitter
Message-ID: <1461972108.4123.43.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
	 <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
	 <57230F71.2020401@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:21:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHjQ-0003D1-Il
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbcD2XVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:21:53 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34683 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbcD2XVv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:21:51 -0400
Received: by mail-qk0-f170.google.com with SMTP id r184so52471501qkc.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=F2ezArMMM1jYoXXQzaYIJlshsxK8biYvMvZMbXh2cac=;
        b=EK9h8Cl97QvRLumZBwEjXwxdGpzxFu2AjAKyPkJBsiWohRDxlWdDK3F50icXoeQkAm
         QPNWC1RvNm+DDOtfx4gZK1bjgfa97nKBXCVVwrrC2xQlUyRXeIMdSmMP5BgcBULNBKIN
         EP8DwmkbXuThWb3gSFrA8fDYyr6y5Yqlb8XO3le8eUphgsQohu0St78bamgF/IbWLAj5
         dc+GVC8tosUQ4EmrX8VpjTfpgs7HuamBbir+nPW9dnxKoCq/isRLBWHx1J4wEx+R++iT
         LF60N/v7r3Pyb6e+QKMz3hYjOS47p/9AITXqorb03oewjVFsIvOIT8OfDIWEme+PTdOW
         f7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=F2ezArMMM1jYoXXQzaYIJlshsxK8biYvMvZMbXh2cac=;
        b=lZbhzz7FNQli73d5p11G2FFRFtkrYQ8U7o21yTJ31B3JOnt6BykQeneVqB7/HT1OHt
         tzvWgPtSymf83R98XMpsUxg38tLhM+4p5pwIo9jXRxfsc5jsDq/jDImrO1pcn77xRX2/
         Ii3KS33O8pQnnxG49yLeB0myP0N5fc/qxV/xTQO/EDLvEaMmh2c3xxWnnZpWuDFPG8uF
         S5nXkbMKVlpcsGuIzMnterDMVEke3aXPnHXcE4OdS8rDPm2k8YDFrMeys45S9U72nw73
         AZ1Qnmgy1GEpb/oES/KGn6dDv1sG+zNnqU35lSowKPx/Iq3PUn4plz4+6BnJib4C58/F
         kfSg==
X-Gm-Message-State: AOPr4FV7Nb76wR0RBCDY2pPf2mNQsguctBWPx6kf1L/BLo1nHWfEdpwgH2b6nElFnFlUIg==
X-Received: by 10.55.41.27 with SMTP id p27mr21944691qkh.84.1461972110595;
        Fri, 29 Apr 2016 16:21:50 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r136sm5208825qke.46.2016.04.29.16.21.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 16:21:49 -0700 (PDT)
In-Reply-To: <57230F71.2020401@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293069>

On Fri, 2016-04-29 at 09:38 +0200, Michael Haggerty wrote:
> On 04/27/2016 08:55 PM, Junio C Hamano wrote:
> > Michael Haggerty <mhagger@alum.mit.edu> writes:
> > 
> > > @@ -2380,8 +2381,8 @@ int rename_ref(const char *oldrefname,
> > > const char *newrefname, const char *logms
> > >  		goto rollback;
> > >  	}
> > >  
> > > -	if (!read_ref_full(newrefname, RESOLVE_REF_READING,
> > > sha1, NULL) &&
> > > -	    delete_ref(newrefname, sha1, REF_NODEREF)) {
> > > +	if (!read_ref_full(newrefname, resolve_flags, sha1,
> > > NULL) &&
> > > +	    delete_ref(newrefname, NULL, REF_NODEREF)) {
> > 
> > Could you explain s/sha1/NULL/ here in the proposed log message?
> 
> Good question.
> 
> Passing sha1 to delete_ref() doesn't add any safety, because the same
> sha1 was just read a moment before, and it is not used for anything
> else. So the check only protects us from a concurrent update to
> newrefname between the call to read_ref_full() and the call to
> delete_ref(). But such a race is indistinguishable from the case that
> a
> modification to newrefname happens just before the call to
> read_ref_full(), which would have the same outcome as the new code.
> So
> the "sha1" check only adds ways for the rename() to fail in
> situations
> where nothing harmful would have happened anyway.
> 
> That being said, this is a very unlikely race, and I don't think it
> matters much either way. In any case, the change s/sha1/NULL/ here
> seems
> orthogonal to the rest of the patch.
> 
> David, you wrote the original version of this patch. Am I overlooking
> something?

I think I might have been handling some weird case related to symbolic
refs, but I don't recall the details.  Your argument seems right to me.
