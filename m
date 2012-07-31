From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 13:39:44 -0700
Message-ID: <CA+55aFzhgTsHKhL599k7M6NzD5WUm72v3V+NYuCKs4uCPbnFzg@mail.gmail.com>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org> <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
 <CA+55aFwE93YeVjZp9VLhRvbxFJNonafmUE6rHzPer5hv-hON5Q@mail.gmail.com> <7vk3xjit4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwJEi-0002Db-BA
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab2GaUkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:40:07 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45684 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab2GaUkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:40:06 -0400
Received: by wibhm11 with SMTP id hm11so3294293wib.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=lbXc2KStiquzhHzHR7QQwJuYdcwZbgzbuO34xfZ7aTM=;
        b=rMkhSjXfmM+duc9zYzDQn4mi853fBiN3OsAPkbICr/7aT/Ca3UBVPXbjIndYKQ85Qk
         FNC5QsrrgTqniLZg8alYIu7TB7BdeGhtnIpU9TQhuKrJXs8uwDn97Cg16EDJ1zU5Dzu1
         botOIzAH82X3JRUBydaQ00MhDtOhyuXbvjqx3qzVDOX/wwPJKEe20dddOYvcAOZAL8w6
         a6oratApL4bjh/DvYfnq7NNV7gAJjJEvz+EzF3i/266t2QKadT1iFIl1loKgcZnkuBuV
         x5q/juEjIYcATh3mt1K9JqKnWqe9dgog9IHpcQiAP2LJr9L0LpnnrYAqkNN1Psls0nXa
         d9WQ==
Received: by 10.180.76.135 with SMTP id k7mr5695351wiw.7.1343767204722; Tue,
 31 Jul 2012 13:40:04 -0700 (PDT)
Received: by 10.216.203.207 with HTTP; Tue, 31 Jul 2012 13:39:44 -0700 (PDT)
In-Reply-To: <7vk3xjit4h.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: PPQbPD6XhQQprPx1vSWGeK-ugSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202686>

On Tue, Jul 31, 2012 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eek.

Oh, I agree. Doing a full character set conversion both ways is quite
a bit more work.

> Not just write_entry() codepath that creates the final paths on the
> filesystem, you would need to touch lstat() calls that check the
> existence and freshness of the path, once you go that route.  I am
> sure such a change can be made to work, but I am not sure how much
> we would gain from one.

I think it might be interesting. I doubt it matters all that much any
more in Western Europe (Unicode really does seem to have largely taken
over), but I think Japan still uses Shift-JIS a lot.

Although maybe that is starting to fade too.

And it really is just a generalization of the OS X filesystem damage.

            Linus
