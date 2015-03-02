From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Mon, 02 Mar 2015 02:00:09 +0100
Message-ID: <20150302020009.Horde.9sATpKnsrWQkGadaRTvxkA3@webmail.informatik.kit.edu>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com>
 <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com>
 <54F2E931.7020200@web.de> <20150301155818.GA5307@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?b?QsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>,
	git@vger.kernel.org, gitster@pobox.com, johan@herland.net
To: =?utf-8?b?TcOlcnRlbg==?= Kongstad <marten.kongstad@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 02:00:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSEir-0006BE-6R
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 02:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbCBBAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2015 20:00:33 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33412 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752240AbbCBBAc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 Mar 2015 20:00:32 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YSEig-0002sF-U2; Mon, 02 Mar 2015 02:00:26 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YSEiP-0007SH-OI; Mon, 02 Mar 2015 02:00:09 +0100
Received: from x590c6035.dyn.telefonica.de (x590c6035.dyn.telefonica.de
 [89.12.96.53]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 02 Mar 2015 02:00:09 +0100
In-Reply-To: <20150301155818.GA5307@laptop>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1425258026.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264571>


Hi,

Quoting M=C3=A5rten Kongstad <marten.kongstad@gmail.com>:

> On Sun, Mar 01, 2015 at 11:25:53AM +0100, Torsten B=C3=B6gershausen w=
rote:
>> On 2015-03-01 08.39, M=C3=A5rten Kongstad wrote:
>> []
>>> +test_expect_success '--shortstat --dirstat should output only
>> one dirstat' '
>>> +	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD
>>> actual_diff_shortstat_dirstat_changes &&
>>> +	test $(grep -c " dst/copy/changed/$"
>> actual_diff_shortstat_dirstat_changes) =3D 1 &&
>> How portable is the "grep -c" usage ?
>> (I don't now it either, do we have other opinions ?), but the
>> following seems to be more "Git-style":
>>
>> test_expect_success '--shortstat --dirstat should output only one di=
rstat' '
>> 	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD
>>> actual_diff_shortstat_dirstat_changes &&
>> 	grep " dst/copy/changed/$" actual_diff_shortstat_dirstat_changes >a=
ctual &&
>> 	test_line_count =3D 1 actual
>>


> Granted I didn't miss anything while trawling the tests for the above
> numbers, it feels like the 'grep -c' option is more in line with the
> existing tests. That said, I don't know if there is an ongoing trend =
to
> deprecate 'grep -c' in favour of 'test_line_count'.

It's not just 'grep -c' but the 'test' checking its output as well.

If something goes wrong and the line count doesn't match expectations
'test' fails silently leaving the developer clueless as to what went
wrong.

'test_line_count', on the other hand, produces useful output in case
of a failure:

    $ printf 'foo\nbar\n' >actual
    $ test_line_count =3D 1 actual
    test_line_count: line count for actual !=3D 1
    foo
    bar

Since the name of the file in question is included in the output and
since there are three separate checks in this test, I would also
suggest writing 'grep's output into separate files
'actual_{changes,lines,files}'.

G=C3=A1bor
