From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Sun, 2 Jun 2013 12:59:26 -0500
Message-ID: <CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
	<51AB86BB.3080203@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 02 19:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjCZ7-0004Qi-J0
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 19:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab3FBR7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 13:59:30 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35476 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab3FBR72 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 13:59:28 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so397940lbd.15
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DLLpxg8b5ULy4zj4v87b4Bp4XK3lp/9fzWSPwPS4hBk=;
        b=P+zaXykDbb8Y/3Gwnotkeo4ZGjaBXmWLjMytvge+p0f5NeQskNA8WorO5bHl4rC+q7
         uHPG+7PjqxIJ5FFFSUZZebG5LtYhi7FUvuJ3Ai9v0NBgV5U05kZLQTPh5+8AUCg0tGKI
         W2kpGGDahIzaKXXChwiBwNz6bDn4/vaTvmF+OrgqFlu+0prLFjO+/lu1BbBue38PGkb8
         /g2s0qIv57R1twxijen/KOU5vrqa9D+T/eZLexg+slTpwiAL11wrfBQ/opUxzvr2I/Lu
         HDJiBjvixe3BNySLNbpEfqoCkv+NMOZFjx48oEznn1EP7/gGccWTj1gvwpakvz+VGy68
         LEow==
X-Received: by 10.112.133.129 with SMTP id pc1mr6393770lbb.49.1370195967027;
 Sun, 02 Jun 2013 10:59:27 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 10:59:26 -0700 (PDT)
In-Reply-To: <51AB86BB.3080203@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226171>

On Sun, Jun 2, 2013 at 12:54 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 02.06.2013 19:25, schrieb Felipe Contreras:
>>
>> On Sun, Jun 2, 2013 at 10:46 AM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>
>>> +               for (i =3D 0; i < n; i++) {
>>> +                       struct cache_entry *ce =3D src[i + o->merge=
];
>>> +                       if (ce !=3D o->df_conflict_entry)
>>
>>
>> It's possible that ce is NULL, but you didn't add that check because
>> free(NULL) still works? Or because ce cannot be NULL?
>>
>> If it's the former, I think it's clearer if we check that ce is not
>> NULL either way.
>
>
> It is NULL if one tree misses an entry (e.g. a new or removed file). =
free
> handles NULL and we generally avoid duplicating its NULL-check.

Yeah, but I can see somebody adding code inside that 'if' clause to
print the cache entry, and see a crash only to wonder what's going on.
And to save what? 5 characters?

--=20
=46elipe Contreras
