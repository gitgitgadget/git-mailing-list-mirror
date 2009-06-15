From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 13:39:08 +0200
Message-ID: <81b0412b0906150439r755a7498ldddbca911b2fd36e@mail.gmail.com>
References: <87bpoqoavp.fsf@meyering.net>
	 <81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
	 <87fxe2lybr.fsf@meyering.net>
	 <81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com>
	 <87vdmxluj8.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 13:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGAXr-0007so-N6
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 13:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbZFOLjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 07:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755696AbZFOLjJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 07:39:09 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41503 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbZFOLjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 07:39:08 -0400
Received: by bwz9 with SMTP id 9so3252288bwz.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l1AoTn6jeZvlxYCRu7UZ/koDdMXkypg2MflL7FLs/S4=;
        b=gojmwPelVPM3DcWa6MwITuLeuKjG233lFWIMx4es9FE4FEOC6bUCODXi1semu7Wk/2
         DObksktxi7kJWSjHTjlc5r8E2w/WV+3GfHUkZAcJeZhqYsoGWi3zTCVqbmrlHYnDalMJ
         NbMHkDqVh+e8L5p4rRAhx9yKXrPd/Adv3xL1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=caUBYWAyL6iavo+oh0+EHRQshSVuXQmcwRCsyQCKsWl8iKNCkW6v26UkJvJK+dse2E
         Wp5ctBSljkIhb6vWjPgGF/rqOQLy+CZeNS0xCW7gVhx712ZpODrhtEmj3X7XYAV9t5zv
         MEILWGfDWnqJtuYl60wwc5ovh0WkKPUrapAX4=
Received: by 10.204.52.146 with SMTP id i18mr6951481bkg.82.1245065948890; Mon, 
	15 Jun 2009 04:39:08 -0700 (PDT)
In-Reply-To: <87vdmxluj8.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121597>

2009/6/15 Jim Meyering <jim@meyering.net>:
> Alex Riesen wrote:
>> 2009/6/15 Jim Meyering <jim@meyering.net>:
>>> Alex Riesen wrote:
>>>> 2009/6/14 Jim Meyering <jim@meyering.net>:
>>>>> @@ -231,7 +231,7 @@ static int read_merge_config(const char *var,=
 const char *value, void *cb)
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(var, "merge.default")) {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value)
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 default_ll_merge =3D strdup(value);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 default_ll_merge =3D xstrdup(value);
>>>>
>>>> read_merge_config has a failure mode (where it returns -1), why no=
t use it?
>>>
>>> I didn't even consider it, because it would be inconsistent with
>>> the other heap-allocation functions used there (xcalloc, xmemdupz).
>>>
>>> However, now that I do, it looks like that would mean adding four t=
imes
>>> the same code (including conditionals and code to generate a diagno=
stic via
>>> a call to error -- or a goto). Why bother, when all of that is alre=
ady
>>> encapsulated in xmalloc?
>>
>> So that a useful error message can be given in the _caller_ (it know=
s
>> more about context)?
>
> So you want to tell the user that we failed
> to strdup the "merge.default" value?
> Or the "driver" value?

"merge: recursive: error loading configuration (last seen:
merge.default): Out of memory\n"

> Of more general interest, when xstrdup fails, it might be useful to
> include in the diagnostic how long the would-be-dup'd string was. =C2=
=A0I.e.,
> rather than saying
>
> =C2=A0 =C2=A0die("Out of memory, strdup failed");
> say
> =C2=A0 =C2=A0die("Out of memory, failed to strdup a %lu-byte string",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(unsigned long int) strlen(str));

Yes. Still lacks higher level information, though.

>> Otherwise the error message ("Out of memory, strdup failed") does no=
t
>> have anything about the place nor situation in it. As the situations
>> when a modern system really runs out of memory are very rare,
>> mostly such reports just point at some inconsistency elsewhere
>
> Exactly. =C2=A0This is why I think it's not worthwhile to invest in
> a more precise diagnostic, here.

I disagree. It is already hard to find starting point for debugging if
the failed code is just a layer: the config of ll-merge is called not o=
nly
from the merge drivers, but also indirectly from the programs which
call the merge itself. Now, go figure where has it failed...

>> (like bloody stupid memory management in system support libraries
>> on an OS-not-to-be-named-again or the usual corruption of heap
>> control structures).
>>
>> Besides, xstrdup does more then just allocation: it tries to free gl=
obal
>> list of cached pack chunks. This does not play very well with the ef=
forts
>> to make a library out of the modern Git code.
>
> Ahh... librarification. =C2=A0This is a slightly different topic.
> I see existing uses of xcalloc and xmemdupz, not to
> mention "error" calls, and conclude that this function is
> not library caliber code, so there's no need to invest.

Well, error() does not finish the programs, and the rest (in just my op=
inion)
suffer the same problems except where it is used in cmd_-functions
(IOW, in top-level caller).

> If you want a version of this function that is more library-friendly,
> then that will be more work. =C2=A0However, I think librarification s=
hould
> be addressed separately from this simple patch to avoid a potential N=
ULL
> dereference (and *no* diagnostic).

I do not explicitely _want_ librarification in this particular context.
I'm just pointing out that you just made another (maybe small) obstacle=
 for it.
