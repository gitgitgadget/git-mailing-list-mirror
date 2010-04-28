From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 1/2 v3] Make diffcore_std only can run once before a 
	diff_flush.
Date: Wed, 28 Apr 2010 11:37:00 +0800
Message-ID: <o2r41f08ee11004272037k5be968adh1d7b98768bf4e398@mail.gmail.com>
References: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
	 <1271945142-27015-2-git-send-email-struggleyb.nku@gmail.com>
	 <7v1ve743vb.fsf@alter.siamese.dyndns.org>
	 <n2m41f08ee11004222055i498174dfi47a5991a08114cd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 05:37:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6y5f-00047p-MR
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 05:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118Ab0D1DhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 23:37:06 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:46012 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0D1DhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 23:37:04 -0400
Received: by qyk9 with SMTP id 9so20564915qyk.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Kw6a5guwb/6vtvHeeIxeYO+tUNUwMH6v3LsTDGyCzY=;
        b=FBvXzaUSga1H5Nau0CDVz/QVh6PSYGXjyIAwKvQeEaxsJdrv1xZjQy3sWwOzcGdml7
         FQes2splJW0pCAdCZlDteIyYJ+Al3e0W2wDpRypbRu+iuFMf09S6WqKq9QwZ0YtlEjve
         CMzb05GYayMlAPx6g0a+dYB2fXWeFXnlCN+No=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wzTFz76d1+nlSG4/f9kunfEj2du4g3Ask46AeQHMWuZxoR3kq2PYDjIt/nW/xYFYfe
         gtLcYSnwOH1slzCaLOrOXI6bmmQfTb7yePuiIs70DWAD6VO57fyTNqLV1JNuOcDMCs49
         aj9Z+naM5Jx2ELmbJJqYAcBedH9ZxuusAK+V4=
Received: by 10.229.38.141 with SMTP id b13mr2638323qce.97.1272425820277; Tue, 
	27 Apr 2010 20:37:00 -0700 (PDT)
Received: by 10.229.98.196 with HTTP; Tue, 27 Apr 2010 20:37:00 -0700 (PDT)
In-Reply-To: <n2m41f08ee11004222055i498174dfi47a5991a08114cd2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145968>

Hi Junio,

   I have not receive any comments on this thread from you, but I
think it worth some words. I want to make these series patches landed
and could you please give some more advice on this?

Regards!
Bo

