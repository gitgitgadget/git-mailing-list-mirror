From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 06 Dec 2011 15:54:13 +0100
Message-ID: <4EDE2C95.5040804@alum.mit.edu>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com> <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 06 15:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXwPX-0007ae-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 15:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933404Ab1LFOyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 09:54:18 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:43908 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933370Ab1LFOyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 09:54:18 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pB6EsDVa017109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Dec 2011 15:54:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186350>

On 12/06/2011 01:17 PM, Erik Faye-Lund wrote:
> 2011/12/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> Too deep delta chains can cause stack overflow in get_base_data(). S=
et
>> a hard limit so that index-pack does not run out of stack. Also stop
>> people from producing such a long delta chains using "pack-object
>> --depth=3D<too large>"
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  I used to make very long delta chains and triggered this in index-p=
ack.
>>  I did not care reporting because it's my fault anyway. Think again,
>>  index-pack is called at server side and a malicious client can
>>  trigger this. This patch does not improve the situation much, but a=
t
>>  least we won't get sigsegv at server side.
>=20
> Wouldn't it make more sense to make the limit a config option rather
> than a hard-coded value of 128 (which seems arbitrary to me)? After
> all, different platforms have different stack-limitations...

I'm confused: is the data only ever read by the same host that generate=
d
it?  Because if not, then the "creator" had better never be configured
to use a chain depth that the "reader" cannot handle.  This in turn
imply that there should be a common limit that is supported by all git
clients and is a documented part of the protocol.  (Or the code has to
be rewritten to use an explicit stack instead of recursion.)

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
