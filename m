From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Sun, 11 Mar 2012 16:11:08 +0100
Message-ID: <4F5CC08C.90703@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBC?= =?UTF-8?B?amFybWFzb24=?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 16:11:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6kR0-0001oV-FC
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 16:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab2CKPLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 11:11:14 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:39232 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab2CKPLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 11:11:13 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id 2E1CEE0BAA7
	for <git@vger.kernel.org>; Sun, 11 Mar 2012 16:11:12 +0100 (CET)
Received: from [192.168.209.23] ([194.22.188.61]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LwI2w-1SPrBQ1bQc-017yQa; Sun, 11 Mar 2012 16:11:10
 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.9.2.27) Gecko/20120217 Thunderbird/3.1.19
In-Reply-To: <4F5BD585.5050007@web.de>
X-Provags-ID: V02:K0:xscaozB/4GMfVcTnR1RWgdb4Lc4GdMDzpocTcn/+5z1
 IqATmUN2DrEYMT22tEuP9/hXcATPqWd43VnnVmznlcTnktctf9
 PH4f1fG8PNvqEDQ6PiwMaoZXq8bK4/gweW/UuRCSdEVktOwLDM
 zRogCnr4dum21ogo16vmVMtT5n0E2ahbs6BUyGNBN7xRSrM5yg
 86p0houwwRVnlc2rw9tjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192813>

On 03/10/2012 11:28 PM, Torsten B=C3=B6gershausen wrote:
> On 03/09/2012 11:30 PM, Junio C Hamano wrote:
>> Junio C Hamano<gitster@pobox.com> writes:
>>
>>> I would be OK if the patch read like the attached, but I do not
>>> think treating the "show key" and "stuff with ?" case differently
>>> like the original code did makes any sense.
>> Ok, here is a re-roll with proper-ish log message. I've tested this
>> only in one of my VMs with is_IS locale (which happened to be Fedora
>> 15).
>>
>> -- >8 --
>> Subject: [PATCH] t0204: clarify the "observe undefined behaviour" te=
st
>>
>> This test asks for an impossible conversion to the system by
>> preparing an UTF-8 translation with characters that cannot be
>> expressed in ISO-8859-1, and then asking the message shown in
>> ISO-8859-1. Even though the behaviour against such a request is
>> undefined, it may be interesting to see what the system does, and
>> the purpose of this test is to see if there are platforms that
>> exhibit behaviour that we haven't seen.
>>
>> The original recognized two known modes of behaviour:
>>
>> - the key used to query the message catalog ("TEST: Old English
>> Runes"), saying "I cannot do that i18n".
>> - impossible characters replaced with ASCII "?", saying "I punt".
>>
>> but they were treated totally differently. The test simply issued
>> an informational message "Your system punts on this one" for the
>> first error mode, while it diagnosed the latter as "Your system is
>> good; you pass!".
>>
>> It turns out that Mac OS X exhibits a third mode of error behaviour,
>> to spew out the raw value stored in the message catalog. The test
>> diagnosed this behaviour as "broken", but it is merely trying to do
>> its best to respond to an impossible request by saying "I punt" in a
>> way that is slightly different from the second one.
>>
>> Update the offending test to make it clear what is (and is not)
>> being tested, update the code structure so that newly discovered
>> error mode can easily be added to it later, and reword the message
>> that comes from a failing case to clarify that it is not the system
>> that is broken when it fails, but merely that the behaviour is not
>> something we have seen.
>>
>> Signed-off-by: Junio C Hamano<gitster@pobox.com>
>> ---
>> t/t0204-gettext-reencode-sanity.sh | 37
>> ++++++++++++++++++++++--------------
>> 1 file changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/t/t0204-gettext-reencode-sanity.sh
>> b/t/t0204-gettext-reencode-sanity.sh
>> index 189af90..8437e51 100755
>> --- a/t/t0204-gettext-reencode-sanity.sh
>> +++ b/t/t0204-gettext-reencode-sanity.sh
>> @@ -7,6 +7,10 @@ test_description=3D"Gettext reencoding of our *.po/=
*.mo
>> files works"
>>
>> . ./lib-gettext.sh
>>
>> +# The constants used in a tricky observation for undefined behaviou=
r
>> +RUNES=3D"TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA
>> =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=AB"
>> +PUNTS=3D"TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? =
??
>> ????"
>> +MSGKEY=3D"TEST: Old English Runes"
>>
>> test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our
>> UTF-8 *.mo files / Icelandic' '
>> printf "TILRAUN: Hall=C3=B3 Heimur!">expect&&
>> @@ -15,8 +19,8 @@ test_expect_success GETTEXT_LOCALE 'gettext:
>> Emitting UTF-8 from our UTF-8 *.mo
>> '
>>
>> test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our
>> UTF-8 *.mo files / Runes' '
>> - printf "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA
>> =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=AB">expect&&
>> - LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Old English
>> Runes">actual&&
>> + printf "%s" "$RUNES">expect&&
>> + LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "$MSGKEY">actual&&
>> test_cmp expect actual
>> '
>>
>> @@ -26,18 +30,23 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext:
>> Emitting ISO-8859-1 from our UT
>> test_cmp expect actual
>> '
>>
>> -test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-=
1
>> from our UTF-8 *.mo files / Runes' '
>> - LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish
>> Runes">runes&&
>> -
>> - if grep "^TEST: Old English Runes$" runes
>> - then
>> - say "Your system can not handle this complexity and returns the
>> string as-is"
>> - else
>> - # Both Solaris and GNU libintl will return this stream of
>> - # question marks, so it is s probably portable enough
>> - printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? =
??
>> ????">runes-expect&&
>> - test_cmp runes-expect runes
>> - fi
>> +test_expect_success GETTEXT_ISO_LOCALE 'gettext: impossible
>> ISO-8859-1 output' '
>> + LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "$MSGKEY">runes=
&&
>> + case "$(cat runes)" in
>> + "$MSGKEY")
>> + say "Your system gives back the key to message catalog"
>> + ;;
>> + "$PUNTS")
>> + say "Your system replaces an impossible character with ?"
>> + ;;
>> + "$RUNES")
>> + say "Your system gives back the raw message for an impossible requ=
est"
>> + ;;
>> + *)
>> + say "We never saw the error behaviour your system exhibits"
>> + false
>> + ;;
>> + esac
>> '
>>
>> test_expect_success GETTEXT_LOCALE 'gettext: Fetching a UTF-8 msgid =
->
>> UTF-8' '
> Hi Junio and all,
> Thanks, the suggestion looks good to me.
>
> I want be able to test it, but there is one problem:

Here the results of my investigations:
a) git-sh-i18n is used by the test suite, not git-sh-i18n.sh
    git-sh-i18n is generated from git-sh-i18n.sh when running make

b) When running
    make clean && make USE_GETTEXT_SCHEME=3Dgnu && (cd t && make)
   the log of t0204 looks like this:

# lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Iceland=
ic
ok 4 - gettext: impossible ISO-8859-1 output
ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
ok 7 - gettext.c: git init UTF-8 -> UTF-8
ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
# passed all 8 test(s)
1..8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
When running
=2E/t0204-gettext-reencode-sanity.sh --verbose
we find the line
"Your system gives back the raw message for an impossible request"
in the log.


Summary: test OK,

May I say
"Thanks for looking into it,
please go ahead with your suggested re-roll" ?

/Torsten
