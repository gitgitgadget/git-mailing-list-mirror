From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Tue, 16 Jul 2013 23:18:57 +0100
Message-ID: <51E5C6D1.7000505@iee.org>
References: <51E431F1.6050002@ramsay1.demon.co.uk> <51E4E0C0.3060604@viscovery.net> <20130716062122.GA4964@sigill.intra.peff.net> <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley> <51E5B8BD.8090202@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 00:19:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzDaL-0004uL-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 00:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732Ab3GPWTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jul 2013 18:19:03 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25075 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933295Ab3GPWTB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jul 2013 18:19:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApUBAALF5VFZ8YYB/2dsb2JhbAANTRaDJINVvnqBKIMXAQEBAQECIw8BBUABEAsVAQICAgUWCwICCQMCAQIBRQYNAQUCAQEWiAKjEnORQYEmjjkHglmBIAOZBZM3
X-IPAS-Result: ApUBAALF5VFZ8YYB/2dsb2JhbAANTRaDJINVvnqBKIMXAQEBAQECIw8BBUABEAsVAQICAgUWCwICCQMCAQIBRQYNAQUCAQEWiAKjEnORQYEmjjkHglmBIAOZBZM3
X-IronPort-AV: E=Sophos;i="4.89,679,1367967600"; 
   d="scan'208";a="78735326"
Received: from host-89-241-134-1.as13285.net (HELO [192.168.0.7]) ([89.241.134.1])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 16 Jul 2013 23:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <51E5B8BD.8090202@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230592>

On 16/07/13 22:18, Stefan Beller wrote:
> On 07/16/2013 10:53 PM, Philip Oakley wrote:
>> From: "Jeff King" <peff@peff.net>
>> Sent: Tuesday, July 16, 2013 7:21 AM
>>> On Tue, Jul 16, 2013 at 07:57:20AM +0200, Johannes Sixt wrote:
>>>
>>>> Am 7/15/2013 19:31, schrieb Ramsay Jones:
>>>>> Sparse issues three "Using plain integer as NULL pointer" warning=
s.
>>>>> Each warning relates to the use of an '{0}' initialiser expressio=
n
>>>>> in the declaration of an 'struct object_info'.
>>>>
>>>> I question the value of this warning. Initialization with '=3D {0}=
' is
>>>> a
>>>> well-established idiom, and sparse should know about it. Also, pla=
in
>>>> 0
>>>> *is* a null pointer constant.
>>>
>>> I agree with you. It's not a bug, and I think sparse is being overl=
y
>>> picky here; it is missing the forest for the trees in interpreting =
the
>>> idiom.
>>>
>>> Still, it may be worth tweaking in the name of eliminating compiler
>>> noise, since it does not cost us very much to do so (and I believe =
we
>>> have done so in the past, too).
>>>
>>> We could also ask people with sparse to turn off the "use NULL inst=
ead
>>> of 0" warning, but I think it _is_ a useful warning elsewhere (even
>>> though it is never a bug, it violates our style guidelines and may =
be
>>> an
>>> indication of a bug). It would be nice if sparse learned to ignore =
the
>>> warning in this particular idiom, but I am not going to hold my bre=
ath
>>> for that.
>>>
>>> -Peff
>>> --
>>
>> On the subject of warnings and null pointers, yesterday's Code Proje=
ct
>> news linked to a blog on the problems of unexpected optimization bug=
s,
>> such as dereferencing a null pointer. "Finding Undefined Behavior Bu=
gs
>> by Finding Dead Code" http://blog.regehr.org/archives/970 which link=
s to
>> the draft of an interesting paper
>> [http://pdos.csail.mit.edu/~xi/papers/stack-sosp13.pdf]
>>
>> Does anyone run the "new static checker called 'Stack' that precisel=
y
>> identifies unstable code"? [though the paper's conclusion says 'All
>> Stack source code will be publicly available.' which suggests it's n=
ot
>> yet available]
>>
>> Or use the =E2=80=98-fno-delete-null-pointer-checks=E2=80=99 referre=
d to in the blog
>> comments (see also index : kernel/git/torvalds/linux.git "Add
>> '-fno-delete-null-pointer-checks' to gcc CFLAGS"
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Da3ca86aea507904148870946d599e07a340b39bf
>>
>>
>> You're probably already aware of these aspects but I thought it wort=
h
>> mentioning for the wider readership.
>>
>> regards
>>
>> Philip
>>
>>
>
> I recently started contributing and I used cppcheck found at
> https://github.com/danmar/cppcheck to submit the patches
> at origin/sb/misc-fixes
> As it is originally for C++, that tool throws lots of
> false-positives (i.e. warns about null pointer dereferencing
> when it's not possible to be a null pointer) unfortunately.
>
> Also I hear llvm/clang comes with a good static code analyzer,
> which I tried today on a different project.
> Though I could not figure out how to use that on a pure C project
> such as git, as that tool seems to require a C++ compilation for
> doing its static code analysis.
>
> The blog post you linked to seems very interesting and promising. :)
>
> Regards,
> Stefan
>
A bit more searching also finds=20
http://pdos.csail.mit.edu/~xi/papers/ub-apsys12.pdf and=20
http://pdos.csail.mit.edu/~xi/papers/ub-apsys12-slides.pptx by the same=
=20
author.
