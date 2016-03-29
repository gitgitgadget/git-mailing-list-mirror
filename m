From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 08/17] read-cache: invalidate untracked cache data
 when reading WAMA
Date: Tue, 29 Mar 2016 17:22:52 -0400
Organization: Twitter
Message-ID: <1459286572.2976.8.camel@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
	 <1458349490-1704-9-git-send-email-dturner@twopensource.com>
	 <CACsJy8DQGadWodE3x0K+h5x75Hrf7QtcCwTC2zOgE_YiwtXc3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:23:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al16J-0002OU-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 23:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157AbcC2VW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 17:22:56 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35860 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbcC2VWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 17:22:55 -0400
Received: by mail-qg0-f48.google.com with SMTP id w104so18010246qge.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=jt8Ooi4BIjBLrytQoycaXw2fD0OPHXHIyJ1Ip+wwqrI=;
        b=SyLz0ywRvMvU3dA8Gf6mL/0rwTTZlYqeoJSIKN3SfzeYoX1YcTuP8q6wHdPqFDt+3A
         2pN2v54hxfa/d6j5nJKgYbUzvDM+66ak5JSfNf52+Rv3AXzBDNAOyNYGSk+otohNbEI6
         qORiiaiKvCb7CjK7rvBZXEkOVCP3lUVzHm6SsUZJtJrh8wFIUXxde1eK6a12o0syCR1A
         hkwUHvUpgqGeb6666tfha7PaqyUprRQFcc4wwGZ7Qm2ZPI6rqaBX/e5RccvDtmvZEzET
         7AaxBfS1f/LLmNJFS+DkS8G/y1x0t4BR1DUmUtrZxUN8DHsJjSGY4b5H/D8iEn04Lpja
         3zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jt8Ooi4BIjBLrytQoycaXw2fD0OPHXHIyJ1Ip+wwqrI=;
        b=buApEaRv+e7X2Om2lkQ1fQIOtqkIvfb3rX4WDwl6wPTshVjTQqjreJdAjtQ6VepRWk
         akOSupZ3f0cuc6gotPSgjMZdYUtamMJd/OosMelOtRJZJauoDrWjMdJ7yR/s4j0cdKIK
         kbl2BbGrNQB49IzRKwUOWAPn0AY+jW0+GBbO83w2jOG33nCynVL+hXS44TR5J/Qtdy98
         Y11mHbLSpQ2xWlmxoLhIdySlBQCgq4rXAqWupcnPRfF1WBuWItS8AHaHestrRvlo5xrv
         le8ItFeZXi/PZgdlklZWe21Izw4V//dgbnAaB1CbWhJUiIwyFv3XtbQcTz0EmWtYKutW
         Gcxw==
X-Gm-Message-State: AD7BkJKyYTpiBDSusVIVjn3dhPFmt0Rb4iug1WVO9uNB3UXX011Va5zUOy4HGif0NkkHeA==
X-Received: by 10.140.222.136 with SMTP id s130mr6086626qhb.62.1459286574047;
        Tue, 29 Mar 2016 14:22:54 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id a91sm309023qga.29.2016.03.29.14.22.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2016 14:22:53 -0700 (PDT)
In-Reply-To: <CACsJy8DQGadWodE3x0K+h5x75Hrf7QtcCwTC2zOgE_YiwtXc3Q@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290198>

On Tue, 2016-03-29 at 09:50 +0700, Duy Nguyen wrote:
> On Sat, Mar 19, 2016 at 8:04 AM, David Turner <
> dturner@twopensource.com> wrote:
> > @@ -1407,10 +1472,24 @@ static int read_watchman_ext(struct
> > index_state *istate, const void *data,
> >         ewah_each_bit(bitmap, mark_no_watchman, istate);
> >         ewah_free(bitmap);
> > 
> > -       /*
> > -        * TODO: update the untracked cache from the untracked data
> > in this
> > -        * extension.
> > -        */
> > +       if (istate->untracked && istate->untracked->root) {
> > +               int i;
> > +               const char *untracked;
> > +
> > +               untracked = data + len + 8 + bitmap_size;
> > +               for (i = 0; i < untracked_nr; ++i) {
> > +                       int len = strlen(untracked);
> > +                       string_list_append(&istate->untracked
> > ->invalid_untracked,
> > +                                          untracked);
> > +                       untracked += len + 1;
> > +               }
> > +
> > +               for_each_string_list(&istate->untracked
> > ->invalid_untracked,
> > +                        mark_untracked_invalid, istate
> > ->untracked);
> 
> I think it's a bit early to invalidate untracked cache here. We can
> do
> that in refresh_by_watchman() in 10/17, where ce_mark_uptodate() to
> prevent lstat() is also done.

Will move/squash
