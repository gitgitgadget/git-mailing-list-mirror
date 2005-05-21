From: "Sean" <seanlkml@sympatico.ca>
Subject: [RFC] git-fsck-cache argument processing
Date: Fri, 20 May 2005 23:38:52 -0400 (EDT)
Message-ID: <4870.10.10.10.24.1116646732.squirrel@linux1>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050520233852_60045"
X-From: git-owner@vger.kernel.org Sat May 21 05:38:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZKoq-00055a-Ov
	for gcvg-git@gmane.org; Sat, 21 May 2005 05:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVEUDjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 23:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVEUDjK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 23:39:10 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:17053 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261648AbVEUDi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 23:38:58 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521033852.USHO23474.simmts7-srv.bellnexxia.net@linux1>
          for <git@vger.kernel.org>; Fri, 20 May 2005 23:38:52 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4L3cqY3013088
	for <git@vger.kernel.org>; Fri, 20 May 2005 23:38:52 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 20 May 2005 23:38:52 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050520233852_60045
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


Here is a first crack at using argp as suggested by Jeff Garzik to
implement argument processing as requested by Junio and Linus.  Each of
the long arguments have been given a single character equivalent as well.

This patch only converts fsck-cache to use argp in case anyone has
objections to the basic format or style.  The patch includes a version
number inside of fsck-cache.c; this should really be in a separate include
file so you can run any command with --version and get the same answer.

With this change you have:

$ git-fsck-cache -?
Usage: git-fsck-cache [OPTION...] [HEAD-SHA1...]
git-fsck-cache - repository consistency check

 -c, --cache            Mark all objects referenced by cache as reachable
 -d, --delta-depth      Show the maximum length of delta chains
 -r, --root             Show root objects, ie. those without parents
 -t, --tags             Show revision tags
 -u, --unreachable      Show missing objects or deltas
 -?, --help             Give this help list
     --usage            Give a short usage message
 -V, --version          Print program version

And the following should work as expected:

$ git-fsck-cache -crudt


fsck-cache.c |   64
+++++++++++++++++++++++++++++++++++------------------------
1 files changed, 39 insertions(+), 25 deletions(-)

Sean

------=_20050520233852_60045
Content-Type: application/octet-stream; name="fsck-cache-argp-v1.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fsck-cache-argp-v1.patch"

