From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Wed, 14 Nov 2012 22:13:28 +0100
Message-ID: <50A40978.2060504@web.de>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de> <50A2F17D.4010907@gmail.com> <20121114190228.GA3860@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGE=?= =?UTF-8?B?dXNlbg==?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 22:13:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYkHL-0005fV-6K
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 22:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423338Ab2KNVNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 16:13:32 -0500
Received: from mout.web.de ([212.227.15.3]:53959 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253Ab2KNVNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 16:13:31 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MNc1S-1TfuCp1kMM-006is0; Wed, 14 Nov 2012 22:13:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <20121114190228.GA3860@sigill.intra.peff.net>
X-Provags-ID: V02:K0:uQlVr+JFr4vdia5kZKa7yWaJeaJ/KFm/e1TVd1AsBRc
 TR73ZWRi86wD7n6Ynzz4WEYbVN6kYtRtE4mNwLCEybLtLOZJgr
 m1mqLNKNYfyk+FY+bxJEPf121YtVxS0E4/lGNd1vBlkmqLhr7r
 iIYB0E4v/oQj+m9t4ZE3D3eZfHnC7RfNZ/fImURQiH0QtgwYZQ
 m3SnAOHab4vL+4j+0A8hA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209753>

On 14.11.12 20:02, Jeff King wrote:
> On Tue, Nov 13, 2012 at 08:18:53PM -0500, Mark Levedahl wrote:
>=20
>> On 11/13/2012 03:45 PM, Torsten B=C3=B6gershausen wrote:
>>>> * ml/cygwin-mingw-headers (2012-11-12) 1 commit
>>>>  - Update cygwin.c for new mingw-64 win32 api headers
>>>>
>>>>  Make git work on newer cygwin.
>>>>
>>>>  Will merge to 'next'.
>>> (Sorry for late answer, I managed to test the original patch minute=
s before Peff merged it to pu)
>>> (And thanks for maintaining git)
>>>
>>> Is everybody using cygwin happy with this?
>>>
>>> I managed to compile on a fresh installed cygwin,
>>> but failed to compile under 1.7.7, see below.
>>> Is there a way we can achieve to compile git both under "old" and "=
new" cygwin 1.7 ?
>>> Or is this not worth the effort?
>>>
>> I found no version info defined that could be used to automatically
>> switch between the old and current headers. You can always
>>
>>     make V15_MINGW_HEADERS=3D1 ...
>>
>> to force using the old set if you do not wish to update your install=
ation.
>=20
> Should we keep the code change, then, but not flip the default (i.e.,
> make people on the newer version opt into it)? I am not clear on how
> common the newer include system is. Of course, auto-detecting would b=
e
> the ideal.
>=20
> -Peff
There are a couple of things which we may want consider:
a) the name V15_MINGW_HEADERS:
  It indicates that this is true for Version 1.5 (of what?)
  If I assume Cygwin version 1.5 , then this name is confusing.
  Even cygwin versions like 1.7.7 use the same (or similar) include fil=
es as 1.5
  A better name could be CYGWIN_USE_MINGW_HEADERS (or the like) and to =
revert the logic.

b) Autodetection:
  (Just loud thinking), running=20
$grep mingw /usr/include/w32api/winsock2.h
 * This file is part of the mingw-w64 runtime package.
#include <_mingw_unicode.h>

on cygwin 1.7.17 indicates that we can use grep in the Makefile to auto=
detect the "mingw headers"

Something like this in Makefile:
+ifeq ($(shell grep mingw /usr/include/w32api/winsock2.h />/dev/null 2>=
/dev/null && echo y),y)
+	CYGWIN_USE_MINGW_HEADERS=3DYesPlease
+endif

c) I'm not sure if we want to change cygwin.c or git-compat-util.h for =
this.

I can prepare a proper patch within the next couple of days

/Torsten







=20
