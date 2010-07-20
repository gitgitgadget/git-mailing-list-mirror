From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Tue, 20 Jul 2010 23:47:44 +0800
Message-ID: <AANLkTil8C7h8T4sVfvj2IkYIUHmGLOIvKX82Lo_Zlyrw@mail.gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<201007200048.18284.trast@student.ethz.ch>
	<7veiezni4m.fsf@alter.siamese.dyndns.org>
	<201007200951.56218.trast@student.ethz.ch>
	<AANLkTinXDRV_Ikd-hoGoWPZmn1Tp0NYHoumaqthydsuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 20 17:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObF2u-0000Xz-0G
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 17:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab0GTPrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 11:47:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58524 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379Ab0GTPrq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 11:47:46 -0400
Received: by fxm14 with SMTP id 14so2917116fxm.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/+YkUCB1z6f84kWbFkNbqQMdFEkuLHtx60O/mOj2n7A=;
        b=sLyqujOqvSmNDukgX3g87l6tkLCxfQxQzHRI1uksPatq07jc0wzfi+v4yx9oXwAqHK
         iDTHDqZbwGUwnzkKqALUPeDcI7JyK1n5e4Gy1IQBSMXvhwtJ7gqX1a88hM3UoDeD+AUL
         FATCv7PXhL+ludDwr1/1+wwPOByPx261lPULk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jP5kqBFtI724X9c2shpBk1ClN6JUBdsw+sZYLFbEK8G7fmO8Ea4G7voLTpeUPRjvoR
         wNOhspfW5nvwtmN+kdm4LNcASiM4bBS2WrA/eFnCzDm8FBZSTxbW88n3bDUyrjuVlYzt
         4kVUiVCZWfBJMmLq3I0LD9tgoUZp5h7DqVFIw=
Received: by 10.216.79.69 with SMTP id h47mr5531290wee.68.1279640865094; Tue, 
	20 Jul 2010 08:47:45 -0700 (PDT)
Received: by 10.229.217.149 with HTTP; Tue, 20 Jul 2010 08:47:44 -0700 (PDT)
In-Reply-To: <AANLkTinXDRV_Ikd-hoGoWPZmn1Tp0NYHoumaqthydsuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151320>

On Tue, Jul 20, 2010 at 11:46 PM, Bo Yang <struggleyb.nku@gmail.com> wr=
ote:
> On Tue, Jul 20, 2010 at 3:51 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
>> Junio C Hamano wrote:
>>> Thomas Rast <trast@student.ethz.ch> writes:
>>> > I think that would just needlessly break the analogy to git-blame=
=2E[0]
>>> > With the current code,
>>> >
>>> > =A0 git blame -L 2,3 <path>
>>> > =A0 git log -L 2,3 <path>
>>> >
>>> > work the same.
>>>
>>> I like the general direction, but I am not sure how far we want to =
take
>>> that analogue with blame, though.
>>>
>>> For example, Bo's "log -L" thing also works on more than one path, =
no? =A0I
>>> suspect it might be be reasonable to teach "blame" to annotate more=
 than
>>> one path (with ranges) the same way. =A0There is no technical limit=
ation in
>>> the underlying scoreboard mechanism to prevent it from happening.
>>>
>>> Very similar to "blame" but quite differently from any normal "log"
>>> operation, "log -L" allows only one positive commit (starting point=
).
>>
>> AFAICT this is not a conceptual requirement, only one of the current
>> implementation/option parsing. =A0[Bo, how hard would it be to remov=
e
>> this requirement?]
>>
>> 'git log --follow', if it were ever unbroken, would have much the sa=
me
>> problem that while technically allowing more than one starting point=
,
>> using that is only possible if the starting filename happens to agre=
e
>> on all of them.
>
> I think Junio here did not ask for 'git log -L' to support multiple
> starting commits. [1]

=46orget [1]: gmane.comp.version-control.git:142900

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
