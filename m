From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/1] merge-file: let conflict markers match end-of-line
 style of the context
Date: Mon, 25 Jan 2016 19:45:51 +0000
Message-ID: <56A67B6F.60300@ramsayjones.plus.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <cover.1453632296.git.johannes.schindelin@gmx.de>
 <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de>
 <56A4FB64.4010609@web.de> <alpine.DEB.2.20.1601250749580.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:46:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNn5O-00080p-Fj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 20:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbcAYTp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2016 14:45:58 -0500
Received: from avasout07.plus.net ([84.93.230.235]:41926 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653AbcAYTp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 14:45:57 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id AKlr1s0084mu3xa01KluYU; Mon, 25 Jan 2016 19:45:55 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=Q9fys5e9bTEA:10 a=s6qUwkWmM148HHDsFoYA:9 a=PUjeQqilurYA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <alpine.DEB.2.20.1601250749580.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284753>



On 25/01/16 06:53, Johannes Schindelin wrote:
> Hi Torsten,
>=20
> On Sun, 24 Jan 2016, Torsten B=F6gershausen wrote:
>=20
>> On 24.01.16 11:48, Johannes Schindelin wrote:
>> (I had the same reasoning about the CRLF in the working tree:
>> We don't need to look at core.autocrlf/attributes, so Ack from me)
>>
>>> +test_expect_success 'conflict markers match existing line endings'=
 '
>>> +	append_cr <nolf-orig.txt >crlf-orig.txt &&
>>> +	append_cr <nolf-diff1.txt >crlf-diff1.txt &&
>>> +	append_cr <nolf-diff2.txt >crlf-diff2.txt &&
>>> +	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>>> +		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
>>> +	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) =3D 3 &&
>>> +	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>>> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
>>> +	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) =3D 0
>>> +'
>>> +
>>
>> Minor remark:
>>
>> Ramsay suggested a test that doesn't use grep or wc and looks like t=
his:
>>
>> test_expect_success 'conflict markers contain CRLF when core.eol=3Dc=
rlf' '
>>   test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>>     nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
>>   tr "\015" Q <output.txt | sed -n "/^[<=3D>|].*Q$/p" >out.txt &&
>>   cat >expect.txt <<-\EOF &&
>>   <<<<<<< nolf-diff1.txtQ
>>   ||||||| nolf-orig.txtQ
>>   =3D=3D=3D=3D=3D=3D=3DQ
>>   >>>>>>> nolf-diff2.txtQ
>>   EOF
>>   test_cmp expect.txt out.txt
>> '
>=20
> Probably he wrapped it at less than 192 columns per row, though ;-)
>=20
;-)
> Seriously again, this longer version might test more, but it definite=
ly
> also tests more than what I actually want to test: I am simply intere=
sted
> to verify that the conflict markers end in CR/LF when appropriate.

But you are only testing 3/4 conflict markers end in CR/LF. :-D

>                                                                     R=
ead: I
> am uncertain that I want to spend the additional lines on testing mor=
e
> than actually necessary.

If the here doc is too verbose for you, how about something like this
(totally untested):

    test $(tr "\015" Q <crlf.txt | grep "^[<=3D>|].*Q$" | wc -l) -eq 4

instead?

HTH

ATB,
Ramsay Jones
