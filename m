From: "Juan J. Martinez" <juan@memset.com>
Subject: Gitweb error: XML Parsing Error: not well-formed
Date: Fri, 20 Feb 2015 15:17:55 +0000
Organization: Memset Ltd
Message-ID: <54E75023.7030701@memset.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 16:24:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOpRE-000611-FH
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 16:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbbBTPYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 10:24:16 -0500
Received: from mail.memset.com ([37.128.131.35]:36755 "EHLO mail.memset.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754958AbbBTPYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 10:24:15 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2015 10:24:15 EST
Received: from [10.87.4.15] (support.memset.com [5.153.255.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.memset.com (Postfix) with ESMTPSA id B1F334D4039
	for <git@vger.kernel.org>; Fri, 20 Feb 2015 15:17:55 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264169>

Hi,

I'm experiencing a problem with gitweb and some utf-8 bits like =C2=A3 =
(the
pound sign) when showing diffs.

Example (Firefox's output):

XML Parsing Error: not well-formed Location:
https://hostname/gitweb?p=3Dredacted.git;a=3Dcommitdiff;h=3D16ae27d6b03=
0949772b298c6e2935a09c48169a7
Line Number 913, Column 492:<div class=3D"diff chunk_header"><span
class=3D"chunk_info">@@ <a class=3D"list"
href=3D"/gitweb?p=3Dredacted.git;a=3Dblob;f=3Dredacted/redacted.py;h=3D=
ce79b086288b96e6dd25d0f0bfb5b5018cca6fe0#l1043">-1043,7</a>
<a class=3D"list"
href=3D"/gitweb?p=3Dredacted.git;a=3Dblob;f=3Dredacted/redacted.py;h=3D=
774c74b703a7d211fe19433236d1745ac7d7697c;hb=3D16ae27d6b030949772b298c6e=
2935a09c48169a7#l1044">+1044,7</a>
@@</span><span
class=3D"section">&nbsp;outstanding&nbsp;amount&nbsp;is&nbsp;=EF=BF=BF1=
0.00.</span></div>

That should be "=C2=A310.00".

This is with latest gitweb  code
(sha:f3f407747c1cce420ae4b4857c4a6806efe38680) and perl v5.10.1.

The problem seems to be in gitweb.perl around line 1543.

Looks like utf8::is_utf8 returns false, and the conversion "in place"
with utf8::decode doesn't seem to work (although it returns success,
=46irefox doesn't like it).

As a workaround I removed the "|| utf8::decode($str)" on the condition
and the error is gone, although I'm not sure about the consequences of
doing that (I guess it returns part of the content in the fallback
encoding; latin1 in this case).

Regards,

Juan

--=20
Juan J. Martinez
Development Manager, MEMSET

mail: juan@memset.com
 web: http://www.memset.com/

Memset Ltd., registration number 4504980.
Building 87, Dunsfold Park, Stovolds Hill, Cranleigh, Surrey GU6 8TB, U=
K.
