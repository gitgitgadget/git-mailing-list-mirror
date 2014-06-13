From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] blame: simplify prepare_lines()
Date: Fri, 13 Jun 2014 23:33:37 +0200
Message-ID: <539B6E31.1080901@web.de>
References: <539B569F.1090800@web.de> <539B5713.10300@web.de> <20140613211339.GL8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Kastrup <dak@gnu.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvZ6x-0007rX-HL
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbaFMVeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 17:34:07 -0400
Received: from mout.web.de ([212.227.17.12]:56133 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaFMVeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:34:06 -0400
Received: from [192.168.178.27] ([79.253.165.171]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0McnqH-1XCoyW0Vur-00HuTx; Fri, 13 Jun 2014 23:33:53
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140613211339.GL8557@google.com>
X-Provags-ID: V03:K0:tI/hga7KcoYC2WybVGVUW1wHqL69D/rPRbVWQ6IlrqNCkwkejqq
 CRHwpCEg8iQO+tM5A/zKxeeIt0VZWLFvEmO0+wTZj1D82bx/9BkdxHt6tCztXItJP3ZhtpC
 l/XOTRMrVLYXY6GgQdBYqjhGcsTI91g4YKyX8xhyoExh0JTp+udOWMxDvQYZkTlCRB5jMWZ
 VOzMd8Hu7mmJJazQV0IkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251640>

Am 13.06.2014 23:13, schrieb Jonathan Nieder:
> Ren=E9 Scharfe wrote:
>
>> -	if (incomplete)
>> -		*lineno++ =3D len;
>> +	*lineno =3D len;
>>
>> -	sb->num_lines =3D num + incomplete;
>> +	sb->num_lines =3D num;
>
> This will always treat whatever comes after the last newline as an
> incomplete line, even if it has zero length.  Is that safe?  (Not a
> rhetorical question --- I haven't looked carefully at the caller.)

There is no need to look at the caller -- the contents of the lineno=20
array is not (intended to be) changed by the patch.

The original code is:

	p =3D memchr(p, '\n', end - p);
	if (p) {
		p++;
		*lineno++ =3D p - buf;
		continue;
	}

Suppose there is no incomplete line.  For the last EOL of a buffer, p=20
points to buf[len - 1] after the memchr call.  Then it is incremented.=20
Then buf + len - buf is written into the last lineno member -- same as=20
after the patch.

Makes sense?

Ren=E9
