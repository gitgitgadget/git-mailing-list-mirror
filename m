From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Thu, 31 Dec 2015 16:43:00 +0100
Message-ID: <1451576580.11138.14.camel@kaarsemaker.net>
References: <xmqqk2nvd0cz.fsf@gitster.mtv.corp.google.com>
	 <20151230233301.GA9194@spirit>
	 <xmqq37ujcwny.fsf@gitster.mtv.corp.google.com>
	 <1451552227.11138.6.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 31 16:43:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEfNf-00037z-3l
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 16:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbbLaPnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 10:43:05 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35630 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbLaPnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 10:43:04 -0500
Received: by mail-wm0-f51.google.com with SMTP id f206so66192678wmf.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=NApTSWKr9znXcg9Cr5WhwaLG7LZWfr2ywh3mNxC8v7w=;
        b=i1A3ZxTLmwsvqURVItHDvLqF9zKebWr4ef1nmWPYn+zMMuDl/OsqfpDJYGgTOBrPul
         EqJj9Hu3++vKCxgv+EWF8QFEMKxCXUs8Y64Jj5BRwb5Tq+iSx4uJfDPyWfjYfPZfRLT3
         PqNdWuzOsO9sl1B1blHawDwXUkoQiQIfxNiag08PHT/XNQ3Q6FrUHuK/0PaiyyOMMyOa
         trwGaHRrciFRHedaKOnGRpRZaYS2Ph/qzQmQlFk47NjSOuTJWhqgGvJiOKwO+fnzzEXj
         qM48oPtt1U+B7XXJfU/5VTzdmJlSNKE4MpWeqItT+kv5qCm8gh2qOk/SWn6Z6hN1zb9F
         1/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=NApTSWKr9znXcg9Cr5WhwaLG7LZWfr2ywh3mNxC8v7w=;
        b=GtBtztM/ekmry4lvIAj5yAf6VOIkvt/CwUC87Mms8uzuLDhXMkQ1tNT8jKMDdH+lGG
         Ofqs30CqXI3tuJQ2Q/cjQmUduSTfFUI/ZR0JavcfRu9Y98tZoFN4wbfaUZVgECbI6DFQ
         43x+R+YgNhIgiXMR76Q2G1pr65htu/gq6Q9NMi9EjOXCWNsuJOzc4ufpAp0ltg+UGuWW
         JhhxTUrmUpGFHvG8rlclpdmL4fTnbnHFsAe+yYqTL5Yxu4WS21TzR5c7xQUlYRyAb2z8
         ZQOJqg8QGV00S2NL4PXMI6LLARXkfhXvN1FBlRu0AuZXQgSbstfbKUU4iARa1MZdplcB
         rBcg==
X-Gm-Message-State: ALoCoQmznnGODA+Xz0O8Wub4yyEb4GwxV3HfUPkdvvWb8bkju9TpOg36QZ3Jcq9TGohS+mJAYu/6jrolrD1M8ykGQ1qfm9wp+g==
X-Received: by 10.194.82.199 with SMTP id k7mr70070193wjy.65.1451576582025;
        Thu, 31 Dec 2015 07:43:02 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id q4sm70293138wja.6.2015.12.31.07.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 07:43:01 -0800 (PST)
In-Reply-To: <1451552227.11138.6.camel@kaarsemaker.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283245>

On do, 2015-12-31 at 09:57 +0100, Dennis Kaarsemaker wrote:
> > > +test_expect_success 'reflog containing non-commit sha1s displays
> > > properly' '
> > 
> > In general, "properly" is a poor word to use in test description
> (or
> > a commit log message or a bug report, for that matter), as the
> whole
> > point of a test is to precisely define what is "proper".
> > 
> > And the code change declares that a proper thing to do is to omit
> > non-commit entries without segfaulting, so something like
> > 
> >     s/displays properly/omits them/
> > 
> > perhaps?
> 
> I did find the test title a bit iffy but couldn't really figure out
> why. What you're saying makes a lot of sense, will fix.

Thinking about it a bit more: 'proper' would be to show everything, we
just expect that not to work yet. So I'll make it

test_expect_failure 'reflog with non-commit entries displays all entries' '
	git reflog refs/tests/tree-in-reflog >actual &&
	test_line_count = 3 actual
'

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
