From: Christian Jaeger <chrjae@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Fri, 21 Feb 2014 00:32:48 +0000
Message-ID: <CAEjYwfU7un6wuA0Z-hSycROSWNdfQq1NawC7=+cNZeNu4-DpJg@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com> <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
 <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
 <xmqqd2ij9be1.fsf@gitster.dls.corp.google.com> <CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 01:33:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGe3I-000498-DP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 01:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbaBUAdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 19:33:11 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:61886 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbaBUAdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 19:33:08 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so3148329oag.21
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 16:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uT8sq8luK1w1+kZMlyp+fPN1FQz1p5j3lM7rtUfX2CI=;
        b=ur86uckiOQ1r0XuNCM40KZq3QbV53y6hAHat4ADVSueuAhC8EOiqxv7uWCymuLe9Y2
         vrs8zMZJsh9HSUNhl3WRoSm0cdPn/1+Jbc+VjLpsNuuOCbcx/mMdcNAnq9b41QnPimFg
         cbp1cjIWToFCYGN9WV9OVZ6FJFC34kNpwIy7t22Tus3Ub4beeNkslDx1sj2vAftwhzgO
         o9ZHKXmvZEXcRGmXzhS6YnYoMYHl+1H6e5Dg4XXn5X5pKeWCPQea/lKErOxJTFRNwr02
         lUIzNHgb90YEFahgyoL+WrBu9kedB3liR5cOSbZgtipsnGH7gKaowc233bmZOHf6xDyE
         9Taw==
X-Received: by 10.60.150.134 with SMTP id ui6mr5483893oeb.62.1392942788245;
 Thu, 20 Feb 2014 16:33:08 -0800 (PST)
Received: by 10.76.27.73 with HTTP; Thu, 20 Feb 2014 16:32:48 -0800 (PST)
In-Reply-To: <CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242455>

2014-02-20 23:35 GMT+00:00 Duy Nguyen <pclouds@gmail.com>:
> does it make sense to apply
> --depth=250 for old commits only

Just wondering: would it be difficult to fix the problems that lead to
worse than linear slowdown with the --depth? (I.e. adaptive cache/hash
table size.) If the performance difference between say --depth=25 and
--depth=250 could be reduced from a factor 40 to 10 (or better if
things are back to other things taking more time than the object
access), that would seem like a nice gain in any case.

Also, in "man git-gc" document --aggressive that it leads to slower
*read* performance after the gc, I remember having red that option's
docs when I ran it, and since it didn't mention that it makes reads
slower, I didn't expect it to, and thus didn't remember this as the
source of the problem when I noticed that things were slow.

(But, I took from the discussion that increasing the gzip window size
(?) would make things smaller anyway, so perhaps all that isn't even
necessary?)

I can test next week if you have particular suggestions to test.

Christian.
