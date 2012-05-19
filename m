From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/2] submodule: fix handling of supermodules with relative
 origin URLs
Date: Sun, 20 May 2012 09:45:57 +1000
Message-ID: <CAH3Anrrq5+MgGMFn89zFaaeyRkcZ7d+PHKfpVhJhdt2dNpWZoQ@mail.gmail.com>
References: <1337402403-7546-1-git-send-email-jon.seymour@gmail.com>
	<1337402403-7546-2-git-send-email-jon.seymour@gmail.com>
	<4FB7ECCF.9020403@web.de>
	<CAH3AnrrqiXqdHHGZPyOPJ3Zend5JrQX0rKV+pz_mjs3SDjv9DA@mail.gmail.com>
	<CAH3AnrrxgT1OQe-K2A91XfMLSd2WGvJ5CzyNR4tRqvYfp4wgQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun May 20 01:46:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVtM7-00065m-PH
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 01:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab2ESXqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 19:46:00 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61615 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab2ESXp7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 19:45:59 -0400
Received: by wgbds11 with SMTP id ds11so1774097wgb.1
        for <git@vger.kernel.org>; Sat, 19 May 2012 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HlgAVuryaPLoLYLayMzXhgW40Fp06EAL6MwmO3xT5vM=;
        b=vgUWEY/xgGKJf7sCl6xiMO3WhEnGi/46/rHWRxOfkRkwJoDR2qePe6Ask7PsRsrVqw
         t+IzrK84wWR3qZXLQQmFyFxVyMXn0F3x/fSXL6JVh7AHUcCbwUFbe7RsnfBOItoQFix1
         +I4+7DoZqS1YOJN7Ke3RDx46TpSzfvOJtLjWKv2OCqN2EFC9qgYNFY7mG6qA5yXQihk4
         Zy5ulmUZU5pjz/T/LnfOCT6pocl9o/1m59YqGMwE8P9RnK2pQuPUMJW4+lC1ZiGZXWSc
         Q1KPN6aoHnH0EJG8ANudHZ9byNxwZu5Q+PpodX2Iq8rIYgwX52zBx4n7eEJGT3q3n/EK
         QR0w==
Received: by 10.180.107.99 with SMTP id hb3mr12899685wib.0.1337471157256; Sat,
 19 May 2012 16:45:57 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sat, 19 May 2012 16:45:57 -0700 (PDT)
In-Reply-To: <CAH3AnrrxgT1OQe-K2A91XfMLSd2WGvJ5CzyNR4tRqvYfp4wgQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198046>

On Sun, May 20, 2012 at 9:10 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Sun, May 20, 2012 at 8:51 AM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>> On Sun, May 20, 2012 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> =
wrote:
>>> Am 19.05.2012 06:40, schrieb Jon Seymour:
>> I noticed one relative case that is not handled properly yet, but
>> there is a workaround. If the superproject's origin URL is of the
>> form: foo/bar (a case I actually have myself for reasons I can expla=
in
>> if you want me to), then the correct rule doesn't get matched by
>> .*/*). The workaround is for the user to change foo/bar style origin
>> URLs to ./foo/bar.
>>
>> Let me know if I should fix this case now too.
>
> I think this expression:
>
> =C2=A0 =C2=A0remoteurl=3D$(echo "remoteurl" | sed "s|^[^/][^:]*\$|./&=
|" )
> =C2=A0 =C2=A0remoteurl=3D${remoteurl%/}
>
> would normalize remoteurl correctly for the foo/bar case and not any =
other.
>
> I'd also need to add at least one new test (or do I actually need 3?)=
,
> of course.

Ok. I have a version that implements this fix:

        url=3D"$1"
+       remoteurl=3D$(echo "$remoteurl" | sed "s|^[^/][^:]*\$|./&|")
        remoteurl=3D${remoteurl%/}

and...

+                       .*/*)
+                               up_path=3D"$(echo "$2" | sed "s/[^/]*/.=
=2E/g")"
+                               remoteurl=3D${remoteurl#./}
+                               remoteurl=3D"${up_path%/}/${remoteurl%/=
*}"
+                               ;;

with a single test that demonstrates that it works. The additional #./
tweak is so that submodule URLs end up like:

   ../foo/sub

instead of:

   ../foo/./sub

jon.
