From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH 3/3] Avoid non-portable strftime format specifiers in git-cvsimport
Date: Wed, 16 Jan 2013 10:38:09 +0000
Message-ID: <CAP30j153s970=2WKqxWTVGRAaJ9jEXg9ETF8OFU=-nDK=BAxfg@mail.gmail.com>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
	<1358291405-10173-4-git-send-email-bdwalton@gmail.com>
	<CAEUsAPZakGKUmQWrsTaF1cpbQm0Y4C3sDxCWD_i1gkQxeC-bRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, esr@thyrsus.com,
	git <git@vger.kernel.org>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 11:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvQOA-00021m-LN
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 11:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758812Ab3APKiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 05:38:12 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:54322 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758752Ab3APKiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 05:38:11 -0500
Received: by mail-la0-f51.google.com with SMTP id fj20so1211315lab.38
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 02:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Fr4TcYtlgfUcVxxVH0zWv5B4qcfT2ktpNeWC6f0kse8=;
        b=DK+QB4vlPxxOyQ01LYcpHrSDJJBaqNOZ9m3NXesZbJCrSEl/A88kqPoHLNyNgd8NBT
         ywJX9T7YKvfJt8bw2vu9z6F306xFUCq3X4E6QT6Wz34yQrSfIm7s8eRzxVDrxp+UVGXa
         u9qNH9MqvybIfIVXHwfTTlm+DHd7q6qyiulmecA13Y+iQ7+oJphON/jCbYFoHua9W/c0
         gZ54djWIYqiVt1NauyL+bu+Rdj5Bswjo8KmdDqPXAW1DX0NpxTHLRZuMyBGJ5xcS7/BS
         VifMMkfCTvXbCw7aWyJSptYSniq0ckT5GPnySB0bPy8ovKZ1HJq52kJMab7s7cf3llOF
         otJw==
X-Received: by 10.112.54.6 with SMTP id f6mr426613lbp.71.1358332689505; Wed,
 16 Jan 2013 02:38:09 -0800 (PST)
Received: by 10.114.29.129 with HTTP; Wed, 16 Jan 2013 02:38:09 -0800 (PST)
In-Reply-To: <CAEUsAPZakGKUmQWrsTaF1cpbQm0Y4C3sDxCWD_i1gkQxeC-bRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213745>

On Wed, Jan 16, 2013 at 1:53 AM, Chris Rorvick <chris@rorvick.com> wrote:
> On Tue, Jan 15, 2013 at 5:10 PM, Ben Walton <bdwalton@gmail.com> wrote:
>> Neither %s or %z are portable strftime format specifiers.  There is no
>> need for %s in git-cvsimport as the supplied time is already in
>> seconds since the epoch.  For %z, use the function get_tz_offset
>> provided by Git.pm instead.
>
> Out of curiosity, which platforms are affected?  Assuming DST is a 1
> hour shift (patch 2/3) is not necessarily portable either, though this
> currently appears to only affect a small island off of the coast of
> Australia.  :-)

My primary motivation on this change was for solaris.  %s isn't
supported in 10 (not sure about 11) and %z was only added in 10.  The
issue affects other older platforms as well.

Good point about the 1 hour assumption.  Is it worth hacking in
additional logic to handle Lord Howe Island?  I think it's likely a
case of "in for a penny, in for a pound" but that could lead to
madness when it comes to time zones.  Either way, the function behaves
better now than before.

(I wasn't aware of the half hour oddball wrt to DST, so I learned
something new here too!)

Thanks
-Ben
--
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
