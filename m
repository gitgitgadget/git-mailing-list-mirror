From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 18:23:49 +0530
Message-ID: <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 13:54:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U49wy-0000Qs-TD
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 13:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab3BIMyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 07:54:11 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64601 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab3BIMyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 07:54:10 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so5994076ieb.20
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 04:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2rjOL1XEwDCjfsqfAztjjgzyOUUbFv5s8Omjtay7dBA=;
        b=eOI1IlHcp2p3vKf56FPI7YZ3ok6E9io1qjIHk18SdmbwWFfva/SZxRPAz/O5HAaZfH
         S9EuMNiS9Jrz3ejrkmSJ6aw3Lnu6rbvfgZSzqQe42aLQMfW+GDJ4+H2ck93HHvY4Pvc0
         5y4TAcZnNUEHit8cxOcVV6mUr/3/l8ar5dmhTgcVc6f2Vi4Cov8Yl2XWRtVL4lKU2HJ6
         vKqEY/oCE41lXhRBbcJfJGr5ajuitX0WlYIluoBWp/7kTWMVHtU21KuKTRsz65Gs/beK
         7seS+IGEX/m9psLNO67tEi9S3OMseJxe4h7BM3HNK2KHL2pCcL27hnOjGF8/GkfmVVam
         fTTw==
X-Received: by 10.50.17.201 with SMTP id q9mr7401614igd.107.1360414449422;
 Sat, 09 Feb 2013 04:54:09 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Sat, 9 Feb 2013 04:53:49 -0800 (PST)
In-Reply-To: <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215863>

Ramkumar Ramachandra wrote:
> What about getting systemd to watch everything for us?

systemd is the perfect candidate!  It already has an inotify watcher:
see systemd.path(5).  Can't be used as-is because it spawns processes
on events, which is a non-scalable design.  Secondly, it uses static
.path files to define the rules which is no good for us.  So, we need
to add an API to it, and ask it to report events over IP sockets.  The
API part is simple too, because it already has a DBUS API for many
things [1]; it's just a matter of extending it.

Yes, I know.  This introduces dbus as an additional optional
non-portable dependency.  Do you have suggestions for alternatives
that aren't complicated?

[1]: http://www.freedesktop.org/wiki/Software/systemd/dbus
