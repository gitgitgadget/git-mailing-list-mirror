From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] nd/resolve-ref v2
Date: Thu, 17 Nov 2011 04:39:24 -0600
Message-ID: <20111117103924.GA5277@elie.hsd1.il.comcast.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQzNe-0003rn-Ie
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 11:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab1KQKjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 05:39:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40776 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab1KQKjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 05:39:37 -0500
Received: by iage36 with SMTP id e36so1907634iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 02:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VDqCMmhV1IWxKUlyDF3nEsZCooGwU3McaJmWfx5UeLM=;
        b=Xjv4LrtRTAl4bl7uI0Y+T0bNDm9cQ713oKn5zoYuJ+YlE1lF3Q0byVG1qelk+W/EC4
         0/RsxH2O/dHHcOGVdu94dohJUPWD+3qpQ519KcTb9OA6ERZDAtZAiur5T5twJ7X3+Ib5
         WJXVDoqZqJ/a121ysX2XcxTAm4FkBoci0Bdn8=
Received: by 10.43.43.130 with SMTP id uc2mr41018923icb.35.1321526376401;
        Thu, 17 Nov 2011 02:39:36 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l28sm15247535ibc.3.2011.11.17.02.39.34
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 02:39:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185593>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):

Here are some comments from a quick glance over the series, to avoid
too much noise that would distract from reports about the upcoming
release.

>   Convert many resolve_ref() calls to read_ref*() and ref_exists()
>   Rename resolve_ref() to resolve_ref_unsafe()

I like the general direction of the series (and especially patch 1/8).
As Junio nicely explains at [1], it is too tempting to keep and pass
around the canonical representation of a refname returned by
resolve_ref() without remembering to copy it.

>   Re-add resolve_ref() that always returns an allocated buffer

Makes me nervous, since it would introduce memory leaks if some other
patch in flight calls resolve_ref().  Why not call it ref_resolve() or
something?

>   cmd_merge: convert to single exit point
>   Use resolve_ref() instead of resolve_ref_unsafe()

The print_summary() change introduces a leak.

[...]
>   Guard memory overwriting in resolve_ref_unsafe's static buffer
>   Enable GIT_DEBUG_MEMCHECK on git_pathname()

__VA_ARGS__ was introduced in C99.  I suspect some compilers that
currently can compile git don't support it.  But if you need to use
it, that wouldn't rule out doing so in some corner guarded with an
#ifdef.

Looks pleasant overall.  I look forward to looking more closely at
this later.

Ciao,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/185446/focus=
=3D185519
