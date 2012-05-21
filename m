From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2 2/2] submodule: fix handling of superproject with
 relative origin URLs
Date: Mon, 21 May 2012 23:52:56 +1000
Message-ID: <CAH3AnrrNTrMcd6ZaUKqt9EgGvbRGBaqiqsPmECZAXZnahzr7OA@mail.gmail.com>
References: <1337468428-26155-1-git-send-email-jon.seymour@gmail.com>
	<1337468428-26155-2-git-send-email-jon.seymour@gmail.com>
	<7vfwau9tgc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 15:53:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWT2x-0008SK-8v
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 15:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757045Ab2EUNxD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 May 2012 09:53:03 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64046 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007Ab2EUNw5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 09:52:57 -0400
Received: by wibhj8 with SMTP id hj8so2398784wib.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hD3jTg7dPiG/KwZDgrIGJdPvRskH41PmUUIKT3m94+0=;
        b=aGJUDbFfaGFC8L5RSMqZT3Bp8Hc9g+T2TeSZuHJbPfpal3BLsr1nUaDS3mZa7aMDj5
         6BZ6pyMpxStoNRrkDu7LZXHIbUl7V3dpLFdsqMVdCChBMH0+u8flD1M6BOZ+dY05J667
         caF6MDNQ7KJtxWog/WnzplTfu3RcBrbMhSc2VME01ZiMLxP8TCUlZGzRJVj//viUjcEI
         TpGBbm59jL/8l4C9mBp9C347aNo12r70O2fR28abWaPghnkpuU7am1cBrJfK4ZarepH6
         pDrNLvkI8bSvErNJ89xR439NZ6Z9hCd2zIPBlSknlWIzlSaOkVqZVPi1FN/nm3EIrmCv
         eqzg==
Received: by 10.180.86.197 with SMTP id r5mr25671885wiz.21.1337608376041; Mon,
 21 May 2012 06:52:56 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Mon, 21 May 2012 06:52:56 -0700 (PDT)
In-Reply-To: <7vfwau9tgc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198105>

On Mon, May 21, 2012 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Prior to this change, an operation such as git submodule add, init o=
r
>> sync produced the wrong result when the origin URL of the superproje=
ct
>> was itself a relative URL.
>
> If you say you are "fixing" something in the title, it is already kno=
wn to
> the reader that a broken behaviour exists in the code without the pat=
ch in
> question. =C2=A0Instead of spending four useless words "Prior to this=
 change",
> could "the wrong result" be clarified with either saying "wrong in wh=
at
> way" and/or "because of this and that reason"?
>

I hope v3 is closer to what you would like to see.

>> Note that superproject relative origin URLs of the form foo/bar
>> are still not handled correctly.
>
> I am not sure what the use case of such a layout is. =C2=A0A project =
that has a
> "bar" repository as its superproject (or its one of submodules for th=
at
> matter) may advertise that the other repository lives at ../bar.git, =
so
> that when these two projects are served at a random hosting service, =
such
> a cross-project pointer does not have to be rewritten as long as thei=
r
> relative location at the hosting service remains the same. =C2=A0But =
what does
> it mean to say a related "foo" project lives in foo/bar.git directory
> relative to one project in the first place? =C2=A0Does the project's =
$GIT_DIR/
> have a "foo" directory next to its "refs" and "objects"? =C2=A0Probab=
ly I am
> missing what you are trying to achieve. =C2=A0Puzzled.

I have tried to explain the use case again in 4/4 of the v3 patch (my
previous attempt
was in a previous reply to one of Jen's posts). I don't claim that
this is a common
use case at all, but it is a use case that I have used several times my=
self.

It is particularly useful in cases where there is a need to regularly
synchronize
a collection of git repos and other files across an "air gap" (for exam=
ple, via
an intermediary USB drive) where one of the repos being synchronized is=
 the
synchronization toolset itself.

In this case, it may well be that the origin repo for a particular
toolset instance
itself is actually located on a USB drive whose physical location chang=
es as
the removable device used to  update the tool set changes.

The user may choose to manage the relative location of the USB drive wi=
th a
symbolic link (relative to the toolset) rather than a git origin URL.
(The advantage of
using a symbolic link in this case is that you can update the actual ph=
ysical
location of the USB drive with a single update to a single symbolic
link - this may
be more convenient in cases where are multiple git repos that need to b=
e synced
to the USB or if there are resources other than git repos on the USB).

So, for example, suppose the toolset is managed within ~/tools with dir=
ectories
such as:

=C2=A0 ~/tools/bin
=C2=A0 ~/tools/lib

then, perhaps the origin copy of the toolset is found by:

=C2=A0 ~/tools/mnt/usb -> /media/MY_USB_DEVICE/tools

remote.origin.url in ~/tools/.git/config might refer to mnt/usb/tools s=
o that
if the device occasionally changes to /media/YOUR_USB_DEVICE/tools
then this can be accomodated by updating a single symbolic link
(e.g. ~/tools/mnt/usb)

Apologies if this explanation is not clear enough.

Again, I don't claim it is a common use case, but then I don't see
any harm with git supporting it either since it doesn't require much
work.

jon
