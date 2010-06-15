From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [PATCH 2/5 v2] unpack_trees: group errors by type
Date: Tue, 15 Jun 2010 15:15:36 +0200
Message-ID: <AANLkTin381eyaDabz3-z_8jB05N4CVKGmLOqVOprJMW2@mail.gmail.com>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<vpqljagzc39.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 15:16:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVzq-0008Dy-7n
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 15:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab0FONPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 09:15:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41062 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0FONPw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 09:15:52 -0400
Received: by fxm10 with SMTP id 10so132359fxm.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=CU12HcPgIJ9OsLrwpyK1uplUSkEs9zA6CxtuTxImJeM=;
        b=b90dvJLs/ksEVaHCyMGEWwpZKl2KnfKpIEtT3GdBjfiUv0c+AG2B6EtRm0N7qVXzHO
         6lBsgW15GSWxZKAouynWp1iifC/9RfSIwWS1SqDIhYG91yRzC9hTNjwJXpmdbtfaqToY
         X/dWBtSkzN4m9+A6EsdqM0RHmFvWRIFDxWQiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=ixOR55hW69W9emlHyDockNr9AD7aZBP2DDmHyyFpiOk4/74eb5ouG7cNC/ReGNrBiR
         Kh+wTCfxQKwgQIlaa9iTyqlNp/ChKt6UH8ke0SGRZsyyKNv/HB6QQfPHtfd++rvHLTt3
         xFuzolQRz+34FIS7yvZZ91r2IKUPbOvKjjaDo=
Received: by 10.239.188.65 with SMTP id o1mr495473hbh.83.1276607751114; Tue, 
	15 Jun 2010 06:15:51 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Tue, 15 Jun 2010 06:15:36 -0700 (PDT)
In-Reply-To: <vpqljagzc39.fsf@bauges.imag.fr>
X-Google-Sender-Auth: q2G5Y8F3trk30s9qsotjsYbJR1M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149184>

Le 15 juin 2010 14:58, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =E9=
crit :
> Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:
>
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -60,6 +60,92 @@ static void add_entry(struct unpack_trees_options=
 *o, struct cache_entry *ce,
>> =A0}
>>
>> =A0/*
>> + * add error messages on path <path> and action <action>
>> + * corresponding to the type <e> with the message <msg>
>> + * indicating if it should be display in porcelain or not
>> + */
>> +static int add_rejected_path(struct unpack_trees_options *o,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum unpack_tre=
es_error e,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *pat=
h,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *act=
ion,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int porcelain,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *msg=
)
>> +{
>> + =A0 =A0 struct rejected_paths_list *newentry;
>> + =A0 =A0 struct rejected_paths **rp;
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* simply display the given error message if in plumbing=
 mode
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (!porcelain)
>> + =A0 =A0 =A0 =A0 =A0 =A0 o->show_all_errors =3D 0;
>> + =A0 =A0 if (!o->show_all_errors)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return error(msg, path, action);
>
> I don't fully understand what you're doing with show_all_errors and
> porcelain here. From the caller, "porcelain" is true iff the
> corresponding error message has been set in o. But if you can infer
> whether you're in porcelain from the error messages, why do you need
> show_all_errors in addition?
>
>> =A0static int reject_merge(struct cache_entry *ce, struct unpack_tre=
es_options *o)
>> =A0{
>> - =A0 =A0 return error(ERRORMSG(o, would_overwrite), ce->name);
>> + =A0 =A0 return add_rejected_path(o, would_overwrite, ce->name, NUL=
L,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(o && (=
o)->msgs.would_overwrite),
>
> Parenthesis around (o) are distracting and useless. I guess you
> copy-pasted from a macro (for which parentheses should definitely be
> used in case the macro is called on an arbitrary expression).
>
>> @@ -874,8 +964,16 @@ static int verify_uptodate_1(struct cache_entry=
 *ce,
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 if (errno =3D=3D ENOENT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 return o->gently ? -1 :
>> - =A0 =A0 =A0 =A0 =A0 =A0 error(error_msg, ce->name);
>> + =A0 =A0 if (error =3D=3D sparse_not_uptodate_file)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return o->gently ? -1 :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_rejected_path(o, spars=
e_not_uptodate_file, ce->name, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (o && (o)->msgs.sparse_not_uptodate_file),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ERRORMSG(o, sparse_not_uptodate_file));
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return o->gently ? -1 :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_rejected_path(o, not_u=
ptodate_file, ce->name, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (o && (o)->msgs.not_uptodate_file),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ERRORMSG(o, not_uptodate_file));
>> =A0}
>
> Isn't that a complex way of saying
>
> =A0 =A0 =A0 =A0int porcelain;
> =A0 =A0 =A0 =A0if (error =3D=3D sparse_not_uptodate_file)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0porcelain =3D o && o->msgs.sparse_not_=
uptodate_file;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0porcelain =3D o && o->msgs.not_uptodat=
e_file;
> =A0 =A0 =A0 =A0return o->gently ? -1 :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_rejected_path(o, e=
rror, ce->name, NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0porcelain, ERRORMSG(o, error));
>
> ?
>

The problem is that "error" is an enum unpack_trees_error, and
ERRORMSG takes the name of the field from unpack_trees_error_msgs.
If I try to do ERRORMSG(o, error), the compilator would say that the
"error" is not a field of unpack_trees_error_msgs.

> Also, I'm not sure I understand why you're attaching the error messag=
e
> string to each rejected_paths entry. Wouldn't it be more sensible to
> use o->msg in display_error_msgs() instead?
>

In display_error_msgs(), I cannot access o->msg because I would not
know which error I am treating.
In the same way as previously, I cannot use the enum
unpack_trees_error to access it.

I know it makes the code a bit "heavy" but I did not see a better way t=
o do it.

> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
