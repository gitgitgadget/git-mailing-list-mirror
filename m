From: Andreas Ericsson <exon@op5.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be deleted
Date: Sat, 18 Apr 2009 13:27:11 +0200
Message-ID: <49E9B90F.8070204@op5.com>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com> <7v4owsfktw.fsf@gitster.siamese.dyndns.org> <20090413230351.7cbb01f5@gmail.com> <7v1vrwdyxx.fsf@gitster.siamese.dyndns.org> <20090417192324.3a888abf@gmail.com> <7vskk6y2tl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 13:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv8j9-0003Kp-Ug
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 13:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbZDRL1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 07:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbZDRL1O
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 07:27:14 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:58489 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbZDRL1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 07:27:13 -0400
Received: by ewy24 with SMTP id 24so538729ewy.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 04:27:12 -0700 (PDT)
Received: by 10.210.16.11 with SMTP id 11mr1644730ebp.65.1240054032084;
        Sat, 18 Apr 2009 04:27:12 -0700 (PDT)
Received: from ?192.168.25.19? (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 23sm269033eya.5.2009.04.18.04.27.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 04:27:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vskk6y2tl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116824>

Junio C Hamano wrote:
> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
>> ... However, there are some cases when these two
>> rules may cause problems:
>>
>> patch #1: rename A to B
>> patch #2: rename C to A
>> patch #3: modify A
>>
>> Should patch #3 modify B (which was A) or A (which was C)?
>>
>> patch #1: rename A to B
>> patch #2: rename B to A
>> patch #3: modify A
>> patch #4: modify B
>>
>> Which files should be patched by #3 and #4?
>>
>> In my opinion both #3 and #4 should fail (or both should succeed) --
>> with my patch only #3 will work and #4 will be rejected, because in =
#2
>> B was marked as deleted.
>=20
> Both of the examples above cannot be emitted as a single commit by
> format-patch; the user is feeding a combined patch.  Perhaps renames
> in each example sequence were came from one git commit but modificati=
ons
> are from separate commit or handcrafted "follow-up" patch.
>=20
> There are two stances we can take:
>=20
>  (1) The user knows what he is doing.
>=20
>      In the first example, if he wanted the change in #3 to end up in=
 B,
>      he would have arranged the patches in a different order, namely,=
 3 1
>      2, but he didn't.  We should modify A (that came from C).
>=20

This gets my vote. Standard "diff -u" patches have always had to be
numbered properly if they have even the slightest chance of interfering
with each other, so developers are already used to it.

/Andreas