On Fri, Apr 23, 2010 at 11:55 AM, Bo Yang <struggleyb.nku@gmail.com> wr=
ote:
> On Fri, Apr 23, 2010 at 4:41 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> It actually is stronger than that; we should never run it more than =
once,
>> and it would be a bug if we did so. =C2=A0Which codepath tries to ca=
ll *_std()
>> twice?
>
> In command 'git log --follow ...'
> log_tree_diff call diff_tree_sha1 and then diff_tree_diff_flush, when
> '--follow' is given, the former function will call
> try_to_follow_renames, which will call diffcore_std to detect rename.
> And then, diff_tree_diff_flush call 'diffcore_std' again
> unconditional. (and I have try to find a condition to make the call,
> but I fail, so I figure out this patch.)
>
> Breakpoint 1, diffcore_std (options=3D0xbf9cc044) at diff.c:3748
> 3748 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (diff_queued_diff.ru=
n)
> (gdb) bt
> #0 =C2=A0diffcore_std (options=3D0xbf9cc044) at diff.c:3748
> #1 =C2=A00x08124206 in try_to_follow_renames (t1=3D0xbf9cc130, t2=3D0=
xbf9cc11c,
> base=3D0x81571c9 "", opt=3D0xbf9cc468) at tree-diff.c:358
> #2 =C2=A00x08124480 in diff_tree_sha1 (old=3D0x9c51d8c
> "$\033\222T=EF=BF=BD=EF=BF=BD=EF=BF=BD\a\035\200T=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD\210;8\235i", new=3D0x9c51d2c
> "\201=EF=BF=BD\017<=EF=BF=BD\v=EF=BF=BD=EF=BF=BDn]\226{=EF=BF=BD+=EF=BF=
=BD\001\003\232\232\230",
> =C2=A0 =C2=A0base=3D0x81571c9 "", opt=3D0xbf9cc468) at tree-diff.c:41=
8
> #3 =C2=A00x080e660e in log_tree_diff (opt=3D0xbf9cc220, commit=3D0x9c=
51d28,
> log=3D0xbf9cc1ac) at log-tree.c:536
> #4 =C2=A00x080e668f in log_tree_commit (opt=3D0xbf9cc220, commit=3D0x=
9c51d28)
> at log-tree.c:560
> #5 =C2=A00x0807faa1 in cmd_log_walk (rev=3D0xbf9cc220) at builtin/log=
=2Ec:237
> #6 =C2=A00x080806e2 in cmd_log (argc=3D5, argv=3D0xbf9cc788, prefix=3D=
0x0) at
> builtin/log.c:481
> #7 =C2=A00x0804b8eb in run_builtin (p=3D0x8161524, argc=3D5, argv=3D0=
xbf9cc788)
> at git.c:260
> #8 =C2=A00x0804ba51 in handle_internal_command (argc=3D5, argv=3D0xbf=
9cc788) at git.c:416
> #9 =C2=A00x0804bb2c in run_argv (argcp=3D0xbf9cc700, argv=3D0xbf9cc70=
4) at git.c:458
> #10 0x0804bcbe in main (argc=3D5, argv=3D0xbf9cc788) at git.c:529
> (gdb) c
> Continuing.
>
> Breakpoint 1, diffcore_std (options=3D0xbf9cc468) at diff.c:3748
> 3748 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (diff_queued_diff.ru=
n)
> (gdb) bt
> #0 =C2=A0diffcore_std (options=3D0xbf9cc468) at diff.c:3748
> #1 =C2=A00x080e6356 in log_tree_diff_flush (opt=3D0xbf9cc220) at log-=
tree.c:449
> #2 =C2=A00x080e6619 in log_tree_diff (opt=3D0xbf9cc220, commit=3D0x9c=
51d28,
> log=3D0xbf9cc1ac) at log-tree.c:537
> #3 =C2=A00x080e668f in log_tree_commit (opt=3D0xbf9cc220, commit=3D0x=
9c51d28)
> at log-tree.c:560
> #4 =C2=A00x0807faa1 in cmd_log_walk (rev=3D0xbf9cc220) at builtin/log=
=2Ec:237
> #5 =C2=A00x080806e2 in cmd_log (argc=3D5, argv=3D0xbf9cc788, prefix=3D=
0x0) at
> builtin/log.c:481
> #6 =C2=A00x0804b8eb in run_builtin (p=3D0x8161524, argc=3D5, argv=3D0=
xbf9cc788)
> at git.c:260
> #7 =C2=A00x0804ba51 in handle_internal_command (argc=3D5, argv=3D0xbf=
9cc788) at git.c:416
> #8 =C2=A00x0804bb2c in run_argv (argcp=3D0xbf9cc700, argv=3D0xbf9cc70=
4) at git.c:458
> #9 =C2=A00x0804bcbe in main (argc=3D5, argv=3D0xbf9cc788) at git.c:52=
9
> (gdb)
>
>> The standard calling sequence is:
>>
>> =C2=A0- start from an empty queue.
>>
>> =C2=A0- use diff_change() and diff_addremove() to populate the queue=
=2E
>>
>> =C2=A0- call diffcore_std(). if you need to use a non-standard chain=
 of
>> =C2=A0 diffcore transformations, you _could_ call the diffcore_* rou=
tines that
>> =C2=A0 diffcore_std() calls, if you choose to, but as you found out,=
 some of
>> =C2=A0 them are not idempotent operations, and shouldn't be called t=
wice.
>>
>> =C2=A0- and finally call diffcore_flush().
>>
>>> @@ -3745,6 +3742,12 @@ void diffcore_fix_diff_index(struct diff_opt=
ions *options)
>>>
>>> =C2=A0void diffcore_std(struct diff_options *options)
>>> =C2=A0{
>>> + =C2=A0 =C2=A0 /* We never run this function more than one time, b=
ecause the
>>> + =C2=A0 =C2=A0 =C2=A0* rename/copy detection logic can only run on=
ce.
>>> + =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 if (diff_queued_diff.run)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>
>> Shouldn't this be a BUG() instead?
>
> Anyone may call diff_tree_sha1 and then diffcore_std, and
> diff_tree_sha1 may call another diffcore_std if '--follow' given. If
> this is a BUG, the calling pattern, diff_tree_sha1 -> diffcore_std
> should all disappear from our code. And this involved much code
> refactor. And I suggest my way that we avoid the duplicate call
> actively in diffcore_std.
>
>> The trivial rewrite to use this macro is a good idea, but it probabl=
y
>> should be a separate patch.
>>
>>> +#define DIFF_QUEUE_CLEAR(q) \
>>> + =C2=A0 =C2=A0 do { \
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (q)->queue =3D NULL; \
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (q)->nr =3D (q)->alloc =
=3D (q)->run =3D 0; \
>>> + =C2=A0 =C2=A0 } while(0);
>>
>
> You mean split this commit into two?
>
> Regards!
> Bo
> --
> My blog: http://blog.morebits.org
>
