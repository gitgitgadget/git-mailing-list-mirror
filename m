From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Sun, 7 Jun 2009 15:31:57 +0200
Message-ID: <c77435a80906070631x5c030b9cve4c8963c0d33e71b@mail.gmail.com>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
	 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
	 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 15:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDITp-0003Qs-L6
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 15:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZFGNb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 09:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbZFGNb6
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 09:31:58 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:36830 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbZFGNb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 09:31:57 -0400
Received: by ewy6 with SMTP id 6so3446602ewy.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qo4KTp03WyKOEHmU6vMC6a73VRNcK61SM0LUD8jwscI=;
        b=FaW4YweQO0m7fo1dSIIO3YQ9zIYf5aqD2OhoSkfLhC12uttZMJl5G1ryKLPc2FHrFO
         6mFLmdLr90WQWvpb5HsR9nmp+qHeCQoRRaCmb8BZnV3Kz5b78E17jCcljsIxdIjPb+H/
         BDbJ2LREFJlQDMgS214HYaBsvYbLiLK4r848Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B0wMgYyk7OCES8Nf+g3pN/U7yMMqBVhVLFGcEgmnYwOxJAUxBRUhyWrkWO0jiyEt1I
         AxVgb+dLWN1xvD3R+PfIzJZoaFfcaNOfInuNR3DK2h02HQDxwPAXSpc1Labjed9VA9MY
         hhSwWlnI8rZXX1SMdDF5Uo8SuNfrlluvDQSUY=
Received: by 10.216.12.67 with SMTP id 45mr1923850wey.218.1244381517866; Sun, 
	07 Jun 2009 06:31:57 -0700 (PDT)
In-Reply-To: <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120970>

by the way, since I'm on the list now anyway:

is there any reason why you guys are calling
mark_parents_uninteresting() after add_parents_to_list() in
limit_list() (revision.c), considering the latter does everything the
former does?  sorta trivial, but it's been bugging me...

On Sun, Jun 7, 2009 at 3:25 PM, Nick Edelen<sirnot@gmail.com> wrote:
> hi guys,
>
> I wasn't aware that Sam was going to upload this, otherwise I would'v=
e
> cleaned it up a bit. =A0not a problem though; thanks for taking the t=
ime
> to do this Sam.
>
> @Johannes:
> the real reason I'm using start_async at all is because of shallow
> commit grafts. =A0we could potentially add an interface to pack-objec=
ts
> to allow it to accept those types of commit grafts if you wanted.
> like, in addition to the --not flag we could add a --shallow flag or
> something... =A0it'd actually be pretty easy to implement, but I don'=
t
> know if you guys'd want that in pack-objects.
>
> @Nicolas:
> I'm using the --revs flag in pack-objects, which causes it to use
> get_object_list(). =A0you'll notice, regardless of whether --thin is
> set, this function still calls
> =A0 =A0 =A0 =A0mark_edges_uninteresting(revs.commits, &revs, show_edg=
e);
> which sets uninteresting objects as preferred bases, which I'd think
> would create a thin pack. =A0I could be wrong though...
>
> as I mentioned in the comment and above, it's an easy fix, but even
> then I wasn't sure what to do with commit grafts. =A0as use_thin_pack
> seemed to be predominantly set on shallow interactions, I just didn't
> bother seperating the cases 'normal but thick pack' and 'shallow
> stuff'.
>
> (btw, I have a really cool idea for shallow/narrow/lazy interaction i=
f
> you have the time. =A0it basically uses 'fantom' placeholder objects =
to
> cover for missing blobs, so a clone/fetch would get all commits/trees
> but only retrieve blobs when a user specifies. =A0I'll get a proof of
> concept done after this rev-cache project).
>
> thank you both for looking over this though.
>
> =A0- Nick
>
> On Fri, Jun 5, 2009 at 6:51 PM, Nicolas Pitre<nico@cam.org> wrote:
>> On Fri, 5 Jun 2009, sam@vilain.net wrote:
>>
>>> instead of using the internal revision walker and piping object ref=
s
>>> to pack-objects this patch passes only the revs to pack-objects, wh=
ich
>>> in turn handles both enumeration and packing.
>>>
>>> Signed-off-by: Sam Vilain <sam@vilain.net>
>>> ---
>>> =A0 Submitted on behalf of Nick in order to get wider feedback on t=
his.
>>> =A0 This version passes the test suite.
>>>
>>> =A0upload-pack.c | =A0 54 +++++++++++++++++++++++++++++++++++++++++=
++++---------
>>> =A01 files changed, 45 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/upload-pack.c b/upload-pack.c
>>> index edc7861..7eda8fd 100644
>>> --- a/upload-pack.c
>>> +++ b/upload-pack.c
>>> @@ -155,13 +155,27 @@ static void create_pack_file(void)
>>> =A0 =A0 =A0 const char *argv[10];
>>> =A0 =A0 =A0 int arg =3D 0;
>>>
>>> - =A0 =A0 rev_list.proc =3D do_rev_list;
>>> - =A0 =A0 /* .data is just a boolean: any non-NULL value will do */
>>> - =A0 =A0 rev_list.data =3D create_full_pack ? &rev_list : NULL;
>>> - =A0 =A0 if (start_async(&rev_list))
>>> - =A0 =A0 =A0 =A0 =A0 =A0 die("git upload-pack: unable to fork git-=
rev-list");
>>> -
>>> - =A0 =A0 argv[arg++] =3D "pack-objects";
>>> + =A0 =A0 /* sending rev params to pack-objects directly is great, =
but unfortunately pack-objects
>>> + =A0 =A0 =A0* has no way of turning off thin pack generation. =A0t=
his would be a relatively simple
>>> + =A0 =A0 =A0* addition, but as we also have to deal with shallow g=
rafts and all it's simplest to
>>> + =A0 =A0 =A0* just resort to piping object refs.
>>> + =A0 =A0 =A0*/
>>
>> What's that? =A0Where did you get that?
>>
>> The way to not generate a thin pack is to not specify --thin to
>> pack-objects. =A0If you get a thin pack without specifying --thin th=
en
>> this is a bug that needs to be fixed first.
>>
>>> + =A0 =A0 if (!use_thin_pack) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 rev_list.proc =3D do_rev_list;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* .data is just a boolean: any non-NULL =
value will do */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 rev_list.data =3D create_full_pack ? &rev=
_list : NULL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (start_async(&rev_list))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("git upload-pack: una=
ble to fork git-rev-list");
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "pack-objects";
>>> + =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "pack-objects";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "--revs";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[arg++] =3D "--include-tag";
>>
>> Shouldn't this be specified only if corresponding capability was
>> provided by the client?
>>
>>
>> Nicolas
>>
>
