From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] test: improve rebase -q test
Date: Tue, 28 May 2013 21:38:41 -0500
Message-ID: <51a56a31947d6_807b33e1899765@nysa.mail>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
 <1369745671-22418-5-git-send-email-felipe.contreras@gmail.com>
 <7vvc6311dr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 04:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWKP-0007fS-9j
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 04:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406Ab3E2ClZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 22:41:25 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42878 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366Ab3E2ClY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 22:41:24 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so2236727obb.32
        for <git@vger.kernel.org>; Tue, 28 May 2013 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=vOsvJAlGiPGULzX7f7HIHpPvEFMUFVmzTeYA0bU//k0=;
        b=sQPchm+rOhEcmkNMafLYb68TMT5jbRuQOuJEanHIpjX96ExnZtaao4Kf3N5DtTukpN
         cK51yb1c6Y8mtyGGtXWhTQbZNygapPr7FUFiNQsUHbCmxgCRjX5XC+FWZVmaejm2SUIX
         2Q32WwAy2sDS47Jy4xteCPOp5+Vm9e5VHWAl7RRBak6PwaPDHvsg3T00MOA2T+X3PP0P
         CD2c8J4OS9WdjRNw44lv7D7OpD7VoAkCOxfZzWphNp0LZw99ex209atZp50YFGHGJ6YQ
         U73hxQxAQ/gU+Dk1YByGFBgEJMR9HqHpRgMTd29wdH4Lk/Dalp5X6QNtrWCdchVrXo56
         IpPg==
X-Received: by 10.60.59.163 with SMTP id a3mr409918oer.45.1369795284113;
        Tue, 28 May 2013 19:41:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm38036084obb.5.2013.05.28.19.41.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 19:41:23 -0700 (PDT)
In-Reply-To: <7vvc6311dr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225701>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Let's show the output so it's clear why it failed.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  t/t3400-rebase.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> > index b58fa1a..fb39531 100755
> > --- a/t/t3400-rebase.sh
> > +++ b/t/t3400-rebase.sh
> > @@ -185,6 +185,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
> >  test_expect_success 'rebase -q is quiet' '
> >  	git checkout -b quiet topic &&
> >  	git rebase -q master >output.out 2>&1 &&
> > +	cat output.out &&
> >  	test ! -s output.out
> >  '
> 
> It is one thing to avoid squelching output that naturally comes out
> of command being tested unnecessarily, so that "./txxxx-*.sh -v"
> output can be used for debugging.  I however am not sure if adding
> "cat" to random places like this is a productive direction for us to
> go in.
> 
> A more preferrable alternative may be adding something like this to
> test-lib.sh and call it from here and elsewhere (there are about 50
> places that do "test ! -s <filename>"), perhaps?
> 
>         test_must_be_an_empty_file () {
>                 if test -s "$1"
>                 then
>                         cat "$1"
>                         false
>                 fi
>         }

Perhaps, but I'm not interested. I'm tired of obvious fixes getting rejected
for hypothetical "ideal" situations that we'll never reach.

-- 
Felipe Contreras
