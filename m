From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 05/10] http-push: Avoid calling setup_git_directory() twice
Date: Tue, 11 Mar 2008 21:54:44 +0700
Message-ID: <fcaeb9bf0803110754v7191d8fckbde0e1313e6a69ec@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103419.GA8957@laptop>
	 <alpine.LSU.1.00.0803111427400.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5t4-0005Kv-0c
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 15:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbYCKOys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYCKOys
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:54:48 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:16693 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbYCKOyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:54:47 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2291716fkz.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bdVS9vlHMfQT8okOhC0K5H+/mq8W/JBJCMmFOt9EXyE=;
        b=ACPPwzSZDSPPF7yetJWkMmFQLcEMq1J6NYRMwK+Nb4fRdCTOmMjyTDbKy48yLkSDLOkkHqbGATW18iYaD7/hYiMQiGBVFYir7UhmXpZJQAOd+uvQlYqiL31Yy/C8BXygyajZ5beP6RW7luruDAdeTwi3tFqPWtOHFMVfqXbYiuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wx+8MPznLS02SJGP2lqRrzsfNVkmtSfDCEmHUC1yz/K1DUVgQ8oo6SN4ANhbbiic2eCIs4XLN+JEOkII/G9YKuYCTttBlHHkrhpA3R6DsGgi3uFLricsmMfoFewq/brKkH1EKQDth7APKjZHbzlYt6ZWh6CjnwnWnmt8jk18P+s=
Received: by 10.82.152.16 with SMTP id z16mr16602053bud.36.1205247284671;
        Tue, 11 Mar 2008 07:54:44 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 07:54:44 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111427400.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76858>

T24gVHVlLCBNYXIgMTEsIDIwMDggYXQgODoyOCBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo8Sm9o
YW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gU3VuLCAyIE1h
ciAyMDA4LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+Cj4gID4KPiAgPiBTaWdu
ZWQtb2ZmLWJ5OiBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IDxwY2xvdWRzQGdtYWlsLmNvbT4K
Pgo+ICBUaGlzIGZpeCBpcyBjb21wbGV0ZWx5IGluZGVwZW5kZW50IG9mIHRoZSByZXN0IG9mIHlv
dXIgc2VyaWVzLgoKTm90IHJlYWxseS4gSXQgd291bGQgaGF2ZSBubyBpbXBhY3QgKGdvb2Qgb3Ig
YmFkKSBpZiBzZW50IHNlcGFyYXRlbHkuCkJ1dCBpdCBpcyByZXF1aXJlZCBieSB0aGUgc2VyaWVz
IChvdGhlcndpc2UgaXQgd291bGQgZGllKCkgdW5kZXIKY2VydGFpbiBjb25kaXRpb24gYmVjYXVz
ZSBwcmVmaXggY2Fubm90IGJlIHJlY29tcHV0ZWQgcHJvcGVybHkpLgotLSAKRHV5Cg==
