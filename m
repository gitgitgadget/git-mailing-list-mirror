From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Thu, 12 Apr 2012 01:35:53 -0700
Message-ID: <CACz_eyetzT3AFg1w3CbQegPLHfH0inwcYv5yhbffjog0cBqwug@mail.gmail.com>
References: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
	<1332482108-2659-1-git-send-email-lucian.poston@gmail.com>
	<7vy5qrtcca.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 10:36:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIFVd-0000aQ-GT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 10:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760685Ab2DLIf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 04:35:59 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37464 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759869Ab2DLIfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 04:35:54 -0400
Received: by dake40 with SMTP id e40so2196070dak.11
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6HJe429VD7ltF/buldJeUtxrhXALv0wtxN+BmAG1dvE=;
        b=Do8YrbyrWflwlCWIXICl+ipUQn3/tXMWmTVmABvQAGjJXsash5UwvpXXC/4zR+kP9s
         Ae+d5LePiwiXBQddkhFYH/iCF/Add2aPV2JMM4OeDDWMqgLSIJxRG+G0ilNac93noAzH
         IZADq6e8spMFMabBLy2ltMaVGFC5aF4o67BN6TyBmGAq7nYZ6goGR20qR+jo0TGhopyD
         5VbZkSsOcGaXTdPuIBqOxmlLl5HqRhIt38tCgLLkNVvp9iG6lqe+i5rLa31HsLcUOF6e
         +5O4c73Gi+B9doMGTK+b93gRQMyLIqZrHbPv5xuL1ei7/4oGkaWycqhWGsZG/Ptoi3V4
         vbdQ==
Received: by 10.68.194.1 with SMTP id hs1mr1457547pbc.6.1334219754238; Thu, 12
 Apr 2012 01:35:54 -0700 (PDT)
Received: by 10.68.238.74 with HTTP; Thu, 12 Apr 2012 01:35:53 -0700 (PDT)
In-Reply-To: <7vy5qrtcca.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195314>

On Fri, Mar 23, 2012 at 11:13, Junio C Hamano <gitster@pobox.com> wrote=
:
> Please do not do reflowing of the text in the same patch as modifying=
 the
> logic. =C2=A0It is unreadable for the purpose of finding out what you=
 really
> changed.

I will un-reflow the text. :]

>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* In other words: stat_width limits the m=
aximum width, and
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* stat_name_width fixes the maximum width=
 of the filename,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* and is also used to divide available co=
lumns if there
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* aren't enough.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 reserved_character_count =3D 6 + number_width;
>
> As far as I can tell, this introduces a variable that is set (and is =
meant
> to be set) only at a single place, namely, here, and used throughout =
the
> rest of the function. But it invites later patches to mistakenly upda=
te
> the variable. =C2=A0I do not see the merit of it.
>
> If you wanted to have a symbolic name for (6+number_width), #define w=
ould
> have served better.
>
> Also as we see in the later part of the review, this name is probably=
 way
> too long to be useful. =C2=A0We need a shorter and sweeter name to ca=
ll it.

I'll remove it.

>> =C2=A0 =C2=A0 =C2=A0 if (options->stat_width =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D term_colu=
mns();
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D options->=
stat_width ? options->stat_width : 80;
>>
>> + =C2=A0 =C2=A0 width -=3D line_prefix_length;
>> +
>
> Isn't this wrong? =C2=A0This is not a rhetoric question, iow, I am no=
t
> declaring that this is wrong --- I just cannot see why the above is a=
 good
> change, as I do not see a sound reasoning behind it.
>
> When the user said "--stat-width=3D80", she means that the diffstat p=
art
> (name and bargraph) is to extend 80 places, and she does not expect i=
t to
> be reduced by the width of the ancestry graph. =C2=A0If the user want=
ed to clip
> the entire width, she would have used COLUMNS=3D80 instead.
>
> Am I missing something?

You're right, the prefix length shouldn't be subtracted when
--stat-width is specified.

>> @@ -1472,16 +1484,36 @@ static void show_stats(struct diffstat_t *da=
ta, struct diff_options *options)
>> =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Adjust adjustable widths not to exceed =
maximum width
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 if (name_width + number_width + 6 + graph_width > wi=
dth) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (graph_width > width =
* 3/8 - number_width - 6)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width * 3/8 - number_width - 6;
>> + =C2=A0 =C2=A0 if (reserved_character_count + name_width + graph_wi=
dth > width) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Reduce graph_wid=
th to be at most 3/8 of the unreserved space and no
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* less than 6, whi=
ch leaves at least 5/8 for the filename.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (graph_width > width =
* 3/8 - reserved_character_count) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graph_width =3D width * 3/8 - reserved_character_count;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (graph_width < 6) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graph_width =3D 6;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> What is this about? =C2=A0reserved_character_count already knows abou=
t the
> magic number 6 and here you have another magic number 6. =C2=A0How ar=
e they
> related with each other?
>
> In other words, shouldn't the added code be more like this?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (graph_width < reserved_character_count=
 - number_width)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0graph_width =3D=
 reserved_character_count - number_width;

There are two magic number 6's. From previous comments that explain
how reserved_character_count is calculated:

        * Each line needs space for the following characters:
        *   - 1 for the initial " "
        *   - 4 + decimal_width(max_change) for " | NNNN "
        *   - 1 for the empty column at the end,
        * Altogether, the reserved_character_count totals
        * 6 + decimal_width(max_change).

In the case of deriving reserved_character_count, 6 arises because 1+4+=
1.

The second magic number 6 is the minimum value for graph_width. The
intention of the original stat width calculation was to give the
filename portion 5/8ths of the total width and give the graph portion
3/8ths of the total width. With 80 columns, that works out to 50 for
filename and 30 for the graph (plus reserved characters). With 16
columns, that works out to be 10 and 6. I assume 5 and 3 would be too
small, so 10 and 6 were probably chosen as the minimum values by the
previous author(s).

So now you ask why I added the if (graph_width < 6) conditional?

> +             if (graph_width > width * 3/8 - reserved_character_coun=
t) {
> +                     graph_width =3D width * 3/8 - reserved_characte=
r_count;
> +                     if (graph_width < 6) {
> +                             graph_width =3D 6;
> +                     }
> +             }

The calculation in the graph_width assignment (and the prior
conditional) does not guarantee graph_width is at least 6. The
calculation should be ((width - reserved_character_count) * 3/8),
instead of (width * 3/8 - reserved_character_count). But as we saw in
my initial patch, adjusting this calculation causes test regressions.
Therefore, I added a conditional to catch the edge case where
graph_width is less than 6.

Assuming the $COLUMNS is 26 or less, graph_width will actually come
out to -1, iirc.
