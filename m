From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Mon, 1 Jun 2015 14:09:49 +0200
Message-ID: <CAP8UFD1XzrC=XLpOYd5S5g_3t6BAbveafO0SctFe=yrwLEAS6Q@mail.gmail.com>
References: <20150601001759.GA3934@kroah.com>
	<20150601015428.GA24214@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e013d1472e08373051773b3be
Cc: git <git@vger.kernel.org>, Gaston Gonzalez <gascoar@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 14:09:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzOXU-0001zV-JR
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 14:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbbFAMJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 08:09:53 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35693 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbFAMJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 08:09:51 -0400
Received: by wgme6 with SMTP id e6so112330546wgm.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i19//kLSGlYcKQz3CrzC9Smu+pN1p9adDl1nJoPED2s=;
        b=DeY3oCjQ5MCIB/4XC1LTlRa7LNngo7C93wzR8YNOpVsKabE6ztTUqweeIU66EHHMJY
         xARoVo8KvhaPVcypSJE0PpB4Y4mDPf3txh6oygmhOWLbS3VapUP3CFU8pk928c00PVfE
         B3UD/JfmTVp+dJMkDFgFeJlRt0HADpk81jUSzVTrmaROJ4ZbGh1LyUjxEx9XuBzo8Wl6
         JXUSpnAuzZVUIZXFGna+IU9YqBLTH0XfUrNoxBuimFM7Ssfx68epo8UOE8U9hsgapjvg
         oQIzgJaUgIRKtQnZCI0drzvXzAWhUMbGkDCIheFdadaXNMqcml/+lbFZQX15r5udaO2m
         i6ag==
X-Received: by 10.194.242.195 with SMTP id ws3mr41325800wjc.155.1433160590037;
 Mon, 01 Jun 2015 05:09:50 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Mon, 1 Jun 2015 05:09:49 -0700 (PDT)
In-Reply-To: <20150601015428.GA24214@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270406>

--089e013d1472e08373051773b3be
Content-Type: text/plain; charset=UTF-8

Hi Greg,

On Mon, Jun 1, 2015 at 3:54 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jun 01, 2015 at 09:17:59AM +0900, Greg KH wrote:
>> Hi all,
>>
>> I received the patch attached below as part of a submission against the
>> Linux kernel tree.  The patch seems to have been hand-edited, and is not
>> correct, and patch verifies this as being a problem:
>>
>> $ patch -p1 --dry-run < bad_patch.mbox
>> checking file drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
>> patch: **** malformed patch at line 133:                skb_put(skb, sizeof(struct ieee80211_authentication));
>>
>> But git will actually apply it:
>> $ git am -s bad_patch.mbox
>> Applying: staging: rtl8192u: ieee80211: Fix sparse endianness warnings
>>
>> But, there's nothing in the patch at all except the commit message:
>>
>> $ git show HEAD
>> commit f6643dfef5b701db86f23be9ce6fb5b3bafe76b6
>> Author: Gaston Gonzalez <gascoar@gmail.com>
>> Date:   Sun May 31 12:17:48 2015 -0300
>>
>>     staging: rtl8192u: ieee80211: Fix sparse endianness warnings
>>
>>     Fix the following sparse warnings:
>>
>>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32: warning: incorrect type in assignment (different base types)
>>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32:    expected restricted __le16 [usertype] frame_ctl
>>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32:    got int
>>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50: warning: invalid assignment: |=
>>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50:    left side has type restricted __le16
>>     drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50:    right side has type int
>>
>>     Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> $ git diff HEAD^
>> $
>>
>> Any ideas what is going on here?  Shouldn't 'git am' have failed?
>>
>> Oh, I'm using git version 2.4.2 right now.
>>
>> I've asked Gaston for the original patch to verify before he hand-edited
>> it, to verify that git wasn't creating something wrong here, as well.
>
> Gaston sent me his original patch, before he edited it, and it was
> correct, so git is correctly creating the patch, which is good.  So it's
> just a 'git am' issue with a broken patch file.

Yeah, git am is calling 'git apply --index' on the attached patch and
'git apply' doesn't apply it, doesn't warn and exits with code 0.

Thanks,
Christian.

--089e013d1472e08373051773b3be
Content-Type: text/plain; charset=US-ASCII; name="bad_patch.txt"
Content-Disposition: attachment; filename="bad_patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iadupqev0

LS0tCiBkcml2ZXJzL3N0YWdpbmcvcnRsODE5MnUvaWVlZTgwMjExL2llZWU4MDIxMV9zb2Z0bWFj
LmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTkydS9pZWVlODAyMTEvaWVl
ZTgwMjExX3NvZnRtYWMuYyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTkydS9pZWVlODAyMTEvaWVl
ZTgwMjExX3NvZnRtYWMuYwppbmRleCBkMmU4YjEyLi4wNDc3YmExIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3N0YWdpbmcvcnRsODE5MnUvaWVlZTgwMjExL2llZWU4MDIxMV9zb2Z0bWFjLmMKKysrIGIv
ZHJpdmVycy9zdGFnaW5nL3J0bDgxOTJ1L2llZWU4MDIxMS9pZWVlODAyMTFfc29mdG1hYy5jCkBA
IC02NjAsMiArNjYwLDIgQEAgaW5saW5lIHN0cnVjdCBza19idWZmICppZWVlODAyMTFfYXV0aGVu
dGljYXRpb25fcmVxKHN0cnVjdCBpZWVlODAyMTFfbmV0d29yayAqYmUKIAlhdXRoID0gKHN0cnVj
dCBpZWVlODAyMTFfYXV0aGVudGljYXRpb24gKikKIAkJc2tiX3B1dChza2IsIHNpemVvZihzdHJ1
Y3QgaWVlZTgwMjExX2F1dGhlbnRpY2F0aW9uKSk7CgotCWF1dGgtPmhlYWRlci5mcmFtZV9jdGwg
PSBJRUVFODAyMTFfU1RZUEVfQVVUSDsKLQlpZiAoY2hhbGxlbmdlbGVuKSBhdXRoLT5oZWFkZXIu
ZnJhbWVfY3RsIHw9IElFRUU4MDIxMV9GQ1RMX1dFUDsKKwlhdXRoLT5oZWFkZXIuZnJhbWVfY3Rs
ID0gY3B1X3RvX2xlMTYoSUVFRTgwMjExX1NUWVBFX0FVVEgpOworCWlmIChjaGFsbGVuZ2VsZW4p
CisJCWF1dGgtPmhlYWRlci5mcmFtZV9jdGwgfD0gY3B1X3RvX2xlMTYoSUVFRTgwMjExX0ZDVExf
V0VQKTsKCiAJYXV0aC0+aGVhZGVyLmR1cmF0aW9uX2lkID0gMHgwMTNhOyAvL0ZJWE1FCgotLQoy
LjEuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2
ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZl
cmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRl
dmVsCgo=
--089e013d1472e08373051773b3be--
