From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 12 Apr 2016 20:32:04 -0400
Organization: Twitter
Message-ID: <1460507524.5540.73.camel@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
	 <1460153784.5540.19.camel@twopensource.com>
	 <1460417232.5540.53.camel@twopensource.com>
	 <CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
	 <1460482108.5540.59.camel@twopensource.com>
	 <xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, aevarb@gmail.com,
	jeffhost@microsoft.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:32:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8j9-0002AE-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbcDMAcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:32:08 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34516 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758887AbcDMAcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:32:07 -0400
Received: by mail-qg0-f45.google.com with SMTP id c6so31035892qga.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=j/hX0mi/lS6MPoQCm1i0m0KqLT8MqdC40xSdBG77VjI=;
        b=h7Las+BHBQBKEkK/z5hjAlhjunMjBn3a/1U4Oe68PU6J+kenE6WmAJTf5+7pqy6yVb
         P81XvA9UcLFa8BFs7P+ujaODOV6u0TUBhsHUi5WtZG/I/BNPWhOgtn/aH62SCM1/nPM5
         aUcwuM+80gfi2vjX2n3pJZjF0oqnSKP3oI9vM5n0VS+AqXd61bw9ehrBmdZYQ4rgUXC2
         aNbo9mu1hS26rjfbyk7w80DPaS4HK4DgWfOlqOt+F5E5erANgflHYWl9ZyGgIp8LX9lg
         rjsQxCMO6w+Oy68IXPhbmXKm6wrZjJBbzube+6Bv/0s16sQCeGwancJ5MYRWHvbPkgLj
         hujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=j/hX0mi/lS6MPoQCm1i0m0KqLT8MqdC40xSdBG77VjI=;
        b=DAMQ7AINEstnk4+dJjbnoXokUgoyyBDienx6qmLtqkDfUJD5x8VLHvhe9i2xyv4acO
         O2AtWaSpdEmJGbaygaRZ9m8RTeSI0jz4C63fZdZqNXccCXLWV96dIstjSoAAzCypGQ7x
         TGjfhYEriA8WWi7IYj4PJS4g+elE0JCMZpN31r+Ym8eLy6+y6NPTjYYkovuG6JsNnl/1
         2SI9NbXo3rBVbszABoliy6ZWtN4la8KV4pLctmr7AUYt/rkTQxnTAfJdgmqp+jRZ2hSM
         HhmlOt1DSFCxQUf047T/ma0K8R4DL30WRqlGEEGqhoIaUykhzUsBFY6HfdwjhR2r9iB2
         KnRg==
X-Gm-Message-State: AOPr4FVHDt4ZhK50WA2fqHigcY78RM8RW+sCQJjrZ4NvHNzqszTFTn0OH7nJGxFv2POvEg==
X-Received: by 10.140.104.180 with SMTP id a49mr7679765qgf.26.1460507525602;
        Tue, 12 Apr 2016 17:32:05 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y89sm14788125qgd.5.2016.04.12.17.32.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:32:04 -0700 (PDT)
In-Reply-To: <xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291336>

On Tue, 2016-04-12 at 11:05 -0700, Junio C Hamano wrote:
> > >  - access is slow (unless cached, but we can't be sure)
> > 
> > We could solve this (and the other problem) with mlock.
> 
> Probably you meant madvise(2)?
> 
> For something of a size comparable to the index file held by
> index-helper-daemon in-core, I'd expect we wouldn't page too
> badly.

No, I meant mlock -- but I guess that's not portable.  madvise with
MADV_WILLNEED will probably do the job.
