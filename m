From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 01:22:18 -0700
Message-ID: <20140612082218.GA5419@hudson.localdomain>
References: <cover.1402557437.git.jmmahler@gmail.com>
 <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
 <539960B8.1080709@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Jun 12 10:22:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv0HF-0005F7-E5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 10:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbaFLIWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 04:22:23 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:45095 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbaFLIWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 04:22:22 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so765768pad.38
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7Zq55E3KqiZcg1ESllG1fFa9klLR13PnznJa3Sk8tqA=;
        b=oHNaoEKeyd1wOpjhlVVW8yq3Zhl5tDOO5LH05wFujmM7eA/TG8w584uKsH/nfrBuRe
         zdk8j6Q/OpULXfffR2W68DRMOJHknxXB+WKKoxP9023v/ikL8lF1N8ZuNMm+JxImq2wX
         uMzF/u7VQt0msAZDstpI45zhsTsTHBQ17nQftI/rgPxVnoV39f72IxqvcLW8Bq2Jzw7v
         AA8sb9OWKdsJ2jIdHtvk30/R3I8nRUk6tUam6XT0acR8KklzW7zNZSObdIRzUXGI6poh
         9hxYsHXTP8N+HOFuLW5WoAKHaCZcGlBVNOFhbJ+X5Ryjk0NPtOStDKAmKJRky+Pq8Bmu
         vTZw==
X-Received: by 10.68.189.137 with SMTP id gi9mr11029814pbc.79.1402561341365;
        Thu, 12 Jun 2014 01:22:21 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id cz3sm79090714pbc.9.2014.06.12.01.22.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 01:22:20 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <539960B8.1080709@virtuell-zuhause.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251403>

Thomas,

On Thu, Jun 12, 2014 at 10:11:36AM +0200, Thomas Braun wrote:
> Am 12.06.2014 09:29, schrieb Jeremiah Mahler:
> > A common use case with strubfs is to set the buffer to a new value.
> > This must be done in two steps: a reset followed by an add.
> > 
> >   strbuf_reset(buf);
> >   strbuf_add(buf, new_buf, len);
> > 
> > In cases where the buffer is being built up in steps, these operations
> > make sense and correctly convey what is being performed.
> > 
> >   strbuf_reset(buf);
> >   strbuf_add(buf, data1, len1);
> >   strbuf_add(buf, data2, len2);
> >   strbuf_add(buf, data3, len3);
> > 
> > However, in other cases, it can be confusing and is not very concise.
> > 
> >   strbuf_reset(buf);
> >   strbuf_add(buf, default, len1);
> > 
> >   if (cond1) {
> >     strbuf_reset(buf);
> >     strbuf_add(buf, data2, len2);
> >   }
> > 
> >   if (cond2) {
> >     strbuf_reset(buf);
> >     strbuf_add(buf, data3, len3);
> >   }
> > 
> > Add strbuf_set operations so that it can be re-written in a clear and
> > concise way.
> > 
> >   strbuf_set(buf, default len1);
> very minor nit: missing comma between default and len1.

I can't believe I missed that.  Good catch ;-)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
