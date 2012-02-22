From: =?ISO-8859-1?Q?Nelson_Ben=EDtez_Le=F3n?= <nbenitezl@gmail.com>
Subject: [PATCH] Improve http proxy support
Date: Wed, 22 Feb 2012 15:04:36 +0100
Message-ID: <CAAUd640GaLz4TGs_Lz6KbSFK0VcEVxGfO6PpSCdhch+fYwVovw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec555566c3a7f4804b98e0369
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 15:05:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Coa-0005LH-JI
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 15:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab2BVOE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 09:04:59 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47254 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab2BVOE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 09:04:58 -0500
Received: by bkcjm19 with SMTP id jm19so69213bkc.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 06:04:57 -0800 (PST)
Received-SPF: pass (google.com: domain of nbenitezl@gmail.com designates 10.112.29.6 as permitted sender) client-ip=10.112.29.6;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nbenitezl@gmail.com designates 10.112.29.6 as permitted sender) smtp.mail=nbenitezl@gmail.com; dkim=pass header.i=nbenitezl@gmail.com
Received: from mr.google.com ([10.112.29.6])
        by 10.112.29.6 with SMTP id f6mr11550378lbh.69.1329919497659 (num_hops = 1);
        Wed, 22 Feb 2012 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=RLGE1Ld4iPP656XX+7JuGtmY2fMuqpR1Lj33LjUaqvM=;
        b=dGp9OZxeVSALShjjrSsZLDWRVjwICL7IuWKJR+xNUDyyTH1dMyoo9Nr90zhYkqDAfG
         o4yzRr2Aeh5Qx3wdKCBWGtOvjhURah/+ZLq9a4RHcqw43T9/I+mOhHO37ohNyHDtJdVu
         BIBLn60WSlv1J4Gwygf7X0xyJDESVjeWMnOxY=
Received: by 10.112.29.6 with SMTP id f6mr9736038lbh.69.1329919497502; Wed, 22
 Feb 2012 06:04:57 -0800 (PST)
Received: by 10.152.114.74 with HTTP; Wed, 22 Feb 2012 06:04:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191256>

--bcaec555566c3a7f4804b98e0369
Content-Type: text/plain; charset=ISO-8859-1

Hi, my initial motivation for this patch was to add NTLM proxy
authentication so I could 'git clone' from inside my employers
network, but apart from doing that, I also added two more features,
so, this patch adds the following improvements to the http proxy
support:

- Support NTLM proxy authentication (as well as other authentication
methods) by setting CURLOPT_PROXYAUTH[1] to CURLAUTH_ANY.

- Look up environment vars http_proxy and HTTP_PROXY in case git
http.proxy config option is not set. This supports system wide proxy
support in terminals.

- Support proxy urls with username but without a password, in which
case we interactively ask for the password (as it's already done in
http auth code). This makes possible to not have the password written
down in git config files or in env vars.

Thanks!

[1] http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTPROXYAUTH

--bcaec555566c3a7f4804b98e0369
Content-Type: application/octet-stream; name="gitproxyauthv2.patch"
Content-Disposition: attachment; filename="gitproxyauthv2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gyyfk58z0

