From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] Build in git-repack
Date: Thu, 8 Aug 2013 09:44:50 +0700
Message-ID: <CACsJy8D3FL0rG9YHuSOtobNffiqffU6J7_gfc85CiGuwUdRNnQ@mail.gmail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
 <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
 <1375884049-14961-2-git-send-email-stefanbeller@googlemail.com>
 <vpqzjsth8wt.fsf@anie.imag.fr> <7v38qlec2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 04:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7GEA-0001QX-D9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 04:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933436Ab3HHCpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 22:45:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35697 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933296Ab3HHCpV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Aug 2013 22:45:21 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so2856046pad.37
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=I3vonEVsCiR5OUXHP2yUUj5NNO6jUNJjN0A3H8VgN5Y=;
        b=AZ2ETZstgaoxdDSj4mu0F0ytGML804Mwf56/+PlojCOoKMNtbC+/+61otojU1Uah/b
         hpMCXa5jqxDggaIHwUNspmYpj3M2ihjvrRwIqS+f19PJtmElRTMPDgKrTgV3ulO5ILI2
         dEaER09XyoDJ8sAmATs/PANi+3N4cZ76ACo1kZG/OJqysmOUTuYrh01gIjZs9MlcG+NW
         +hW9b0jabz7suyURVeOBMBtkH6R//giC7CeDPQXzACG1d/PRag3V+Bzv+7WatR3eHZ+R
         zKEMrP+auVd3/kcri2+TZhhY2kK91Uw+9Xa1p+DehzSnWQHaOK8n3ZksINTSfQi42CDZ
         q7hg==
X-Received: by 10.68.129.138 with SMTP id nw10mr3522263pbb.158.1375929920811;
 Wed, 07 Aug 2013 19:45:20 -0700 (PDT)
Received: by 10.70.102.163 with HTTP; Wed, 7 Aug 2013 19:44:50 -0700 (PDT)
In-Reply-To: <7v38qlec2w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231858>

On Wed, Aug 7, 2013 at 10:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> [ It's cool you're working on this, I'd really like a git-repack in =
C.
>>   That would fix this
>>   http://thread.gmane.org/gmane.comp.version-control.git/226458 ]
>>
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>
>>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>>
>>> pack-objects learns a few more options to take over what's been don=
e
>>> by git-repack.sh. cmd_repack() becomes a wrapper around
>>> cmd_pack_objects().
>>
>> I think the patch would read easier if these were split into two
>> patches: one doing the real stuff in pack-objects, and then getting =
rid
>> of git-repack.sh to replace it with a trivial built-in.
>>
>> Actually, I'm wondering why pack-objects requires so much changes.
>> git-repack.sh was already a relatively small wrapper around
>> pack-objects, and did not need the new options you add, so why are t=
hey
>> needed? In particular adding the new --update-info option that just =
does
>>
>>> +    if (repack_flags & REPACK_UPDATE_INFO)
>>> +            update_server_info(0);
>>
>> seems overkill to me: why don't you just let cmd_repack call
>> update_server_info(0)?
>
> My feeling exactly.  I would rather see a patch that does not touch
> pack-objects at all, and use run_command() interface to spawn it.
> Once we do have to pack, the necessary processing cycle will dwarf
> the fork/exec latency anyway, no?

I'm not opposed to run_command(). I think the reason I wanted to move
repack functionality to pack-objects is to avoid reading sha-1 from
pack-objects and reconstruct the paths again from the sha-1. But for
simplicity, perhaps we should not touch pack-objects at all. Then we
could have builtin/repack.c instead of stuffing cmd_repack in
builtin/pack-objects.c

@Stefan, if you want to push this work, feel free to take it as _your_
patch, rewrite as will. You don't need to retain my name.
--=20
Duy
