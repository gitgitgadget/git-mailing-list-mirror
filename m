From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] tests: test applying criss-cross rename patch
Date: Tue, 21 Apr 2009 14:41:40 +0200
Message-ID: <81b0412b0904210541o17baa103h62fc0825727fe83b@mail.gmail.com>
References: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
	 <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
	 <81b0412b0904200711p66ea2500s7cc5894aba71f641@mail.gmail.com>
	 <7viqkya3hq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 14:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwFJl-0001GR-KH
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 14:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbZDUMln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 08:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZDUMln
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 08:41:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:52020 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbZDUMlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 08:41:42 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1617925ywb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dphCnDneHw2CXyty7S1EqHG9ql7id9miXXArBeQ5hK8=;
        b=VdbTDafgCoJuKRGtfo8V68OLhvClBWfdHhKx1mMj4vlD+yX8XY1YUme+FVSz5yWB0s
         2YsrmEhx60o//mmGj50qjq0ytJJMF0i40EdOkCAAAx/ZLPVALtSthTUIv0Vt7I6riqmS
         uSYU2vuxlalo1SnIWbTaFRVsV+nkS69gigcso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SSkGo30IoKcwhFBAMoMmso7Njkew3NFrgDXXDMzifGgsEuZI31JC5XP6eFb5Y9GUD9
         +/SHvDNqSbz2H2wyvUBLhUtbEWbyFru1wNGi1vc8uKkZ+j1Iwd6n4WT69vvTi4BZ8GBD
         bzgI1l9mL1UXZXtfv0vCDcxUm62mwa/mYTLmg=
Received: by 10.150.177.20 with SMTP id z20mr8400064ybe.13.1240317700855; Tue, 
	21 Apr 2009 05:41:40 -0700 (PDT)
In-Reply-To: <7viqkya3hq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117127>

2009/4/21 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> 2009/4/11 Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>:
>>> +test_expect_success 'criss-cross rename' '
>>> + =C2=A0 =C2=A0 =C2=A0 mv file1 tmp &&
>>> + =C2=A0 =C2=A0 =C2=A0 mv file2 file1 &&
>>> + =C2=A0 =C2=A0 =C2=A0 mv tmp file2
>>> +'
>>> +
>>> +test_expect_success 'diff -M -B' '
>>> + =C2=A0 =C2=A0 =C2=A0 git diff -M -B > diff &&
>>> + =C2=A0 =C2=A0 =C2=A0 git reset --hard
>>> +
>>> +'
>>
>> This cannot work on systems where ctime is not trusted:
>> git diff will produce no data, as there are no changes in
>> metadata (the files are of the same size). Either make
>> the file sizes different or add a "touch file1 file2".
>
> You seem to be saying that we still have a racy-git bug somewhere. =C2=
=A0Is
> your statement from an actual experience or a speculation?

The test reproducibly fails for me.

> If the former we have a bug to kill, not a workaround to avoid the
> issue in this test.

Maybe. As I see it, there is just not _enough_ metadata in this
particular case to notice the change without doing complete
content comparison: the size is the same, mtime is the same,
dev/ino aren't available, and ctime is marked untrusted and thus
is not used. What's left to notice the change?
