From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 10:55:45 -0700
Message-ID: <CAL=YDW=e3Z5TqDcsY3J4-CDw+ZgQPcDTAcc1pyEeTkzAeVFcog@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
	<20140715180424.GJ12427@google.com>
	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
	<53F4B642.7020002@alum.mit.edu>
	<CAL=YDW=zmqwjLzjWYLGCjwb_aQTofTJ-CrmPgoq3KKJjfHR3XQ@mail.gmail.com>
	<20140820174914.GE20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKA6x-0007rI-7G
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 19:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaHTRzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 13:55:47 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:41876 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbaHTRzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 13:55:46 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so9524345vcb.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UQliGLDNtdprQl5VPnm39TnrCtS3Vq2KF29/Fioh66w=;
        b=Bnvt0njSnqk7Y2ArF9fqgxu6FIJS/dkhI7Xj/YooKzPO4/Co2pqgXCBu8hxkgfZ54H
         yeLIMKMHlSLI07bZAN3Q5NHUFyyRk5tOq7T51rpDws9UefNcBBMfnuu5YVCem0E9vp2C
         GgS4sR20aOfvrGsmTUS9hDggpHCLhrfCB2wrSzPpOBVRNEN6qRsvWB3i0E5meqxW+cTX
         Tz9jc2/wSkKD72m3f/fTiXpQGGioLcVki72S/O4ooywUHaAEiKD4Wg5/QFJYMe95PEX8
         QUbrzexZPBBs5ofL2fTtzZXTT5wGcfATWYC1Uw6Z76QrR69ckd+b8JxPcrE2QttVSSWN
         TRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UQliGLDNtdprQl5VPnm39TnrCtS3Vq2KF29/Fioh66w=;
        b=Tya74Qr9oZps7bXzjQEGJcbO4mUTqhqABtNWSt7+a5ekGviDZj8++Dxn3IcX+NaJUc
         sPc8np9GBORDGAomZUYsGzDCV9QlgeRxI8A9YuxdkYo8odWqQyupDEf/QKApYXiDWMDt
         CrvdQ7riDg8fheCV0/iUL+oYQrfDUTMw0OkAuDYzXzhSHXRW/NO9M+qlAp5Lm6RyRwhk
         bXcKWfTWSGgSXFlM1+mnzVR2N4mEfLDPKrQ2G9nFn4HhW+fr7OR11uXAiR2obsJEU4/P
         VaKQR04api6LGZ9FjcHHVxcrluU+gsbydrUjsd7jA6NeaSo9mIPNkE+2sG2YoGaQl1i/
         pmJw==
X-Gm-Message-State: ALoCoQm8X3/JyULlCVQRh7dtJM2Ywj9h52gxwbRnKTZwt3VCTOfVDJMtpTcMnX8MNQYHHetOxfWE
X-Received: by 10.52.32.66 with SMTP id g2mr4083786vdi.49.1408557345545; Wed,
 20 Aug 2014 10:55:45 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Wed, 20 Aug 2014 10:55:45 -0700 (PDT)
In-Reply-To: <20140820174914.GE20185@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255578>

On Wed, Aug 20, 2014 at 10:49 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Ronnie Sahlberg wrote:
>> On Wed, Aug 20, 2014 at 7:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
>>> I'm a little worried that abandoning *all* refname checks could open us
>>> up to somehow trying to delete a "reference" with a name like
>>> "../../../../etc/passwd".  Either such names have to be prohibited
>>> somehow, or we have to be very sure that they can only come from trusted
>>> sources.
>>
>> I only set this flag from builtin/branch.c so it should only be used
>> when a user runs 'git branch -D' from the command line.
>> All other places where we delete branches we should still be checking
>> the rename for badness.
>
> Right, this should be safe for 'git branch -D' and 'git update-ref -d'.
>
> But if we wanted to open it up in the future for 'git push --delete',
> too, then it would be a way to break out of the repository on hosts where
> people use git-shell instead of relying on filesystem permissions.  And
> that wouldn't be good.
>
> I think elsewhere git has some checks for "does this pathname fall in
> this directory".  Could that be reused here, too, to make sure the
> resolved path is under the resolved $GIT_DIR/refs directory?
>
> Alternatively, when a ref being deleted doesn't meet the
> 'check-ref-format' checks, would it make sense to check that it is one
> of the refs you can get by iteration?

Good idea! I will add such a check using the iterator.
That means that "we can git branch -D anything that shows up in the
iterator regardless if the ref is badly named or unresolvable" which
sounds like fairly sane semantics.

Thanks!

Ronnie
