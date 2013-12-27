From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH] git-svn: workaround for a bug in svn serf backend
Date: Fri, 27 Dec 2013 10:09:30 +0400
Message-ID: <CANiYKX6VA2KvJ_YWYOegb6+VFg_unL96P9qUBthYPFuo9fhAMA@mail.gmail.com>
References: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
	<1388059524-4864-1-git-send-email-rkagan@mail.ru>
	<20131226202805.GV20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 07:09:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwQcL-00040M-R9
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 07:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab3L0GJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 01:09:31 -0500
Received: from mail-qe0-f54.google.com ([209.85.128.54]:42535 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3L0GJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 01:09:31 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so8747138qeb.41
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 22:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CqAMs1GsD3VWOGp4zweKzyGuX9NcOUidEDr5l54sKqY=;
        b=vWH4odtQuZDxH4w1wkOaY/Nour0eBoaSaDEoZhtN3ECATdsoYylx4jd6/GYtMaKwB+
         Pia7fZE2Vs1QlCUk3PcDY+mz30A3DqcRkj9vJlRj1xNSD5IgACy4I6/lbKWPz4oF81jm
         +R0L/Qf885jeITF0KtvKMao4ox/QDPsKKf8mINcQXADU2C98fF9qp7ZlieeV7Z1f+Cm9
         BjrNQbIdnduEJ4MbAEjDamH3vrOdpmQwdELn05KOInZpYyVt1u2YM2yol2kQjPuy16xn
         x4N9BkCXU56PjRYnUj4FsYGL8CH6t3Cih1NnVqKcFOXI4AaHsIeTt5zlCaimcXPNv0G9
         p0Iw==
X-Received: by 10.49.13.135 with SMTP id h7mr79530179qec.73.1388124570267;
 Thu, 26 Dec 2013 22:09:30 -0800 (PST)
Received: by 10.224.98.146 with HTTP; Thu, 26 Dec 2013 22:09:30 -0800 (PST)
In-Reply-To: <20131226202805.GV20443@google.com>
X-Google-Sender-Auth: 6i1agIhA3MKLbXqT6swYhxaXnCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239720>

2013/12/27 Jonathan Nieder <jrnieder@gmail.com>:
> Roman Kagan wrote:
>
>> Subversion serf backend in versions 1.8.5 and below has a bug that the
>> function creating the descriptor of a file change -- add_file() --
>> doesn't make a copy of its 3d argument when storing it on the returned
>
> 3d makes me think of 3-dimensional. ;-)  I think you mean third
> (or the abbreviation 3rd).

Indeed.

>> descriptor.  As a result, by the time this field is used (in
>> transactions of file copying or renaming) it may well be released.
>
> Please describe the symptom so this patch is easy to find when other
> people run into it.

OK

> Do I remember correctly that "... released and scribbled over with a
> new value, causing such-and-such assertion to fire" was what happened?

Exactly.

>> This patch works around this bug, by storing the value to be passed as
>> the 3d argument to add_file() in a local variable with the same scope as
>> the file change descriptor, making sure their lifetime is the same.
>
> Could this be reproduced with a test script to make sure we don't
> reintroduce the bug again later?  (It's okay if the test only fails on
> machines with the problematic svn version.)

That would need a fairly fancy setup phase, as the bug triggers only
on http(s)-accessed svn repositories.  I'll take a look if there's
something already available in the existing test scripts; writing one
from scratch for this specific case is IMO beyond the reasonable
effort.

> Modulo the confusing 3-dimensional arguments in comments, the code
> change looks good.

Thanks, I'll adjust the wording and resubmit.

Roman.
