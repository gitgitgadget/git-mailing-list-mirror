From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: fix clone
Date: Thu, 12 Jan 2006 11:54:00 +0000
Message-ID: <b0943d9e0601120354u73489c74j@mail.gmail.com>
References: <1137017966.10975.8.camel@dv> <43C58916.6030409@citi.umich.edu>
	 <43C58AF3.10606@citi.umich.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_67168_8467450.1137066840095"
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 12:54:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex11q-0004yL-HZ
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 12:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWALLyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 06:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWALLyD
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 06:54:03 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:8247 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030304AbWALLyB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 06:54:01 -0500
Received: by xproxy.gmail.com with SMTP id i30so267241wxd
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 03:54:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=BWGJdF7LMZmqmioexCxmvd7bL4EKfTUv/ysxsVWUBibxOb9WoqYcz40btUryg72XQD+rX+cW4XAJ8wyKxR4GdfoNRFMIsR2XoI6E0tBIuKOBoogMXXtet1GITxNf3jhcnNX8FoVRIlKRPLGBMRxHW+XRWi1JWRxsRMxU4Lnv0co=
Received: by 10.70.108.19 with SMTP id g19mr2249872wxc;
        Thu, 12 Jan 2006 03:54:00 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Thu, 12 Jan 2006 03:54:00 -0800 (PST)
To: cel@citi.umich.edu
In-Reply-To: <43C58AF3.10606@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14559>

------=_Part_67168_8467450.1137066840095
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/01/06, Chuck Lever <cel@citi.umich.edu> wrote:
> Chuck Lever wrote:
> > seems to me the "git clone" script should create an environment where
> > "git-rev-parse --git-dir" ought to work correctly.
>
> stgit/main.py does a special stack.Series('master') just for the clone
> command.  it really shouldn't do this -- the crt_series.init() in the
> clone command ought to be fixed to do this properly.

