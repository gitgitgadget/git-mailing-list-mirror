From: pi song <pi.songs@gmail.com>
Subject: Re: [PATCH1/2] Libify blame
Date: Wed, 18 Mar 2009 16:59:07 +1100
Message-ID: <1b29507a0903172259t348cb4d5n70f5b3003b1eeb00@mail.gmail.com>
References: <49BE5343.60900@gmail.com>
	 <7vocvzmlqf.fsf@gitster.siamese.dyndns.org>
Reply-To: pi.songs@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 07:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljopj-0004VR-8L
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 07:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZCRF7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 01:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbZCRF7L
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:59:11 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:49070 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbZCRF7K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 01:59:10 -0400
Received: by yx-out-2324.google.com with SMTP id 31so384669yxl.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 22:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wCEA6vFK2dmXCwuw+3dNMwp1WI3efwptbZeZ67kukF8=;
        b=om216fhVot7BuFmBDtfgfMqpGDBV9nh7vhyogXKB/AmPfjX+LmaArBPKVW0bWxG3hS
         dBdEH7jM9adJkrLrd4Tlo8V1yLad8AaKAIJLnbx4c9Ou1yFvLyWYCj6q6tqPy7QE3qIr
         3ZOICyUEEZ+kGGcwFla8OPyWckIdti48/DQT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=quXQr2e/FMX+UW06K5p9YTyZ2ek89VEf6A9O8LkWFfimms1uzDpJ23UXqzzHCA0zwb
         baCtXFXd0Fov5ESTpRLlIplzqn2STD8h82GvhsjnqUXK/6WZ/MiO6ApPg7XxlPQbNVkI
         WmHCCss2SP5MHw+E5VDUZS1/Y1IFXVQrYTCj4=
Received: by 10.142.214.5 with SMTP id m5mr360038wfg.37.1237355947721; Tue, 17 
	Mar 2009 22:59:07 -0700 (PDT)
In-Reply-To: <7vocvzmlqf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113584>

Don't you think we should rather split up into smaller files before
start reorganizing things?

Pi Song

On Wed, Mar 18, 2009 at 4:41 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> pi song <pi.songs@gmail.com> writes:
>
>> diff --git a/blame.h b/blame.h
>> new file mode 100644
>> index 0000000..72d1e2a
>> --- /dev/null
>> +++ b/blame.h
>> @@ -0,0 +1,166 @@
>> +/*
>> + * for storing stats. it can be used
>> + * across multiple blame operations
>> + */
>> +struct blame_stat {
>> + =C2=A0 =C2=A0 int num_read_blob;
>> + =C2=A0 =C2=A0 int num_get_patch;
>> + =C2=A0 =C2=A0 int num_commits;
>> +};
>
> As I said in my previous message, I do not understand why this is not=
 part
> of the super-scoreboard (now blame_info).
>
>> +#define PICKAXE_BLAME_MOVE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 01
>> +#define PICKAXE_BLAME_COPY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 02
>> +#define PICKAXE_BLAME_COPY_HARDER =C2=A0 =C2=A004
>> +#define PICKAXE_BLAME_COPY_HARDEST =C2=A0 010
>> +
>> +#define BLAME_DEFAULT_MOVE_SCORE =C2=A0 =C2=A0 20
>> +#define BLAME_DEFAULT_COPY_SCORE =C2=A0 =C2=A0 40
>> +
>> +/* bits #0..7 in revision.h, #8..11 used for merge_bases() in commi=
t.c */
>> +#define METAINFO_SHOWN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1u<<12)
>> +#define MORE_THAN_ONE_PATH =C2=A0 (1u<<13)
>
> Do we need to expose all of these constants outside blame.c? =C2=A0I =
think the
> library caller needs access to the first four above, but I tend to th=
ink
> the latter four are purely internal implementation detail that should=
 be
> kept in blame.c.
>
>> +/* output formatting constants */
>> +#define OUTPUT_ANNOTATE_COMPAT =C2=A0001
>> +#define OUTPUT_LONG_OBJECT_NAME 002
>> +#define OUTPUT_RAW_TIMESTAMP =C2=A0 =C2=A0004
>> +#define OUTPUT_PORCELAIN =C2=A0 =C2=A0 =C2=A0 =C2=A0010
>> +#define OUTPUT_SHOW_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0020
>> +#define OUTPUT_SHOW_NUMBER =C2=A0 =C2=A0 =C2=A0040
>> +#define OUTPUT_SHOW_SCORE =C2=A0 =C2=A0 =C2=A00100
>> +#define OUTPUT_NO_AUTHOR =C2=A0 =C2=A0 =C2=A0 0200
>
> I think these can be public.
>
>> +/*
>> + * One blob in a commit that is being suspected
>> + */
>> +struct origin {
>> + =C2=A0 =C2=A0 int refcnt;
>> + =C2=A0 =C2=A0 struct origin *previous;
>> + =C2=A0 =C2=A0 struct commit *commit;
>> + =C2=A0 =C2=A0 mmfile_t file;
>> + =C2=A0 =C2=A0 unsigned char blob_sha1[20];
>> + =C2=A0 =C2=A0 char path[FLEX_ARRAY];
>> +};
>
> I somehow doubt we would want to expose this level of implementation
> detail to the callers of the library. =C2=A0If we need to, the struct=
ure needs
> to be renamed---"origin" is way too generic a name.
>
>> +extern void assign_blame(struct blame_scoreboard *sb, int opt) ;
>
> Lose the extra SP before ";". =C2=A0I had to fix them in your previou=
s patch
> and there were many.
>