ZnNjay1jYWNoZS5jOiBuZWVkcyB1cGRhdGUKSW5kZXg6IGZzY2stY2FjaGUuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSA1ODc0MWM2OTU3MDcwNTgwMWRiNGI3ODU2ODE3OTBkNjM2NDc1Njk1L2ZzY2stY2FjaGUu
YyAgKG1vZGU6MTAwNjQ0KQorKysgdW5jb21taXR0ZWQvZnNjay1jYWNoZS5jICAobW9kZToxMDA2
NDQpCkBAIC0xLDUgKzEsNyBAQAogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPGRp
cmVudC5oPgorI2luY2x1ZGUgPGFyZ3AuaD4KK2NvbnN0IGNoYXIgKmFyZ3BfcHJvZ3JhbV92ZXJz
aW9uID0gImdpdCAxLjAiOwogCiAjaW5jbHVkZSAiY2FjaGUuaCIKICNpbmNsdWRlICJjb21taXQu
aCIKQEAgLTQwNywzNiArNDA5LDQ4IEBACiAJZmluZF9maWxlX29iamVjdHMoZ2l0X2RpciwgInJl
ZnMiKTsKIH0KIAorI2RlZmluZSBPX1VOUkVBQ0ggJ3UnCisjZGVmaW5lIE9fVEFHUyAndCcKKyNk
ZWZpbmUgT19ST09UICdyJworI2RlZmluZSBPX0RFTFRBICdkJworI2RlZmluZSBPX0NBQ0hFICdj
JworCitzdGF0aWMgY29uc3QgY2hhciBkb2NbXSA9ICJQZXJmb3JtIHJlcG9zaXRvcnkgY29uc2lz
dGVuY3kgY2hlY2siOworCitzdGF0aWMgc3RydWN0IGFyZ3Bfb3B0aW9uIG9wdGlvbnNbXSA9IHsK
KyB7InVucmVhY2hhYmxlIiwgT19VTlJFQUNILCAwLCAwLCAiU2hvdyBtaXNzaW5nIG9iamVjdHMg
b3IgZGVsdGFzIn0sCisgeyJ0YWdzIiwgT19UQUdTLCAwLCAwLCAiU2hvdyByZXZpc2lvbiB0YWdz
In0sCisgeyJyb290IiwgT19ST09ULCAwLCAwLCAiU2hvdyByb290IG9iamVjdHMsIGllLiB0aG9z
ZSB3aXRob3V0IHBhcmVudHMifSwKKyB7ImRlbHRhLWRlcHRoIiwgT19ERUxUQSwgMCwgMCwgIlNo
b3cgdGhlIG1heGltdW0gbGVuZ3RoIG9mIGRlbHRhIGNoYWlucyJ9LAorIHsiY2FjaGUiLCBPX0NB
Q0hFLCAwLCAwLCAiTWFyayBhbGwgb2JqZWN0cyByZWZlcmVuY2VkIGJ5IGNhY2hlIGFzIHJlYWNo
YWJsZSJ9LAorIHsgfQorfTsKKworc3RhdGljIGVycm9yX3QgcGFyc2Vfb3B0IChpbnQga2V5LCBj
aGFyICphcmcsIHN0cnVjdCBhcmdwX3N0YXRlICpzdGF0ZSkKK3sKKwlzd2l0Y2ggKGtleSkgewor
CWNhc2UgT19VTlJFQUNIOgkJc2hvd191bnJlYWNoYWJsZSA9IDE7IGJyZWFrOworCWNhc2UgT19U
QUdTOgkJc2hvd190YWdzID0gMTsgYnJlYWs7CisJY2FzZSBPX1JPT1Q6CQlzaG93X3Jvb3QgPSAx
OyBicmVhazsKKwljYXNlIE9fREVMVEE6CQlzaG93X21heF9kZWx0YV9kZXB0aCA9IDE7IGJyZWFr
OworCWNhc2UgT19DQUNIRToJCWtlZXBfY2FjaGVfb2JqZWN0cyA9IDE7IGJyZWFrOworCWNhc2Ug
QVJHUF9LRVlfQVJHOglzdGF0ZS0+bmV4dCA9IHN0YXRlLT5hcmdjOyBicmVhazsKKwlkZWZhdWx0
OgkJcmV0dXJuIEFSR1BfRVJSX1VOS05PV047CisJfQorCXJldHVybiAwOworfQorCitzdGF0aWMg
Y29uc3Qgc3RydWN0IGFyZ3AgYXJncCA9IHsgb3B0aW9ucywgcGFyc2Vfb3B0LCAiW0hFQUQtU0hB
MS4uLl0iLCBkb2MgfTsKKwogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewogCWlu
dCBpLCBoZWFkczsKIAljaGFyICpzaGExX2RpcjsKIAotCWZvciAoaSA9IDE7IGkgPCBhcmdjOyBp
KyspIHsKLQkJY29uc3QgY2hhciAqYXJnID0gYXJndltpXTsKLQotCQlpZiAoIXN0cmNtcChhcmcs
ICItLXVucmVhY2hhYmxlIikpIHsKLQkJCXNob3dfdW5yZWFjaGFibGUgPSAxOwotCQkJY29udGlu
dWU7Ci0JCX0KLQkJaWYgKCFzdHJjbXAoYXJnLCAiLS10YWdzIikpIHsKLQkJCXNob3dfdGFncyA9
IDE7Ci0JCQljb250aW51ZTsKLQkJfQotCQlpZiAoIXN0cmNtcChhcmcsICItLXJvb3QiKSkgewot
CQkJc2hvd19yb290ID0gMTsKLQkJCWNvbnRpbnVlOwotCQl9Ci0JCWlmICghc3RyY21wKGFyZywg
Ii0tZGVsdGEtZGVwdGgiKSkgewotCQkJc2hvd19tYXhfZGVsdGFfZGVwdGggPSAxOwotCQkJY29u
dGludWU7Ci0JCX0KLQkJaWYgKCFzdHJjbXAoYXJnLCAiLS1jYWNoZSIpKSB7Ci0JCQlrZWVwX2Nh
Y2hlX29iamVjdHMgPSAxOwotCQkJY29udGludWU7Ci0JCX0KLQkJaWYgKCphcmcgPT0gJy0nKQot
CQkJdXNhZ2UoImdpdC1mc2NrLWNhY2hlIFstLXRhZ3NdIFtbLS11bnJlYWNoYWJsZV0gWy0tY2Fj
aGVdIDxoZWFkLXNoYTE+Kl0iKTsKKwllcnJvcl90IHJjID0gYXJncF9wYXJzZSgmYXJncCwgYXJn
YywgYXJndiwgMCwgTlVMTCwgTlVMTCk7CisJaWYgKHJjKSB7CisJCWZwcmludGYoc3RkZXJyLCAi
YXJndW1lbnQgZmFpbGVkOiAlc1xuIiwgc3RyZXJyb3IocmMpKTsKKwkJcmV0dXJuIDE7CiAJfQog
CiAJc2hhMV9kaXIgPSBnZXRfb2JqZWN0X2RpcmVjdG9yeSgpOwo=
------=_20050520233852_60045--


