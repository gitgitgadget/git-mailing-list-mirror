From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: thread-utils: build with NO_PTHREADS fails
Date: Sun, 11 Oct 2015 05:58:30 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8mailaccesssof_"
Cc: "vleschuk@gmail.com" <vleschuk@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlGEi-0007kg-74
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 15:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbbJKNAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 09:00:18 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:48618 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbJKNAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 09:00:17 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Sun, 11 Oct 2015 06:00:14 -0700
Thread-Topic: thread-utils: build with NO_PTHREADS fails
Thread-Index: AQHRBCSGtNpNRryDVkOtvYPD+eAPtA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279337>

--_002_6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8mailaccesssof_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I think that no one tried it for a long time but I needed a single-threaded=
 git version for debug purpose. I tried to build with -DNO_PTHREADS and thr=
ead-utils.c failed to compile.

In brief the situation is the following:

in header file we have something like that:


#ifndef NO_PTHREAD
extern int online_cpus(void);

#else
#define online_cpus() 1
#endif // NO_PTHREAD

and in *.c file:


int online_cpus(void)
{
    // ...
}

So the compilation fails with:=20

test.c:3:21: error: macro "online_cpus" passed 1 arguments, but takes just =
0
 int online_cpus(void)

That's a tiny issue, but maybe we could apply a straight-forward solution (=
see attached diff)? If you agree I'll prepare a properly-formatted [PATCH] =
submit.


--
Best Regards,
Victor=

--_002_6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8mailaccesssof_
Content-Type: text/x-patch; name="no_pthreads.patch"
Content-Description: no_pthreads.patch
Content-Disposition: attachment; filename="no_pthreads.patch"; size=879;
	creation-date="Sun, 11 Oct 2015 12:58:56 GMT";
	modification-date="Sun, 11 Oct 2015 12:58:56 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3RocmVhZC11dGlscy5jIGIvdGhyZWFkLXV0aWxzLmMKaW5kZXggYTIxMzVl
MC4uZjNlOTBmYiAxMDA2NDQKLS0tIGEvdGhyZWFkLXV0aWxzLmMKKysrIGIvdGhyZWFkLXV0aWxz
LmMKQEAgLTIwLDYgKzIwLDcgQEAKIAogaW50IG9ubGluZV9jcHVzKHZvaWQpCiB7CisjaWZuZGVm
IE5PX1BUSFJFQURTCiAjaWZkZWYgX1NDX05QUk9DRVNTT1JTX09OTE4KIAlsb25nIG5jcHVzOwog
I2VuZGlmCkBAIC01OCwxMSArNTksMTMgQEAgaW50IG9ubGluZV9jcHVzKHZvaWQpCiAJCXJldHVy
biAoaW50KW5jcHVzOwogI2VuZGlmCiAKKyNlbmRpZgogCXJldHVybiAxOwogfQogCiBpbnQgaW5p
dF9yZWN1cnNpdmVfbXV0ZXgocHRocmVhZF9tdXRleF90ICptKQogeworI2lmbmRlZiBOT19QVEhS
RUFEUwogCXB0aHJlYWRfbXV0ZXhhdHRyX3QgYTsKIAlpbnQgcmV0OwogCkBAIC03NCw0ICs3Nyw3
IEBAIGludCBpbml0X3JlY3Vyc2l2ZV9tdXRleChwdGhyZWFkX211dGV4X3QgKm0pCiAJCXB0aHJl
YWRfbXV0ZXhhdHRyX2Rlc3Ryb3koJmEpOwogCX0KIAlyZXR1cm4gcmV0OworI2Vsc2UKKwlyZXR1
cm4gMDsKKyNlbmRpZgogfQpkaWZmIC0tZ2l0IGEvdGhyZWFkLXV0aWxzLmggYi90aHJlYWQtdXRp
bHMuaAppbmRleCBkOWE3NjlkLi42ZmI5OGMzIDEwMDY0NAotLS0gYS90aHJlYWQtdXRpbHMuaAor
KysgYi90aHJlYWQtdXRpbHMuaApAQCAtNyw5ICs3LDUgQEAKIGV4dGVybiBpbnQgb25saW5lX2Nw
dXModm9pZCk7CiBleHRlcm4gaW50IGluaXRfcmVjdXJzaXZlX211dGV4KHB0aHJlYWRfbXV0ZXhf
dCopOwogCi0jZWxzZQotCi0jZGVmaW5lIG9ubGluZV9jcHVzKCkgMQotCiAjZW5kaWYKICNlbmRp
ZiAvKiBUSFJFQURfQ09NUEFUX0ggKi8K

--_002_6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8mailaccesssof_--
