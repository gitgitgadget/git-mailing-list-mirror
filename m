From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: git merge-tree segfault
Date: Sat, 30 Oct 2010 18:27:03 +0200
Message-ID: <AANLkTikPPGYit4h_heg3j+bz_p8ug9TGwnH62+i-prFL@mail.gmail.com>
References: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
	<SNT124-w295B9D20AA43A06DEFD13BC4440@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 18:27:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCEGu-00046s-Eg
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 18:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab0J3Q1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 12:27:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60117 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab0J3Q1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 12:27:05 -0400
Received: by vws13 with SMTP id 13so1374390vws.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Kw1Ga56Yi5rARyfOWJYVk6S5wy/t6XKr6iHs1j0iFJk=;
        b=nBybWwhu14eIKjCi+7c7o/0BMKwDuMO6ZAH4OqPt8KRuim5pv+8C16Hm0pTV5llQ6K
         u+QsXRQV1dMPOvXGn2R0l3f/j28cQ5g2FNUczkVfqOffBoPfMvn9v+55maGUdQZ9le+o
         zoE5wf9Bf4o1yUCxgtiOOyNF/EKprle9T+t1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SxIehoVew+I4EtFTZFy3gjCXXJGti+2h3x+Ca00lAGirHkU6XB6yjIgrVY70Upy5d7
         JreNDWO7QFjKt2K7dBtZX4DrOLkWZYIDXxHTK/ETrUI1os3xlO7CG4kBr7/D1Z5atMtP
         iaY+fVlD4FaOuVCnIpsngb0RJdXwblP+zUWdc=
Received: by 10.224.201.137 with SMTP id fa9mr6173920qab.10.1288456024006;
 Sat, 30 Oct 2010 09:27:04 -0700 (PDT)
Received: by 10.229.182.209 with HTTP; Sat, 30 Oct 2010 09:27:03 -0700 (PDT)
In-Reply-To: <SNT124-w295B9D20AA43A06DEFD13BC4440@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160401>

On Thu, Oct 28, 2010 at 10:25 PM, Tim Mazid <timmazid@hotmail.com> wrote:
>
>> Date: Thu, 28 Oct 2010 22:16:03 +0200
>> Subject: git merge-tree segfault
>> From: klas.lindberg@gmail.com
>> To: git@vger.kernel.org
>>
>> I haven't tried this on newer versions of git, but the release notes
>> for later releases don't mention merge-tree anywhere, so...
>>
>> git version: 1.7.0
>> uname -a: Linux tor 2.6.32-trunk-amd64 #1 SMP Sun Jan 10 22:40:40 UTC
>> 2010 x86_64 GNU/Linux
>> distro: Debian GNU/Linux squeeze/sid
>>
>> Unpack the attached tree, cd into it and run:
>> git merge-tree common master other
>>
>> I get the following result:
>> added in local
>> our 100644 d68dd4031d2ad5b7a3829ad7df6635e27a7daa22 t1.txt
>> Segmentation fault
>>
>> The exit code:
>> 139
>>
>> BR / Klas
>
>
> Confirm this bug with arbitrary repository and arbitrary revs.
>
> git version: 1.7.1
> uname -a: Linux Imperial-SSD-Overlord 2.6.35-trunk-amd64 #1 SMP
> Tue Aug 17 08:22:25 UTC 2010 x86_64 GNU/Linux
> distro: Debian GNU/Linux unstable/experimental
>
> Same exit code; 139.
>
> Regards,
> Tim.
>
>

I made some more tests and discovered that the order of parameters to
merge-tree is important:

 * Let the tree contain one commit.
 * Let the tree contain branches "common", "this" and "that". All of
them point to the single commit.

 * Check out "this" and add/commit a file "text". "text" does not
appear in "that".
 * Running "git merge-tree common this that" triggers the bug.
 * Running "git merge-tree common that this" does NOT trigger the bug.

BR / Klas
