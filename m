From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use
 write_script
Date: Fri, 25 Mar 2016 15:46:38 +0100
Message-ID: <20160325154638.Horde.LzlsD6cZcQfmt894cll_0Tl@webmail.informatik.kit.edu>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
 <1458817259-11675-1-git-send-email-szeder@ira.uka.de>
 <CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:47:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajT0n-0002iP-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbcCYOqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 10:46:44 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59063 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751884AbcCYOqn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:46:43 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ajT0Z-00052b-Nq; Fri, 25 Mar 2016 15:46:39 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ajT0Y-0001At-VO; Fri, 25 Mar 2016 15:46:38 +0100
Received: from x590e51bb.dyn.telefonica.de (x590e51bb.dyn.telefonica.de
 [89.14.81.187]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 25 Mar 2016 15:46:38 +0100
In-Reply-To: <CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1458917199.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289893>


Quoting Eric Sunshine <sunshine@sunshineco.com>:

> On Thu, Mar 24, 2016 at 7:00 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:

>>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>>> index 2ddf28c..cf95efb 100755
>>> --- a/t/t7507-commit-verbose.sh
>>> +++ b/t/t7507-commit-verbose.sh
>>> @@ -3,12 +3,11 @@
>>>  test_description=3D'verbose commit template'
>>>  . ./test-lib.sh
>>>
>>> -cat >check-for-diff <<EOF
>>> -#!$SHELL_PATH
>>> -exec grep '^diff --git' "\$1"
>>> +write_script "check-for-diff" <<-\EOF &&
>>> +grep '^diff --git' "$1" >out &&
>>> +test $(wc -l <out) =3D 1
>>
>> Our test lib offers the test_line_count helper function, which
>> outputs a helpful error message in case the number of lines do not
>> match.
>
> test_line_count() was mentioned in [2], however, this line counting i=
s
> done in the fake "editor" script, not in the test script proper, so
> the spelled-out form $(wc ...) was proposed[2].

Ah, yes, of course.

But then the question is: why is the line counting in the editor script
in the first place?

By redirecting grep's output to a file in the editor script, like this
patch wanted to, we can count the lines in the test script itself after
'git commit' finished.  This way we could use test_line_count, with
all its error reporting benefits, and we could use the same editor
script for all tests.

And if you insist on doing the line counting in the editor script, then
why redirecting grep's output and 'wc -l' separately, why not 'grep -c'=
?
