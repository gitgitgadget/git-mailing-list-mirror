From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] count-objects: output "KiB" instead of "kilobytes"
Date: Fri, 5 Apr 2013 22:31:47 +0200
Message-ID: <CALWbr2wgJmY86Fic-eE9AbtP=HMPddTO=LDp5RGYmt6_kFawpg@mail.gmail.com>
References: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
	<1364993331-20199-1-git-send-email-mihai@mihaic.ro>
	<7vd2ub7k7c.fsf@alter.siamese.dyndns.org>
	<CADyhzG3HJhrXJAoTfyHUsg=8ZmUUwUgrNfUiLHF0Ws=gSERAqw@mail.gmail.com>
	<7vvc82jm77.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Mihai_Capot=C4=83?= <mihai@mihaic.ro>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 18:58:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWOI-0001b9-22
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162750Ab3DEUbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 16:31:48 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:45507 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162735Ab3DEUbr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Apr 2013 16:31:47 -0400
Received: by mail-qe0-f50.google.com with SMTP id k5so2246227qej.23
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=lk79HtSkFOf3O9ZFg9nlnYgusWwuoUEOM8kyJsAt3fI=;
        b=mgfSb2P0ERYhbL7CFLb/Nxyr9HW/pe4vHyi/LM1qPB5/MsjBXoKabR+22MmjzZg9Gf
         ytTgC/88TjZYHvOSeLsFpZBQ/mIqBjXFUVfIxsPg9niJsgPDmdCNkx52F0jMMqq4/tO1
         4ECBXknh8iIs/oU6mITT6A/vEXoGOo+XIBoVA9yLFcE0U1eWXI3ZN910M36KVYUTRL4n
         OflkHe82TthcDDckdk2/80xy+Ml3LOT8KOvJctwIM/MhE93SNFZUU29x3GpHpmBoA4Lh
         RAeJQsgylIkLdohkIj7pRR41I2LxHyjrX/URwWSr3ubdl/Kcu229175AF/xT+98mjRGX
         Yx+g==
X-Received: by 10.229.151.134 with SMTP id c6mr2554994qcw.58.1365193907232;
 Fri, 05 Apr 2013 13:31:47 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Fri, 5 Apr 2013 13:31:47 -0700 (PDT)
In-Reply-To: <7vvc82jm77.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220176>

Should we use that opportunity to implement an option like -h (for
humanize) similar to what ls(1), df(1), du(1) does ? Of course "-h" is
already used for help, so we could use -H or any other sensible
choice.
It can become tough to read the size when it gets big enough.

On Thu, Apr 4, 2013 at 6:27 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Mihai Capot=C4=83 <mihai@mihaic.ro> writes:
>
>> The git manual contains an explicit warning about the output of a
>> porcelain command changing: "The interface to Porcelain commands on
>> the other hand are subject to change in order to improve the end use=
r
>> experience."
>
> Yeah, I know that, as I wrote it ;-)
>
> Aside from count-object being not exactly a Porcelain, the statement
> does not give us a blank check to make random changes as we see fit.
> There needs to be a clear improvement.
>
> I am just having a hard time weighing the benefit of using more
> accurate kibibytes over kilobytes and the possible downside of
> breaking other peoples' tools.
>
> Perhaps it would be alright if the change was accompanied by a
> warning in the Release Notes to say something like:
>
>         If you have scripts that decide when to run "git repack" by
>         parsing the output from "git count-objects", this release
>         may break them.  Sorry about that.  One of the scripts
>         shipped by git-core itself also had to be adjusted.  The
>         command reports the total diskspace used to store loose
>         objects in kibibytes, but it was labelled as "kilobytes".
>         The number now is shown with "KiB", e.g. "6750 objects,
>         50928 KiB".
>
>         You may want to consider updating such scripts to always
>         call "git gc --auto" to let it decide when to repack for
>         you.
>
> Also, I suspect that for the purpose of this exact output field,
> nobody cares the difference between kibibytes and kilobytes.
> Depending on the system, we add up either st.st_blocks or st.st_size
> and the result is not that exact as "how much diskspace is
> consumed".
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
