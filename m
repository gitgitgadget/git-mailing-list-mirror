From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and 
	error-handling in send_message's sendmail code
Date: Sat, 18 Apr 2009 21:51:43 -0400
Message-ID: <76718490904181851g2701ce59x614ea60452b914ce@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 03:53:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvMDk-000541-9A
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 03:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZDSBvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 21:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbZDSBvp
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 21:51:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:25587 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZDSBvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 21:51:44 -0400
Received: by yx-out-2324.google.com with SMTP id 3so465039yxj.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FKjqzuw0R1Hqy516yIePzY/m+EL53FbaU7MVFUkz4pY=;
        b=kTePDWBzhqenmoT3Qppybjzku8cFv1VQhzfJVDNjsA70doJCcOk9I03PYcP0YSwqoZ
         F5qq/HlmfLJTcbRkrfudKNyHlXo7847tmzVGfYi7vI+Z+4x9pJeVPTKp+VN0gPXR6sJU
         S40t+m7LuwN4C3EIDmTwQ0nE751WaW8Vw/Dug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QmAc6VstHtRBd+dX4RQhkCgE2gL46Ljn61/xEdHcX+z65GmpcEduYvgKzuJtW1fsqg
         pNGMppr91Emde/vrBTI/PolSk6yD/L93BM/y/CYxzQdIubdCiAaZMaAS63au/2lSbCM7
         YU7m/fGXJU5f/haG3s1kvaGDBZRgf7oa9eUfY=
Received: by 10.150.153.7 with SMTP id a7mr275067ybe.164.1240105903617; Sat, 
	18 Apr 2009 18:51:43 -0700 (PDT)
In-Reply-To: <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116874>

T24gU2F0LCBBcHIgMTgsIDIwMDkgYXQgMTowMiBQTSwgTWljaGFlbCBXaXR0ZW4gPG1md2l0dGVu
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gZGlmZiAtLWdpdCBhL2dpdC1zZW5kLWVtYWlsLnBlcmwgYi9n
aXQtc2VuZC1lbWFpbC5wZXJsCj4gaW5kZXggZTJjNzk1NC4uMjcyN2M3NyAxMDA3NTUKPiAtLS0g
YS9naXQtc2VuZC1lbWFpbC5wZXJsCj4gKysrIGIvZ2l0LXNlbmQtZW1haWwucGVybAo+IEBAIC05
NjcsMTUgKzk2NywyMiBAQCBYLU1haWxlcjogZ2l0LXNlbmQtZW1haWwgJGdpdHZlcnNpb24KPiDC
oCDCoCDCoCDCoH0KPgo+IMKgIMKgIMKgIMKgaWYgKCRkcnlfcnVuKSB7Cj4gKwo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIyBXZSBkb24ndCB3YW50IHRvIHNlbmQgdGhlIGVtYWlsLgo+ICsKPiDC
oCDCoCDCoCDCoH0gZWxzaWYgKCRzbXRwX3NlcnZlcl9pc19hX2NvbW1hbmQpIHsKPiAtIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIG15ICRwaWQgPSBvcGVuIG15ICRzbSwgJ3wtJzsKPiAtIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGRlZmluZWQgJHBpZCBvciBkaWUgJCE7Cj4gLSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoISRwaWQpIHsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV4
ZWMoJHNtdHBfc2VydmVyLCBAc2VuZG1haWxfcGFyYW1ldGVycykgb3IgZGllICQhOwo+IC0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfQo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQgJHNtICIk
aGVhZGVyXG4kbWVzc2FnZSI7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbG9zZSAkc20gb3Ig
ZGllICQ/Owo+ICsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChteSAkcGlkID0gb3BlbiBteSAk
cGlwZSwgJ3wtJykKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8vIGRpZSAi
Q291bGQgbm90IGZvcmsgdG8gcnVuICckc210cF9zZXJ2ZXInOiAkIVxuIjsKCldoYXQgaXMgJy8v
JyBhYm91dD8KCmouCg==
