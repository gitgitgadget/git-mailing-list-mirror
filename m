From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 18/27] setup.c: support multi-checkout repo setup
Date: Sat, 8 Mar 2014 08:55:15 +0700
Message-ID: <CACsJy8DyqJ-6SpgUdgM0Q2MQxDKDdE2uotF7wV4cBvCigCO_vw@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-19-git-send-email-pclouds@gmail.com>
 <xmqqlhwoh1p4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 02:55:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM6UR-0003qs-Cu
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 02:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbaCHBzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 20:55:47 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:49240 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaCHBzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 20:55:46 -0500
Received: by mail-qc0-f169.google.com with SMTP id i17so5677355qcy.14
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 17:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tVpef5/2LJUcEETBCCFEqxLqB/Fg4yS2IfPkIh0cUXM=;
        b=TsQcOqwXaSffXd69U8MQI6QnZAummQGL6/sf0y+/l+Sh6Tcc+GJRjRVarKJo5kZGK8
         kabTZtz6xx3+KP6zg2ikThawK3AuRZbpDvYK9vEXxCnJ5RgICSpZ8Xp3ILtCI/C2Lh8Z
         7CHVFr1bhjd2DXC1etgGgxZwf7zhpY3AqP+UVTjaU4pP5ufwEATlZXncHhF6soiLptA6
         aYx7t6mpm/yfXm6QUQgyXb3QLIJw5ht9SZyWnViTkEMD+1EUM/BWe0oYd9PInIxnUvVW
         5DzVhcHrCas8qzwki9w6QI1siwkN8V+kGedxI/hjdY0+PschNjy0nLb6W3qK4FldNrUg
         c7Gg==
X-Received: by 10.140.94.134 with SMTP id g6mr3418446qge.19.1394243745919;
 Fri, 07 Mar 2014 17:55:45 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 7 Mar 2014 17:55:15 -0800 (PST)
In-Reply-To: <xmqqlhwoh1p4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243640>

On Thu, Mar 6, 2014 at 2:42 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>  core.worktree::
>>       Set the path to the root of the working tree.
>> +     If GIT_COMMON_DIR environment variable is set, core.worktree
>> +     is ignored and not used for determining the root of working tr=
ee.
>
> Just thinking aloud to see if I got the full implication of the
> above right...
>
> If we find ourselves in the multi-checkout mode because we saw
> .git/commondir on the filesystem, it is clear that the root of the
> working tree is the parent directory of that .git directory.
>
> If the reason we think we are in the multi-checkout mode is not
> because of .git/commondir but because $GIT_COMMON_DIR is set,

I tend to think so, .git/commondir is just a convenient way to set
$GIT_COMMON_DIR. $GIT_COMMON_DIR is the key. config.txt correctly
states so, but the commit message is misleading.

>  should we assume the same relationship between the root of the worki=
ng tree
> and the GIT_DIR (however we find it) when the environment variable
> $GIT_WORK_TREE is not set?  Or should that configuration be an error?
> With $GIT_DIR set without $GIT_WORK_TREE set, the user is telling us
> that the $cwd is the root of the working tree, so perhaps we should
> do the same?

It should work exactly like how normal worktree does, so if $GIT_DIR
is set and $GIT_WORK_TREE is not, $PWD is the worktree root.
--=20
Duy
