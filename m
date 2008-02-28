From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] http-push: Avoid calling setup_git_directory() twice
Date: Thu, 28 Feb 2008 10:26:03 +0700
Message-ID: <fcaeb9bf0802271926icf626d9s5dd762ce56d7a5a0@mail.gmail.com>
References: <cover.1204130175.git.pclouds@gmail.com>
	 <20080227163918.GA28071@laptop>
	 <7vd4qhnbui.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 04:26:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUZPx-0004XZ-Tz
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 04:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYB1D0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 22:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbYB1D0H
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 22:26:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:42832 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYB1D0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 22:26:06 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2518203fga.17
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 19:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6hWMrNCa+xbAVqDfx1lLYeZojsmUfwlX5ATrgS5upiI=;
        b=TzDx2Bv60fp90e9qfP/yJwtyKLD5RDyf/RWWYrslMmGJnv5Bz1QGe8mLwFK+vU2KbIjVc2KKfJjxwbkB6CaEQRIQ5SGmjiWVt0HNrSyQBxXJdn3ppPH+aum2iqmvh0Jm55DzkDoHWyMtP5xugX2d4zYmWX0V00H5JlVwhifk/cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DiG4lUcqQ4JwQ3nHZ19aZQ75Jm2M9kX3PUvsRDU9OGX4jWp689DmC2Agezk5b6op2Z6hko0beO+LD6JC4rjF+Hx4nRvEHRP2phMqcJ1Mo5XgyYA3GgRmNsFm5YnKbzsp5HQQEsLo7TbdFWLjN5QsWjAV6ER3wcFUPzlqI0NwZ9A=
Received: by 10.86.100.7 with SMTP id x7mr7218634fgb.41.1204169164022;
        Wed, 27 Feb 2008 19:26:04 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Wed, 27 Feb 2008 19:26:03 -0800 (PST)
In-Reply-To: <7vd4qhnbui.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75344>

T24gVGh1LCBGZWIgMjgsIDIwMDggYXQgNzo1MCBBTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJA
cG9ib3guY29tPiB3cm90ZToKPiBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IDxwY2xvdWRzQGdt
YWlsLmNvbT4gd3JpdGVzOgo+Cj4gID4gU2lnbmVkLW9mZi1ieTogTmd1eeG7hW4gVGjDoWkgTmfh
u41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+Cj4gID4gLS0tCj4gID4gIGh0dHAtcHVzaC5jIHwg
ICAgNCArKy0tCj4gID4gIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Cj4gIENhbGxpbmcgc2V0dXAgbW9yZSB0aGFuIG9uY2UgaXMgbm93IGFuIGVycm9y
PyAgSSBkbyBub3QgbWluZCB0aGUKPiAgbmV3IHJlc3RyaWN0aW9uIGJ1dCBpcyBpdCBkb2N1bWVu
dGVkIGNsZWFybHkgc29tZXdoZXJlPwo+CgpUaGlzIHBhcnQgd2FzIGxlZnQgZnJvbSBteSBhdHRl
bXB0IHRvIG1ha2Ugc2V0dXBfZ2l0X2RpcmVjdG9yeSgpCnJldHVybiBubyBwcmVmaXguIFRoZSBh
dHRlbXB0IGZhaWxlZCBidXQgSSB0aG91Z2h0IGl0IHdhcyBhIHN0aWxsIGdvb2QKY2xlYW51cC4g
Tm93IHRoaW5rIGl0IGFnYWluLiBJIGFncmVlIGNhbGxpbmcgc2V0dXBfZ2l0X2RpcmVjdG9yeSgp
CnR3aWNlIGlzIGFuIGVycm9yIGFzIGl0IG1heSBjYWxsIHNldHVwX3dvcmtfdHJlZShOVUxMKSB0
d2ljZS4gWWVzIGl0Cm5lZWRzIHRvIGJlIGRvY3VtZW50ZWQuIFdpbGwgYW1lbmQgdGhlIGRvY3Vt
ZW50YXRpb24gcGF0Y2guCi0tIApEdXkK
