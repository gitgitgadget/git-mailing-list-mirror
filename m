From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working 
	directory
Date: Thu, 9 Apr 2009 20:53:27 +1000
Message-ID: <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com> 
	<1239260490-6318-2-git-send-email-pclouds@gmail.com> <1239260490-6318-3-git-send-email-pclouds@gmail.com> 
	<1239260490-6318-4-git-send-email-pclouds@gmail.com> <7vws9u2ov4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 12:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrrug-00030v-AZ
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 12:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbZDIKxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 06:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbZDIKxo
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 06:53:44 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:24410 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbZDIKxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 06:53:43 -0400
Received: by wf-out-1314.google.com with SMTP id 29so570142wff.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sjHQPmyk8gDNR4T+gbREuTu7WhnQw0ULBMjwTaInImE=;
        b=tncF7h3TEsYYQ2LV1qiTRlDjqgsmk5lBfp1ZecwjGAFZbTQSw/6o6NE3SDNuNUXpSI
         u+cnxPVzvksi38T1DTr3NeLeOY2q9X+d4LZkI8I2uNUDPVgRb42jJ2k+17xaxpJNVt9I
         zCnkKv/PAtGvRJEaQJXTiCWxKcen+rYpLsKwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GifJesuO+5cKyoF6oWmzvTw+cj+Xt0LKx+F1y1GqeFXH/6poqXy2r/FLVy/PIbuKTM
         TkuTs0sgCqquyJmcLbZS3onuvIAuuKzY572sFI0Hn5koRDAjn6NP1C4KxBO+8n0zUzie
         1pjfIL7ZykLUJJsoocJVw63mUF4NF5etMRZ+0=
Received: by 10.142.158.3 with SMTP id g3mr837595wfe.265.1239274422426; Thu, 
	09 Apr 2009 03:53:42 -0700 (PDT)
In-Reply-To: <7vws9u2ov4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116162>

2009/4/9 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> @@ -168,6 +171,22 @@ int write_archive_entries(struct archiver_args =
*args,
>> =C2=A0 =C2=A0 =C2=A0 context.args =3D args;
>> =C2=A0 =C2=A0 =C2=A0 context.write_entry =3D write_entry;
>>
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Setup index and instruct attr to read index =
only
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if (!args->worktree_attributes) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&opts, 0, sizeof(=
opts));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.index_only =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.head_idx =3D -1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.src_index =3D &the_=
index;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.dst_index =3D &the_=
index;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts.fn =3D oneway_merge=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_tree_desc(&t, args-=
>tree->buffer, args->tree->size);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unpack_trees(1, &t, =
&opts))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_attr_set_direction(G=
IT_ATTR_INDEX, &the_index);
>
> Why use unpack_trees with oneway_merge? =C2=A0You won't be doing "is =
this file
> up-to-date in the work tree?", and you won't be writing the index out
> either, so there is nothing gained by keeping the cached stat informa=
tion
> fresh, which is the major justification of using that mechanism. =C2=A0=
I think
> using tree.c::read_tree() would be more appropriate.

Because I'm more familiar with unpack stuff than read-tree (or to be
honest, haven't touched tree stuff at all). Will look at read_tree().

>> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
>> index 0713bca..69a93fc 100644
>> --- a/builtin-tar-tree.c
>> +++ b/builtin-tar-tree.c
>> @@ -36,6 +36,11 @@ int cmd_tar_tree(int argc, const char **argv, con=
st char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv++;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc--;
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (2 <=3D argc && !strcmp(argv[1], "--fix-attribute=
s")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nargv[nargc++] =3D argv[=
1];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc--;
>> + =C2=A0 =C2=A0 }
>
> I am not sure if it is worth backporting this new option to tar-tree =
which
> is an essentially backward-compatibility interface, and worse yet, do=
ing
> it poorly (i.e. --fix-attributes must come after --remote=3D for unex=
plained
> reason).

It's because git-tar-tree is used in tests and I don't want to migrate
all to git-archive. I don't want to change too much in a deprecated
command. Maybe just remove the option and make --fix-attributes
default for git-tar-tree. In other words, keep git-tar-tree's current
behaviour.

> It would affect a bit more tests, but I think you would want to test =
both
> the new "normal" mode of operation (generate archives with "git archi=
ve"
> and "git tar-tree" without options and compare, for example), instead=
 of
> adding --fix-attributes everywhere.

There is a new test to test the new "normal" mode. I'll think of more.
--=20
Duy
