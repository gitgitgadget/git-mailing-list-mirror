From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 23:35:00 +0100
Message-ID: <20160118223500.GK7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
 <20160118195159.GD1009@sigill.intra.peff.net>
 <20160118220913.GI7100@hank>
 <20160118222012.GA24740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 23:34:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLINj-0006fI-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 23:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666AbcARWeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 17:34:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36667 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbcARWef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 17:34:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so19311050wmf.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 14:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=isgPiuB8MUzu0teLmVfMk1X7MNvVJsbQchmVeMF8O7U=;
        b=OZRdbu53zIiU/qhNSGqbsmcahdWy4hXScHMy9hFPx9M3ncqjlvVMGNilonjaK+ZaN+
         7K+X1nvRebmGCjPVypienIf7FOQDPfokRZxQnBDh5vgJ0OWNXDdmgGhLrxaW7ws6SvnX
         2VaGYuaV5rlQh2sKrHcjKnkFGHJ3Ho7ebZF4L3HKy9yGGUL+n4TQThdx0/oJeD/b9Ifk
         N2o4VqsW1mxLOb8+0GXeLBJ8fXoP3/FWN36iMjIZnfWRnTGkdCCWN4Fc5Igp5bG57Ve8
         T9yHt1EoNCiABf47cP00/H7fQse9NX5yCL1cW9hO3XYijzoNjjFHXvZTbwkeB29hRX1I
         GdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=isgPiuB8MUzu0teLmVfMk1X7MNvVJsbQchmVeMF8O7U=;
        b=f7+e26d8tBemwpqyfl/dUvkTN5efslK5leJ1tyDYDOgRR3RhDFZTSEJJzuRrVHFJP6
         GKF3pWWkr3nAnYscOyDGtRIYqvsdPGFh54hpja/E5RRYfo/qV2VutZQQleSU/Gz44j52
         s8dNDxprBZZH8bH2KUddH82CQngDyJxbxxLhS4JpYt1pt1Jz6vso9JV+r3gZJRRbKgwc
         cOcTcbr7rzL9buHWS5qyq1hGvcU5XjC4EqatzYM7pwiqkUBSjvNXy+M8m9a+6iZlL7tW
         Biw2AP6gJz6TbPp3yjnhelGhqAJU1lfTbItM00reIeKe/o96Rnat+iusNiuTHCyqq4lB
         c1xA==
X-Gm-Message-State: AG10YOSCcA+wvj1ps0FXILRHA1wnYL3EC+z5vBOGZS7KOYheVxwdWXGU9WQRBu30NWMzmg==
X-Received: by 10.28.30.138 with SMTP id e132mr14649964wme.86.1453156473728;
        Mon, 18 Jan 2016 14:34:33 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id q6sm8477806wja.19.2016.01.18.14.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 14:34:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160118222012.GA24740@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284334>

On 01/18, Jeff King wrote:
> On Mon, Jan 18, 2016 at 11:09:13PM +0100, Thomas Gummerer wrote:
>
> > > +test_expect_failure 'ls-remote with filtered symrefs (--heads)' '
> > > +	git symbolic-ref refs/heads/foo refs/tags/mark &&
> > > +	cat >expect <<-\EOF &&
> > > +	ref: refs/heads/bar	refs/tags/mark
> > > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
> > > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> > > +	EOF
> > > +	git ls-remote --symrefs --heads . >actual &&
> > > +	test_cmp expect actual
> > > +'
> >
> > I'm a bit confused by this.  Shouldn't the "ref: refs/heads/bar
> > refs/tags/mark" line only show up when we use --tags, not --heads?
> > Also should refs/heads/bar be refs/heads/foo?
>
> Yes, sorry, I bungled this. It should expect:
>
>   ref: refs/tags/mark\trefs/heads/foo
>
> I changed my mind about which refs to use halfway through writing, and
> of course because it is marked to expect failure, running the test
> didn't clue me in. :)

Heh, thanks for clearing this up :-)

> -Peff

--
Thomas
