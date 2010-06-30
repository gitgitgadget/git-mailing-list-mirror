From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 03/12] add the basic data structure for line level history
Date: Wed, 30 Jun 2010 22:42:30 +0800
Message-ID: <AANLkTikeqoZeUcnR157VEUVKEYlr0RkYbH_BTb7MMEuj@mail.gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
	<1277558857-23103-4-git-send-email-struggleyb.nku@gmail.com>
	<7v39w8gwrw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 16:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTyV4-0002ay-J7
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 16:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab0F3Omg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 10:42:36 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35764 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab0F3Ome convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 10:42:34 -0400
Received: by gwb15 with SMTP id 15so412669gwb.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UGPcbCE7xKOT6su7QGoHljgp7oSriuXqyNIth4vcvE0=;
        b=WSeRYDJfyS7zokN2bUcLvBdIdo0c1GlutQdY9fDWTzttYh+gkZI2mlFz7hPl6ITFcD
         fttj5cyZMEj1/EvH2G/wVeHYX/da+PquaBCmNk4OWLUoAvmjxwQ7drNarX2S1opf4Hnp
         IGGf4x+Wacjs3lZG7Yzlbj9e+8B1OZsHnPi1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jolivX8MREh+aWZK9gb6JdP9s+k1ZKrj+W7aTGFEZ8B5lY75mYUNmqujrRWHchGAtN
         zB6TxldxMvCN/xLAioq+l94orZRur5X+0R7gL+gpP7mU6oO4hj06Zt62CsroWGD4q/QY
         E6AX88c54fXsCocbZjfD6JvsM85uanS2vfLlY=
Received: by 10.229.187.77 with SMTP id cv13mr5069112qcb.3.1277908951607; Wed, 
	30 Jun 2010 07:42:31 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Wed, 30 Jun 2010 07:42:30 -0700 (PDT)
In-Reply-To: <7v39w8gwrw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149961>

On Mon, Jun 28, 2010 at 2:23 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> +/*
>> + * copied from blame.c, indeed, we can even to use this to test
>
> A bit of refactoring would certainly help, before this series graduat=
es
> the WIP/RFC stage.

I have put the 'parse_loc' into the line.c and make blame.c use it.
Please see the commit log. :-)

>> diff --git a/revision.c b/revision.c
>> index 7847921..3186e0e 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1397,18 +1397,19 @@ static int handle_revision_opt(struct rev_in=
fo *revs, int argc, const char **arg
>> =A0 =A0 =A0 return 1;
>> =A0}
>>
>> -void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx=
_t *ctx,
>> +int parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_=
t *ctx,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct option *opt=
ions,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char * const usage=
str[])
>> =A0{
>> =A0 =A0 =A0 int n =3D handle_revision_opt(revs, ctx->argc, ctx->argv=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
&ctx->cpidx, ctx->out);
>> =A0 =A0 =A0 if (n <=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 error("unknown option `%s'", ctx->argv[0])=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 usage_with_options(usagestr, options);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 ctx->argv +=3D n;
>> =A0 =A0 =A0 ctx->argc -=3D n;
>> +
>> + =A0 =A0 return 0;
>> =A0}
>
> The function has existing callers and they expect it to fail with
> usage_with_options(), never to return. =A0Doesn't this change break t=
hem?
>
> This change is not described nor justified in the commit log message.

Yes, this will affect other callers badly. But, with the new one pass
parsing method, we don't need this change anymore, so please forget
it.

>> =A0static int for_each_bad_bisect_ref(each_ref_fn fn, void *cb_data)
>> @@ -1631,6 +1632,12 @@ int setup_revisions(int argc, const char **ar=
gv, struct rev_info *revs, struct s
>> =A0 =A0 =A0 if (revs->combine_merges)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 revs->ignore_merges =3D 0;
>> =A0 =A0 =A0 revs->diffopt.abbrev =3D revs->abbrev;
>> +
>> + =A0 =A0 if (revs->line) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 revs->limited =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 revs->topo_order =3D 1;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (diff_setup_done(&revs->diffopt) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("diff_setup_done failed");
>>
>> diff --git a/revision.h b/revision.h
>> index 855464f..26c2ff5 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -14,6 +14,7 @@
>> =A0#define CHILD_SHOWN =A0(1u<<6)
>> =A0#define ADDED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1u<<7) /* Parents a=
lready parsed and added? */
>> =A0#define SYMMETRIC_LEFT =A0 =A0 =A0 (1u<<8)
>> +#define RANGE_UPDATE (1u<<9) /* for line level traverse */
>> =A0#define ALL_REV_FLAGS =A0 =A0 =A0 =A0((1u<<9)-1)
>
> It doesn't make sense to add a global flag here and keep ALL_REV_FLAG=
S the
> same value. =A0Have you audited the existing code and made sure that =
they
> either do use 1<<9 for their own or their uses of such a custom flag =
are
> compatible with this?
>

Hmm, I really mean the ALL_REV_FLAGS would be ((1u<<10)-1). :-)

And all the other comments from you are very helpful and I have
changed the according it. Thanks a lot!

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
