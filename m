From: Jeenu Viswambharan <jeenuv@gmail.com>
Subject: git add -p refuses to apply an edited patch that otherwise applies
Date: Tue, 1 Mar 2016 20:04:39 +0000
Message-ID: <CAKCW0Y6GT1aKoCLtPaX+-Qk4u6qGdpAZ7RCFFb29qwteJzY1ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ec13a3b07a8052d02486b
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 21:05:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaqXm-0006oN-7X
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 21:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbcCAUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 15:05:10 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:34554 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcCAUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 15:05:09 -0500
Received: by mail-io0-f180.google.com with SMTP id b188so17661093iof.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=hhiYUS1jhBRgdO0rjD1KTPZSQWHPx9LKV3QGFTaMivw=;
        b=jctUXsfYNnEP8sDBDk6iF6DHiX0reKc0WW0fEi4ftl8qrG5P4JheDtDITf8T0kZ8Ma
         DzROTBZO8mhkDEVmye+MIAj2OCjoHhCP4u2WjlCH6yb/FFTAN0xpShrF8EDHkCxhHBay
         mknYA9gJQDhqN66P5aalp3Z2ahjB8qC8xJcL0hWFOWVYVZUxOi6TaGqe4VMOxbOxuvvl
         POmAo/SiO5AblI7EHUiT1DmVkp9sQizknImhKMd3reLheeFigrxtd3AbpdgwSJTEt03I
         MP5aL6NS00dEP+KBvrq3Be8bnn/b6WlsKrf2b6hsLvQfk5RD079FF8Lycr4ZoZIdIACh
         8v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hhiYUS1jhBRgdO0rjD1KTPZSQWHPx9LKV3QGFTaMivw=;
        b=KjPD5z3xlPUagsZRHQ8TfaQme+RNEI7yAa4NMu0QpevbIsTDcbT3phSFK6sTShSNh0
         UbcbBUiYH3VH2XgNv1Nk7J639KNIAqvW6Snvcu8wirNnDGk+sPFhQDxdgZJ/82dcXx1L
         u1tJV9FWYc6RNXtd2fAr1oIyeLIrqM7vH+NeF5MIhTwqR2n4f8wiOah/GTc7v7XO5fsa
         jmZEGIJAJ/93wXIIgfSoM8yNYUAyU3d+j6Se6tW4JSI1mf/wE66C3mD3nKFwzk0Lgl3W
         bxqGH6ZRSsavBYiEyNV/Dn/cTM9PT63EG01opmchRI+u/BQGWXatp2v9bFdb4PQZjldF
         OLkg==
X-Gm-Message-State: AG10YOTgyFiiuE4nirDE5Yk6shIuA8qKyxn7nNB26rrsimGJB/Q3/ntkew+8uVdkEdBkbjoVwIXZ2dfjnDpomw==
X-Received: by 10.107.130.167 with SMTP id m39mr31091073ioi.77.1456862708554;
 Tue, 01 Mar 2016 12:05:08 -0800 (PST)
Received: by 10.107.155.213 with HTTP; Tue, 1 Mar 2016 12:04:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288059>

--001a113ec13a3b07a8052d02486b
Content-Type: text/plain; charset=UTF-8

Hi,

As subject, the problem I'm facing is that, while doing an interactive
add, an edited patch fails to apply. The same patch content
successfully applies otherwise, with git apply.

To reproduce the problem:

  - Add the attached site.css to an empty git repository, and make an
initial commit
  - Apply the attached full.patch using 'patch -p1'
  - Do 'git add -p', and choose to edit the second hunk (i.e., s, n, e)
  - Edit the presented patch look like the content of attached
no_problem.patch; write and quit

The patch fails to apply.

To see git apply the patch normally, do 'git reset --hard'. Now apply
the no_problem.patch as

git apply --cached --recount < no_problem.patch

AFAIU, the command above is what the interactive script uses to apply
the patch to the index, but I'm confused as to why an edited patch
fails.

Any thoughts? FWIW, I'm using version 2.7.2.

-- 
Jeenu

--001a113ec13a3b07a8052d02486b
Content-Type: text/x-patch; charset=US-ASCII; name="full.patch"
Content-Disposition: attachment; filename="full.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_il9ucl0s0

