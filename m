From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v8 3/4] submodule: fix sync handling of some relative
 superproject origin URLs
Date: Wed, 6 Jun 2012 21:09:59 +1000
Message-ID: <CAH3AnrpFg=mUcrRMUhbFvShnXwpvJa5eE-VsqcJm0MNMz8C6zA@mail.gmail.com>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
	<1338716810-9881-4-git-send-email-jon.seymour@gmail.com>
	<4FCE77AA.6060005@web.de>
	<7v7gvlnzlz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	phil.hord@gmail.com, ramsay@ramsay1.demon.co.uk, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 13:10:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScE7u-0002hL-0n
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 13:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab2FFLKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 07:10:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45655 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab2FFLKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 07:10:03 -0400
Received: by wgbdr13 with SMTP id dr13so6106439wgb.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fRnR/RzlHFS7XiyArFPxkslakiKKJsYy3Xdu/+EiSNE=;
        b=t7atyL32xjm5awiotZKRixaVCdpeydv2lGwsJ4xa0F03n1vsLewBzYmmzQOc8xk9zS
         XhvJ3opUn8F49nz6klWt0H6YXapjg6x0kepbvf9cTBxdvaLKWXlEY5n6gkC1O2YTl5eK
         LsZCtflsn7ULVusMIUUgqQmJKBIjWDZDlXFCtkeb/+Bd8KVPa0n17HNBZix8husH2QEv
         CRSs4Sko8PPDfDzcPFLw531ZllfPsFT/OrGOg7kf5Rgsy+4W0oglq/41Ri8HVkI5rf9T
         q+KAOWYBYu3O9QlNY5Dxu3+Qo1p2wHN6IfjkfuxsprXkOmknfc9DmOhRa8tPlBW1YMZK
         1Ceg==
Received: by 10.216.145.13 with SMTP id o13mr16099065wej.95.1338980999675;
 Wed, 06 Jun 2012 04:09:59 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Wed, 6 Jun 2012 04:09:59 -0700 (PDT)
In-Reply-To: <7v7gvlnzlz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199312>

On Wed, Jun 6, 2012 at 8:49 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Am 03.06.2012 11:46, schrieb Jon Seymour:
>>> @@ -959,19 +985,32 @@ cmd_sync()
>>> =C2=A0 =C2=A0 =C2=A0while read mode sha1 stage sm_path
>>> =C2=A0 =C2=A0 =C2=A0do
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name=3D$(module_nam=
e "$sm_path")
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url=3D$(git config -f .g=
itmodules --get submodule."$name".url)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# path from superproject=
 origin repo to submodule origin repo
>>
>> This comment is misleading as it only describes part of the truth, i=
n a lot
>> of cases it'll just be an absolute URL of the submodule.

Done. v9 3/4 also updates the header comments for resolve_relative_url =
to remove
a similar misleading implication.

>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module_url=3D$(git confi=
g -f .gitmodules --get submodule."$name".url)
>>
>> And I see no real value of renaming "url" to "module_url" here (but =
maybe
>> that is just me).
>
> I tend to agree; there is no other kind of URL involved, and I do
> not see a clear motivation behind this renaming. =C2=A0Renaming url t=
o
> module_url would not help much if it is to differenciate URLs to the
> repositories of submodule and superproject, so that can't be it.
>
> In any case, I suspect that you would be involved in maintaining
> this code in the long haul, so even if it were "just you", your
> opinion counts.
>

This is reverted in v9.

>> So I'd vote for dropping that comment and the "url" to "module_url" =
change.
>> But apart from that and the issues Junio mentioned in his response t=
his
>> series is looking good to me.
>
> Thanks for looking this over.

Yes, thank you all.

jon.
