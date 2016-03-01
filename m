From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 30/33] refs: break out resolve_ref_unsafe_submodule
Date: Tue, 01 Mar 2016 14:17:39 -0500
Organization: Twitter
Message-ID: <1456859859.18017.79.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-31-git-send-email-dturner@twopensource.com>
	 <56D5CF9C.4010808@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	peff@peff.net, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 20:17:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aapnn-00073z-AR
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 20:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbcCATRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 14:17:43 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34682 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbcCATRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 14:17:42 -0500
Received: by mail-qg0-f45.google.com with SMTP id b67so150438750qgb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 11:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=yseMusD7Ni+Nnl0GN48KZUwnAKneKSQ+x1qJYN+8h7Q=;
        b=AmxW+997AiIxqJveYRMhiuf8SBeZJgoM1txLKabgd7ncuiKSsHVXdG+2xbHP9xivTK
         uI14Igz2raKdbpblk3ucs6MDJTjObyTnKBJDBQUE5x97G7pnTpPEgxW0Tv6pG3+yNL1g
         7FlZwbhE+u16JONyC43cvtq2BWahi5ZVLPcxBGmyusJTQSGZZhi5/4a4OXGcl8SmBwm+
         dTsy9DT7L9VEVegEvCd+wNCe8YT7O2WpBUTcNKdm/iyvvGJ39tCKLwQIH3xnYCNuXk7G
         HFWzSQUtqyDloMsOA2fC6CaOFEMyVXwSfxnjE7s35e7/OdscJJtw54pa68L7iEg4T5z6
         4oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=yseMusD7Ni+Nnl0GN48KZUwnAKneKSQ+x1qJYN+8h7Q=;
        b=fSnhqYS/G6eHpxfn9EPXKqp5PC8gpaPRQwK5M8MbJav96AVMYLJQjeQXUFnU//3u6C
         D+wD7EFwzrI4aHExUDsjYCiCNGpq7RMUoifhE3RR9pfsuzmny0ZO17abQ24Mhz2O4fmJ
         39NUPN5092tJudvl3GBBB2Ig0pQtlbPGKsDjtf+diqnHkJnjBvJvqd4uAtaX9Sb/g4pN
         pTMH6E3jw5Ui28Ocf+tTR16UjyLuMSfxfKQZbX2Z1mFup3mOVeCnwjtHAIVk0I11efH5
         wzNQeDP6IrGKrDm7IucFpOoDBc5v/km6nXBCuROEJUr637EmabK6RCA2WOywekUVLmTV
         OCgg==
X-Gm-Message-State: AD7BkJIwoEFWQSMK4cT/dOuMObmLkbnMiHe1VQuiIk2mKedL2VG61zTIP6Mao3ebCH4q6g==
X-Received: by 10.140.93.65 with SMTP id c59mr28212839qge.101.1456859861461;
        Tue, 01 Mar 2016 11:17:41 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id u202sm13539964qka.43.2016.03.01.11.17.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 11:17:40 -0800 (PST)
In-Reply-To: <56D5CF9C.4010808@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288056>

On Tue, 2016-03-01 at 17:21 +0000, Ramsay Jones wrote:
> 
> On 01/03/16 00:53, David Turner wrote:
> > It will soon be useful for resolve_ref_unsafe to support
> > submodules.
> > But since it is called from so many places, changing it would have
> > been painful.  Fortunately, it's just a thin wrapper around (the
> > former) resolve_ref_1.  So now resolve_ref_1 becomes
> > resolve_ref_unsafe_submodule, and it passes its submodule argument
> > through to read_raw_ref.
> > 
> > The files backend doesn't need this functionality, but it doesn't
> > hurt.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  refs.c               | 41 +++++++++++++++++++++++++---------------
> > -
> >  refs/files-backend.c |  8 ++++++--
> >  refs/refs-internal.h | 19 ++++++++++++++++---
> >  3 files changed, 47 insertions(+), 21 deletions(-)
> > 
> > diff --git a/refs.c b/refs.c
> > index 5fe0bac..d1cf707 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -60,6 +60,9 @@ void register_ref_storage_backends(void)
> >  	 * entries below when you add a new backend.
> >  	 */
> >  	register_ref_storage_backend(&refs_be_files);
> > +#ifdef USE_LIBLMDB
> > +	register_ref_storage_backend(&refs_be_lmdb);
> > +#endif
> 
> Again, just skimming patches, ...
> 
> The lmdb refs backend (hence refs_be_lmdb) is not introduced until
> the next patch [31/33], right?

Yep.