ZGlmZiAtLWdpdCBhL3NpdGUuY3NzIGIvc2l0ZS5jc3MKaW5kZXggNjhhODhhZS4uMTQzODM4YyAx
MDA2NDQKLS0tIGEvc2l0ZS5jc3MKKysrIGIvc2l0ZS5jc3MKQEAgLTUzLDE0ICs1NywyMyBAQCBo
NCB7CiAgIG92ZXJmbG93LXk6IGF1dG87CiB9CiAKLXAgewotICBtYXJnaW46IDE1cHggMHB4Owor
LyogVGFibGUgb2YgY29udGVudHMgKi8KKyN0b2MgeworICBtYXJnaW46IDIwcHggMHB4IDIwcHgg
MHB4OworICBwYWRkaW5nLWxlZnQ6IDVweDsKIH0KLQotaDEsIGgyLCBoMywgaDQgeworI3RvYyBs
aSB7CisgIGRpc3BsYXk6IGJsb2NrOworfQorI3RvYyB1bCB7CisgIHBhZGRpbmctbGVmdDogMTBw
eDsKICAgbWFyZ2luOiA1cHggMHB4OwogfQogCitwIHsKKyAgbWFyZ2luOiAxNXB4IDBweDsKK30K
KwogLyoKICAqIEZvciBzY3JlZW4gd2lkZXIgdGhhbiA0ODBweCwgZml4IHRoZSBsZWZ0IGJhciwg
YW5kIHNldCAyNS83NSBzcGxpdC4KICAqIEFsc28gc2V0IGEgbWF4IHdpZHRoIG9mIDI1MHB4IGFu
ZCA3NTBweCBtYXgtd2lkdGggcmVzcGVjdGl2ZWx5Cg==
--001a113ec13a3b07a8052d02486b
Content-Type: text/x-patch; charset=US-ASCII; name="no_problem.patch"
Content-Disposition: attachment; filename="no_problem.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_il9ucl1o1

ZGlmZiAtLWdpdCBhL3NpdGUuY3NzIGIvc2l0ZS5jc3MKaW5kZXggNjhhODhhZS4uMTQzODM4YyAx
MDA2NDQKLS0tIGEvc2l0ZS5jc3MKKysrIGIvc2l0ZS5jc3MKQEAgLTU4LDYgKzYwLDkgQEAKIH0K
LQotaDEsIGgyLCBoMywgaDQgewotICBtYXJnaW46IDVweCAwcHg7Ci19CiAK
--001a113ec13a3b07a8052d02486b
Content-Type: text/css; charset=US-ASCII; name="site.css"
Content-Disposition: attachment; filename="site.css"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_il9ucl202

Ci8qIFN0eWxlcyB0byBiZSBhcHBsaWVkIGZvciBldmVyeSBvbmUgKi8KYm9keSB7CiAgcG9zaXRp
b246IHJlbGF0aXZlOwoKICBmb250LWZhbWlseTogIlBUIFNhbnMiLCBzYW5zLXNlcmlmOwogIGZv
bnQtc2l6ZTogMTZweDsKICB0ZXh0LXJlbmRlcmluZzogb3B0aW1pemVMZWdpYmlsaXR5OwoKICBs
aW5lLWhlaWdodDogMS40ZW07CiAgd29yZC1zcGFjaW5nOiAwLjA1ZW07CgogIGJveC1zaXppbmc6
IGJvcmRlci1ib3g7CgogIG1hcmdpbjogMHB4OwogIHBhZGRpbmc6IDBweDsKCiAgY29sb3I6ICMz
MzM7Cn0KCi8qIFVzZSBwcm9ncmVzc2l2ZWx5IHNtYWxsZXIgaGVhZGluZ3MgKi8KaDEgewogIGZv
bnQtc2l6ZTogMmVtOwp9CmgyIHsKICBmb250LXNpemU6IDEuN2VtOwp9CmgzIHsKICBmb250LXNp
emU6IDEuNWVtOwp9Cmg0IHsKICBmb250LXNpemU6IDEuM2VtOwp9CgojbGVmdC1iYXIsICNtYWlu
IHsKICAvKiBVc2UgYm9yZGVyIGJveCAqLwogIGJveC1zaXppbmc6IGJvcmRlci1ib3g7CgogIC8q
IFVzZSA1cHggcGFkZGluZyBvdmVyYWxsOyBhIGxpdHRsZSBtb3JlIG9uIHRoZSBsZWZ0ICovCiAg
cGFkZGluZzogNXB4OwogIHBhZGRpbmctbGVmdDogMTBweDsKfQoKI2xlZnQtYmFyIHsKICAvKiBV
c2UgYSBzbWFsbGVyIGZvbnQgKi8KICBmb250LXNpemU6IDAuOWVtOwoKICAvKiBFeHRyYSBwYWRk
aW5nIHRvIHJpZ2h0ICovCiAgcGFkZGluZy1yaWdodDogMTBweDsKCiAgLyogRml4IGhlaWdodCBh
dCAxMDAlIHNvIHRoYXQgd2UgZ2V0IGEgc2Nyb2xsYmFyICovCiAgbWF4LWhlaWdodDogMTAwJTsK
ICBvdmVyZmxvdy15OiBhdXRvOwp9CgpwIHsKICBtYXJnaW46IDE1cHggMHB4Owp9CgpoMSwgaDIs
IGgzLCBoNCB7CiAgbWFyZ2luOiA1cHggMHB4Owp9CgovKgogKiBGb3Igc2NyZWVuIHdpZGVyIHRo
YW4gNDgwcHgsIGZpeCB0aGUgbGVmdCBiYXIsIGFuZCBzZXQgMjUvNzUgc3BsaXQuCiAqIEFsc28g
c2V0IGEgbWF4IHdpZHRoIG9mIDI1MHB4IGFuZCA3NTBweCBtYXgtd2lkdGggcmVzcGVjdGl2ZWx5
CiAqLwo=
--001a113ec13a3b07a8052d02486b--
