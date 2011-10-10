From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] Teach merge the '[-e|--edit]' option
Date: Mon, 10 Oct 2011 15:53:16 -0700
Message-ID: <CAG+J_Dz37etot0nNkq+1gTUy8R0vVJpsRQuvwrTSczXRWy7mkA@mail.gmail.com>
References: <1318099192-60860-1-git-send-email-jaysoffian@gmail.com>
	<7vd3e4k162.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 00:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDOip-0001xA-2g
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 00:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab1JJWxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 18:53:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40138 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1JJWxR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 18:53:17 -0400
Received: by ggnv2 with SMTP id v2so5007632ggn.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 15:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=v/51L/2Tw05TnLdXN0PP33/N/jet3I95lCADv2VSA3A=;
        b=bFsrPsiWfXDMH9Ea5GZxKvjrIdMKZD0+Yu1ybiJCxaf6ujw88TpR6+lmL+pOMXfFyx
         7r/oZZ9Ay0ENy6wmI/16SbT9TUU0nwvmsr8WdtpJrwFmLl5MRE1c0JjbYHp8ImTvXZmT
         zNXteBPpkt3ds0odvnHcfAWlyY0/vMTA/fFpk=
Received: by 10.147.5.21 with SMTP id h21mr4050353yai.26.1318287196914; Mon,
 10 Oct 2011 15:53:16 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Mon, 10 Oct 2011 15:53:16 -0700 (PDT)
In-Reply-To: <7vd3e4k162.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183263>

