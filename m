From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 16:34:58 -0400
Message-ID: <76718490904051334p67e34ee5t89e73430a311bff3@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
	 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
	 <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
	 <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:41:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZ56-00041j-EY
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652AbZDEUfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbZDEUfC
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:35:02 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:37048 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZDEUfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:35:00 -0400
Received: by gxk4 with SMTP id 4so4071978gxk.13
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 13:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pNkBH3gALI5MFoAh8LCLxVUcr12u+KDBtzmidc0doQ0=;
        b=ggZPmZDHcWxcbdrgZAOHB709gBGTPFvAaFKJxOcs9dVJa//cvAAeshtJh3w1JWjNOL
         +a2wVx/UaooqjtJte3ruYZjugxHx5iP1ELZpbXyNNYYvqQWOYgMpNZuUivR2CXW+gJQS
         P0UgtOp2KofVtR+0zgDQAW8TAaWB9CQfhahvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ehfX33fXTfgt3l01FlFRji0h/ALgDaNe9YzzKbdiATeCHphSxxf9vuW79Sqb2/emGs
         nYGMiH9zioJttYP+/KV/uwceBSFqp4c5676Xh1N0qF0MQuWyuq6aKbZMsghzo9J6FfUX
         SzfpXU0Ya6lGh3oLvdP7o7R/u18BM9QPVryMw=
Received: by 10.150.122.21 with SMTP id u21mr5559129ybc.20.1238963698543; Sun, 
	05 Apr 2009 13:34:58 -0700 (PDT)
In-Reply-To: <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115702>

On Sun, Apr 5, 2009 at 3:31 PM, Reece Dunn <msclrhd@googlemail.com> wrote:
> 2009/4/5 Felipe Contreras <felipe.contreras@gmail.com>:
>> On Sun, Apr 5, 2009 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> U3ZlcnJlIFJhYmJlbGllciA8c3JhYmJlbGllckBnbWFpbC5jb20+IHdyaXRlczoNCg0KPiBPbiBT
>>> YXQsIEFwciA0LCAyMDA5IGF0IDIyOjU5LCBDaHJpc3RpYW4gQ291ZGVyIDxjaHJpc2Nvb2xAdHV4
>>> ZmFtaWx5Lm9yZz4gd3JvdGU6DQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
>>> IMKgIMKgIMKgIMKgIGlmIChsbyA8PSBtaSAmJiBtaSA8IGhpKQ0KPj4gKyDCoCDCoCDCoCDCoCDC
>>> oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsNCj4+ICsg
>>> wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJvb3BzIik7
>>> DQo+DQo+IFRoYXQncyBnb2luZyB0byBiZSBhbiBvZmZpY2lhbCBnaXQgZXJyb3IgbWVzc2FnZT8g
>>> V2h5IG5vdCBtYWtlIGl0ICJUaGUNCg0KSXQncyBub3QgImdvaW5nIHRvIGJlIiwgYnV0ICJoYXMg
>>> YmVlbiBzbyBmb3IgdGhlIGxhc3QgdHdvIHllYXJzIHNpbmNlDQo1ZDIzZTEzIi4NCg0KSXQgaXMg
>>> YW4gYXNzZXJ0LCBhbmQgSSB0aGluayBQZWZmJ3MgZGllKCJCVUc6IC4uLiIpIHdvdWxkIGJlIGEg
>>> Z29vZCBpZGVhLg0K
>>
>> Huh?
>
> I think Junio is trying to learn base64 :)!

Junio's _original_ message was fine. The problem is that vger
(majordomo) appends the mailing list footer which technically corrupts
the message. Respectable MUA's can deal with the corruption, but
gmail's web-interface just shows the raw base64 (previously it used to
just show an empty message). I've filed a bug against gmail, but who
knows.

The other options are:

- fix majordomo on vger
- replace majordomo on vger with a decent MLM
- disable the mailing list footer
- deal with it if you're a gmail user

j.
