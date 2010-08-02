From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 07/16] upload-pack: support subtree pack
Date: Sun, 1 Aug 2010 22:27:02 -0600
Message-ID: <AANLkTi=jSFa0B9iSNZdEBOjDgtuECkOxOEcO2ujVeUwb@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 06:27:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfmcK-0000Vw-6D
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 06:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab0HBE1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 00:27:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65476 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab0HBE1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 00:27:03 -0400
Received: by wyb39 with SMTP id 39so2888338wyb.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 21:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fBmLQyDkBc6xCtkw/j6RxK3GKcGSrHm2dCaMn3WoIkg=;
        b=pj4OCww8qvyiAg+hShynaC4x9M3zx86DAwpKPS5ul1IWMqbZFUCZYBx+ZsWWUty7mZ
         4CmadjCQOTIIgavPaK3qp2wMC8ulqsENW+s54+GwtkUiwlCrLgT7xc4Hh3MAiwn4rFt3
         +TSk93ZJI7sohUN19F+vLchh6UWzrLBH8Kwus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=boe8/fKCqDqp7d5fIlfzb7v3G+7j+heWJ1NavgM/P8+R5R+YDQ/UOmBhf+p8UPoYpj
         6wtqP2lFtaSBghtezTupoVwPbvj71yfaNBND1zdYa8ycDyFl1oxVcPG1u6JoiLU+Zy4V
         03Gd73jkL1BFt4u+CN3uhzbA0qMcdjN82B3n4=
Received: by 10.216.35.85 with SMTP id t63mr2240103wea.56.1280723222461; Sun, 
	01 Aug 2010 21:27:02 -0700 (PDT)
Received: by 10.216.132.8 with HTTP; Sun, 1 Aug 2010 21:27:02 -0700 (PDT)
In-Reply-To: <1280593105-22015-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152391>

MjAxMC83LzMxIE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNAZ21haWwuY29tPjoK
PHNuaXA+Cj4gZGlmZiAtLWdpdCBhL3VwbG9hZC1wYWNrLmMgYi91cGxvYWQtcGFjay5jCj4gaW5k
ZXggZTQzMmU4My4uOWI2NzEwYSAxMDA2NDQKPiAtLS0gYS91cGxvYWQtcGFjay5jCj4gKysrIGIv
dXBsb2FkLXBhY2suYwo8c25pcD4KPiBAQCAtNTA1LDYgKzUwNSwyMCBAQCBzdGF0aWMgdm9pZCBy
ZWNlaXZlX25lZWRzKHZvaWQpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGVidWdfZmQp
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB3cml0ZV9pbl9mdWxsKGRlYnVn
X2ZkLCBsaW5lLCBsZW4pOwo+Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIXByZWZpeGNt
cChsaW5lLCAic3VidHJlZSAiKSkgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgaW50IGxlbjsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNoYXIgKnN1
YnRyZWU7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoY29yZV9zdWJ0
cmVlKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGll
KCJzb3JyeSwgb25seSBvbmUgc3VidHJlZSBzdXBwb3J0ZWQiKTsKCkknbSBub3Qgc3VyZSB1c2Vy
cyB3b3VsZCB1bmRlcnN0YW5kIHRoaXMgZXJyb3IgbWVzc2FnZTsgcGVyaGFwcwpzb21ldGhpbmcg
bW9yZSBsaWtlICJGZXRjaGluZy9jbG9uaW5nIGZyb20gYSBzdWJ0cmVlLXNwYXJzZSByZXBvc2l0
b3J5Cm5vdCBzdXBwb3J0ZWQiPwo=
