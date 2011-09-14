From: Chris Li <git@chrisli.org>
Subject: Re: [PATCH] git-p4: import utf16 file properly
Date: Wed, 14 Sep 2011 11:29:26 -0700
Message-ID: <CANeU7QnW5kSni0W9M9q-FTWv4p_qc67LG3mA6BQj_U-wxNuZeQ@mail.gmail.com>
References: <CANeU7QndA0yv1OzU3vta5B8r8nCRdBSqTy0Rboc_bbpst+1pcw@mail.gmail.com>
	<4E705DF8.1040508@diamand.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec51f8e719e825604aceaf04d
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uDF-00061h-AW
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab1INS31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:29:27 -0400
Received: from mail-gw0-f52.google.com ([74.125.83.52]:42348 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261Ab1INS31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:29:27 -0400
Received: by gwb1 with SMTP id 1so501911gwb.11
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=GhfP0T69HX83/ZIpSVKXc3uQH8PjJ/u2fHO3be2oTYQ=;
        b=jn4QCKMPHuxlEi9VFvmtyEIuP4RT8ENETGzSj9L3jf5KDrdqUBTmpq7R2JEABVK1uI
         euQICWO6vTepTw5ZX3wRPdx3nxYoqi+tYTba3JLhCwNGqdRnX51u1QiED/Zqbz++bjYy
         0hEWoO+imGxZTMhQKxQWytr+q1kyDnLTfK5qk=
Received: by 10.68.12.196 with SMTP id a4mr403854pbc.185.1316024966086; Wed,
 14 Sep 2011 11:29:26 -0700 (PDT)
Received: by 10.143.76.16 with HTTP; Wed, 14 Sep 2011 11:29:26 -0700 (PDT)
In-Reply-To: <4E705DF8.1040508@diamand.org>
X-Google-Sender-Auth: VTmMMtWG5xMnajGrv8e1bWJuGMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181374>

--bcaec51f8e719e825604aceaf04d
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Sep 14, 2011 at 12:55 AM, Luke Diamand <luke@diamand.org> wrote:
> On 13/09/11 22:33, Chris Li wrote:
>> The fix is simple, just ask perforce to print the depot
>> file into a real file. This way perforce will not performe
>> the utf16 to utf8 conversion. Git can import the exact same
>> file as perforce checkout.
>
> Does this change do the right thing with RCS keywords in UTF16 files?

I don't know what is the rules about the RCS keyword in UTF16 files.
I look at the current git-p4, it does not do any keyword replacement in
utf16 files. So this patch did not change that. It should be a separate issue.

The way I see it, this patch is a straight enhancement compare to the
current git-p4 because the current git-p4 *corrupts* the utf16 files.

>
> If p4CmdList() fails, e.g. due to running out of diskspace, will this just
> happily import a truncated/corrupt file?

Good point. I add the error check and attach the new patch.

> (And I could be wrong about this, but does you patch have newline damage? It
> didn't seem to apply for me).

Gmail dmage the white space. I should always use the attachment.
Does the attached patch work for you?

Thanks

Chris

--bcaec51f8e719e825604aceaf04d
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-git-p4-import-utf16-file-properly.patch"
Content-Disposition: attachment; 
	filename="0001-git-p4-import-utf16-file-properly.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gskmtszt0

RnJvbSAwNmRlOWNmZGNkODllOGJmYjY1NzVmNDBkMzZmZGZjZWZlMWExOTg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpcyBMaSA8Z2l0QGNocmlzbGkub3JnPgpEYXRlOiBUdWUs
IDEzIFNlcCAyMDExIDEzOjU3OjMxIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gZ2l0LXA0OiBpbXBv
cnQgdXRmMTYgZmlsZSBwcm9wZXJseQoKVGhlIGN1cnJlbnQgZ2l0LXA0IGRvZXMgbm90IGhhbmRs
ZSB1dGYxNiBmaWxlcyBwcm9wZXJseS4KVGhlICJwNCBwcmludCIgY29tbWFuZCwgd2hlbiBvdXRw
dXQgdG8gc3Rkb3V0LCBjb252ZXJ0IHRoZQp1dGYxNiBmaWxlIGludG8gdXRmOC4gVGhhdCBlZmZl
Y3RpdmVseSBpbXBvcnRlZCB0aGUgdXRmMTYgZmlsZQphcyB1dGY4IGZvciBnaXQuIEluIG90aGVy
IHdvcmRzLCBnaXQtcDQgaW1wb3J0IGEgZGlmZmVyZW50CmZpbGUgY29tcGFyZSB0byBmaWxlIGNo
ZWNrIG91dCBieSBwZXJmb3JjZS4gVGhpcyBicmVha3MgbXkKd2luZG93cyBidWlsZCBpbiB0aGUg
Y29tcGFueSBwcm9qZWN0LgoKVGhlIGZpeCBpcyBzaW1wbGUsIGp1c3QgYXNrIHBlcmZvcmNlIHRv
IHByaW50IHRoZSBkZXBvdApmaWxlIGludG8gYSByZWFsIGZpbGUuIFRoaXMgd2F5IHBlcmZvcmNl
IHdpbGwgbm90IHBlcmZvcm0KdGhlIHV0ZjE2IHRvIHV0ZjggY29udmVyc2lvbi4gR2l0IGNhbiBp
bXBvcnQgdGhlIGV4YWN0IHNhbWUKZmlsZSBhcyBwZXJmb3JjZSBjaGVja291dC4KLS0tCiBjb250
cmliL2Zhc3QtaW1wb3J0L2dpdC1wNCB8ICAgIDggKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbnRyaWIvZmFz
dC1pbXBvcnQvZ2l0LXA0IGIvY29udHJpYi9mYXN0LWltcG9ydC9naXQtcDQKaW5kZXggNmI5ZGU5
ZS4uYzExMWNhZCAxMDA3NTUKLS0tIGEvY29udHJpYi9mYXN0LWltcG9ydC9naXQtcDQKKysrIGIv
Y29udHJpYi9mYXN0LWltcG9ydC9naXQtcDQKQEAgLTEyMzksNiArMTIzOSwxNCBAQCBjbGFzcyBQ
NFN5bmMoQ29tbWFuZCwgUDRVc2VyTWFwKToKICAgICAgICAgICAgIGNvbnRlbnRzID0gbWFwKGxh
bWJkYSB0ZXh0OiByZS5zdWIocicoP2kpXCQoSWR8SGVhZGVyKTpbXiRdKlwkJyxyJyRcMSQnLCB0
ZXh0KSwgY29udGVudHMpCiAgICAgICAgIGVsaWYgZmlsZVsndHlwZSddIGluICgndGV4dCtrJywg
J2t0ZXh0JywgJ2t4dGV4dCcsICd1bmljb2RlK2snLCAnYmluYXJ5K2snKToKICAgICAgICAgICAg
IGNvbnRlbnRzID0gbWFwKGxhbWJkYSB0ZXh0OiByZS5zdWIocidcJChJZHxIZWFkZXJ8QXV0aG9y
fERhdGV8RGF0ZVRpbWV8Q2hhbmdlfEZpbGV8UmV2aXNpb24pOlteJFxuXSpcJCcscickXDEkJywg
dGV4dCksIGNvbnRlbnRzKQorICAgICAgICBlbGlmIGZpbGVbJ3R5cGUnXSA9PSAndXRmMTYnOgor
ICAgICAgICAgICAgIHRtcEZpbGUgPSB0ZW1wZmlsZS5OYW1lZFRlbXBvcmFyeUZpbGUoKQorICAg
ICAgICAgICAgIGNtZCA9ICJwcmludCAtbyAlcyAlcyIlKHRtcEZpbGUubmFtZSwgZmlsZVsnZGVw
b3RGaWxlJ10pCisgICAgICAgICAgICAgcmVzdWx0ID0gcDRDbWQoY21kKQorICAgICAgICAgICAg
IGlmICJwNEV4aXRDb2RlIiBpbiByZXN1bHQ6CisgICAgICAgICAgICAgICAgIGRpZSgiUHJvYmxl
bXMgZXhlY3V0aW5nIHA0ICVzIiVjbWQpCisgICAgICAgICAgICAgY29udGVudHMgPSBbIG9wZW4o
dG1wRmlsZS5uYW1lKS5yZWFkKCkgXQorICAgICAgICAgICAgIHRtcEZpbGUuY2xvc2UoKQogCiAg
ICAgICAgIHNlbGYuZ2l0U3RyZWFtLndyaXRlKCJNICVzIGlubGluZSAlc1xuIiAlIChtb2RlLCBy
ZWxQYXRoKSkKIAotLSAKMS43LjYKCg==
--bcaec51f8e719e825604aceaf04d--
