From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 03/14] upload-pack-2: Implement the version 2 of
 upload-pack
Date: Mon, 02 May 2016 14:56:15 -0400
Organization: Twitter
Message-ID: <1462215375.4123.69.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-4-git-send-email-sbeller@google.com>
	 <1462210997.4123.49.camel@twopensource.com>
	 <CAGZ79kavBUohoMcC3iEws5mVBQ6HZsR=HyBoxM1jxUVJ6Z1jkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:56:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJ15-0001Sc-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbcEBS4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:56:20 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33395 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbcEBS4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:56:19 -0400
Received: by mail-qg0-f45.google.com with SMTP id f92so73527156qgf.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wrNd2n95+Gw+4nOqzjT/X5GkfEeb2LTamTxp3HIYj10=;
        b=g7sj000oZOPnZzUqWE0AlBz8kkoPMigY58UacKcS6MS7uqffMZdJRFTh0xguPoqJAx
         F7jMiNSweBxRGhFE7QK2jxFORkJjTO0QpgWhHCdqiPn0aNED+ShChinJgH1gz1iQj44B
         RTf7L8yeEatsXFTFWo3vPY5jGEJ9nI20/0HPnkXMUpaSeUrpccBUgTgy59VV75Zd1mcO
         npGophTV+ATLjBa3ZJSHOn1Pv1AcGOz/FqZf0OSdk5NqmyYkT2g0e0nBOIUSzlyHBhQu
         Ns/VA8OefiaTHkz/1ActHDgE/2HVCSqmAlkE+zuoEAR72JHQs1WqjpWwIYiqen8MtWIX
         07cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wrNd2n95+Gw+4nOqzjT/X5GkfEeb2LTamTxp3HIYj10=;
        b=EykijLMEuqFJ/jAnbXDJX611gWBZ2GEcEH4jwqZ2mc1EipSJa/yzFJTqIYK64FfXxF
         K7FaZu3O1bNn9T8QU+hZQHwy83t0R94IC2VLZwBFj/6BN6t+Qulbotj952ikR6KLNbJd
         uSfUBleaGjL0FRjnLKreJAjudPkGbLdEhDnSE1qRBDgdosGqdKReBDzVucOPbKY/mqTF
         0tfrkoZUGE6icE/olyxo+gcB/+I5mOvLLsZSFfN+dBUj0ys4JLsm3wwzppZTZmcmHMfl
         EsdFCawo7xct9eqDK47eDUkXSR6sIaLjbnZCbKLhy7D4helO8TfYl9/1AshW9lA7TYgF
         tqQA==
X-Gm-Message-State: AOPr4FXVT+OdZHalBxqhwekqyzQhSNyA4JNj+Hclt27GB4N5sz4hYqX8A9MlgDTsKvnFXQ==
X-Received: by 10.140.175.193 with SMTP id v184mr36018016qhv.23.1462215378019;
        Mon, 02 May 2016 11:56:18 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id c193sm9677044qkg.43.2016.05.02.11.56.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 11:56:16 -0700 (PDT)
In-Reply-To: <CAGZ79kavBUohoMcC3iEws5mVBQ6HZsR=HyBoxM1jxUVJ6Z1jkA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293267>

On Mon, 2016-05-02 at 10:51 -0700, Stefan Beller wrote:
> On Mon, May 2, 2016 at 10:43 AM, David Turner <
> dturner@twopensource.com> wrote:
> > On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> > > In upload-pack-2 we send each capability in its own packet
> > > buffer.
> > > The construction of upload-pack-2 is a bit unfortunate as I would
> > > like
> > > it to not be depending on a symlink linking to upload-pack.c, but
> > > I
> > > did
> > > not find another easy way to do it. I would like it to generate
> > > upload-pack-2.o from upload-pack.c but with '
> > > -DTRANSPORT_VERSION=2'
> > > set.
> > 
> > Couldn't we check argv[0] and use that to determine protocol?  Then
> > we
> > could symlink executables rather than source code.
> 
> IIRC I proposed a similar thing earlier, i.e.
> 
>     if (argv[0] ends with 2)
>         do_protocol_v_2(...)
> 
> but that may break (and confuse a lot!) some use cases.
> `git fetch` has the documented --upload-pack switch, so as a server
> -admin
> you are free to have git-upload-pack linking to
> "git-upload-pack-2.8" but additionally you still have
> "git-upload-pack-1.7" or "git-upload-pack-custom-2".
> 
> so I think we should not do that :(
> I do like to symlink the executables though.

I think it would probably not break anyone if the new executable name
were sufficiently distinctive -- e.g. starts_with (strrchr(argv[0],
'/'), "git-upload-pack-protocol-v2"). But it would make custom
executables a bit more complicated for the future.

I guess it is better to have silly source code but clean binaries than
clean source code but silly user-visible rules.
