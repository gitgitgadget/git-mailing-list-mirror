From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 19/19] hack: watchman/untracked cache mashup
Date: Thu, 17 Mar 2016 14:08:39 -0400
Organization: Twitter
Message-ID: <1458238119.9385.15.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-20-git-send-email-dturner@twopensource.com>
	 <CACsJy8DGEQJmhxZpX3Zd=tGk_9T0n+ZhcaaEahaqFuh6NRvgSQ@mail.gmail.com>
	 <1458176165.9385.9.camel@twopensource.com>
	 <CACsJy8Cx7LnPC1+17qov_pJK9OMpYtdOzS_uTBh5Fnr=A8z_OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:08:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcLm-0003Xr-Hj
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936297AbcCQSIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 14:08:44 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33000 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933880AbcCQSIm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 14:08:42 -0400
Received: by mail-qg0-f41.google.com with SMTP id a36so47362233qge.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=lKbj0zCCjeeIHSn1CkTuQh/enq4ra5utko6JDcwWS2I=;
        b=zeLDHGRW1U+YQsZ7ui2AnSRDbFUb8Ij0hq8Mhs6EhP7OjEqNf4tSpNcfe6dJcNv1U8
         a+QGGKxngBPLu0FwDzJ9te49OBy1vygnYL92gWIwYzcW+p3WuyRH2cTK9uRc9S9FPcf1
         d7HXbTmNJmSpU2pS0Liqm5+j6bET4lQGCi27IyUjhBQkbxGO84t8sRoeEuO92hDA3Huw
         1IMhw5g76zD53QsxGFalocRCrG5sYtnACO/G0+dc+V1IiZxMzIu4t5qXMsgeVuJzrSDE
         Q1sWYgnfc1TBM2DxA0lSZnECdzUBW8cqg9Px8MUvOcl0bq0h/y8NJwMXN/V1e/cmwKvw
         csYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=lKbj0zCCjeeIHSn1CkTuQh/enq4ra5utko6JDcwWS2I=;
        b=Lq2GmwC+T+Qfua+J5unt/aAKqmV4t2SrEPXQP2NqAFDkTI26SSETuwqdgb8qTRA+MU
         +voapFC3Wql9J7OaaTerbMtBTtGA2pvsfYt2dWStgL6mh7v6ZxMzjuY5jVcxzbbva8fQ
         iuCH6VQ35BqNzA9wQfMjDsj9K567MLh7x3QhkJsvJV8JEroh/i1G4/ZVUr9zadpAolKo
         wiQq/P1sK99PuQa+t2IxzaNOweRfCHc1x/2vU+8gxMF5drofnVs6ylKYlRjmoCt4XxRG
         EORHGlo68x9HXt8NxrPiI3UJHzV0E0a1HxTjxLftE67DZDRZS4n50EUuKOKPo8xHOjaW
         Uu+Q==
X-Gm-Message-State: AD7BkJLBppQ9vZs/Wm0LXFlpujZWCsrp7Pb4ce3FPzzlDhqvfkUgzy8OTBMzmRtyEboP1Q==
X-Received: by 10.140.133.133 with SMTP id 127mr17253438qhf.42.1458238121193;
        Thu, 17 Mar 2016 11:08:41 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y187sm250387qhy.49.2016.03.17.11.08.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2016 11:08:40 -0700 (PDT)
In-Reply-To: <CACsJy8Cx7LnPC1+17qov_pJK9OMpYtdOzS_uTBh5Fnr=A8z_OQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289135>

On Thu, 2016-03-17 at 20:06 +0700, Duy Nguyen wrote:
> On Thu, Mar 17, 2016 at 7:56 AM, David Turner <
> dturner@twopensource.com> wrote:
> > > So if we detect an updated file that's not in the index, we are
> > > prepared to invalidate that path, correct? We may invalidate more
> > > than
> > > necessary if that's true. Imagine a.o is already ignored. If it's
> > > rebuilt, we should not need to update untracked cache.
> > 
> > Yes, that's true.  But it would be true with the mtime system too.
> > This
> > is no worse, even if it's no better.  In-tree builds are a hard
> > case to
> > support, and I'm totally OK with a system that encourages out-of
> > -tree
> > builds.
> > 
> > We could check if it's ignored, but then if someone changes their
> > gitignore, we could be wrong.
> > 
> > Or we could suggest that people make their watchmanignore match
> > their
> > gitignore.
> 
> So your purpose is to reduce stat() on those "quiet" directories?

Yes.  Twitter's repo is perhaps somewhat unusual in that it has a very
"bushy" directory structure -- tens of thousands of directories.
