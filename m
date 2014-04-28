From: Bhushan Lodha <bhushanlodha@gmail.com>
Subject: Re: [PATCH 06/10] log: --function-name pickaxe
Date: Mon, 28 Apr 2014 16:04:40 -0400
Message-ID: <CAHqUa-3myd+ephcRBQ97gV02BJqzKLqowU4GFi-PsS6qzCMQUw@mail.gmail.com>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
	<62ab0f9c34eabe020ae99c7c1f69d580d9bb36d8.1395942768.git.davidad@alum.mit.edu>
	<533DD1B1.3000107@web.de>
	<xmqqwqf6ozp3.fsf@gitster.dls.corp.google.com>
	<533E9465.8070609@gmail.com>
	<xmqqlhvlorug.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:04:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WernD-00056B-5C
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbaD1UEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 16:04:43 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:40348 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaD1UEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 16:04:42 -0400
Received: by mail-la0-f43.google.com with SMTP id c6so5346510lan.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UBNljycmvtZVMZKniBe/Xzh5L+2SX9TL6lf+exmRK3g=;
        b=tpZMrUxdI3ED/rmrQNVKA8DFgYbiEudXqpDkXSAhWExbDtZUNzbgcBYrn44wYnytsj
         w24ffa0tQ0dKLVfd7cgNbov2hlnz3bYE9FLkJ6Fbisd3aJcZLf68/UPV1o7CKzPnNbSM
         DrhH0OISqloHrt8sIEplOKtsqvv+619CXF0BNQtNzGkDvrtoewK1PWdBechq7jEGYIGi
         dQYuZiVZGR8YxokNoO/mD0y/iSCqkwqRnCPRD2h5N28GG7A3DVl7kB8Skba7RozLFJlV
         VGnGNLb4JXLb82NiNf4tqIfR3MDaEH8kam0c35eUY1yJOR8l8lfbSpbAOWeUutL/j6tV
         UFKg==
X-Received: by 10.112.118.20 with SMTP id ki20mr2523124lbb.45.1398715480693;
 Mon, 28 Apr 2014 13:04:40 -0700 (PDT)
Received: by 10.112.236.129 with HTTP; Mon, 28 Apr 2014 13:04:40 -0700 (PDT)
In-Reply-To: <xmqqlhvlorug.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247434>

I plan to work on this in few weeks. If anybody has more suggestion or
want to discuss the implementation let me know

On Fri, Apr 4, 2014 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> W dniu 2014-04-03 23:44, Junio C Hamano pisze:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> With that approach you depend on the hunk header and apparently ne=
ed
>>>> to add XDL_EMIT_MOREFUNCNAMES and XDL_EMIT_MOREHUNKHEADS to improv=
e
>>>> the results.  This approach feels fragile.
>>>>
>>>> Would it perhaps be more robust to not base the implementation on =
diff
>>>> and instead to scan the raw file contents?
>>>
>>> That is an interesting idea.
>>>
>>> Perhaps this can be implemented as a new stage in the transformatio=
n
>>> pipeline, I wonder?  There is currently no transformation that
>>> modifies the blob contents being compared, but I do not think there
>>> is anything fundamental that prevents one from being written.  The
>>> new "limit to this function body" transformation would perhaps sit
>>> before the diffcore-rename and would transform all the blobs to
>>> empty, except for the part that is the body of the function the use=
r
>>> is interested in.
>>
>> Well, there is 'texconv', e.g.
>>
>>   .gitattributes
>>   *.jpg diff=3Djpg
>>
>>   .git/config
>>   [diff "jpg"]
>>          textconv =3D exif
>
> ;-)  So you could define this textconv
>
>     sed -n -e '/^int main(/,/^}/p'
>
> to limit the output only to the definition of the function main().
>
>> Doesn't it fit in said place in the transformation pipeline?
>
> Not at all, unfortunately.  The textconv conversion happens in the
> final output stage and comes way too late to influence the earlier
> stages like renames and pickaxe, which will still see the whole
> contents outside the definition of the function main().
>
>
>
