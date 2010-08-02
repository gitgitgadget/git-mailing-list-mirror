From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/16] list-objects: limit traversing within the given 
	subtree if core.subtree is set
Date: Mon, 2 Aug 2010 16:51:53 +1000
Message-ID: <AANLkTi=B0fDy6u2zL_SV-HnYAzfOaAvWcFn_5deL_ZQq@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-3-git-send-email-pclouds@gmail.com>
	<AANLkTikZrD+RRMnae0OOPU_keuu97LditFZnekcpkrYZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 08:52:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfosT-0004wp-0E
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 08:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0HBGvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 02:51:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53272 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab0HBGvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 02:51:54 -0400
Received: by wyb39 with SMTP id 39so2957910wyb.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kQOZ2p5nXgZqvbNeowE03H2jaYERb3wXX3HA4VOOlW4=;
        b=CTXRII87mVhes6GHfdOQR5eTp2J45Eoyt5xogGwL1kSLrCk4eF/2T/wCsnn2wBxjnW
         FB3dlTjT2En1IY/u15Tfo4hqkeaR1fv4tMWjRjUiPwAVs24osZhnm8yxYuAW3MDiYZtY
         R2OCL39isGovbt2Nso7VNqDjqaYhubUbIHZ5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w7j0gWtZV8QgqRkRKDxsdASDHQuwE0lzv2pTZQKkrhk/G8oLbcpFOq0NX8n5kYixyE
         qLJIcH/EhUZVDRtrEBls+pTeIGCSZzjwlruq4cIgojd/GwRzXWieD4kJdy5LBh/pulKm
         7jOXKurqom+6eeOxoCPbjon2s7S0A5bWuNh6k=
Received: by 10.216.2.198 with SMTP id 48mr2310508wef.107.1280731913234; Sun, 
	01 Aug 2010 23:51:53 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Sun, 1 Aug 2010 23:51:53 -0700 (PDT)
In-Reply-To: <AANLkTikZrD+RRMnae0OOPU_keuu97LditFZnekcpkrYZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152397>

MjAxMC84LzIgRWxpamFoIE5ld3JlbiA8bmV3cmVuQGdtYWlsLmNvbT46Cj4+Cj4+IMKgIMKgIMKg
IMKgaWYgKCFyZXZzLT50cmVlX29iamVjdHMpCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
dXJuOwo+PiBAQCAtODIsMTMgKzg1LDIxIEBAIHN0YXRpYyB2b2lkIHByb2Nlc3NfdHJlZShzdHJ1
Y3QgcmV2X2luZm8gKnJldnMsCj4+IMKgIMKgIMKgIMKgbWUuZWxlbSA9IG5hbWU7Cj4+IMKgIMKg
IMKgIMKgbWUuZWxlbV9sZW4gPSBzdHJsZW4obmFtZSk7Cj4+Cj4+ICsgwqAgwqAgwqAgaWYgKHN1
YnRyZWUpIHsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzbGFzaCA9IHN0cmNocihzdWJ0cmVl
LCAnLycpOwo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN1YnRyZWVfbGVuID0gc2xhc2ggPyBz
bGFzaCAtIHN1YnRyZWUgOiBzdHJsZW4oc3VidHJlZSk7Cj4+ICsgwqAgwqAgwqAgfQo+PiArCj4+
IMKgIMKgIMKgIMKgaW5pdF90cmVlX2Rlc2MoJmRlc2MsIHRyZWUtPmJ1ZmZlciwgdHJlZS0+c2l6
ZSk7Cj4+Cj4+IMKgIMKgIMKgIMKgd2hpbGUgKHRyZWVfZW50cnkoJmRlc2MsICZlbnRyeSkpIHsK
Pj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoU19JU0RJUihlbnRyeS5tb2RlKSkKPj4gLSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcm9jZXNzX3RyZWUocmV2cywKPj4gLSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxvb2t1
cF90cmVlKGVudHJ5LnNoYTEpLAo+PiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc2hvdywgJm1lLCBlbnRyeS5wYXRoKTsKPj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBpZiAoU19JU0RJUihlbnRyeS5tb2RlKSkgewo+PiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICghc3VidHJlZSB8fCAhc3RybmNtcChlbnRyeS5wYXRo
LCBzdWJ0cmVlLCBzdWJ0cmVlX2xlbikpCj4KPiBPbmx5IG9uZSBzdWJkaXJlY3RvcnkgYWxsb3dl
ZD8gwqBXaGF0IGlmIHNvbWVvbmUgd2FudHMgYSBzcGFyc2UgY2xvbmUKPiBjb250YWluaW5nIHR3
byBvciBtb3JlIGRpcmVjdG9yaWVzPyDCoChBY3R1YWxseSwgdGhhdCdzIG5vdCBzbyBtdWNoIG9m
Cj4gYSAid2hhdCBpZiIgLS0gaXQncyBleGFjdGx5IHdoYXQgSSB3YW50IGluIGFib3V0IGhhbGYg
bXkgdXNlY2FzZXMgZm9yCj4gc3BhcnNlIGNsb25lcy4pCgpPbmUgaXMgc2ltcGxlci4gU28gb25l
IGZpcnN0LCBtdWx0aXBsZSBtYXkgY29tZSBsYXRlci4KCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJvY2Vzc190cmVlKHJldnMsCj4+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBsb29rdXBfdHJlZShlbnRyeS5zaGExKSwKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNob3csICZtZSwgZW50cnku
cGF0aCwKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHNsYXNoICYmIHNsYXNoWzFdID8gc2xhc2grMSA6IE5VTEwpOwo+
Cj4gSWYgSSByZWFkIGNvcnJlY3RseSwgc2xhc2ggd2lsbCBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQg
aGVyZSB3aGVuZXZlcgo+IHN1YnRyZWUgPT0gTlVMTC4KClllcy4gVGhhbmtzLiBXaWxsIGZpeC4K
LS0gCkR1eQo=
