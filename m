From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Define a version of lstat(2) with posix semantics
Date: Thu, 19 Mar 2009 11:27:12 +0100
Message-ID: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e644cfd644d3bb0465763eec
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	layer <layer@known.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFVT-0000WL-FE
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbZCSK1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZCSK1Q
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:27:16 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:28619 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbZCSK1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:27:14 -0400
Received: by yx-out-2324.google.com with SMTP id 31so457633yxl.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=/Tu3PUjWEz1GSI/swBlhMLQXQbJyXg6lhcsh+YVzxZI=;
        b=feoOf39gZMg0u9irI2OGksCsYzTHp/gFeiAtiq17qWMMv3B0Dr4RHyWOq+ZGJsrd20
         9LxZ1U69RN0lddIO4J4ZP/9bXg37LEqdWX30XaK/QcLVxb72sVHqClbQDWkcysVO8ecp
         iiiiuvS4TzKlJ+U6WN4e7TFGWoE0MZkH/80XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=LdKrrPGz5dIAdajZKaWnU6a8Gug/DBCYcXbJNPa4lG0w6hjWMXi3EHpW3cjf7o5YIX
         4eQbIAVfRGGsL4JqVwldcdQDXAJLGR+16YTuBN405afZchB0gyMM5X2UEwqKTDUvJ29p
         /f6Bv2PK5ZDxJ1YAPTvqpexHCFT55BspL9pBw=
Received: by 10.100.142.15 with SMTP id p15mr83447and.20.1237458432086; Thu, 
	19 Mar 2009 03:27:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113749>

--0016e644cfd644d3bb0465763eec
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

So that Cygwin port can continue work around its supporting
library and get access to its faked file attributes.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

2009/3/18 Junio C Hamano <gitster@pobox.com>:
> Yuck; that's a bit too ugly for generic code. =C2=A0Will there be other p=
laces
> that this needs to be used? =C2=A0If so, we'd probably need to encourage =
its
> use where appropriate, which is even uglier but we cannot avoid it...

You are damn right! I suggest providing posix_lstat, which has the posix
semantics regarding x-bit in st_mode. Maybe even posix_stat is need, too.

There are other places which went broken recently in this regard (lstat
cache patches?). Some will have to use this posix_lstat (the
copy_templates_1), the others have to get a careful core.filemode
handling (like check_remove in diff-lib.c, which isn't just about
removed files).

 git-compat-util.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

--0016e644cfd644d3bb0465763eec
Content-Type: application/octet-stream; 
	name="0001-Define-a-version-of-lstat-2-with-posix-semantics.diff"
Content-Disposition: attachment; 
	filename="0001-Define-a-version-of-lstat-2-with-posix-semantics.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fshanw0y0

RnJvbSBiMGUzNzEwZTdlNjBkOGY4MWJmMjUyZmY5OTg3ZTE3ZWNlNGEzYmUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDE5IE1hciAyMDA5IDExOjE3OjAxICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRGVmaW5l
IGEgdmVyc2lvbiBvZiBsc3RhdCgyKSB3aXRoIHBvc2l4IHNlbWFudGljcwoKU28gdGhhdCBDeWd3
aW4gcG9ydCBjYW4gY29udGludWUgd29yayBhcm91bmQgaXRzIHN1cHBvcnRpbmcKbGlicmFyeSBh
bmQgZ2V0IGFjY2VzcyB0byBpdHMgZmFrZWQgZmlsZSBhdHRyaWJ1dGVzLgoKU2lnbmVkLW9mZi1i
eTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBnaXQtY29tcGF0LXV0aWwu
aCB8ICAgIDUgKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1jb21wYXQtdXRpbC5oIGIvZ2l0LWNvbXBhdC11dGls
LmgKaW5kZXggMTkwNjI1My4uMjQwMWY4NCAxMDA2NDQKLS0tIGEvZ2l0LWNvbXBhdC11dGlsLmgK
KysrIGIvZ2l0LWNvbXBhdC11dGlsLmgKQEAgLTg1LDExICs4NSwxNiBAQAogI3VuZGVmIF9YT1BF
Tl9TT1VSQ0UKICNpbmNsdWRlIDxncnAuaD4KICNkZWZpbmUgX1hPUEVOX1NPVVJDRSA2MDAKK3N0
YXRpYyBpbmxpbmUgaW50IHBvc2l4X2xzdGF0KGNvbnN0IGNoYXIgKmZpbGVfbmFtZSwgc3RydWN0
IHN0YXQgKmJ1ZikKK3sKKwlyZXR1cm4gbHN0YXQoZmlsZV9uYW1lLCBidWYpOworfQogI2luY2x1
ZGUgImNvbXBhdC9jeWd3aW4uaCIKICNlbHNlCiAjdW5kZWYgX0FMTF9TT1VSQ0UgLyogQUlYIDUu
M0wgZGVmaW5lcyBhIHN0cnVjdCBsaXN0IHdpdGggX0FMTF9TT1VSQ0UuICovCiAjaW5jbHVkZSA8
Z3JwLmg+CiAjZGVmaW5lIF9BTExfU09VUkNFIDEKKyNkZWZpbmUgcG9zaXhfbHN0YXQgbHN0YXQK
ICNlbmRpZgogI2Vsc2UgCS8qIF9fTUlOR1czMl9fICovCiAvKiBwdWxsIGluIFdpbmRvd3MgY29t
cGF0aWJpbGl0eSBzdHVmZiAqLwotLSAKMS42LjIuMTQyLmdhZjhkYgoK
--0016e644cfd644d3bb0465763eec--