If the stack.Series() doesn't get a parameter, it will try to get the
default branch using 'git-symbolic-ref HEAD'. Any command run outside
a tree (and which doesn't have the -h option) would fail. The clone
command is the only one allowed to run outside a tree and that's why I
passed a default branch name. This is to avoid the creation of another
stack.Series() object later when the git tree was cloned.

See the attached patch for a different fix and let me know if there
are any issues with it. I should probably release 0.8.1 with the fixed
bugs.

--
Catalin

------=_Part_67168_8467450.1137066840095
Content-Type: text/x-patch; name="clone-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="clone-fix.diff"

Rml4IHRoZSBjbG9uZSBjb21tYW5kIGZhaWx1cmUKCkZyb206IENhdGFsaW4gTWFyaW5hcyA8Y2F0
YWxpbi5tYXJpbmFzQGdtYWlsLmNvbT4KClRoZSBjbG9uZSBjb21tYW5kIGZhaWxzIGJlY2F1c2Ug
dGhlcmUgaXMgbm8gR0lUIHRyZWUgYXZhaWxhYmxlLCB3aGljaCBpcwp3cm9uZy4gVGhlIHBhdGNo
IGZpeGVzIHRoZSBTZXJpZXMuX19pbml0X18oKSBmdW5jdGlvbiBhbmQgYWxzbyBjcmVhdGVzIGEK
bmV3IFNlcmllcyBvYmplY3QgaW4gY2xvbmUucHkgb25jZSBhIEdJVCB0cmVlIHdhcyBpbml0aWFs
aXNlZC4KClNpZ25lZC1vZmYtYnk6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGdt
YWlsLmNvbT4KLS0tCgogc3RnaXQvY29tbWFuZHMvY2xvbmUucHkgfCAgICAyICstCiBzdGdpdC9t
YWluLnB5ICAgICAgICAgICB8ICAgMTggKysrKysrKystLS0tLS0tLS0tCiBzdGdpdC9zdGFjay5w
eSAgICAgICAgICB8ICAgMzAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAzIGZpbGVz
IGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3N0Z2l0L2NvbW1hbmRzL2Nsb25lLnB5IGIvc3RnaXQvY29tbWFuZHMvY2xvbmUucHkKaW5kZXgg
ZjRlM2Y2Yi4uOWFkNzZhNiAxMDA2NDQKLS0tIGEvc3RnaXQvY29tbWFuZHMvY2xvbmUucHkKKysr
IGIvc3RnaXQvY29tbWFuZHMvY2xvbmUucHkKQEAgLTUxLDYgKzUxLDYgQEAgZGVmIGZ1bmMocGFy
c2VyLCBvcHRpb25zLCBhcmdzKToKICAgICBvcy5jaGRpcihsb2NhbF9kaXIpCiAgICAgZ2l0LmNo
ZWNrb3V0KHRyZWVfaWQgPSAnSEVBRCcpCiAKLSAgICBjcnRfc2VyaWVzLmluaXQoKQorICAgIHN0
YWNrLlNlcmllcygpLmluaXQoKQogCiAgICAgcHJpbnQgJ2RvbmUnCmRpZmYgLS1naXQgYS9zdGdp
dC9tYWluLnB5IGIvc3RnaXQvbWFpbi5weQppbmRleCBiODRkOTFkLi4yMzM2YTQzIDEwMDY0NAot
LS0gYS9zdGdpdC9tYWluLnB5CisrKyBiL3N0Z2l0L21haW4ucHkKQEAgLTE1MCwxNiArMTUwLDE0
IEBAIGRlZiBtYWluKCk6CiAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wdGlvbl9saXN0ID0g
Y29tbWFuZC5vcHRpb25zKQogICAgIG9wdGlvbnMsIGFyZ3MgPSBwYXJzZXIucGFyc2VfYXJncygp
CiAgICAgdHJ5OgotICAgICAgICAjICdjbG9uZScgZG9lc24ndCBleHBlY3QgYW4gYWxyZWFkeSBp
bml0aWFsaXNlZCBHSVQgdHJlZQotICAgICAgICBpZiBjbWQgPT0gJ2Nsb25lJzoKLSAgICAgICAg
ICAgIHN0Z2l0LmNvbW1hbmRzLmNvbW1vbi5jcnRfc2VyaWVzID0gc3RhY2suU2VyaWVzKCdtYXN0
ZXInKQotICAgICAgICBlbGlmIGhhc2F0dHIob3B0aW9ucywgJ2JyYW5jaCcpIGFuZCBvcHRpb25z
LmJyYW5jaDoKLSAgICAgICAgICAgIHN0Z2l0LmNvbW1hbmRzLmNvbW1vbi5jcnRfc2VyaWVzID0g
c3RhY2suU2VyaWVzKG9wdGlvbnMuYnJhbmNoKQotICAgICAgICBlbHNlOgotICAgICAgICAgICAg
c3RnaXQuY29tbWFuZHMuY29tbW9uLmNydF9zZXJpZXMgPSBzdGFjay5TZXJpZXMoKQotICAgICAg
ICAjIHRoZSBsaW5lIGJlbG93IGlzIGEgc2ltcGxlIHdheSB0byBhdm9pZCBhbiBleGNlcHRpb24g
d2hlbgotICAgICAgICAjIHN0Z2l0IGlzIHJ1biBvdXRzaWRlIGFuIGluaXRpYWxpc2VkIHRyZWUK
LSAgICAgICAgc2V0YXR0cihjb21tYW5kLCAnY3J0X3NlcmllcycsIHN0Z2l0LmNvbW1hbmRzLmNv
bW1vbi5jcnRfc2VyaWVzKQorICAgICAgICAjICdjbG9uZScgZG9lc24ndCBleHBlY3QgYW4gYWxy
ZWFkeSBpbml0aWFsaXNlZCBHSVQgdHJlZS4gQSBTZXJpZXMKKyAgICAgICAgIyBvYmplY3Qgd2ls
bCBiZSBjcmVhdGVkIGFmdGVyIHRoZSBHSVQgdHJlZSBpcyBjbG9uZWQKKyAgICAgICAgaWYgY21k
ICE9ICdjbG9uZSc6CisgICAgICAgICAgICBpZiBoYXNhdHRyKG9wdGlvbnMsICdicmFuY2gnKSBh
bmQgb3B0aW9ucy5icmFuY2g6CisgICAgICAgICAgICAgICAgY29tbWFuZC5jcnRfc2VyaWVzID0g
c3RhY2suU2VyaWVzKG9wdGlvbnMuYnJhbmNoKQorICAgICAgICAgICAgZWxzZToKKyAgICAgICAg
ICAgICAgICBjb21tYW5kLmNydF9zZXJpZXMgPSBzdGFjay5TZXJpZXMoKQorICAgICAgICAgICAg
c3RnaXQuY29tbWFuZHMuY29tbW9uLmNydF9zZXJpZXMgPSBjb21tYW5kLmNydF9zZXJpZXMKIAog
ICAgICAgICBjb21tYW5kLmZ1bmMocGFyc2VyLCBvcHRpb25zLCBhcmdzKQogICAgIGV4Y2VwdCAo
SU9FcnJvciwgQ21kRXhjZXB0aW9uLCBzdGFjay5TdGFja0V4Y2VwdGlvbiwgZ2l0LkdpdEV4Y2Vw
dGlvbiksIFwKZGlmZiAtLWdpdCBhL3N0Z2l0L3N0YWNrLnB5IGIvc3RnaXQvc3RhY2sucHkKaW5k
ZXggOGI3YzI5Ni4uYzJhZGViOSAxMDA2NDQKLS0tIGEvc3RnaXQvc3RhY2sucHkKKysrIGIvc3Rn
aXQvc3RhY2sucHkKQEAgLTI1NywyMSArMjU3LDIzIEBAIGNsYXNzIFNlcmllczoKICAgICBkZWYg
X19pbml0X18oc2VsZiwgbmFtZSA9IE5vbmUpOgogICAgICAgICAiIiJUYWtlcyBhIHNlcmllcyBu
YW1lIGFzIHRoZSBwYXJhbWV0ZXIuCiAgICAgICAgICIiIgotICAgICAgICBpZiBuYW1lOgotICAg
ICAgICAgICAgc2VsZi5fX25hbWUgPSBuYW1lCi0gICAgICAgIGVsc2U6Ci0gICAgICAgICAgICBz
ZWxmLl9fbmFtZSA9IGdpdC5nZXRfaGVhZF9maWxlKCkKLQotICAgICAgICBpZiBzZWxmLl9fbmFt
ZToKKyAgICAgICAgdHJ5OgorICAgICAgICAgICAgaWYgbmFtZToKKyAgICAgICAgICAgICAgICBz
ZWxmLl9fbmFtZSA9IG5hbWUKKyAgICAgICAgICAgIGVsc2U6CisgICAgICAgICAgICAgICAgc2Vs
Zi5fX25hbWUgPSBnaXQuZ2V0X2hlYWRfZmlsZSgpCiAgICAgICAgICAgICBiYXNlX2RpciA9IGdp
dC5nZXRfYmFzZV9kaXIoKQotICAgICAgICAgICAgc2VsZi5fX3BhdGNoX2RpciA9IG9zLnBhdGgu
am9pbihiYXNlX2RpciwgJ3BhdGNoZXMnLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzZWxmLl9fbmFtZSkKLSAgICAgICAgICAgIHNlbGYuX19iYXNlX2ZpbGUg
PSBvcy5wYXRoLmpvaW4oYmFzZV9kaXIsICdyZWZzJywgJ2Jhc2VzJywKLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VsZi5fX25hbWUpCi0gICAgICAgICAgICBz
ZWxmLl9fYXBwbGllZF9maWxlID0gb3MucGF0aC5qb2luKHNlbGYuX19wYXRjaF9kaXIsICdhcHBs
aWVkJykKLSAgICAgICAgICAgIHNlbGYuX191bmFwcGxpZWRfZmlsZSA9IG9zLnBhdGguam9pbihz
ZWxmLl9fcGF0Y2hfZGlyLCAndW5hcHBsaWVkJykKLSAgICAgICAgICAgIHNlbGYuX19jdXJyZW50
X2ZpbGUgPSBvcy5wYXRoLmpvaW4oc2VsZi5fX3BhdGNoX2RpciwgJ2N1cnJlbnQnKQotICAgICAg
ICAgICAgc2VsZi5fX2Rlc2NyX2ZpbGUgPSBvcy5wYXRoLmpvaW4oc2VsZi5fX3BhdGNoX2Rpciwg
J2Rlc2NyaXB0aW9uJykKKyAgICAgICAgZXhjZXB0IGdpdC5HaXRFeGNlcHRpb24sIGV4OgorICAg
ICAgICAgICAgcmFpc2UgU3RhY2tFeGNlcHRpb24sICdHSVQgdHJlZSBub3QgaW5pdGlhbGlzZWQ6
ICVzJyAlIGV4CisKKyAgICAgICAgc2VsZi5fX3BhdGNoX2RpciA9IG9zLnBhdGguam9pbihiYXNl
X2RpciwgJ3BhdGNoZXMnLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNlbGYuX19uYW1lKQorICAgICAgICBzZWxmLl9fYmFzZV9maWxlID0gb3MucGF0aC5qb2luKGJh
c2VfZGlyLCAncmVmcycsICdiYXNlcycsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2VsZi5fX25hbWUpCisgICAgICAgIHNlbGYuX19hcHBsaWVkX2ZpbGUgPSBvcy5w
YXRoLmpvaW4oc2VsZi5fX3BhdGNoX2RpciwgJ2FwcGxpZWQnKQorICAgICAgICBzZWxmLl9fdW5h
cHBsaWVkX2ZpbGUgPSBvcy5wYXRoLmpvaW4oc2VsZi5fX3BhdGNoX2RpciwgJ3VuYXBwbGllZCcp
CisgICAgICAgIHNlbGYuX19jdXJyZW50X2ZpbGUgPSBvcy5wYXRoLmpvaW4oc2VsZi5fX3BhdGNo
X2RpciwgJ2N1cnJlbnQnKQorICAgICAgICBzZWxmLl9fZGVzY3JfZmlsZSA9IG9zLnBhdGguam9p
bihzZWxmLl9fcGF0Y2hfZGlyLCAnZGVzY3JpcHRpb24nKQogCiAgICAgZGVmIGdldF9icmFuY2go
c2VsZik6CiAgICAgICAgICIiIlJldHVybiB0aGUgYnJhbmNoIG5hbWUgZm9yIHRoZSBTZXJpZXMg
b2JqZWN0Cg==
------=_Part_67168_8467450.1137066840095--
