From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: forcing a user@ into the URL if not present
Date: Wed, 06 May 2015 07:29:20 +0200
Organization: gmx
Message-ID: <e8793cf6c07dcfcfa835dbc4c438918f@www.dscho.org>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
 <CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
 <20150430202342.GC5015@vauxhall.crustytoothpaste.net>
 <CABU7BdcuJp3f6_cN8TpJX-brDUWL6-0Q5M0Yvpg2ND-k--yEbw@mail.gmail.com>
 <CABU7BddLGe-+b4cEiPi9MCd6xY5kpBU6aZuy4Vn7j+NgPdLwuA@mail.gmail.com>
 <231730bb9947a6ddbbd8f3bda36c89f2@www.dscho.org>
 <xmqqmw1iex4m.fsf@gitster.dls.corp.google.com> <55499E10.2050003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dan Langille <dlangille@sourcefire.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 06 07:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpsDq-00045T-7e
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 07:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbbEFFuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 01:50:09 -0400
Received: from mout-xforward.gmx.net ([82.165.159.42]:50301 "EHLO
	mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbEFFuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 01:50:01 -0400
X-Greylist: delayed 1226 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2015 01:50:01 EDT
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MNMyz-1Yrotv3pMH-006sa8; Wed, 06 May 2015 07:29:22
 +0200
In-Reply-To: <55499E10.2050003@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:tyofEBsrg6AKpx88G7jXNdUndMjiq2PGMdNEPHIk43z+xSAw+o3
 jUAlzeWXSFJaMzqKcydkd/I7pmQXGACtbmXsoCGlY7BIEFMfDe/6H7Efy3kiY49s+RjQTvR
 JJq/hYnaZpO2t3yrTFRL5UDtjmYdVbPylP1WvFNJq2TyBggZTTdpQxwvO3zrVzhCtupIjnb
 iGssbyiuspK+0uxxpVD7Q==
X-UI-Out-Filterresults: junk:10;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268448>

Hi Torsten & Junio,

On 2015-05-06 06:52, Torsten B=C3=B6gershausen wrote:
> On 05/05/2015 07:45 PM, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Having stumbled over [this
>>> ticket](https://github.com/git-for-windows/git/issues/92) recently,=
 it
>>> appears to me as if the following should work for you:
>>>
>>> git clone https://:@repo.example.org/
>>
>> Wow.

My reaction exactly.

>> Is this a windows-only SSPI thing, or is this a widely accepted URL =
convention?

Quite frankly, I have no idea. Before reading that ticket, I did not ev=
en think of trying such a convention.

>> I haven't seen anybody use such a URL but I would say that is a natu=
ral thing to expect to work, as both username and password are missing =
so they should default to some sensible values, in this case "current u=
ser, shouldn't need password", just like "scheme://site:/" is "port mis=
sing so it should default to some sensible value, appropriate for the s=
cheme".

Yes, that makes total sense to me, too. In fact, I found it rather clev=
er once I got over the surprise.

>> I think Torsten recently added a bit more test for our URL parsing
>> code, especially for "scheme://site:/" (missing port), but I do not
>> think we have "scheme://:site/" (missing user or password).  Perhaps
>> we would want to have additional tests to cover this shape of URL?
>>
> I have added tests for URL parsing, but for host names/port numbers.
> Not for usernames/passwords (passwords shouldn't be there,
> recommends RFC 3986)
>=20
> And only for the ssh:// protocol, as well as git://.
> http:// and https:// are not handled by connect.c at all,
> and I'm not really familiar with curl, nor kerberos.

TBH it does not seem overly urgent to add those tests for the HTTPS han=
dling. From a cursory look it seems that neither `transport_helper_init=
()` nor any code in `remote-curl.c` parses the "<user@password>" part o=
f the URL, or for that matter puts restrictions on it. The issue I link=
ed to was with a cURL that was compiled without support for the particu=
lar authentication method configured for the credential helper.

So I fear that testing the KERBEROS support would be the duty of an int=
egration test (which we do not have so far) rather than a unit test.

Ciao,
Dscho
