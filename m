From: "marc zonzon" <marc.zonzon+git@gmail.com>
Subject: Re: git-relink status (or bug?)
Date: Sat, 21 Jun 2008 22:23:12 +0200
Message-ID: <71295b5a0806211323s24d58004m21721a2c878c8737@mail.gmail.com>
References: <20080621103636.GA696@kernoel.dyndns.org>
	 <7v4p7ma90e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 22:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA9dN-0003W6-F0
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 22:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbYFUUXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 16:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbYFUUXO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 16:23:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44452 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYFUUXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 16:23:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6249647rvb.1
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=J7rmpZxEtJAy/DKHvRWtm54U0mQcpO5+tOqcz9et8Rs=;
        b=uoWv38dO0UGXHGDUKlFxzBzVUYmHI/jt5gxTUnlfKQjW+7vIczhgNIJZrXkPh7ialD
         8ukin+HUYJe3RoBgM8N5j6Wd8nzUnBKJrd3uQlZ8TjIsaSbjSmYMH3IMGnKlTwz1oI84
         XQ5FMk0Rhfh3QffUeP3tfCfWA71OUFFykLOIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=keAVHj4t2It6Vsn2m/LYbEGWW0i1wFA5z4mGVYvdovD78SbpI3yQbN7EGZNpHvVSDs
         2jE0g/6Jz5qKX+YG2Xj8vnEIp4HmuRZ/9CKl+rKYxzZZmp4IPNyVUhVOsI85p4ZoukmP
         e6XYwq+5BYuyprdk8Golp9Prp+PJeF7KeXN48=
Received: by 10.141.122.20 with SMTP id z20mr9916706rvm.93.1214079793256;
        Sat, 21 Jun 2008 13:23:13 -0700 (PDT)
Received: by 10.140.187.11 with HTTP; Sat, 21 Jun 2008 13:23:12 -0700 (PDT)
In-Reply-To: <7v4p7ma90e.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 669aaa9a6bf741da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85723>

Thank you for your answer

On Sat, Jun 21, 2008 at 9:22 PM, Junio C Hamano <gitster@pobox.com> wrote:

>
> I do not think anybody uses it these days.  Instead either they clone with
> reference (or -s), or perhaps use new-workdir.

The goal of git-relink is analogous to the default local clone,
hardlinks can be safer than
 sharing because you don't loose anything when the origin directory
reset a branch.
I remark that git-clone(1) warn about -s use, but not --reference, but
they seems identical on these aspects.

In numerous cases you cannot suppose your alternate will keep your
objects forever.
I have posted recently such a case study
http://thread.gmane.org/gmane.comp.version-control.git/85407
and when trying hardlinks, i found this bug. It happens that sharing
was a better solution
(but only with the help of Shawn answer I could set it up!)

This new-workdir seems also a nice script, that I never looked at
before (But why is there no documentation on these contrib?)

>
> Here is a totally untested fix.
>
> The "careful" part can be made much more clever and efficient by learning
> implementation details about the .idx file (it has the checksum for itself
> and the checksum for its .pack file at the end) but I did not bother.

Thank you
I see that you only take the safe way, don't hardlink if something is
different, but there would be a more efficient one, to link when the
packs have the same name, and link also the idx. If they have the same
name they have the same content (with a fair probability!)

I cannot provide a patch for that, because I'm not a perl programmer,
and I'm too lazy to rewrite it in C or python!

> I do not think this in its current shape is committable, without
> improvements and success reports from the list.  Hint, hint...

Being "perl challenged" I cannot readproof the script, but at least I
can test it but only on trivial test cases which make git-relink fail!
(I have only tried once to use it to solve the previously cited
problem)

Marc
