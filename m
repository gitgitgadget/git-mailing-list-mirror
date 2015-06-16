From: Jan-Philip Gehrcke <jgehrcke@googlemail.com>
Subject: Re: Should the --encoding argument to log/show commands make any
 guarantees about their output?
Date: Tue, 16 Jun 2015 11:38:45 +0200
Message-ID: <557FEEA5.2080006@googlemail.com>
References: <557E91D2.3000908@googlemail.com> <557EFB94.3040104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 11:39:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4nKl-0005Ss-EC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 11:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbbFPJjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2015 05:39:00 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33523 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbbFPJit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 05:38:49 -0400
Received: by wgez8 with SMTP id z8so7955104wge.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=H+PsPgwBBf1x3pwAjFOmt2d80jbJNmWZUwEsBJmt70w=;
        b=rg729nrMqo9kWcbE0rb1vDryHkpe6IAAJth3GOPh7RGZ5RP5l3dOAQb5LQNqIviHSu
         Z9gT8/1iW7yqUW9n/q1Vo/hmIskk5o4ZJgEpf7ffvrqDbsDe7y57mk+fGbg85b5UImiV
         DXSusKw6wMmAUP8ycYbQ4sR3sy5hCjSfE7IrgtYneKl0H5hFBI8FP/H9PEKXidoBWytQ
         gAH7F0wp0ShMkrC0hgA6tZZv78QyLScVQipuKk0vvqOhOQwBiKJRVwSYZIGnv/SyOhki
         dT6ZAjLsnACuMVDcWdDL+M14h2IJIGlmEuLX66kMf+wxA4DY4l/c9QZVx4k99YV/6OQa
         E5bg==
X-Received: by 10.180.97.7 with SMTP id dw7mr41820531wib.74.1434447528244;
        Tue, 16 Jun 2015 02:38:48 -0700 (PDT)
Received: from [192.168.178.11] (ip92342367.dynamic.kabel-deutschland.de. [146.52.35.103])
        by mx.google.com with ESMTPSA id k2sm1675240wif.3.2015.06.16.02.38.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2015 02:38:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <557EFB94.3040104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271744>

On 15.06.2015 18:21, Torsten B=C3=B6gershausen wrote:
> On 2015-06-15 10.50, Jan-Philip Gehrcke wrote:
>> Let me describe what I think it currently does:
>>
>> The program attempts to re-code a log message, so it follows the cha=
in
>>
>>      raw input -> unicode -> raw output
> Not sure what "raw input/output" means.
> But there is only one reencode step involved, e.g.
> input(8859) -> output(UTF-8)

We surely agree. With "raw" I meant a sequence of bytes, and with=20
"unicode" I meant the intermediate state in the process of re-encoding=20
(which can be thought of as decoding and encoding with a transient=20
intermediate state).

> If the user ignores this warning, how should Git guess the encoding  =
?

I entirely appreciate that there is no satisfying solution to this very=
=20
problem.

>> If this step fails (if the entry contains a byte sequence that is in=
valid in the specified/assumed input codec),
>> the procedure is aborted and the data is dumped as is (obviously wit=
hout applying the requested output encoding).
>>
>> Is that correct?
> Yes, see above.

Thanks!

>> Hence, from my point of view, the rational that git show/log should =
be able to output *text* information means
>> that they should not emit byte sequences that are invalid in the cod=
ec specified via the --encoding argument.
>> In the current situation, the work of dealing with invalid byte sequ=
ences is just outsourced to software
>> further below in the tool chain
>> (at some point a replacement character =EF=BF=BD should be displayed=
 to the user instead of the invalid raw bytes).
>>
>> I am not entirely sure where this discussion should lead to.
> Yes, until someone writes a patch to improve either the documentation=
 or the code,
> nothing will be changed.
>> However, I think that if the behavior of the software will not be ch=
anged,
>> then the documentation for the --encoding option should be more prec=
ise and
>> clarify what actually happens behind the scenes. What do you think?
> Patches are more than welcome.

I'd be willing to contribute, but of course there must be a discussion=20
and an agreement before that, if there is need to change something at=20
all, and what exactly.

To this discussion I would like to contribute that I am of the opinion=20
that there should be a command line option to make git show/log/friends=
=20
emit a byte stream that is guaranteed to be valid in a given codec.

That would require detection and treatment of those cases where=20
corrupted text resides in the repository (we cannot prevent it from=20
entering the repository, as discussed). In these cases, one could emit =
a=20
replacement symbol (e.g. '?') per invalid byte subsequence (this seems=20
to be more established than just swallowing the invalid byte sequence).

What do you think?

I think the --encoding option would have ideal semantics for described=20
behavior.

However, I guess maintaining backwards compatibility is an issue here.=20
On the other hand, I realize that the --encoding option undergoes=20
changes: the docs for git log in release 2.4.3 do not even list the=20
--encoding option anymore. Why is that? I haven't found a corresponding=
=20
changelog/release notes entry.


Thanks,


Jan-Philip
