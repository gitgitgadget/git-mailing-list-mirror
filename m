From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] reflog: continue walking the reflog past root commits
Date: Fri, 3 Jun 2016 21:54:27 -0400
Message-ID: <CAPig+cRwvfQ3hL9XKHteGr30M4eMKZm19_UCXGxuoqsxvXje4A@mail.gmail.com>
References: <f51f9df7-d6d7-3a45-736f-ca2e2c9eb2cb@textalk.se> <20160603204235.7994-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrik Gustafsson <pvn@textalk.se>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Jun 04 03:54:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b90nL-00027F-Nj
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 03:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbcFDBy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 21:54:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35414 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbcFDBy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 21:54:29 -0400
Received: by mail-it0-f66.google.com with SMTP id z123so767146itg.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mBOGTGpqFtRxX9gb4MfqxF7u5Li7xPCH9QCQNz2gPC0=;
        b=oWY5RbgMFQLKZxqWRLDFl2mBl+dUdz8KVAmPWQ7oesx7ghwUdUIpT3j8x7RMm4B94t
         xKiCWmuUOAvB9U0W2LvQu4IJP2YmgUM4nizeGJL+lOyASU6xrC02sXcZCN4QLF/H+LDi
         ZLOEJhxtIyqZu6BruVeeV1QKR/uwIzm+66IhdR821AUjMB4a9B0JNAdOxDzM44RvsUWQ
         Dd3wmxggZL2RPkvpX165IRAENZqNOiG6FgTnsru8P1bBwfZr8yJz/rruERBvPNG3RKmD
         ThYqUezZ48thTAhIdlFsZClum9SG1CNyOy6jcYJvWqIqxY/+gcIUzRoe7diCjECA0naE
         /7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mBOGTGpqFtRxX9gb4MfqxF7u5Li7xPCH9QCQNz2gPC0=;
        b=SvEyevphbAoDHN1E+M2OrheIsAy7e+TgEJJ4+smmK06AR8xdKifq8uLreacOg6rdW1
         H3HD4D8olvdZUT7D7qC77CYotqr2+FdPac1beBsDODP5+ShCyvSFxEGmDewBOoySIlzH
         Ff5im6vl/+S8KhnezHKodMA5/DxescLqIcJvVuYxUJJ1E+truYl3jKMjZFOIEIKzH3cC
         GXZdLDZa4Cl5BVPiUz1C7QRSTYqswGsN3+SUSB3A/kpTKnMbyQX9wZF5fpYurmuDxi1m
         9Df+LRjNGvWAft6lj6bb22YGQUEXCvbJoZ77O6Uiyv8pvBLRzRQg5JhpI8SyGzkSkbFz
         dKeQ==
X-Gm-Message-State: ALyK8tLfFD1T9g/SXWYxvtPS6GtmCQ+ii+xI9UdmFviN6VvR6Txi44gXuIZrLTdonTo1pvlaGDfb9WhuKRRdow==
X-Received: by 10.36.207.137 with SMTP id y131mr3566624itf.32.1465005268117;
 Fri, 03 Jun 2016 18:54:28 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 3 Jun 2016 18:54:27 -0700 (PDT)
In-Reply-To: <20160603204235.7994-1-szeder@ira.uka.de>
X-Google-Sender-Auth: qzmjAHL3qHszneQXyIgfE5G-vRM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296437>

On Fri, Jun 3, 2016 at 4:42 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:
> If a repository contains more than one root commit, then its HEAD
> reflog may contain multiple "creation events", i.e. entries whose
> "from" value is the null sha1.  Listing such a reflog currently stops
> prematurely at the first such entry, even when the reflog still
> contains older entries.  This can scare users into thinking that thei=
r
> reflog got truncated after 'git checkout --orphan'.
>
> Continue walking the reflog past such creation evens based on the

s/evens/events/

> preceeding reflog entry's "new" value.
>
> The test 'symbolic-ref writes reflog entry' in t1401-symbolic-ref
> implicitly relies on the current behavior of the reflog walker to sto=
p
> at a root commit and thus to list only the reflog entries that are
> relevant for that test.  Adjust the test to explicitly specify the
> number of relevant reflog entries to be listed.
>
> Reported-by: Patrik Gustafsson <pvn@textalk.se>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
