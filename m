From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] log: grep author/committer using mailmap
Date: Fri, 28 Dec 2012 19:00:50 +0100
Message-ID: <CALWbr2y63L0-ykdUNGqUOb0LhG=vpXGRcb1KkvssEZmKFJEGeQ@mail.gmail.com>
References: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
	<1356622318-19523-1-git-send-email-apelisse@gmail.com>
	<7v1uebmizx.fsf@alter.siamese.dyndns.org>
	<7vwqw3l49z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 19:01:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToeF7-0002xJ-B9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 19:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab2L1SAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 13:00:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41761 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab2L1SAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 13:00:54 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so5233154eek.19
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CGXUnwO+92YX5PcvxyeGBsJDAUbR9pEOVxHlHr64eeo=;
        b=qcg7ZBBdnQ4YMuceSMhLF2IZwivF/WQiVWjHKPwKm6Mev43VYqRKBGT9hT5QNeneMa
         uMPdoQVeTa8cf8ZSMePx3fcocwIVsZiWnohTo47wJkffQvyo+cCoo9bpJ7IYro7MKsDD
         /3a9+4GHRrK6nAjFl6cnuklxjN27UjDO5Yo9k5g7QjkL7lWVyrVrY9gbBhQIcyVPhTmZ
         QcG2O9wVCdM7jqB5V7eKsJ5x/6UTq0XgBVfMahI8BSyKBOLT+ZgoNcrv7A54T5VEezeC
         Dj3FIO5lW92ucLrIdsvNxR7WI6S9vpbJY9tnF53jFQEiYUSoWs30YKfRhsygHsPyJbk/
         X1Tg==
Received: by 10.14.194.4 with SMTP id l4mr87915238een.42.1356717650366; Fri,
 28 Dec 2012 10:00:50 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 28 Dec 2012 10:00:50 -0800 (PST)
In-Reply-To: <7vwqw3l49z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212248>

Actually, gprof seems to be unhappy about the number of call to
strbuf_grow() in map_user() (25% of the time spent in map_user() is
spent in strbuf_grow()).

That probably comes from the repeated call to strbuf_addch() when
lowering the email address.
At this point, we are also copying the '\0' for every char we add,
doubling the copy.
This may not be much of a difference, but it seems to be called 15
millions times when running:
$ git log --author='Junio C Hamano' --use-mailmap

Maybe we should come up with another way to lower this email address afterall.
