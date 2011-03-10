From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH 2/2] blame: introduce -u/--unique option
Date: Thu, 10 Mar 2011 15:13:41 +0900
Message-ID: <1299737621.1496.55.camel@leonhard>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
	 <1299581951-4670-2-git-send-email-namhyung@gmail.com>
	 <7vy64o9ixz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 07:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxZ8G-0003OV-1O
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 07:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab1CJGNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 01:13:52 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61724 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1CJGNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 01:13:49 -0500
Received: by iyb26 with SMTP id 26so1222341iyb.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 22:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=3uEyJQLmSBkxT1EEKAWBEXmfn/vS9jV6ePoEAcXUN5E=;
        b=EaXojmZcPAEFkP4zxIeoTBAgiNO7D52R+xvZtjdy/inEy4qX05iWXppJGi8QocH86c
         5AoGhW1g04jKNvStsGqElkbxHLuDreLDZgJw8ZVWx6wrkL3t7GF2L6hrtMMElW/zOs0u
         m+VTYl2MyDeHsKvVFDOZh2wIdRN+D0KycqK2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=XttmtbYdC1PFnXRGfvSzDEjdDBcHZkDU2LrjWGrozNkl4esipkM5otkR1OB60omnMM
         MQQdY4NBHMQsyyliEa5wDymUGAnc8048esUvMgwDXYViMFIuecRe3srnROGgF1hwhwHV
         u3XqgUtv+zL1M93Kf53R7fl3DwAO/XI5ffq4A=
Received: by 10.42.168.129 with SMTP id w1mr7407901icy.373.1299737628325;
        Wed, 09 Mar 2011 22:13:48 -0800 (PST)
Received: from [118.176.73.109] ([118.176.73.109])
        by mx.google.com with ESMTPS id jv9sm1951219icb.13.2011.03.09.22.13.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 22:13:47 -0800 (PST)
In-Reply-To: <7vy64o9ixz.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168790>

2011-03-09 (=EC=88=98), 11:45 -0800, Junio C Hamano:
> Namhyung Kim <namhyung@gmail.com> writes:
>=20
> > -u/--unique option will find and use minimum length of unique
> > SHA-1 name. If -l option is specified also, it will have higher
> > priority, IOW git blame will use full 40-length SHA-1 name.
>=20
> > @@ -1867,6 +1878,10 @@ static void find_alignment(struct scoreboard=
 *sb, int *option)
> >  			longest_dst_lines =3D num;
> >  		if (largest_score < ent_score(sb, e))
> >  			largest_score =3D ent_score(sb, e);
> > +		sha1 =3D find_unique_abbrev(suspect->commit->object.sha1,
> > +					  MINIMUM_ABBREV);
> > +		if (longest_uniq_sha1 < strlen(sha1))
> > +			longest_uniq_sha1 =3D strlen(sha1);
>=20
> The logic to determine and keep track of the longuest-unique looks
> correct, but I was hoping that we already have an easy optimization
> codepath to do this only once per commit, not for every blame-entry i=
n the
> result.  Doesn't the code have a similar optimization to figure out t=
he
> necessary number of columns to show author names (I haven't read the =
code
> recently, though)?
>=20

Right. METAINFO_SHOWN flag does that. I'll move the code under the bloc=
k
in next version.


> Also we might find that the performance impact of doing this may be s=
o
> miniscule that it is not worth wasting a short option name.  If we we=
re to
> use an option, I was actually hoping that the option would let the us=
ers
> specify a value different from the hardcoded 8 at the same time.  E.g=
=2E
>=20
>     git blame --abbrev=3D8 ;# current default with uniquefy applied
>     git blame --abbrev=3D4 ;# equivalent to your "blame -u"
>=20

Hmm... I thought about that too. But you mean that you only want
--abbrev instead of -u, right?

My original intention was if user specified --abbrev explicitly, it
should be honored regardless of the uniqueness. The guard will not be
used in this situation because the user gave the exact length [s]he
wants to see.


> Can we have a benchmark of this feature in a largish and busy file in=
 a
> project with a deep history?
>=20

I gave it a try on a file in Linux kernel (with METAINFO_SHOWN
optimization applied):

$ wc -l mm/page_alloc.c
5629 mm/page_alloc.c
$ git log --oneline mm/page_alloc.c | wc -l
566
$ perf record ../git/git blame -u mm/page_alloc.c > /dev/null
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.229 MB perf.data (~10014 samples) ]
$ perf report
# Events: 5K cycles
#
# Overhead  Command         Shared Object                         Symbo=
l
# ........  .......  ....................  ............................=
=2E
#
    21.11%      git  git                   [.] cmd_blame
    18.34%      git  git                   [.] get_origin
    18.32%      git  git                   [.] pass_blame
     3.99%      git  libz.so.1.2.3.3       [.] inflate
     3.14%      git  git                   [.] xdl_hash_record
     2.84%      git  libz.so.1.2.3.3       [.] inflate_table
     2.60%      git  libz.so.1.2.3.3       [.] inflate_fast
     2.23%      git  git                   [.] find_pack_entry_one
     1.84%      git  git                   [.] xdl_recmatch
     1.51%      git  libc-2.11.1.so        [.] memcpy
     1.49%      git  git                   [.] xdl_prepare_env
     1.36%      git  git                   [.] xdl_prepare_ctx
     1.13%      git  [kernel.kallsyms]     [k] __lock_acquire
     1.12%      git  git                   [.] xdi_diff
     1.09%      git  git                   [.] blame_chunk
     0.99%      git  libc-2.11.1.so        [.] _int_malloc
     0.79%      git  git                   [.] tree_entry_interesting
     0.77%      git  git                   [.] origin_decref
     0.67%      git  libz.so.1.2.3.3       [.] adler32
     0.42%      git  [kernel.kallsyms]     [k] sched_clock_local
     0.40%      git  git                   [.] decode_tree_entry
     0.38%      git  [kernel.kallsyms]     [k] clear_page_c
     0.35%      git  libc-2.11.1.so        [.] __GI___strncmp_ssse3
     0.32%      git  git                   [.] lookup_object
     0.31%      git  [kernel.kallsyms]     [k] lock_release
     0.29%      git  [kernel.kallsyms]     [k] hlock_class
     0.29%      git  [kernel.kallsyms]     [k] page_fault
     0.29%      git  git                   [.] patch_delta
     0.28%      git  [kernel.kallsyms]     [k] local_clock
     0.27%      git  [kernel.kallsyms]     [k] sched_clock
     0.25%      git  [kernel.kallsyms]     [k] delay_tsc
     0.25%      git  git                   [.] parse_commit_buffer
     0.25%      git  [kernel.kallsyms]     [k] look_up_lock_class
     0.23%      git  git                   [.] xdl_cha_alloc
     0.22%      git  libc-2.11.1.so        [.] _int_free
     0.22%      git  libc-2.11.1.so        [.] malloc_consolidate
     0.22%      git  [kernel.kallsyms]     [k] mark_lock
     0.21%      git  libc-2.11.1.so        [.] __malloc
     0.20%      git  git                   [.] nth_packed_object_offset

Looks like it doesn't have a performance impact IMHO.
Hope this helps.

Thank you.


--=20
Regards,
Namhyung Kim
