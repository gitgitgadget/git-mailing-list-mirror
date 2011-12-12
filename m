From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 15:56:45 -0600
Message-ID: <20111212215645.GA3024@elie.hsd1.il.comcast.net>
References: <4EE4F97B.9000202@alum.mit.edu>
 <20111212064305.GA16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDro-0007aJ-BA
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab1LLV44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:56:56 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36707 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab1LLV4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:56:55 -0500
Received: by yenm11 with SMTP id m11so4194828yen.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gJPPyP3PN2twN+n87CRAyt/Wc5nqtSKul3yEMg+Ph4g=;
        b=ZimJgwxh1Jku0zPGpsN9eeQw8iL9LiKIu8Ua65p3rDOM3Ks5IaCKzfc1pzaKgR2gxw
         tEzCMA/dHcWvUUWpljdZY0gMrWuApLAX2ufbOz6HByNysh+PE9N4NcuuLMqJZXNA7tSM
         5pH78ElzNLHvziaEq3lM0RIahCuSD0SbOqvIg=
Received: by 10.236.155.2 with SMTP id i2mr28789690yhk.115.1323727014818;
        Mon, 12 Dec 2011 13:56:54 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f47sm32854133yhh.8.2011.12.12.13.56.53
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 13:56:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111212064305.GA16511@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186962>

Jeff King wrote:

> I'll leave the issue of "-std=c89" triggering SNPRINTF_RETURNS_BOGUS to
> people who know and care about autoconf. My gut is to say "don't do
> that". Git is not actually pure c89. We typically target systems that
> are _at least_ c89, but it's more important to match and run well on
> real-world systems than what was defined in the standard. So we don't
> depend on c99, but we do depend on quirks and features that were
> prominent in mid-90's Unix variants.

Using vsnprintf isn't even wrong from the standards-pedant point of
view --- vsnprintf has been in POSIX for a long time.  The problem is
that the configure script is not setting appropriate feature test
macros such as _XOPEN_SOURCE (like git-compat-util.h does) during its
feature tests.

Maybe it would be possible to hook the appropriate magic into
AC_LANG_PROGRAM.
