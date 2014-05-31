From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Sat, 31 May 2014 12:47:56 +0200
Message-ID: <5389B35C.8060308@alum.mit.edu>
References: <1401311055-480-2-git-send-email-dturner@twitter.com> <538658C0.8050001@alum.mit.edu> <1401320968.18134.98.camel@stross> <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com> <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com> <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com> <20140529234109.GA28683@sigill.intra.peff.net> <CACsJy8BgriBBWJ6ZzQS8S7p4SUB=bdZHdnUQsyN03g+vtApbxA@mail.gmail.com> <20140530000728.GC28683@sigill.intra.peff.net> <538853B5.1080308@alum.mit.edu> <20140530172944.GC25443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 31 12:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqgpn-00041B-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 12:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbaEaKsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 06:48:01 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55523 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754118AbaEaKsA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 May 2014 06:48:00 -0400
X-AuditID: 12074413-f79bc6d000000b9e-a9-5389b35f04e7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.21.02974.F53B9835; Sat, 31 May 2014 06:47:59 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97BB9.dip0.t-ipconnect.de [79.201.123.185])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4VAluW5025823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 31 May 2014 06:47:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140530172944.GC25443@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqBu/uTPYoOGohcWHK88ZLeZvOsFo
	0XWlm8miofcKs0X3lLeMFj9aepgd2Dx2zrrL7vGsdw+jx8VLyh4Xu58weyx4fp/d4/MmuQC2
	KG6bpMSSsuDM9Dx9uwTujCub1jIXbGapOPtqOUsD4z7mLkYODgkBE4nJO4K7GDmBTDGJC/fW
	s3UxcnEICVxmlPj/rZ8JwrnAJLFh2TlWkCpeAW2Jie/OsoE0swioSjRu4QUJswnoSizqaWYC
	CYsKBEn8OasIUS0ocXLmExYQW0RAVuL74Y2MIDazwDVGiQN/NUBsYQEzicuHNrFArFrPIvGt
	+y4TSIJTwFpi1fa9bBB3ikv0NAaBmMwC6hLr5wlBjJGX2P52DvMERsFZSLbNQqiahaRqASPz
	Kka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQOBDewbjrpNwhRgEORiUeXocZ
	HcFCrIllxZW5hxglOZiURHkTp3cGC/El5adUZiQWZ8QXleakFh9ilOBgVhLhlawDyvGmJFZW
	pRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHhlNwE1ChalpqdWpGXmlCCkmTg4
	QYZzSYkUp+alpBYllpZkxIMiN74YGLsgKR6gvSEg7bzFBYm5QFGI1lOMuhyn7hxrYxJiycvP
	S5US503fCFQkAFKUUZoHtwKW9F4xigN9LMxrCDKKB5gw4Sa9AlrCBLTkbRXYkpJEhJRUA+OW
	poxdrz9kOsx3m1gtm7BqbZXHq5tX1yfG307Vk4plYLzWnnB8iekVcd0Hj1xmyJzP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250505>

On 05/30/2014 07:29 PM, Jeff King wrote:
> On Fri, May 30, 2014 at 11:47:33AM +0200, Michael Haggerty wrote:
>> [...]
>> If we want to be robust to future changes to refname rules, we could add
>> a header flag like
>>
>>     # pack-refs with: peeled fully-peeled check-level=1.0
> [...]
> Yeah, I thought about mentioning something like that. But really, this
> just seems like a lot of complexity to solve the problem in a wrong way.

Yes, you are right.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
