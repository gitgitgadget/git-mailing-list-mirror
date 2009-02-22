From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: Re: [PATCH/RFC 4/6] object: add one bit to let creation of private 
	types (OBJ_MAX + n)
Date: Sun, 22 Feb 2009 20:35:05 +0200
Message-ID: <e29894ca0902221035s54e005adg586409754966cfcc@mail.gmail.com>
References: <e29894ca0902221006u77fdaa89s9cc01fb27bffce0b@mail.gmail.com>
	 <7vocwuxrgb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:36:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJBu-0004gb-DW
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZBVSfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbZBVSfK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:35:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:63722 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbZBVSfI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:35:08 -0500
Received: by nf-out-0910.google.com with SMTP id d21so370570nfb.21
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7Rj8qvaS2AePfcD1uVSt7aUwozfPvfvjbNNC4CyDvLI=;
        b=C7e23urm8v5gleVYe27pfAfZsg5mkf33MB3zgTC/L2husoOQoMiMyrs8hyHhb5PDNq
         7QlSrfA2PUFj0CiwRwdN+NAqrn3Y5wPlL9+deV0/lUOMnryqcHSk4lz7wQWm/d0AqX7K
         gqM+ohPYFSzuZ4w7oXQHRiaU/7Ji406Z2sYL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XsRIhyIpbEueuHoJ/J+PuoiqrzM2ScFn8a1gHzKCnp9RGaOwWc+fxoos+2rCOR1c0B
         DaFkrl88wNPevunHh54CX3WgOqGp3eu0dSafMzd2UJKQL/E3ErD2pNx79KGBn0xUTeM8
         KUOKEThox3Wmn+3u6k21qJKWS7pVIJwlIIn5o=
Received: by 10.210.119.5 with SMTP id r5mr2728824ebc.64.1235327705916; Sun, 
	22 Feb 2009 10:35:05 -0800 (PST)
In-Reply-To: <7vocwuxrgb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111044>

Hi

On Sun, Feb 22, 2009 at 8:21 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> ---
>>  object.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/object.h b/object.h
>> index 89dd0c4..83d3644 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -21,7 +21,7 @@ struct object_array {
>>       } *objects;
>>  };
>>
>> -#define TYPE_BITS   3
>> +#define TYPE_BITS   4
>>  #define FLAG_BITS  27
>
> This would increase the value of (TYPE_BITS+FLAG_BITS).  We spent a l=
ot of
> effect to keep sizeof(struct object) to absolute minimum, and you nee=
d to
> have a very good reason if you are breaking it.
>
>

Ooops. Ok, I should try to think harder how to have my own tag_list. I
only store a struct tag or a struct light_tag currently.

One option is to reuse the struct tag, by adding a "light" flag, but I
am not fond of this idea.

Second option is to create a custom tag list in builtin-tag.c, not
reusing object_list. I guess this is better then.  What do you think?

=46or example:

struct tag_list {
 struct object *item;
 int light; /* item is a struct light_tag */
 struct object_list *next;
}

thanks,

--=20
Marc-Andr=E9 Lureau
Sent from: Helsinki Southern Finland Finland.
