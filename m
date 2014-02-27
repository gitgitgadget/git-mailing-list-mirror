From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Thu, 27 Feb 2014 23:24:29 +0100
Message-ID: <530FBB1D.3050505@gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com> <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com> <530FA0C1.3000109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9NX-0002Bc-3K
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbaB0WY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 17:24:27 -0500
Received: from mail-ea0-f178.google.com ([209.85.215.178]:41873 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbaB0WY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 17:24:26 -0500
Received: by mail-ea0-f178.google.com with SMTP id a15so2165772eae.23
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 14:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7AM4dXbOHj8VB4F8GHk8EZ+EeE/5am+APqiU+eFvxT4=;
        b=QO4dB8/nLDp1mGPsxN4lP5pfVSFaP5pDtAk2Gk5xN7/eAuM4f2IGKYbAa5oj4oDVjX
         zpC208MzlgN5yiGeFpVAEaZTxkznKHYTRPmxpZDjP9MOtfP6FlwvyNKgRjFuYUw8tx3H
         TeXphpfzLwZTifQzO/7SV2s9Sz9HMRkamXpgOF/yaCmUmgg4snbnlCbgkCv0nD7HTXZH
         m+ylVfh5Nj0hpXEv5SOUB9U4iQ6UpB6usfNWG7LWqlmzQfLbDWZO1FjJyWFJ1vopbt3X
         dODlIatZJlQxqvzRu1lA8gjxUUYumGBp2QoQGt4iP29zODrT6nusRYfWQFA79seoxInY
         ptwg==
X-Received: by 10.14.179.129 with SMTP id h1mr16502976eem.26.1393539865746;
        Thu, 27 Feb 2014 14:24:25 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id j41sm2742266eeg.10.2014.02.27.14.24.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 14:24:25 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <530FA0C1.3000109@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242869>

Am 27.02.2014 21:32, schrieb Torsten B=F6gershausen:
> On 2014-02-27 20.50, Junio C Hamano wrote:
>> Lee Hopkins <leerhop@gmail.com> writes:
>>
>>> Last week I ran across a potential bug with branch names on case
>>> insensitive file systems, the complete scenario can be found here:
>>>
>>> https://groups.google.com/forum/#!topic/msysgit/ugKL-sVMiqI
>>>
>>> The tldr is because refs are stored as plain text files except when
>>> packed into packed-refs, Git occasionally cannot tell the differenc=
e
>>> between branches whose names only differ in case, and this could
>>> potentially lead to the loss of history.
>>>
>>> It sounds like this is a known issue, and after some more digging I
>>> did find some older threads related to this topic, but nothing rece=
nt.
>>
>> Yes, it is not limited to branch names but also applies to tags and
>> filenames in your working tree.
>>
>> Perhaps git-{branch,tag}.txt and possibly gitrepository-layout.txt
>> in Documentation/ may need a new "*Note*" section to warn against
>> this.
>>
>> Thanks.
> There is a possible workaround:
> git pack-refs --all --prune
>=20

If I understand the issue correctly, the problem is that packed-refs ar=
e always case-sensitive, even if core.ignorecase=3Dtrue. OTOH, checking=
 / updating _unpacked_ refs on a case-insensitive file system is natura=
lly case-insensitive. So wouldn't it be a better workaround to disallow=
 packed refs (i.e. 'git config gc.packrefs false')?
