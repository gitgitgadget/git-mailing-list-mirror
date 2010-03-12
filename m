From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 06/16] Use git_config_early() instead of git_config() 
	during repo setup
Date: Fri, 12 Mar 2010 10:35:25 +0700
Message-ID: <fcaeb9bf1003111935k7719c2a8r3e925f8ad2c12276@mail.gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com> 
	<1268313754-28179-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 04:35:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpvfF-0002dG-CV
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 04:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab0CLDfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 22:35:47 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45362 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0CLDfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 22:35:46 -0500
Received: by pvb32 with SMTP id 32so305710pvb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 19:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=f411X5hPV6ZdkaINAMwFsJUNNqs2yzwkttMJQsMrXio=;
        b=E+FjsRqyA/4xQWxr9hrgdfspve+DwZymxFdK7Ai7IIRv6AQpth7X0yT6xRRydZt3x9
         0e9sYYi0xLaRYXwVVXemJ2DD5AULy9JO6ReYw2NZO5VWu8mkMC7AbhWi7FsS0G9U32dw
         gy5Uc1+PmsZ4YyJpz+UBDsMmz2g8kLpnI90vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=kP0Dkl0XuCnaeBrz2Qc02n4wJrkOSIpC+7YbOVtXt1Ktc3JK1PhOMKM5AlNBMEKWDi
         nP5olPoCuAFXXuAeKGBMVngPoo8S6vQSqFG1XdlQXEfEWfzcv/A7zAxT4c+oMvOAS+Et
         AcQq6gMIypaxKkZG8x/z7+u110MIAbySX/sKI=
Received: by 10.141.124.12 with SMTP id b12mr2426512rvn.55.1268364945813; Thu, 
	11 Mar 2010 19:35:45 -0800 (PST)
In-Reply-To: <1268313754-28179-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142011>

MjAxMC8zLzExIE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNAZ21haWwuY29tPjoK
PiBAQCAtNDExLDYgKzQyNSw4IEBAIHN0YXRpYyBjb25zdCBjaGFyICpzZXR1cF9naXRfZGlyZWN0
b3J5X2dlbnRseV8xKGludCAqbm9uZ2l0X29rKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaW5zaWRlX2dpdF9kaXIgPSAxOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKCF3b3JrX3RyZWVfZW52KQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaW5zaWRlX3dvcmtfdHJlZSA9IDA7Cj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoY2hlY2tfcmVwb3NpdG9yeV9mb3JtYXRfZ2VudGx5
KGdpdGZpbGVfZGlyLCBub25naXRfb2spKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIE5VTEw7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAob2Zmc2V0ICE9IGxlbikgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcm9vdF9sZW4gPSBvZmZzZXRfMXN0X2NvbXBvbmVudChj
d2QpOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY3dk
W29mZnNldCA+IHJvb3RfbGVuID8gb2Zmc2V0IDogcm9vdF9sZW5dID0gJ1wwJzsKClNvbWV0aGlu
ZyB3ZW50IHdyb25nIGluIHJlYmFzZXMgYW5kIGNvbmZsaWN0cy4gZ2l0ZmlsZV9kaXIgaW4gdGhl
CmFib3ZlIGNhbGwgc2hvdWxkIGJlIHJlcGxhY2VkIGJ5ICIuIgoKaWYgKGNoZWNrX3JlcG9zaXRv
cnlfZm9ybWF0X2dlbnRseSgiLiIsIG5vbmdpdF9vaykpCi0tIApEdXkK
