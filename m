From: Phil Miller <mille121@illinois.edu>
Subject: [PATCH] (to improve gitosis support) CVS Server: Support reading base 
	and roots from environment
Date: Thu, 12 Nov 2009 11:25:36 -0600
Message-ID: <81f018ac0911120925w848594dt276735955681e8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d99d7e03b51304782fd645
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 12 18:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8dQq-0000Ta-FE
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbZKLRZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 12:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbZKLRZx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:25:53 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62601 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbZKLRZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 12:25:51 -0500
Received: by fxm21 with SMTP id 21so2490860fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=xmmMrxx0jBNl98GwQOv3Z6K8ybid+AkUTrTX4losrko=;
        b=f1H3FFjaEuWTgzib52NqE/4rP5tnazWeqoz+vIv5kdsRaTXnKCcpDzrxKS8c1+tX8D
         hcsWrQUAJ4Ix52iQ4OHmhLVLEFsaZQNgBHrhpttbhJeJ47Fb2lFj0n5bOSBR0+SdNmQa
         CMqTbvN1YFVxPNs1w+AyebLVFZR0c1JHEWjXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=ry3uxA4LEkidGfRCUV0c/v0xSVP7qt8KAvt/imHXgreoy+UlmD8A7pUkhBzARvwbBu
         sOA+FevOO+DmMg2Ov+XmSTQ8tiHmneeXMvyn1ofxAUvvNADnMvmvzXUykX2zjgIc8hAA
         MquLvCB07vwr22w+vVKmi/CD/unG/o2adKLD4=
Received: by 10.216.89.130 with SMTP id c2mr1065289wef.44.1258046756205; Thu, 
	12 Nov 2009 09:25:56 -0800 (PST)
X-Google-Sender-Auth: 1fdc4de8aac2a31f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132789>

--0016e6d99d7e03b51304782fd645
Content-Type: text/plain; charset=UTF-8

