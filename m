From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: Re: 64-bit support.
Date: Thu, 14 Nov 2013 18:55:52 +0400
Message-ID: <CAJc7Lbp2gF18xAM1z-NCo8cp73px_-RTqGcB1MiPup9iGn+uRw@mail.gmail.com>
References: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
	<27C8BBEE-128F-4CC1-AACE-248CA0CD8FBE@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Kent R. Spillner" <kspillner@acm.org>
X-From: git-owner@vger.kernel.org Thu Nov 14 15:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgyKu-0002v4-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 15:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310Ab3KNOzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Nov 2013 09:55:54 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:47311 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab3KNOzx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 09:55:53 -0500
Received: by mail-vc0-f180.google.com with SMTP id ib11so771342vcb.11
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1O2Wrwq7l44B8OLFobial1QYSgVwoHUApZ+6i++2v5U=;
        b=lbeE4+LNlSmgF9hd/W/gTkbZwNSJRbGHLJ3Y60DK0KxoNPrjzAVEtlz9v8ROU9bspW
         yXS+Utat1k4ShQhHGHUrmcohp4+hgcjvoqxEFEEbf0h5q2GSlZdemxfpZ/LiI9cYrVI2
         sFExh+pwnMioCT3ne6acbrvON9edweeyzUELXG4XOIkFfdRUSWXxdqYy1/EeZ9KMvyBF
         4aAN4VlypXuUDnD8QHKh8kJyZssENlqS5v1zYWfpr4CP+HnsyoGg7/pTE5FwOvVXvTAd
         XODTJK9LUNyMGlw/XYMP2x87q+hRTyyL1V4lLmQ0h2Qu6fnR6sxsTPraXrjWsQJE23SO
         wQjw==
X-Received: by 10.220.199.5 with SMTP id eq5mr1117495vcb.16.1384440952414;
 Thu, 14 Nov 2013 06:55:52 -0800 (PST)
Received: by 10.58.109.71 with HTTP; Thu, 14 Nov 2013 06:55:52 -0800 (PST)
In-Reply-To: <27C8BBEE-128F-4CC1-AACE-248CA0CD8FBE@acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237852>

I hit this limit in file 'diffcore-rename.c':

if (rename_limit <=3D 0 || rename_limit > 32767)
        rename_limit =3D 32767;

I just guess, that this limit comes from the O(N^2) complexity of the
comparison algorithm. Since the max 32-bit signed value is 2^31, then
the 2^15 =3D 32768 is somehow correlated with its square root, maybe,
like 2^(32/2 - 1) - to prevent overflow.
I'm trying to prepare the patch right now, that changes the `int
rename_limit` =3D> `long rename_limit` and all intermediate variable
types. Is it a correct way to do?

On 14 November 2013 18:40, Kent R. Spillner <kspillner@acm.org> wrote:
> Can you be more specific about the limitation you suspect you are hit=
ting?  32,768 is not the "max 32-bit value."
>
>
>> On Nov 14, 2013, at 6:58, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=B8=
=D0=BD =D0=98=D0=B2=D0=B0=D0=BD  <abyss.7@gmail.com> wrote:
>>
>> Hi!
>>
>> Do you plan to implement the 64-bit support in git? - Right now I ha=
ve
>> a problems sometimes with a huge repo and renaming detection. If I
>> merge more than 32768 files at once, then the renaming detection
>> fails, because of limitation inside git. The limitation is put by ma=
x
>> 32-bit value.
>>
>> I tweaked sources locally, to use 64-bit value as a number of mergin=
g
>> files - generally, it works. But I'm not so brave to try to replace =
it
>> everywhere in git.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
