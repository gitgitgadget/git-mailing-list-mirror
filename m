From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 2/2] pull: support rebased upstream + fetch + pull 
	--rebase
Date: Thu, 16 Jul 2009 08:29:22 +0200
Message-ID: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
References: <1247702955-1559-1-git-send-email-santi@agolina.net>
	 <1247702955-1559-2-git-send-email-santi@agolina.net>
	 <7vab35cw2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 08:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRKTt-0002RD-Ej
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 08:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbZGPG32 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 02:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757067AbZGPG31
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 02:29:27 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60246 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZGPG3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 02:29:24 -0400
Received: by fxm18 with SMTP id 18so3884275fxm.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 23:29:22 -0700 (PDT)
Received: by 10.204.118.132 with SMTP id v4mr8458636bkq.3.1247725762838; Wed, 
	15 Jul 2009 23:29:22 -0700 (PDT)
In-Reply-To: <7vab35cw2e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123365>

2009/7/16 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> =A0 =A0 =A0 reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" =
&&
>> - =A0 =A0 oldremoteref=3D"$(git rev-parse -q --verify \
>> - =A0 =A0 =A0 =A0 =A0 =A0 "$reflist")"
>> + =A0 =A0 num=3D0 &&
>> + =A0 =A0 while oldremoteref=3D"$(git rev-parse -q --verify "$reflis=
t@{$num}")"
>
> Applying @{nth} reflog notation to something that identifies itself a=
s a
> "list" made me go "Huh?". =A0Why is this variable called refLIST? =A0=
Shouldn't
> it be simply called something like "remoteref" or even "ref"?

It used to be a list, before my patch 97af7ff (parse-remote: function
to get the tracking branch to be merge, 2009-06-12). I'll change it.

>
>> + =A0 =A0 do
>> + =A0 =A0 =A0 =A0 =A0 =A0 test $oldremoteref =3D $(git merge-base $o=
ldremoteref $curr_branch) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 break
>> + =A0 =A0 =A0 =A0 =A0 =A0 num=3D$((num+1))
>
> I think we always write "num=3D$(( $num + 1 ))" for portability; noti=
ce the
> lack of $ in your version.

Oops, you are right. I somehow missed, I even did "git grep "((" *.sh"
to check it.

>
>> + =A0 =A0 done
>
> Does this loop ever give up? =A0Should it?

When remote/$origin/$branch@{nth} does not exist. I don't think we
need another way to give up (nth<10?) because normally nth is small,
it does not harm the normal case and it can help when nth is large.

>
> What happens in the subsequent code outside of the patch context, whe=
n
> this loop does not find any suitable "old" value?

Then the $oldremoteref is empty and in the git-rebase command it is
used as ${oldremoteref:-$merge_head} so it get replaced by
$merge_head.

Thanks,
Santi
