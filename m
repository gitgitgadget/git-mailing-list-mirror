From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 21:09:41 +0700
Message-ID: <CACsJy8CW0shw5JYtXScQHMYJ+D18-UJ6HanP-5OCuv87kHbnBg@mail.gmail.com>
References: <52FB2268.7080906@viscovery.net> <87mwhwa3s1.fsf@fencepost.gnu.org>
 <52FB7196.7060209@viscovery.net> <87ioska2iu.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 15:10:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDaW4-0008VV-Lq
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 15:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbaBLOKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 09:10:13 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:63166 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaBLOKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 09:10:12 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so15365479qcq.18
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZNxpTh5YyXTRmTvhxbIgnPEJJhZc36cbTIEPOgYaC+U=;
        b=WEVP1w8nFCTQBibcTvuFoiW1dDvucZnbaFcWK824cPtBbbYKUg3qj66gc/z5datAAr
         xZ7i6YgJdHtK4xigZGvfMh/ZVa23qHY9kRw4z2H2zENjXpqwjbWHi45rgENUHpfUlljz
         IRsLBF7Mc7IrRsTzoImkC9UmQromjMsao8H5jcwDcUgz7yRrd3ebPFZxpOMlLa8hpaeS
         VcxRYtNzzQ14cTvpnBATpPoIkVUEmXpoh1j6yExHimz0GV3BAT3xw/Kj8HmpPIusCaYj
         zcRsKhv4su5V2qCCimIYg9OSyiK3Tl0iJDFHy7sicbQLzJl+nQMylaPVyOfGW1MHH+vM
         NAgA==
X-Received: by 10.224.19.199 with SMTP id c7mr48510153qab.78.1392214211828;
 Wed, 12 Feb 2014 06:10:11 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 12 Feb 2014 06:09:41 -0800 (PST)
In-Reply-To: <87ioska2iu.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241991>

On Wed, Feb 12, 2014 at 8:23 PM, David Kastrup <dak@gnu.org> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Am 2/12/2014 13:55, schrieb David Kastrup:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>
>>>> Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
>>>> the following symptoms. I haven't followed the topic. Have there been
>>>> patches floating that addressed the problem in one way or another?
>>>>
>>>> (gdb) run
>>>> Starting program: D:\Src\mingw-git\t\trash
>>>> directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap
>>>> HEAD
>>>> [New thread 3528.0x8d4]
>>>> Bitmap v1 test (20 entries loaded)
>>>> Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits
>>>> / 15873b36 checksum
>>>
>>> Does reverting a201c20b41a2f0725977bcb89a2a66135d776ba2 help?
>>
>> YES! t5310 passes after reverting this commit.
>
> Oh.  I just looked through the backtrace until finding a routine
> reasonably related with the regtest and checked for the last commit
> changing it, then posted my question.
>
> Then I looked through the diff of the patch and considered it
> unconspicuous.  So I commenced reading through earlier commits.
>
> I actually don't have a good idea what might be wrong here.  The code is
> somewhat distasteful as it basically uses eword_t and uint64_t
> interchangeably, but then this does match its current definition.

Perhaps __BYTE_ORDER or __BIG_ENDIAN is misdefined and the ntohll() is skipped?
-- 
Duy
