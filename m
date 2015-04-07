From: Marcio Almada <marcio.web2@gmail.com>
Subject: Bug: global bash variable leak on __gitcompappend
Date: Tue, 7 Apr 2015 05:42:23 -0300
Message-ID: <CAOsHV+vG9CfPTTj1AmvSU_fziFtmLCJ67QGAnV11p3y+FDCBnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0111b8faee5b9005131e6535
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 10:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfP5u-0007DT-45
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 10:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbbDGImp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 04:42:45 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35273 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbbDGImo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 04:42:44 -0400
Received: by ierf6 with SMTP id f6so40679750ier.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qoLxnzgQEXEgadnlDDnv71k5Vpeb+oFl9WobwJxOJm0=;
        b=ivDGlPO8nuAJmGc46wqxUcK9BYhd0q2Tev0BfJpkoaNtRKuM77wTn4OYBQgDO/7fSr
         yFv7yCqgyEdjg6roUtWtwe5gUqNC2AkNm4KGouRuMJjso6qM8gGNzU+RGtUOWXVTkAFH
         3YLn4E1MOfKoy4qOPl4vPFszkb0pgErKNYBzlPvbUe4w/NWGwHA1kgemEm4MBUFJf2ME
         Espb8aI1myhSTFLhXFsxkG5BSlcdlmGaINPi0mkKT5Okp8n5wX/ZGkWa0sNpIOUJuK8r
         46oYOIduuTNOZfzXmtKXsdtQt2mi6AMsHcshqM4ydGrhZfvHzgRltMOStj/jaotRpFqr
         2jfA==
X-Received: by 10.50.176.196 with SMTP id ck4mr1956007igc.40.1428396163613;
 Tue, 07 Apr 2015 01:42:43 -0700 (PDT)
Received: by 10.36.93.144 with HTTP; Tue, 7 Apr 2015 01:42:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266904>

--089e0111b8faee5b9005131e6535
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

This is how to reproduce the bug:

```
git checkout [tab-tab]
echo $x # outputs the name of the last branch on completion list
```

Or more directly:

```
__gitcompappend "something"
echo $x # outputs 'something'
```

No big deal, but it's annoying to know that `$x` is lurking.

Cheers,
M=C3=A1rcio Almada.

--089e0111b8faee5b9005131e6535
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-fix-global-bash-variable-leak-on-__gitcompappend.patch"
Content-Disposition: attachment; 
	filename="0001-fix-global-bash-variable-leak-on-__gitcompappend.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i8722x3o0

RnJvbSA5ZmY4NDkyNzJmODBmNWUyMWE2ODE5OTVlZDlhZWNmZmZjYWYyYTg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TT1DMz1BMXJjaW89MjBBbG1hZGE/PSA8bWFy
Y2lvM3dAZ21haWwuY29tPgpEYXRlOiBUdWUsIDcgQXByIDIwMTUgMDU6MTE6MzUgLTAzMDAKU3Vi
amVjdDogW1BBVENIXSBmaXggZ2xvYmFsIGJhc2ggdmFyaWFibGUgbGVhayBvbiBfX2dpdGNvbXBh
cHBlbmQKCi0tLQogY29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2ggfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaCBiL2NvbnRyaWIvY29t
cGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoCmluZGV4IGZiZTU5NzIuLjU5NDRjODIgMTAwNjQ0
Ci0tLSBhL2NvbnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoCisrKyBiL2NvbnRy
aWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoCkBAIC0xODYsNyArMTg2LDcgQEAgZmkK
IAogX19naXRjb21wYXBwZW5kICgpCiB7Ci0JbG9jYWwgaT0keyNDT01QUkVQTFlbQF19CisJbG9j
YWwgeCBpPSR7I0NPTVBSRVBMWVtAXX0KIAlmb3IgeCBpbiAkMTsgZG8KIAkJaWYgW1sgIiR4IiA9
PSAiJDMiKiBdXTsgdGhlbgogCQkJQ09NUFJFUExZW2krK109IiQyJHgkNCIKLS0gCjEuOS4zCgo=
--089e0111b8faee5b9005131e6535--
