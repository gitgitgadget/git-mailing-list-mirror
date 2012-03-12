From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] t3310: Add testcase demonstrating failure to --commit
 from within another dir
Date: Mon, 12 Mar 2012 19:54:14 +0100
Message-ID: <CALKQrgeXSwG6n41CDwmoyHWrU5CnQMBtoPdFmGqh1gZqeMzNqA@mail.gmail.com>
References: <87boo3m50x.fsf@zancas.localnet>
	<1331564233-1969-1-git-send-email-johan@herland.net>
	<7vr4wxsmrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, david@tethera.net, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7AO0-00070y-Tl
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 19:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab2CLSyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 14:54:20 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:53293 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab2CLSyU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 14:54:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1S7ANu-000H9L-I0
	for git@vger.kernel.org; Mon, 12 Mar 2012 19:54:18 +0100
Received: by iagz16 with SMTP id z16so7226267iag.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 11:54:14 -0700 (PDT)
Received: by 10.50.159.161 with SMTP id xd1mr321093igb.15.1331578454879; Mon,
 12 Mar 2012 11:54:14 -0700 (PDT)
Received: by 10.42.170.3 with HTTP; Mon, 12 Mar 2012 11:54:14 -0700 (PDT)
In-Reply-To: <7vr4wxsmrt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192923>

On Mon, Mar 12, 2012 at 19:21, Junio C Hamano <gitster@pobox.com> wrote=
:
> Johan Herland <johan@herland.net> writes:
>
>> Found-by: David Bremner <david@tethera.net>
>> Signed-off-by: Johan Herland <johan@herland.net>
>
> Could you clarify what "from within another dir" means on the subject=
?
>
> What was the expected usage?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The 'git notes merge' command expected to =
be run from the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0working tree of the project being annotate=
d, and did not
> =C2=A0 =C2=A0 =C2=A0 =C2=A0anticipate getting run inside $GIT_DIR/. =C2=
=A0However, because
> =C2=A0 =C2=A0 =C2=A0 =C2=A0we use $GIT_DIR/NOTES_MERGE_WORKTREE as a =
temporary working
> =C2=A0 =C2=A0 =C2=A0 =C2=A0space for the user to work on resolving co=
nflicts, it is not
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unreasonable for a user to run "git notes =
merge --commit"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0there.
>
> Is that the issue?

That is exactly the issue. Thanks for the clear wording.

=46eel free to update the commit message accordingly.


=2E..Johan

>> ---
>>
>> (sending again in the correct thread. Sorry for the screwup.)
>>
>> This is a transcription of David's test script into a git test case.
>>
>> Thanks to David for finding this issue.
>>
>>
>> Have fun! :)
>>
>> ...Johan
>>
>> =C2=A0t/t3310-notes-merge-manual-resolve.sh | =C2=A0 19 ++++++++++++=
+++++++
>> =C2=A01 file changed, 19 insertions(+)
>>
>> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-m=
erge-manual-resolve.sh
>> index 4367197..0c531c3 100755
>> --- a/t/t3310-notes-merge-manual-resolve.sh
>> +++ b/t/t3310-notes-merge-manual-resolve.sh
>> @@ -553,4 +553,23 @@ test_expect_success 'resolve situation by abort=
ing the notes merge' '
>> =C2=A0 =C2=A0 =C2=A0 verify_notes z
>> =C2=A0'
>>
>> +cat >expect_notes <<EOF
>> +foo
>> +bar
>> +EOF
>> +
>> +test_expect_failure 'switch cwd before committing notes merge' '
>> + =C2=A0 =C2=A0 git notes add -m foo HEAD &&
>> + =C2=A0 =C2=A0 git notes --ref=3Dother add -m bar HEAD &&
>> + =C2=A0 =C2=A0 test_must_fail git notes merge refs/notes/other &&
>> + =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd .git/NOTES_MERGE_WORK=
TREE &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "foo" > $(git rev-p=
arse HEAD) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "bar" >> $(git rev-=
parse HEAD) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git notes merge --commit
>> + =C2=A0 =C2=A0 ) &&
>> + =C2=A0 =C2=A0 git notes show HEAD > actual_notes &&
>> + =C2=A0 =C2=A0 test_cmp expect_notes actual_notes
>> +'
>> +
>> =C2=A0test_done
>> --
>> 1.7.9.2



--=20
Johan Herland, <johan@herland.net>
www.herland.net
