From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetools: add support for DeltaWalker
Date: Sat, 3 Mar 2012 14:00:17 -0800
Message-ID: <CAJDDKr4q7gmFeHuGM5hFruduHw-3mGa+CMU=U6X0jjXUsJLsvw@mail.gmail.com>
References: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
	<7vaa3ybpat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:00:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3x0B-0005C2-Ph
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 23:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab2CCWAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 17:00:19 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47920 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab2CCWAS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2012 17:00:18 -0500
Received: by yhmm54 with SMTP id m54so1260997yhm.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 14:00:17 -0800 (PST)
Received-SPF: pass (google.com: domain of davvid@gmail.com designates 10.236.116.66 as permitted sender) client-ip=10.236.116.66;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davvid@gmail.com designates 10.236.116.66 as permitted sender) smtp.mail=davvid@gmail.com; dkim=pass header.i=davvid@gmail.com
Received: from mr.google.com ([10.236.116.66])
        by 10.236.116.66 with SMTP id f42mr20611222yhh.70.1330812017862 (num_hops = 1);
        Sat, 03 Mar 2012 14:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Gc7IdyCaiSjs0eqJycNbsvW9KIfV0058I4Uv7hR6xZ8=;
        b=WK8T/KG6j3Dq/I9KuOWkXG2mznj9tg8DyaQj8YHSJRw9rRNbQlwvVk/SaBVUswrVyH
         i+liFKg3fpdOx07PWhebc9DLnBVEOpgvGOGOEXn9wses+gWUm4zhUUGP6ToJveoR6qc/
         guQZuTVbvdZ2myv8Y7tS5NSSP+ghP+ynLYTAPM4qMm1B9mY8kMiE/Q53wItJWQf3DDmR
         uAO3jfxkWSmnP3MJKbC2HgmNwRTuMiio3jN982wnwtWaKljLR3xe4jlCCgIzTiuxUiKH
         qfg/Y+jmrfnwlfLFM0xk7BXy52KKAoYxJH0flc7wrQEY4Dt1g/SpM2yD9SxfeGopjgO0
         vcOA==
Received: by 10.236.116.66 with SMTP id f42mr16344896yhh.70.1330812017823;
 Sat, 03 Mar 2012 14:00:17 -0800 (PST)
Received: by 10.146.205.20 with HTTP; Sat, 3 Mar 2012 14:00:17 -0800 (PST)
In-Reply-To: <7vaa3ybpat.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192138>

On Fri, Mar 2, 2012 at 2:39 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> =C2=A0mergetools/DeltaWalker | =C2=A0 12 ++++++++++++
>
> How does an end user choose to use this backend? =C2=A0Perhaps like t=
his?
>
> =C2=A0 =C2=A0$ git mergetool --tool=3DDeltaWalker
>
> All the other files in mergetools/ are in lower case, and I _strongly=
_
> prefer to have this new file also be in lower case.

I agree.

> Such a change may mean you may have to override translate_merge_tool_=
path
> in this file, like some other backends seem to do.
>
>> =C2=A01 file changed, 12 insertions(+)
>> =C2=A0create mode 100644 mergetools/DeltaWalker
>>
>> diff --git a/mergetools/DeltaWalker b/mergetools/DeltaWalker
>> new file mode 100644
>> index 0000000..b9e6618
>> --- /dev/null
>> +++ b/mergetools/DeltaWalker
>> @@ -0,0 +1,12 @@
>> +diff_cmd () {
>> + =C2=A0 =C2=A0 "$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&=
1
>> +}
>> +
>> +merge_cmd () {
>> + =C2=A0 =C2=A0 if $base_present
>> + =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$LOC=
AL" "$REMOTE" "$BASE" -merged=3D"$PWD/$MERGED"
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$LOC=
AL" "$REMOTE" -merged=3D"$PWD/$MERGED"
>> + =C2=A0 =C2=A0 fi >/dev/null 2>&1
>> +}

Is the $PWD/ prefix strictly needed?  The rest of the mergetools use
$MERGED as-is.  Does it work without it?
--=20
David
