From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 6/7] git-p4: add support for large file systems
Date: Sun, 20 Sep 2015 23:26:24 +0200
Message-ID: <107A7A4A-1B2C-4280-A66E-A4B3BED13AE0@gmail.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com> <1442237194-49624-7-git-send-email-larsxschneider@gmail.com> <55F92A1E.1090002@diamand.org> <5329966D-1A0C-42A1-9099-AC449D50AA52@gmail.com> <xmqqzj0ms85n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 23:26:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdm8L-0000bp-TL
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 23:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbbITV02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Sep 2015 17:26:28 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36409 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbITV02 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Sep 2015 17:26:28 -0400
Received: by wicgb1 with SMTP id gb1so91337001wic.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=osaL8VXgVhNPaMYjrhNkfMWgCNlNOKF6gMja7AXT3Xs=;
        b=HJEssh1PWBzhQxDYnzlE7dDepHtY2eIwl1UwoSsxp7/ouTRYBjnfpawQhj2X2we0O0
         a+aALPtl34F3kPSzcGqFso2TtTflLdNsSGNpYGCTc8Uza8dkYnSbM6a55QDTmzQ/AspN
         7N+eIEBduLoCDmVcFEVcElmkerWdYhekpbCZbF+1qXP5gLWegL2ELN5wW9azjTprddWG
         ihqDh1VwCVrlvpl4nZicfzHLuEm9ZFH8o6iydVhJEe/ZHpcYwyqlc2JT1obb9qSiMPXn
         07CoMf8GKv0vXFFMgjdUM354CYnvAXWhlfWDLxKs4KpyyY0mNhvUmYEGkONrwQGp/0Gs
         KFHg==
X-Received: by 10.180.87.198 with SMTP id ba6mr10504197wib.39.1442784386582;
        Sun, 20 Sep 2015 14:26:26 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id s16sm10098963wik.13.2015.09.20.14.26.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Sep 2015 14:26:25 -0700 (PDT)
In-Reply-To: <xmqqzj0ms85n.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278271>


On 16 Sep 2015, at 17:20, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>>> +git-p4.largeFileSystem::
>>>> +	Specify the system that is used for large (binary) files. Please=
 note
>>>> +	that large file systems do not support the 'git p4 submit' comma=
nd.
>>>=20
>>> Why is that? Is it just that you haven't implemented support, or
>>> is it fundamentally impossible?
>>=20
>> If we detect LFS files only by file extension then we could make
>> it work. But then we must not use any git-p4 settings. We would
>> need to rely only on the =93.gitattributes=94 file that is stored in
>> the P4 repository. My implementation also looks at the file size
>> and decides on a individual file basis if a file is stored in
>> LFS. That means all clients need the same file size threshold.
>>=20
>> Junio explained the problem in the v4 thread:
>>> ...
>=20
> Hmm, I am not sure if Luke's question was answered with the above,
> and I do not think I explained anything, either.  I did point out
> that with _your_ code I didn't see how "submit" would not work, but
> that is quite different from the problem being fundamentally not
> solvable.

OK, to answer Luke=92s question after some thoughts: I think it is poss=
ible but I haven=92t implemented it.

I see one issue right away:
Some large file systems depend on gitattributes filters (e.g. Git-LFS).=
 Git-p4 would need to run the filters on clone/sync/submit. Right now t=
his does not happen and the user sees the raw LFS pointer files in the =
Git repository instead of the content after the initial git-p4 clone (t=
he Git-LFS test cases shows this). This is no problem for a git-p4 one =
time usage as you usually upload the created Git repo to some Git serve=
r. Nevertheless, I was not able to find a quick and easy way to fix thi=
s. Anyone an idea?

If we get these filters working then we could create a new large file s=
ystem similar to =93Git-LFS=94. Instead of pointing to large files on a=
 =93Git-LFS=94 server we could point right to their P4 location. That w=
ould be pretty neat.

- Lars