On Mon, Oct 10, 2011 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>> +static void prepare_to_commit(void)
>> +{
>> + =C2=A0 =C2=A0 struct strbuf msg =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 strbuf_addbuf(&msg, &merge_msg);
>> + =C2=A0 =C2=A0 strbuf_addch(&msg, '\n');
>> + =C2=A0 =C2=A0 write_merge_msg(&msg);
>> =C2=A0 =C2=A0 =C2=A0 run_hook(get_index_file(), "prepare-commit-msg"=
,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_path("MER=
GE_MSG"), "merge", NULL, NULL);
>> - =C2=A0 =C2=A0 read_merge_msg();
>> + =C2=A0 =C2=A0 if (option_edit) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (launch_editor(git_pa=
th("MERGE_MSG"), NULL, NULL))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 abort_commit(NULL);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 read_merge_msg(&msg);
>> + =C2=A0 =C2=A0 stripspace(&msg, option_edit);
>> + =C2=A0 =C2=A0 if (!msg.len)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort_commit(_("Empty co=
mmit message."));
>> + =C2=A0 =C2=A0 strbuf_release(&merge_msg);
>> + =C2=A0 =C2=A0 strbuf_addbuf(&merge_msg, &msg);
>> + =C2=A0 =C2=A0 strbuf_release(&msg);
>> =C2=A0}
>
> An abstraction very nicely done.

<blush> :-)

> I am not sure about the '\n' you unconditionally added at the end of =
the
> existing message.

Right, the old code does that when the merge fails, counting on (I
think) git-commit to then take care of any extra newlines. My
reasoning was tack it on before running prepare-commit-msg, then run
stripspace() after the hook and and editor, which will take care of
any excess newlines. I guess this would be a regression if someone's
prepare-commit-msg hook blindly appends to the commit message.

> I think running stripspace(&msg, option_edit) is a good change, even
> though some people might feel it is a regression. "git commit" also c=
leans
> up the whitespace cruft left by prepare-commit-message hook when the
> editor is not in use, and this change makes it consistent.

Correct.

>> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
>> index 87aac835a1..8c6b811718 100755
>> --- a/t/t7600-merge.sh
>> +++ b/t/t7600-merge.sh
>> @@ -643,4 +643,19 @@ test_expect_success 'amending no-ff merge commi=
t' '
>>
>> =C2=A0test_debug 'git log --graph --decorate --oneline --all'
>>
>> +cat >editor <<\EOF
>> +#!/bin/sh
>> +# strip comments and blank lines from end of message
>> +sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > exp=
ected
>> +EOF
>> +chmod 755 editor
>
> I am not sure about this one. Wouldn't this want to be editing the gi=
ven
> file to make sure that the edited content appear in the result, not j=
ust
> testing the additional stripspace() call you added in the codepath?

Yep.

I added this test under the previous iteration of the patch when I was
concerned that commit message make it through the external commit code
path correctly. It doesn't really make sense with this iteration now
that I think about it. The part about stripping comments and newlines
is no longer needed.

>> +test_expect_success 'merge --no-ff --edit' '
>> + =C2=A0 =C2=A0 git reset --hard c0 &&
>> + =C2=A0 =C2=A0 EDITOR=3D./editor git merge --no-ff --edit c1 &&
>> + =C2=A0 =C2=A0 verify_parents $c0 $c1 &&
>> + =C2=A0 =C2=A0 git cat-file commit HEAD | sed "1,/^$/d" > actual &&
>> + =C2=A0 =C2=A0 test_cmp actual expected
>> +'
>> +
>> =C2=A0test_done
>
> So perhaps this one on top? I am just suspecting that your additional=
 '\n'
> is to make sure we do not write out a file with an incomplete line wi=
th
> this patch, but that change is not explained in your commit log messa=
ge,
> so I am not sure.

I assumed the '\n' was needed as it's added (unconditionally) before
writing MERGE_MSG when the merge fails. I didn't notice that when I
added the prepare-commit-msg hook support to merge.c (65969d43d1).

> =C2=A0builtin/merge.c =C2=A0| =C2=A0 =C2=A03 ++-
> =C2=A0t/t7600-merge.sh | =C2=A0 10 +++++++++-
> =C2=A02 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8dbf4a..09ffc07 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -867,7 +867,8 @@ static void prepare_to_commit(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf msg =3D STRBUF_INIT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addbuf(&msg, &merge_msg);
> - =C2=A0 =C2=A0 =C2=A0 strbuf_addch(&msg, '\n');
> + =C2=A0 =C2=A0 =C2=A0 if (msg.len && msg.buf[msg.len-1] !=3D '\n')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addch(&msg,=
 '\n');
> =C2=A0 =C2=A0 =C2=A0 =C2=A0write_merge_msg(&msg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0run_hook(get_index_file(), "prepare-commit=
-msg",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_path("MER=
GE_MSG"), "merge", NULL, NULL);

I'm guessing the '\n' is always needed (per above), but I'm not sure.

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 8c6b811..3008e4e 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -645,6 +645,12 @@ test_debug 'git log --graph --decorate --oneline=
 --all'
>
> =C2=A0cat >editor <<\EOF
> =C2=A0#!/bin/sh
> +# Add a new message string that was not in the template
> +(
> + =C2=A0 =C2=A0 =C2=A0 echo "Merge work done on the side branch c1"
> + =C2=A0 =C2=A0 =C2=A0 echo
> + =C2=A0 =C2=A0 =C2=A0 cat <"$1"
> +) >"$1.tmp" && mv "$1.tmp" "$1"
> =C2=A0# strip comments and blank lines from end of message
> =C2=A0sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' >=
 expected
> =C2=A0EOF
> @@ -654,7 +660,9 @@ test_expect_success 'merge --no-ff --edit' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard c0 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EDITOR=3D./editor git merge --no-ff --edit=
 c1 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0verify_parents $c0 $c1 &&
> - =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD | sed "1,/^$/d" > act=
ual &&
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD >raw &&
> + =C2=A0 =C2=A0 =C2=A0 grep "work done on the side branch" raw &&
> + =C2=A0 =C2=A0 =C2=A0 sed "1,/^$/d" >actual raw &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp actual expected
> =C2=A0'

Okay. A test that the merge is aborted if the message is empty would
also be good.

I'll try to find time to send another iteration with better tests. May
not be till next week though.

j.