LS0tIGh0dHAuYwkyMDEyLTAxLTE5IDAxOjE5OjIyLjAwMDAwMDAwMCArMDEwMAorKysgaHR0cC5t
b2QyLmMJMjAxMi0wMi0yMiAxNDo0NDoxMS43Mjc3NzMwMzggKzAxMDAKQEAgLTI5OSw4ICsyOTks
NTQgQEAKIAlpZiAoY3VybF9mdHBfbm9fZXBzdikKIAkJY3VybF9lYXN5X3NldG9wdChyZXN1bHQs
IENVUkxPUFRfRlRQX1VTRV9FUFNWLCAwKTsKIAotCWlmIChjdXJsX2h0dHBfcHJveHkpCi0JCWN1
cmxfZWFzeV9zZXRvcHQocmVzdWx0LCBDVVJMT1BUX1BST1hZLCBjdXJsX2h0dHBfcHJveHkpOwor
CWlmICghY3VybF9odHRwX3Byb3h5KSB7CisJCWNvbnN0IGNoYXIgKmVudl9wcm94eTsKKwkJZW52
X3Byb3h5ID0gZ2V0ZW52KCJIVFRQX1BST1hZIik7CisJCWlmICghZW52X3Byb3h5KSB7CisJCQll
bnZfcHJveHkgPSBnZXRlbnYoImh0dHBfcHJveHkiKTsKKwkJfQorCQlpZiAoZW52X3Byb3h5KSB7
CisJCQljdXJsX2h0dHBfcHJveHkgPSB4c3RyZHVwKGVudl9wcm94eSk7CisJCX0KKwl9CisJaWYg
KGN1cmxfaHR0cF9wcm94eSkgeworCQljaGFyICphdCwgKmNvbG9uLCAqcHJveHl1c2VyOworCQlj
b25zdCBjaGFyICpjcDsKKwkJY3AgPSBzdHJzdHIoY3VybF9odHRwX3Byb3h5LCAiOi8vIik7CisJ
CWlmIChjcCA9PSBOVUxMKSB7CisJCQljcCA9IGN1cmxfaHR0cF9wcm94eTsKKwkJfSBlbHNlIHsK
KwkJCWNwICs9IDM7CisJCX0KKwkJYXQgPSBzdHJjaHIoY3AsICdAJyk7CisJCWNvbG9uID0gc3Ry
Y2hyKGNwLCAnOicpOworCQlpZiAoYXQgJiYgKCFjb2xvbiB8fCBhdCA8IGNvbG9uKSkgeworCQkJ
LyogcHJveHkgc3RyaW5nIGhhcyB1c2VybmFtZSBidXQgbm8gcGFzc3dvcmQsIGFzayBmb3IgcGFz
c3dvcmQgKi8KKwkJCWNoYXIgKmFza19zdHIsICpwcm94eXVzZXIsICpwcm94eXBhc3M7CisJCQlp
bnQgbGVuOworCQkJc3RydWN0IHN0cmJ1ZiBwYnVmID0gU1RSQlVGX0lOSVQ7CisJCQlsZW4gPSBh
dCAtIGNwOworCQkJcHJveHl1c2VyID0geG1hbGxvYyhsZW4gKyAxKTsKKwkJCW1lbWNweShwcm94
eXVzZXIsIGNwLCBsZW4pOworCQkJcHJveHl1c2VyW2xlbl0gPSAnXDAnOworCQkJCisJCQlzdHJi
dWZfYWRkZigmcGJ1ZiwgIkVudGVyIHBhc3N3b3JkIGZvciBwcm94eSAlcy4uLiIsIGF0KzEpOwor
CQkJYXNrX3N0ciA9IHN0cmJ1Zl9kZXRhY2goJnBidWYsIE5VTEwpOworCQkJcHJveHlwYXNzID0g
eHN0cmR1cChnaXRfZ2V0cGFzcyhhc2tfc3RyKSk7CisJCQkKKwkJCXN0cmJ1Zl9pbnNlcnQoJnBi
dWYsIDAsIGN1cmxfaHR0cF9wcm94eSwgY3AgLSBjdXJsX2h0dHBfcHJveHkpOworCQkJc3RyYnVm
X2FkZGYoJnBidWYsICIlczolcyIsIHByb3h5dXNlciwgcHJveHlwYXNzKTsKKwkJCXN0cmJ1Zl9h
ZGQoJnBidWYsIGF0LCBzdHJsZW4oYXQpKTsKKwkJCWN1cmxfZWFzeV9zZXRvcHQocmVzdWx0LCBD
VVJMT1BUX1BST1hZLCBzdHJidWZfZGV0YWNoKCZwYnVmLCBOVUxMKSk7CisJCQkKKwkJCWZyZWUo
YXNrX3N0cik7CisJCQlmcmVlKHByb3h5dXNlcik7CisJCQlmcmVlKHByb3h5cGFzcyk7CisJCX0g
ZWxzZSB7CisJCQljdXJsX2Vhc3lfc2V0b3B0KHJlc3VsdCwgQ1VSTE9QVF9QUk9YWSwgY3VybF9o
dHRwX3Byb3h5KTsKKwkJfQorCQljdXJsX2Vhc3lfc2V0b3B0KHJlc3VsdCwgQ1VSTE9QVF9QUk9Y
WUFVVEgsIENVUkxBVVRIX0FOWSk7CisJfQogCiAJcmV0dXJuIHJlc3VsdDsKIH0K
--bcaec555566c3a7f4804b98e0369--
