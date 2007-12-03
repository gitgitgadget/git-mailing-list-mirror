From: Benjamin Close <Benjamin.Close@clearchain.com>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 04 Dec 2007 08:16:24 +1030
Message-ID: <47547930.5070603@clearchain.com>
References: <4753D419.80503@clearchain.com> <m3prxougmx.fsf@roke.D-201> <20071203163856.GA24269@auto.tuwien.ac.at> <200712031802.55514.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	=?ISO-8859-1?Q?Ismail_?= =?ISO-8859-1?Q?D=F6nmez?= 
	<ismail@pardus.org.tr>, Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:47:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzJ84-0003L4-Ml
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 22:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbXLCVqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 16:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbXLCVqn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 16:46:43 -0500
Received: from ipmail04.adl2.internode.on.net ([203.16.214.57]:2584 "EHLO
	ipmail04.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751106AbXLCVql (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 16:46:41 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAAYGVEd5LVoqWmdsb2JhbACBW41mASA
X-IronPort-AV: E=Sophos;i="4.23,245,1194183000"; 
   d="scan'208";a="10407854"
Received: from ppp121-45-90-42.lns10.adl6.internode.on.net (HELO mail.clearchain.com) ([121.45.90.42])
  by ipmail04.adl2.internode.on.net with ESMTP; 04 Dec 2007 08:16:36 +1030
Received: from [192.168.155.249] (draco.internal.clearchain.com [192.168.155.249])
	(authenticated bits=0)
	by mail.clearchain.com (8.13.8/8.13.8) with ESMTP id lB3LkTtB067838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 08:16:30 +1030 (CST)
	(envelope-from Benjamin.Close@clearchain.com)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200712031802.55514.jnareb@gmail.com>
X-Virus-Scanned: ClamAV version 0.91.2, clamav-milter version 0.91.2 on pegasus.clearchain.com
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (mail.clearchain.com [192.168.154.1]); Tue, 04 Dec 2007 08:16:34 +1030 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66963>

Jakub Narebski wrote:
> On Mon, 3 Dec 2007, Martin Koegler wrote:
>  =20
>> On Mon, Dec 03, 2007 at 04:06:48AM -0800, Jakub Narebski wrote:
>>    =20
>>> Ismail D=F6nmez <ismail@pardus.org.tr> writes:
>>>      =20
>>>> Monday 03 December 2007 Tarihinde 12:14:43 yazm??t?:
>>>>        =20
>>>>> Benjamin Close <Benjamin.Close@clearchain.com> writes:
>>>>>          =20
>>>>>> -	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
>>>>>> -	if (defined $res) {
>>>>>> -		return $res;
>>>>>> -	} else {
>>>>>> -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>>>>>> -	}
>>>>>> +	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)); =
};
>>>>>> +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>>>>>>  }
>>>>>>            =20
>> This version is broken on Debian sarge and etch. Feeding a UTF-8 and=
 a latin1
>> encoding of the same character sequence yields to different results.
>>    =20
>
>  =20
=46or the record, this was on a debian sid machine.

#perl --version
This is perl, v5.8.8 built for x86_64-linux-gnu-thread-multi

and the result of not using the original patch was:

<h1>Software error:</h1>
<pre>Cannot decode string with wide characters at /usr/lib/perl/5.8/Enc=
ode.pm line 166.
</pre>


I haven't tried the other solutions tested here.
>> eval { $res =3D decode_utf8(...); }
>> if ($@)=20
>>      return decode(...);
>> return $res
>>
>> or
>>
>> eval { $res =3D decode_utf8(...); }
>> if (defined $res)
>>       return $res;
>> else
>>     return decode(...);
>>
>> show the same (wrong) behaviour on Debian sarge. They do not always
>> decode non UTF-8 characters correctly, eg.
>> #=F6=E4=FC does not work
>> #=E4=F6=FC=E4 does work
>>
>> On Debian etch, both versions are working.
>>    =20
>
> I don't know enough Perl to decide if it is a bug in gitweb usage
> of decode_utf8, if it is a bug in your version of Encode, or if it
> is bug in Encode.
>
> Send copy of this mail to maintainers of Encode perl module.
>  =20
Ismail do you know if sid was also broken?
