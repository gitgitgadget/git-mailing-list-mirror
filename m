From: Alex Vandiver <alex@chmrr.net>
Subject: Re: git-svn: SVK merge commits can have >2 parents
Date: Sun, 29 Nov 2009 02:46:49 -0500
Message-ID: <1259480367-sup-6891@utwig>
References: <1259479636-sup-573@utwig>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1259480809-959285-30157-9020-2-="
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 08:46:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEeUi-0004bF-9y
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 08:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZK2Hqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 02:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbZK2Hqo
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 02:46:44 -0500
Received: from chmrr.net ([209.67.253.66]:40825 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbZK2Hqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 02:46:43 -0500
X-Greylist: delayed 1090 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Nov 2009 02:46:43 EST
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NEeUb-0007tq-VU; Sun, 29 Nov 2009 02:46:49 -0500
In-reply-to: <1259479636-sup-573@utwig>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134000>


--=-1259480809-959285-30157-9020-2-=
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

At Sun Nov 29 02:28:39 -0500 2009, Alex Vandiver wrote:
> While converting a mildly complicated svn repository that was managed
> with SVK, I ran across the following oddness.  `svk smerge` can only
> merge between _two_ branches at once -- however, the way that svk
> merge detection works, you can end up with erroneous extra parents
> from long-dead branches.

Upon a little more inspection, I now understand that the rev-parse
lines in find_extra_svk_parents are attempting to deal with this exact
circumstance -- but they fail to properly sort the merge tickets
first, which leads to this incorrect behavior.  Armed with this
understanding, I'm more confident in the attached updated patch.  I
assume, however, that the logic allows for more than one extra parent
only because such an occurrance could be constructed by hand-editing
svk:merge, because AFAIK svk's command-line tools should be able to
construct such a circumstance.
 - Alex
-- 
Networking -- only one letter away from not working

--=-1259480809-959285-30157-9020-2-=
Content-Disposition: attachment; filename="0001-git-svn-sort-svk-merge-tickets-to-account-for-minima.patch"
Content-Type: application/octet-stream; name="0001-git-svn-sort-svk-merge-tickets-to-account-for-minima.patch"
Content-Transfer-Encoding: base64

RnJvbSA0ZDMwZTU3ZTVkYTdjMmU4ODA5MDhiYzc0MmNmODA5OTBkNmY5ZjVk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFZhbmRpdmVy
IDxhbGV4QGNobXJyLm5ldD4KRGF0ZTogU3VuLCAyOSBOb3YgMjAwOSAwMjoy
MDoyMSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIGdpdC1zdm46IHNvcnQgc3Zr
IG1lcmdlIHRpY2tldHMgdG8gYWNjb3VudCBmb3IgbWluaW1hbCBwYXJlbnRz
CgpXaGVuIG1lcmdpbmcgYnJhbmNoZXMgYmFzZWQgb24gc3ZrOm1lcmdlIHBy
b3BlcnRpZXMsIGEgc2luZ2xlIG1lcmdlCmNhbiBoYXZlIHVwZGF0ZWQgb3Ig
YWRkZWQgbXVsdGlwbGUgc3ZrOm1lcmdlIGxpbmVzLiAgQXR0ZW1wdCB0bwpp
bmNsdWRlIHRoZSBtaW5pbWFsIHNldCBvZiBwYXJlbnRzIGJ5IHNvcnRpbmcg
dGhlIG1lcmdlIHByb3BlcnRpZXMgaW4Kb3JkZXIgb2YgcmV2aXNpb24sIGhp
Z2hlc3QgdG8gbG93ZXN0LgoKU2lnbmVkLW9mZi1ieTogQWxleCBWYW5kaXZl
ciA8YWxleEBjaG1yci5uZXQ+Ci0tLQogZ2l0LXN2bi5wZXJsIHwgICAgNiAr
KysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1zdm4ucGVybCBiL2dpdC1z
dm4ucGVybAppbmRleCA5NTdkNDRlLi41MWYwM2FkIDEwMDc1NQotLS0gYS9n
aXQtc3ZuLnBlcmwKKysrIGIvZ2l0LXN2bi5wZXJsCkBAIC0yOTQwLDEwICsy
OTQwLDE0IEBAIHN1YiBmaW5kX2V4dHJhX3N2a19wYXJlbnRzIHsKIAkJCWlm
ICggbXkgJGNvbW1pdCA9ICRncy0+cmV2X21hcF9nZXQoJHJldiwgJHV1aWQp
ICkgewogCQkJCSMgd2FoZXkhICB3ZSBmb3VuZCBpdCwgYnV0IGl0IG1pZ2h0
IGJlCiAJCQkJIyBhbiBvbGQgb25lICghKQotCQkJCXB1c2ggQGtub3duX3Bh
cmVudHMsICRjb21taXQ7CisJCQkJcHVzaCBAa25vd25fcGFyZW50cywgWyAk
cmV2LCAkY29tbWl0IF07CiAJCQl9CiAJCX0KIAl9CisJIyBPcmRlcmluZyBt
YXR0ZXJzOyBoaWdoZXN0LW51bWJlcmVkIGNvbW1pdCBtZXJnZSB0aWNrZXRz
CisJIyBmaXJzdCwgYXMgdGhleSBtYXkgYWNjb3VudCBmb3IgbGF0ZXIgbWVy
Z2UgdGlja2V0IGFkZGl0aW9ucworCSMgb3IgY2hhbmdlcy4KKwlAa25vd25f
cGFyZW50cyA9IG1hcCB7JF8tPlsxXX0gc29ydCB7JGItPlswXSA8PT4gJGEt
PlswXX0gQGtub3duX3BhcmVudHM7CiAJZm9yIG15ICRwYXJlbnQgKCBAa25v
d25fcGFyZW50cyApIHsKIAkJbXkgQGNtZCA9ICgncmV2LWxpc3QnLCAkcGFy
ZW50LCBtYXAgeyAiXiRfIiB9IEAkcGFyZW50cyApOwogCQlteSAoJG1zZ19m
aCwgJGN0eCkgPSBjb21tYW5kX291dHB1dF9waXBlKEBjbWQpOwotLSAKMS42
LjYucmMwLjI1NC5nNzM1MmQKCg==

--=-1259480809-959285-30157-9020-2-=--
