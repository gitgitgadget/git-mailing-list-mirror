From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict resolution
Date: Tue, 12 Jul 2011 11:13:58 +0530
Message-ID: <CALkWK0=W58pHShDeoPkys2gYNAk+VSP7CCVijvSDq6N_NdLaKw@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com> <7vbox0cz1j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVmb-0004Cq-UQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1GLFoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 01:44:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54790 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1GLFoT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 01:44:19 -0400
Received: by wwe5 with SMTP id 5so4575892wwe.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 22:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4VA2sTt3p+wdbhXOiATfhvIKOhNJTUO3WrCxl0nesT4=;
        b=gNh2UjQhne63Bue/7mHgT+fOtcGrlivnWyoEKociygexctb77CZK2aiHQe63uDcClG
         cwUsokFjaAWNNit7k9rg3XMDO9BQMvwXS/fSrVYHLa4V+5/Q1+eZuf5w7RYhgZlNN/Bz
         RMyaLaGleRZ1xcm7QMbOSO6gP//qgqSZYNKqo=
Received: by 10.217.3.17 with SMTP id q17mr3593836wes.107.1310449458117; Mon,
 11 Jul 2011 22:44:18 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 22:43:58 -0700 (PDT)
In-Reply-To: <7vbox0cz1j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176914>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> + *
>> + * Usage example:
>> + *
>> + * =C2=A0 =C2=A0 struct commit_list *list;
>> + * =C2=A0 =C2=A0 struct commit_list **next =3D &list;
>> + *
>> + * =C2=A0 =C2=A0 next =3D commit_list_append(c1, next);
>> + * =C2=A0 =C2=A0 next =3D commit_list_append(c2, next);
>> + * =C2=A0 =C2=A0 *next =3D NULL;
>> + * =C2=A0 =C2=A0 assert(commit_list_count(list) =3D=3D 2);
>> + * =C2=A0 =C2=A0 return list;
>> + *
>> + * Don't forget to NULL-terminate!
>
> I am still not convinced that making it the caller's responsibility t=
o
> NULL-terminate the list after it finishes to append is a good trade-o=
ff
> between run-time performance and ease of API use. =C2=A0If you are ap=
pending
> thousands of commits to a commit list in a tight loop, surely you wou=
ld
> save the same thousands of assignment of NULL to the next field of th=
e
> element at the tail of the list, which may reduce the instruction cou=
nt a
> tiny bit, but that field was assigned in the last round in that tight=
 loop
> and the cacheline would likely to be owned by the CPU already, so it =
might
> not make much practical difference.

Ah, I hadn't thought about it this deeply.  Changed now- thanks for
the explanation.

-- Ram