The Gitosis single-account Git/ssh hosting system runs git commands
through git-shell after confirming that the connecting user is
authorized to access the requested repository. This works well for
upload-pack and receive-pack, which take a repository argument through
git-shell. This doesn't work so well for `cvs server', which is passed
through literally, with no arguments. Allowing arguments risks
sneaking in `--export-all', so that restriction should be maintained.

Despite that, passing a list of repository roots is necessary for
per-user access control by the hosting software, and passing a base
path improves usability without weakening security. Thus,
git-cvsserver needs to come up with these values at runtime by some
other means. Since git-shell preserves the environment for other
purposes, the environment can carry these arguments as well.

Thus, modify git-cvsserver to read $GIT_CVSSERVER_{BASE_PATH,ROOTS} in
the absence of equivalent command line arguments.

Signed-off-by: Phil Miller <mille121@illinois.edu>

--0016e6d99d7e03b51304782fd645
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-CVS-Server-Support-reading-base-and-roots-from-envir.patch"
Content-Disposition: attachment; 
	filename="0001-CVS-Server-Support-reading-base-and-roots-from-envir.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1xsg1op0

RnJvbSBmNWM5MTFhYjhkN2YxN2QyNjc2ZmM1MjA1MzlmMGU4N2Y0Y2ZlMDE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsIE1pbGxlciA8bWlsbGUxMjFAaWxsaW5vaXMuZWR1PgpE
YXRlOiBXZWQsIDE0IE9jdCAyMDA5IDIzOjIwOjA5IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gQ1ZT
IFNlcnZlcjogU3VwcG9ydCByZWFkaW5nIGJhc2UgYW5kIHJvb3RzIGZyb20gZW52aXJvbm1lbnQK
ClRoZSBHaXRvc2lzIHNpbmdsZS1hY2NvdW50IEdpdC9zc2ggaG9zdGluZyBzeXN0ZW0gcnVucyBn
aXQgY29tbWFuZHMKdGhyb3VnaCBnaXQtc2hlbGwgYWZ0ZXIgY29uZmlybWluZyB0aGF0IHRoZSBj
b25uZWN0aW5nIHVzZXIgaXMKYXV0aG9yaXplZCB0byBhY2Nlc3MgdGhlIHJlcXVlc3RlZCByZXBv
c2l0b3J5LiBUaGlzIHdvcmtzIHdlbGwgZm9yCnVwbG9hZC1wYWNrIGFuZCByZWNlaXZlLXBhY2ss
IHdoaWNoIHRha2UgYSByZXBvc2l0b3J5IGFyZ3VtZW50IHRocm91Z2gKZ2l0LXNoZWxsLiBUaGlz
IGRvZXNuJ3Qgd29yayBzbyB3ZWxsIGZvciBgY3ZzIHNlcnZlcicsIHdoaWNoIGlzIHBhc3NlZAp0
aHJvdWdoIGxpdGVyYWxseSwgd2l0aCBubyBhcmd1bWVudHMuIEFsbG93aW5nIGFyZ3VtZW50cyBy
aXNrcwpzbmVha2luZyBpbiBgLS1leHBvcnQtYWxsJywgc28gdGhhdCByZXN0cmljdGlvbiBzaG91
bGQgYmUgbWFpbnRhaW5lZC4KCkRlc3BpdGUgdGhhdCwgcGFzc2luZyBhIGxpc3Qgb2YgcmVwb3Np
dG9yeSByb290cyBpcyBuZWNlc3NhcnkgZm9yCnBlci11c2VyIGFjY2VzcyBjb250cm9sIGJ5IHRo
ZSBob3N0aW5nIHNvZnR3YXJlLCBhbmQgcGFzc2luZyBhIGJhc2UKcGF0aCBpbXByb3ZlcyB1c2Fi
aWxpdHkgd2l0aG91dCB3ZWFrZW5pbmcgc2VjdXJpdHkuIFRodXMsCmdpdC1jdnNzZXJ2ZXIgbmVl
ZHMgdG8gY29tZSB1cCB3aXRoIHRoZXNlIHZhbHVlcyBhdCBydW50aW1lIGJ5IHNvbWUKb3RoZXIg
bWVhbnMuIFNpbmNlIGdpdC1zaGVsbCBwcmVzZXJ2ZXMgdGhlIGVudmlyb25tZW50IGZvciBvdGhl
cgpwdXJwb3NlcywgdGhlIGVudmlyb25tZW50IGNhbiBjYXJyeSB0aGVzZSBhcmd1bWVudHMgYXMg
d2VsbC4KClRodXMsIG1vZGlmeSBnaXQtY3Zzc2VydmVyIHRvIHJlYWQgJEdJVF9DVlNTRVJWRVJf
e0JBU0VfUEFUSCxST09UU30gaW4KdGhlIGFic2VuY2Ugb2YgZXF1aXZhbGVudCBjb21tYW5kIGxp
bmUgYXJndW1lbnRzLgoKU2lnbmVkLW9mZi1ieTogUGhpbCBNaWxsZXIgPG1pbGxlMTIxQGlsbGlu
b2lzLmVkdT4KLS0tCiBnaXQtY3Zzc2VydmVyLnBlcmwgfCAgIDIxICsrKysrKysrKysrKysrKysr
KysrLQogMSBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2dpdC1jdnNzZXJ2ZXIucGVybCBiL2dpdC1jdnNzZXJ2ZXIucGVybAppbmRl
eCA2ZGM0NWY1Li45ZTU4ZDJhIDEwMDc1NQotLS0gYS9naXQtY3Zzc2VydmVyLnBlcmwKKysrIGIv
Z2l0LWN2c3NlcnZlci5wZXJsCkBAIC0xMDQsNiArMTA0LDcgQEAgJGxvZy0+aW5mbygiLS0tLS0t
LS0tLS0tLS0tIFNUQVJUSU5HIC0tLS0tLS0tLS0tLS0tLS0tIik7CiBteSAkdXNhZ2UgPQogICAg
ICJVc2FnZTogZ2l0IGN2c3NlcnZlciBbb3B0aW9uc10gW3BzZXJ2ZXJ8c2VydmVyXSBbPGRpcmVj
dG9yeT4gLi4uXVxuIi4KICAgICAiICAgIC0tYmFzZS1wYXRoIDxwYXRoPiAgOiBQcmVwZW5kIHRv
IHJlcXVlc3RlZCBDVlNST09UXG4iLgorICAgICIgICAgICAgICAgICAgICAgICAgICAgICAgIENh
biBiZSByZWFkIGZyb20gR0lUX0NWU1NFUlZFUl9CQVNFX1BBVEhcbiIuCiAgICAgIiAgICAtLXN0
cmljdC1wYXRocyAgICAgIDogRG9uJ3QgYWxsb3cgcmVjdXJzaW5nIGludG8gc3ViZGlyZWN0b3Jp
ZXNcbiIuCiAgICAgIiAgICAtLWV4cG9ydC1hbGwgICAgICAgIDogRG9uJ3QgY2hlY2sgZm9yIGdp
dGN2cy5lbmFibGVkIGluIGNvbmZpZ1xuIi4KICAgICAiICAgIC0tdmVyc2lvbiwgLVYgICAgICAg
OiBQcmludCB2ZXJzaW9uIGluZm9ybWF0aW9uIGFuZCBleGl0XG4iLgpAQCAtMTExLDcgKzExMiw4
IEBAIG15ICR1c2FnZSA9CiAgICAgIlxuIi4KICAgICAiPGRpcmVjdG9yeT4gLi4uIGlzIGEgbGlz
dCBvZiBhbGxvd2VkIGRpcmVjdG9yaWVzLiBJZiBubyBkaXJlY3Rvcmllc1xuIi4KICAgICAiYXJl
IGdpdmVuLCBhbGwgYXJlIGFsbG93ZWQuIFRoaXMgaXMgYW4gYWRkaXRpb25hbCByZXN0cmljdGlv
biwgZ2l0Y3ZzXG4iLgotICAgICJhY2Nlc3Mgc3RpbGwgbmVlZHMgdG8gYmUgZW5hYmxlZCBieSB0
aGUgZ2l0Y3ZzLmVuYWJsZWQgY29uZmlnIG9wdGlvbi5cbiI7CisgICAgImFjY2VzcyBzdGlsbCBu
ZWVkcyB0byBiZSBlbmFibGVkIGJ5IHRoZSBnaXRjdnMuZW5hYmxlZCBjb25maWcgb3B0aW9uLlxu
Ii4KKyAgICAiQWx0ZXJuYXRlbHksIHRoZXNlIGRpcmVjdG9yaWVzIG1heSBiZSBzcGVjaWZpZWQg
aW4gR0lUX0NWU1NFUlZFUl9ST09UUy5cbiI7CiAKIG15IEBvcHRzID0gKCAnaGVscHxofEgnLCAn
dmVyc2lvbnxWJywKIAkgICAgICdiYXNlLXBhdGg9cycsICdzdHJpY3QtcGF0aHMnLCAnZXhwb3J0
LWFsbCcgKTsKQEAgLTE0OCw2ICsxNTAsMjMgQEAgaWYgKCRzdGF0ZS0+eydleHBvcnQtYWxsJ30g
JiYgIUB7JHN0YXRlLT57YWxsb3dlZF9yb290c319KSB7CiAgICAgZGllICItLWV4cG9ydC1hbGwg
Y2FuIG9ubHkgYmUgdXNlZCB0b2dldGhlciB3aXRoIGFuIGV4cGxpY2l0IHdoaXRlbGlzdFxuIjsK
IH0KIAorIyBFbnZpcm9ubWVudCBoYW5kbGluZyBmb3IgcnVubmluZyB1bmRlciBnaXQtc2hlbGwK
K2lmICgkRU5We0dJVF9DVlNTRVJWRVJfQkFTRV9QQVRIfSkgeworICAgIGlmICgkc3RhdGUtPnsn
YmFzZS1wYXRoJ30pIHsKKwlkaWUgIkNhbm5vdCBzcGVjaWZ5IGJhc2UgcGF0aCBib3RoIHdheXMu
XG4iOworICAgIH0KKyAgICBteSAkYmFzZV9wYXRoID0gJEVOVntHSVRfQ1ZTU0VSVkVSX0JBU0Vf
UEFUSH07CisgICAgJHN0YXRlLT57J2Jhc2UtcGF0aCd9ID0gJGJhc2VfcGF0aDsKKyAgICAkbG9n
LT5kZWJ1ZygiUGlja2VkIHVwIGJhc2UgcGF0aCAnJGJhc2VfcGF0aCcgZnJvbSBlbnZpcm9ubWVu
dC5cbiIpOworfQoraWYgKCRFTlZ7R0lUX0NWU1NFUlZFUl9ST09UU30pIHsKKyAgICBpZiAoQHsk
c3RhdGUtPnthbGxvd2VkX3Jvb3RzfX0pIHsKKwlkaWUgIkNhbm5vdCBzcGVjaWZ5IHJvb3RzIGJv
dGggd2F5czogQEFSR1ZcbiI7CisgICAgfQorICAgIG15IEBhbGxvd2VkX3Jvb3QgPSBzcGxpdCgn
LCcsICRFTlZ7R0lUX0NWU1NFUlZFUl9ST09UU30pOworICAgICRzdGF0ZS0+e2FsbG93ZWRfcm9v
dHN9ID0gWyBAYWxsb3dlZF9yb290IF07Cit9CisKICMgaWYgd2UgYXJlIGNhbGxlZCB3aXRoIGEg
cHNlcnZlciBhcmd1bWVudCwKICMgZGVhbCB3aXRoIHRoZSBhdXRoZW50aWNhdGlvbiBjYXQgYmVm
b3JlIGVudGVyaW5nIHRoZQogIyBtYWluIGxvb3AKLS0gCjEuNi41LjIuNDExLmdmN2MwZi5kaXJ0
eQoK
--0016e6d99d7e03b51304782fd645--
