From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 20:31:06 +0100
Message-ID: <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
	 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
	 <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:33:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqY5I-00056a-7D
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbZDETbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbZDETbL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:31:11 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:60224 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbZDETbK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 15:31:10 -0400
Received: by bwz17 with SMTP id 17so1604682bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TJBaMLm1tFiCXwr5mKo0DLXj6DwzL1PMFNNrliz8rOs=;
        b=Io6fL351sHMqZmnCymnojH6sfpBBBfya39BecKJMdOZSH+CIqFev5nPNpUck8nTYbz
         T77qPpLsGoWWKf63Fs/VxxLpxc4hbEnd5R0ioDuis4f8S3pjNKH0ZN4jewvPnlUiQaqJ
         udLcoi/gCbMS8gKTs2YPe//Mes0tkcPsHXRi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vw4X7plhaT4woPQTzOsh/WZVRufLgtaROfUVFFSF7/aRXJByrdk8BSQRT22acSxcxG
         SLpxkUI/iwK/cDx4sZU3cmLGwgn/sf5awNMK0lOv9btZhkqj5JhtvW+JDEuxqOZ5o0QQ
         RAc/0wsL+8hMyJ8m+Xsth1lJNosHZaXU9KzKY=
Received: by 10.239.162.74 with SMTP id k10mr78972hbd.42.1238959866589; Sun, 
	05 Apr 2009 12:31:06 -0700 (PDT)
In-Reply-To: <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115686>

2009/4/5 Felipe Contreras <felipe.contreras@gmail.com>:
> On Sun, Apr 5, 2009 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> U3ZlcnJlIFJhYmJlbGllciA8c3JhYmJlbGllckBnbWFpbC5jb20+IHdyaXRlczoNCg0K=
PiBPbiBT
>> YXQsIEFwciA0LCAyMDA5IGF0IDIyOjU5LCBDaHJpc3RpYW4gQ291ZGVyIDxjaHJpc2Nv=
b2xAdHV4
>> ZmFtaWx5Lm9yZz4gd3JvdGU6DQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg=
IMKgIMKg
>> IMKgIMKgIMKgIMKgIGlmIChsbyA8PSBtaSAmJiBtaSA8IGhpKQ0KPj4gKyDCoCDCoCDC=
oCDCoCDC
>> oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsN=
Cj4+ICsg
>> wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJv=
b3BzIik7
>> DQo+DQo+IFRoYXQncyBnb2luZyB0byBiZSBhbiBvZmZpY2lhbCBnaXQgZXJyb3IgbWVz=
c2FnZT8g
>> V2h5IG5vdCBtYWtlIGl0ICJUaGUNCg0KSXQncyBub3QgImdvaW5nIHRvIGJlIiwgYnV0=
ICJoYXMg
>> YmVlbiBzbyBmb3IgdGhlIGxhc3QgdHdvIHllYXJzIHNpbmNlDQo1ZDIzZTEzIi4NCg0K=
SXQgaXMg
>> YW4gYXNzZXJ0LCBhbmQgSSB0aGluayBQZWZmJ3MgZGllKCJCVUc6IC4uLiIpIHdvdWxk=
IGJlIGEg
>> Z29vZCBpZGVhLg0K
>
> Huh?

I think Junio is trying to learn base64 :)!

This is what `base64 -d` gives:

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sat, Apr 4, 2009 at 22:59, Christian Couder <chriscool@tuxfamily.o=
rg> wrote:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lo=
 <=3D mi && mi < hi)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("o=
ops");
>
> That's going to be an official git error message? Why not make it "Th=
e

It's not "going to be", but "has been so for the last two years since
5d23e13".

It is an assert, and I think Peff's die("BUG: ...") would be a good ide=
a.
