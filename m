From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 5/7] refs: new public ref function: safe_create_reflog
Date: Tue, 07 Jul 2015 19:18:38 -0400
Organization: Twitter
Message-ID: <1436311118.5521.16.camel@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	 <1435609076-8592-6-git-send-email-dturner@twopensource.com>
	 <559AAB18.1090701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 01:18:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCc8U-0001xs-RZ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 01:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310AbbGGXSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 19:18:43 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35368 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbGGXSl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 19:18:41 -0400
Received: by qget71 with SMTP id t71so92183060qge.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 16:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CfPQ7MyRIlaD/0ge/iCmbaEkKoCtxtss96RyMbBCfvY=;
        b=KCagAGldwEYB0bk5wXMF/zppI0hMONuemEyjol2UhzPpIKP0ZclKc7wyzrO2JMyKbR
         sBmX3iSd76IK6O25YhBuYXaK1MqYmRc+y0XXUQhvXIarSbBoSeDlNMqp+k/LUeZ0xxec
         7MIuv/GqzQaCdGGX2jD2BlZqN+rq5L5GIG4Ih1NsRLngFXiuV80RUDSY2xZ+9hYEP8tO
         Ro+hIqmSlBqzpK50nWqbmjeSNc8qMGLhDuN0STq3bnlQBHUhJU2c/+ykgQdyDv3IVRTq
         GD28+mSR4VEj47eQfJJ0O9A2aYKfZSXKu1yu0s8NjDZ6OASFz84X8+yeRicpv7+MImV5
         qlDQ==
X-Gm-Message-State: ALoCoQkmaK+Frn7ijpB9dI6ondbKjrAJGqjkUFmArV7YMST4ueyLZKACNbNMhIg6qNpL8TZg20sj
X-Received: by 10.55.31.22 with SMTP id f22mr11176861qkf.33.1436311121046;
        Tue, 07 Jul 2015 16:18:41 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w68sm239727qge.18.2015.07.07.16.18.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 16:18:40 -0700 (PDT)
In-Reply-To: <559AAB18.1090701@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273618>

On Mon, 2015-07-06 at 18:21 +0200, Michael Haggerty wrote:

<snip> changes applied; will re-roll.

> > +
> > +int safe_create_reflog(const char *refname, struct strbuf *err, int force_create)
> > +{
> > +	int ret;
> > +	struct strbuf sb = STRBUF_INIT;
> > +
> > +	ret = log_ref_setup(refname, &sb, err, force_create);
> > +	strbuf_release(&sb);
> > +	return ret;
> > +}
> > +
> 
> Is it really necessary to have two functions, safe_create_reflog() and
> log_ref_setup()? I don't see any of the callers doing anything special
> with the sb_logfile argument from the latter, so maybe it could be
> inlined into safe_create_reflog()? Maybe I'm overlooking something.

log_ref_write_1 does use the sb_logfile argument.
