From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Sat, 10 Mar 2012 23:28:21 +0100
Message-ID: <4F5BD585.5050007@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 23:28:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6UmA-0004od-F6
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 23:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab2CJW23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 17:28:29 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:41034 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab2CJW22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 17:28:28 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id EEEF46B275ED
	for <git@vger.kernel.org>; Sat, 10 Mar 2012 23:28:26 +0100 (CET)
Received: from wanderer.site ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MMW5u-1S0R2C25s6-008PYW; Sat, 10 Mar 2012 23:28:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
In-Reply-To: <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:XgIK4ZKDCM1YDZUnoungmZ8FBJH5USIDmuGGESa3Geo
 dW8B/I+TLBi7J1obnODvhcWfVvF/X5WLppwFfxI07ViS5p5ddg
 zS8vFq8c/JWyQgS4IshJmkpQpad9WW2iWDW5IXe5DqEBTQnENn
 RmIJKxpEiVMiTpGc9JOkottPZjXjLMsmEUFP+JOu2ymqR7jBG1
 B1Up0rMtzTVRRNjiH/ydg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192792>

On 03/09/2012 11:30 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> I would be OK if the patch read like the attached, but I do not
>> think treating the "show key" and "stuff with ?" case differently
>> like the original code did makes any sense.
> Ok, here is a re-roll with proper-ish log message.  I've tested this
> only in one of my VMs with is_IS locale (which happened to be Fedora
> 15).
>
> -- >8 --
> Subject: [PATCH] t0204: clarify the "observe undefined behaviour" tes=
t
>
> This test asks for an impossible conversion to the system by
> preparing an UTF-8 translation with characters that cannot be
> expressed in ISO-8859-1, and then asking the message shown in
> ISO-8859-1.  Even though the behaviour against such a request is
> undefined, it may be interesting to see what the system does, and
> the purpose of this test is to see if there are platforms that
> exhibit behaviour that we haven't seen.
>
> The original recognized two known modes of behaviour:
>
>   - the key used to query the message catalog ("TEST: Old English
>     Runes"), saying "I cannot do that i18n".
>   - impossible characters replaced with ASCII "?", saying "I punt".
>
> but they were treated totally differently.  The test simply issued
> an informational message "Your system punts on this one" for the
> first error mode, while it diagnosed the latter as "Your system is
> good; you pass!".
>
> It turns out that Mac OS X exhibits a third mode of error behaviour,
> to spew out the raw value stored in the message catalog.  The test
> diagnosed this behaviour as "broken", but it is merely trying to do
> its best to respond to an impossible request by saying "I punt" in a
> way that is slightly different from the second one.
>
> Update the offending test to make it clear what is (and is not)
> being tested, update the code structure so that newly discovered
> error mode can easily be added to it later, and reword the message
> that comes from a failing case to clarify that it is not the system
> that is broken when it fails, but merely that the behaviour is not
> something we have seen.
>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
> ---
>   t/t0204-gettext-reencode-sanity.sh |   37 ++++++++++++++++++++++---=
-----------
>   1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-ree=
ncode-sanity.sh
> index 189af90..8437e51 100755
> --- a/t/t0204-gettext-reencode-sanity.sh
> +++ b/t/t0204-gettext-reencode-sanity.sh
> @@ -7,6 +7,10 @@ test_description=3D"Gettext reencoding of our *.po/*=
=2Emo files works"
>
>   . ./lib-gettext.sh
>
> +# The constants used in a tricky observation for undefined behaviour
> +RUNES=3D"TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=
=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=
=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=
=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=
=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=
=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=
=AB"
> +PUNTS=3D"TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ?=
? ????"
> +MSGKEY=3D"TEST: Old English Runes"
>
>   test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from ou=
r UTF-8 *.mo files / Icelandic' '
>       printf "TILRAUN: Hall=C3=B3 Heimur!">expect&&
> @@ -15,8 +19,8 @@ test_expect_success GETTEXT_LOCALE 'gettext: Emitti=
ng UTF-8 from our UTF-8 *.mo
>   '
>
>   test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from ou=
r UTF-8 *.mo files / Runes' '
> -    printf "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=
=9A=AB">expect&&
> -    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Old Englis=
h Runes">actual&&
> +    printf "%s" "$RUNES">expect&&
> +    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "$MSGKEY">actual&=
&
>       test_cmp expect actual
>   '
>
> @@ -26,18 +30,23 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: =
Emitting ISO-8859-1 from our UT
>       test_cmp expect actual
>   '
>
> -test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1=
 from our UTF-8 *.mo files / Runes' '
> -    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old En=
glish Runes">runes&&
> -
> -	if grep "^TEST: Old English Runes$" runes
> -	then
> -		say "Your system can not handle this complexity and returns the st=
ring as-is"
> -	else
> -		# Both Solaris and GNU libintl will return this stream of
> -		# question marks, so it is s probably portable enough
> -		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? =
?? ????">runes-expect&&
> -		test_cmp runes-expect runes
> -	fi
> +test_expect_success GETTEXT_ISO_LOCALE 'gettext: impossible ISO-8859=
-1 output' '
> +	LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "$MSGKEY">runes&=
&
> +	case "$(cat runes)" in
> +	"$MSGKEY")
> +		say "Your system gives back the key to message catalog"
> +		;;
> +	"$PUNTS")
> +		say "Your system replaces an impossible character with ?"
> +		;;
> +	"$RUNES")
> +		say "Your system gives back the raw message for an impossible requ=
est"
> +		;;
> +	*)
> +		say "We never saw the error behaviour your system exhibits"
> +		false
> +		;;
> +	esac
>   '
>
>   test_expect_success GETTEXT_LOCALE 'gettext: Fetching a UTF-8 msgid=
 ->  UTF-8' '
Hi Junio and all,
Thanks, the suggestion looks good to me.

I want be able to test it, but there is one problem:
I can not reproduce the original problem any more.
I went through all commit, all my branches, run git bisect, restore old=
=20
backups:
The problem is gone.

Then I diged into the test code. As Hannes pointed out, all test cases=20
in t0204 are
skipped.
This is not because Mac OS X does not have the island locale (it has),
but because GIT_INTERNAL_GETTEXT_SH_SCHEME" =3D fallthrough.

Side note: I will send an improved lib-gettext.sh as a suggested patch.

Back to my setup:
I realized, that there is i18n stuff installed by git under $HOME/share=
=2E
Could that be a reason why I got that non-reproducable failure in t0204=
?

And the skipped test cases seem to indicate that the gettext feature is
not working under Mac OS X?

Does anybody else have t0204 working and not skipped?
Any hints are welcome.

/Torsten
