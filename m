From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] index-pack: reduce object_entry size to save memory
Date: Mon, 23 Feb 2015 10:38:30 +0700
Message-ID: <CACsJy8CGQAx9KVHF_yGHh+zi6xirtP7ZxTb3-2NafGkmjQkcGA@mail.gmail.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
 <1424397488-22169-2-git-send-email-pclouds@gmail.com> <xmqqegphuze8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	matthew sporleder <msporleder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 04:39:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPjrR-0007v7-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 04:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbbBWDjC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2015 22:39:02 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:46565 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbBWDjB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2015 22:39:01 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so15411766igk.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2015 19:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=F+3m8pPrD7xfh3WM6l4zx7/DYKlCrhwu7pnWoNuPAUs=;
        b=LOz8aTSvwZUKShilmnYokFkoFFg56jk8h2OSP2SU2AdZnQv28ZOtU2nmd6bV4AdFSJ
         w8/0mAf71uJE6Aotmch1DkvJjuQWUd19WPnq+4qScGpbJry9izvE4YJloG2ojXvtkWib
         wwQvY2anEf7NC0D3FDtKuFAfFwjXX8pTu2NsvCWU6ijdalCOMiHjWjGvydA5AMsSQ0Q9
         u2EVO2sF2cs8L6OeEUcuHov0txsppRTNyM3X9v9+t2qgVBXKwll4NeP2eVJEhXXTDRS5
         kiy19NbjCvkEn2DJrDSnKmHJBJ/eaIQHIyUwi+ARzDvbq9/L0fEKdIfBp39Qh7fzpMQa
         b0MQ==
X-Received: by 10.50.66.243 with SMTP id i19mr10551320igt.7.1424662740474;
 Sun, 22 Feb 2015 19:39:00 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Sun, 22 Feb 2015 19:38:30 -0800 (PST)
In-Reply-To: <xmqqegphuze8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264246>

On Mon, Feb 23, 2015 at 9:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 4632117..07b2c0c 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -18,9 +18,12 @@ static const char index_pack_usage[] =3D
>>  struct object_entry {
>>       struct pack_idx_entry idx;
>>       unsigned long size;
>> -     unsigned int hdr_size;
>> -     enum object_type type;
>> -     enum object_type real_type;
>> +     unsigned char hdr_size;
>> +     char type;
>> +     char real_type;
>
> Don't you need these two fields to be able to hold a negative value
> like OBJ_BAD (=3D -1)?  You'd need to spell "signed char" out here.

Right. char's signedness is undefined. Can't believe I hit this on ARM
not 2 months ago and already forgot the lesson. Will fix.
--=20
Duy
