From: Elliot Wolk <elliot.wolk@gmail.com>
Subject: Re: move detection doesnt take filename into account
Date: Tue, 01 Jul 2014 10:40:48 -0400
Message-ID: <53B2C870.4030406@gmail.com>
References: <53B105DA.30004@gmail.com> <287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 16:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1zEt-0000nG-Km
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 16:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaGAOku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 10:40:50 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:50232 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaGAOkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 10:40:49 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so3372218qgd.21
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XRGfBpo3vVLB+527yiJOwf4WO8ZbFvWuuX8YUzhgEW8=;
        b=xafYpSBrkH8YIAgz7mIJ/5oQjjly+MYuLwl6BizfWWldm1PpHILImUXGWOOGKWybkb
         oRmbztn0P3Nub1CKuQWI14wAfB/9ReGJVMhndxHC8NgOqAtmeVYHwQLagcTivyWmtXTS
         719w1BNAPH1hSBQQLtRHTIfUQoH2lTAu3OblPNP6ePdmtDjoHkM56pvTYClfu3qukIiz
         pfKwp8jK1XSlUtWyAZM03TyrDc5avyicLAD32tqYTDPR6qKxGa86XF7WX3Q5xUFUXuDf
         daeRWCbmKQe5jP1Tuvy7Oa5auaxc7JiXRZVEao3uRRuSeqGXOp6XDTVuwl8Djqji6R5S
         gBbg==
X-Received: by 10.224.25.206 with SMTP id a14mr7396975qac.35.1404225649309;
        Tue, 01 Jul 2014 07:40:49 -0700 (PDT)
Received: from [192.168.11.50] ([98.113.246.12])
        by mx.google.com with ESMTPSA id c2sm37634004qan.18.2014.07.01.07.40.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jul 2014 07:40:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Icedove/30.0
In-Reply-To: <287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252717>

interesting that it considers suffixes {only suffixes following=20
periods?}. this is insufficient, in my opinion.

with all other things being equal, it ought to find the closest match=20
{using smith-waterman or some such algorithm}.

as a real-world use case, i have a repository with empty files that=20
mirrors the file structure of a directory containing large binary files=
=2E
when i move a dir, it seems to select the files renamed at random.

On 07/01/2014 05:16 AM, Robin Rosenberg wrote:
>
> ----- Ursprungligt meddelande -----
>> Fr=C3=A5n: "Elliot Wolk" <elliot.wolk@gmail.com>
>> Till: git@vger.kernel.org
>> Skickat: m=C3=A5ndag, 30 jun 2014 8:38:18
>> =C3=84mne: move detection doesnt take filename into account
>>
>> if you move two identical {e.g.: empty} files to two new locations i=
n a
>> single commit, the move detection picks them {seemingly?} arbitraril=
y.
>> it should use a statistical algorithm to compare the filenames and p=
ick
>> a likely match.
> I think it does, but based on filename suffix. E.g. here is a rename =
of
> three empty files with a suffix.
>
>   3 files changed, 0 insertions(+), 0 deletions(-)
>   rename 1.a =3D> 2.a (100%)
>   rename 1.b =3D> 2.b (100%)
>   rename 1.c =3D> 2.c (100%)
>
> -- robin
