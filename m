From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Thu, 1 Dec 2011 11:43:23 +0700
Message-ID: <CACsJy8Dmyha-L-iW3KVzAZ6wX+gH4qWSXPUT-XQJX1xYewuzMw@mail.gmail.com>
References: <1322546563.1719.22.camel@yos> <20111129090733.GA22046@sigill.intra.peff.net>
 <CACsJy8DboVU4kSbJSV=8NP08OyLYVgOKsm8tt=koZ0=JcGSE=A@mail.gmail.com>
 <20111129205905.GA1793@sigill.intra.peff.net> <CACsJy8A6kGmn0h0xdxfTC4krXgc8hzO1fHTdqfk0YnASGN5K0w@mail.gmail.com>
 <7vzkfdqye3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Bill Zaumen <bill.zaumen+git@gmail.com>,
	git@vger.kernel.org, spearce@spearce.org,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 05:44:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVyV6-00033Y-Pn
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 05:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab1LAEn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 23:43:56 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45562 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab1LAEnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 23:43:55 -0500
Received: by bkas6 with SMTP id s6so1878778bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 20:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PSwFjKHGNwvjXau40giSXrdEK/wRtwsuztBKUaKh7uY=;
        b=FRXwY4daNs9LyIp+F5kQR/Mo7Mdnk6mGUr6lg2yzfTtMifIXEsJEvQDb187uT42AJD
         TMvEUo9lgwnX9r/9rJWD10MG/SQluikIJOXSZxddrDDwaHG1aCVQIGAF8NvnPWjy1HtB
         bsudn5UjCotpXMsnOvkV3MNcBvHx2hSLf0GSM=
Received: by 10.204.14.208 with SMTP id h16mr5445396bka.2.1322714634209; Wed,
 30 Nov 2011 20:43:54 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 30 Nov 2011 20:43:23 -0800 (PST)
In-Reply-To: <7vzkfdqye3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186161>

On Thu, Dec 1, 2011 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> What I'm thinking is whether it's possible to decouple two sha-1 roles
>> in git, as object identifier and digest, separately.
>
> Why it would be a good thing? If you have a collided identifier, somebody
> has to choose which blob a particular tree wants to have at the path, and
> because the tree would not record anything but the identifier, you cannot.

Accidental collision likelihood is small enough we don't have to care about.

>> ...
>> The day sha-1 is broken, a project can generate new digests from its
>> old good repo and enforce developers to use new digests for
>> verification instead of sha-1. sha-1 is still used by git as
>> identifier after that day.
>
> And an old blob that is identified with a SHA-1 now has a new blob that
> has different contents but happens to have the same SHA-1. How does Git
> decide which blob to use when a particular object is named by the SHA-1?

Again, I assume the likelihood that a content happens to have the same
sha-1 with another one is too low to care about. If they are, it's
must be an attack. We do not allow malicious objects to enter in the
first place using other digests. Once objects are in, they are safe to
use.
-- 
Duy
