From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Thu, 22 Mar 2012 21:38:54 -0700
Message-ID: <CACz_eycFU564bz1aO6-QF3=6GV8oHvGYfMWHRfgT1-j9AcAX-g@mail.gmail.com>
References: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
	<1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
	<4F6B8B59.4010106@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Mar 23 05:39:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAwHW-0005Tl-3g
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 05:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab2CWEiz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 00:38:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52770 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab2CWEiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 00:38:54 -0400
Received: by pbcun15 with SMTP id un15so2189236pbc.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 21:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Ct2t7jTorQ0muBNAMvzrgTNjDuIhJFGT2sHuP3Bfu+k=;
        b=hK5zdMAmhP3GEB6WB1PralcixkjTCFOs6jfT2nu1q4+vUUNmNWI63esqwdGBjoIQnV
         fMIpvPJsQTuqMgu+ZImC/vMSIzKcAMhOVRlB4Pza/J428O10EsVnIXegmLfqm/9plALp
         2ztGqi3l7jRUSaGEfzY9swZf5eF6dXBeh9VJRa4EKVeOCFEMu0uyTSv6CZRf2sAcp5L7
         WOncCgF6HLi9MsPvlRDdmhMkugE75e6nerqaKU/sldVJnI/z6Nb2FvPW2L2HAK0k1kWT
         CKKqjIoUphM6RGexn0mvikNPcjhZllqcGOobrxqeo3dFQxuKpOYLYOcAoR/8KL6qsaWW
         gykA==
Received: by 10.68.132.40 with SMTP id or8mr25949292pbb.34.1332477534438; Thu,
 22 Mar 2012 21:38:54 -0700 (PDT)
Received: by 10.68.47.232 with HTTP; Thu, 22 Mar 2012 21:38:54 -0700 (PDT)
In-Reply-To: <4F6B8B59.4010106@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193743>

2012/3/22 Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>:
> On 03/22/2012 08:27 PM, Lucian Poston wrote:
>>
>> The recent change to compute the width of diff --stat did not take i=
nto
>> consideration the output from --graph. The consequence is that when =
both
>> options are used, e.g. in 'log --stat --graph', the lines are too lo=
ng.
>>
>> Adjust stat width calculations to take --graph output into account.
>
> (1)
>
>> Adjust stat width calculations to reserve space for required charact=
ers
>> before
>> scaling the widths for the filename and graph portions of the diff-s=
tat.
>> For
>> example, consider:
>>
>> " diff.c | =C2=A0 66 ++-"
>>
>> Before calculating the widths allocated to the filename, "diff.c", a=
nd the
>> graph, "++-", reserve space for the initial " " and the part between=
 the
>> filename and graph portions " | =C2=A0 66 ". Then, divide the remain=
ing space
>> so
>> that 5/8ths is given to the filename and 3/8ths for the graph.
>
> (2)
>
> Hi,
>
> I think that (1) is good. It fixes the bug and even makes the code mo=
re
> readable. But (2) should be separated, IMHO... There was a motivation=
 for
> the layout in 1b058bc30df5f: not changing previous behaviour ("... at=
 least
> 5/8 of available space is devoted to filenames. On a standard 80 colu=
mn
> terminal, or if not connected to a terminal and using the default of =
80
> columns, this gives the same partition as before.").
> (2) would change the way format-patch --stat output looks, which prob=
ably is
> not wanted.

I suppose changing the format of format-patch --stat output could be
annoying to anyone expecting it to remain unchanged. I'll update the
patch so that the diff-stat output using the default of 80 columns
remains unmodified.
