From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Issuing warning when hook does not have execution permission
Date: Wed, 20 Aug 2014 20:55:52 +1200
Message-ID: <CAFOYHZCGQj1vaZfOpFXHpuf-OjTB5RXRN_37O2EkQFRvow-RfA@mail.gmail.com>
References: <CAPyMVO+a+R-+UDVuNSfhyB=PX-NUZbt6VGXfOv19-mDKTqfj6g@mail.gmail.com>
	<20140819080002.GB7712@peff.net>
	<xmqqegwcwhfc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Babak M <babak@melon.com.au>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 10:56:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK1gx-00031M-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 10:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbaHTI4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 04:56:01 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37025 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbaHTIz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 04:55:58 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so11349642pdj.7
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jkrPJ2D973SJZV2g8xD5FBcS+fS5vm8tz3emP98U+OM=;
        b=rERkJ4zvkW7Oq58pumm0VxTA/AIsO8FIa9SaGWhz8KrXi4ohDnIQfgqdB1d4NnDn8R
         F3edzDKqubST61kQdQ9djqRrlbV8IZ286i6RgcInPPDNxXFKE0Hos8S4EZGjDllRCblf
         8qi/MjqyRs06B+taUwSJdvyALr7om4qkytenVYpHJuoVQ6QGD1BdXljkbFyFk9RDYLej
         xINRZKZZt8P0+UtvWTeRM+cuMKQWnScXgA43dn9otZtRLad5/3KkFnOgnpzByUAWLY5p
         qAkw22KYD6QbCPfHpX5VSOPpfUUH4w8FSxzaTp9p7cxefAdacEqmPzcXb4B1cWtvqF08
         1T/g==
X-Received: by 10.68.115.48 with SMTP id jl16mr16170241pbb.78.1408524952458;
 Wed, 20 Aug 2014 01:55:52 -0700 (PDT)
Received: by 10.70.98.140 with HTTP; Wed, 20 Aug 2014 01:55:52 -0700 (PDT)
In-Reply-To: <xmqqegwcwhfc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255559>

On Wed, Aug 20, 2014 at 4:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Aug 19, 2014 at 04:05:21PM +1000, Babak M wrote:
>>
>>> I saw that if a hook file is present in .git/hooks and it does not
>>> have execution permissions it is silently ignored.
>>>
>>> I thought it might be worthwhile issuing a warning such as "Warning:
>>> pre-commit hook exists but it cannot be executed due to insufficient
>>> permissions".
>>>
>>> Not sure if this has been discussed before. I searched the archive but
>>> didn't see anything.
>>>
>>> Thoughts, suggestions? Is there anything like that already?
>>
>> Once upon a time we shipped sample hooks with their execute bits turned
>> off, and such a warning would have been very bad.
>>
>> These days we give them a ".sample" extension (because Windows installs
>> had trouble with the execute bit :) ), so I think it should be OK in
>> theory. Installing a new version of git on top of an old one with "make
>> install" does not clean up old files. So somebody who has continuously
>> upgraded their git via "make install" to the same directory would have
>> the old-style sample files. Under your proposal, they would get a lot of
>> warnings.
>>
>> However, that change came in v1.6.0, just over 6 years ago. We can
>> probably discount that (and if it does happen, maybe it is time for that
>> someone to clean up the other leftover cruft from past git installs).
>
> The above all sounds very sensible.
>
> We have another code path that looks for an executable, finds one
> with no execute permission and decides not to execute it, and I
> wonder if we should use the same criteria to decide to give (or not
> give) a warning as the one used in the other code path (i.e. looking
> up "git-foo" executable when the user runs "git foo").
> --

I actually find the existing behaviour useful. If I want to disable a
hook to I can just chmod -x .git/hook/... and I then chmod +x it when
I want to re-enable it. I guess I could live with an extra warning as
long as the command still succeeds.
