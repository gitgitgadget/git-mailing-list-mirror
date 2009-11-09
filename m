From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #02; Sun, 08)
Date: Mon, 9 Nov 2009 00:08:43 -0800
Message-ID: <905315640911090008h34b55a37q439d02de37127039@mail.gmail.com>
References: <7vzl6wz36r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502aeebebb5ce0477ebb46a
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 09:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7PJi-0003q4-OZ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 09:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbZKIII7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 03:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbZKIII7
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 03:08:59 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35974 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbZKIII5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 03:08:57 -0500
Received: by pwi3 with SMTP id 3so483774pwi.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 00:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=+aCAMqFc5QCz2bqK3pVoXFs5CWvLZEH62mHxODtE+VM=;
        b=NK0NjpBOE146nSwtSw0Z5VoDlLmxcNPs09hvkaBLZuTtfk3HSr3L3YxNkRRScrHFi4
         HvUNLSEAdvKg+GmqkjX1AE/tEvoIZX9YlWXIOpmZKNrPB4UjvibDg1clrQubqLXyG3uJ
         1b4pWfeuK7z3woAgoWAy8S/RoA14wFziUUJx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=hLnwngfk/hP0Jo6xc6mdwtiDMqqaDt3i8HrMTSTcvOsaAuFFxtTInaDF38uqMNFK77
         8n76822Da+Tud6eC32Z6v7nfjf1+9poZtIxvv+yjgzX8F5jh4+uBt12JbWc6PNKLetNt
         SbLj2AKwnPn+G4rsSVxbiz21F4n2wfK0Y/9BU=
Received: by 10.142.59.6 with SMTP id h6mr791053wfa.21.1257754143208; Mon, 09 
	Nov 2009 00:09:03 -0800 (PST)
In-Reply-To: <7vzl6wz36r.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 617ac67e42207f18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132451>

--00504502aeebebb5ce0477ebb46a
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Nov 8, 2009 at 9:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * sp/smart-http (2009-11-04) 30 commits
>  + test smart http fetch and push

I am trying to test smart http, and have had to set
DEFAULT_HTTPD_PATH='/usr/sbin/httpd'
DEFAULT_HTTPD_MODULE_PATH='/usr/lib64/httpd/modules' on Centos.
Perhaps this failing test is just a difference in the default Apache
and curl configurations.

Testing with 7f640b7 ("http-backend: Test configuration options")
gives me errors with the third test in t5551-http-fetch.   I don't
really know the point of the sed lines, but I am attaching my "err"
file in case some of the problem is with the CR/LF stuff.

Thanks,
Tarmigan

* expecting success:
	GIT_CURL_VERBOSE=1 git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
	test_cmp file clone/file &&
	tr '\015' Q <err |
	sed -e "
		s/Q\$//
		/^[*] /d

		/^[^><]/{
			s/^/> /
		}

		/^> User-Agent: /d
		/^> Host: /d
		s/^> Content-Length: .*/> Content-Length: xxx/

		/^< Server: /d
		/^< Expires: /d
		/^< Date: /d
		/^< Content-Length: /d
		/^< Transfer-Encoding: /d
	" >act &&
	test_cmp exp act

--- exp	2009-11-09 07:33:19.000000000 +0000
+++ act	2009-11-09 07:33:19.000000000 +0000
@@ -6,15 +6,16 @@
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-advertisement
-<
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
+> Accept: */*
 > Accept-Encoding: deflate, gzip
 > Content-Type: application/x-git-upload-pack-request
 > Accept: application/x-git-upload-pack-response
 > Content-Length: xxx

+> 0073want 1937bb05802e1973cc2e437c13e9f1845941b785
multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta
+> 00000009done
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-result
-<
* FAIL 3: clone http repository
	
		GIT_CURL_VERBOSE=1 git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
		test_cmp file clone/file &&
		tr '\015' Q <err |
		sed -e "
			s/Q\$//
			/^[*] /d
	
			/^[^><]/{
				s/^/> /
			}
	
			/^> User-Agent: /d
			/^> Host: /d
			s/^> Content-Length: .*/> Content-Length: xxx/
	
			/^< Server: /d
			/^< Expires: /d
			/^< Date: /d
			/^< Content-Length: /d
			/^< Transfer-Encoding: /d
		" >act &&
		test_cmp exp act

--00504502aeebebb5ce0477ebb46a
Content-Type: application/octet-stream; name=err
Content-Disposition: attachment; filename=err
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1sybf4e0

KiBDb3VsZG4ndCBmaW5kIGhvc3QgMTI3LjAuMC4xIGluIHRoZSAubmV0cmMgZmlsZSwgdXNpbmcg
ZGVmYXVsdHMKKiBBYm91dCB0byBjb25uZWN0KCkgdG8gMTI3LjAuMC4xIHBvcnQgNTU1MQoqICAg
VHJ5aW5nIDEyNy4wLjAuMS4uLiAqIGNvbm5lY3RlZAoqIENvbm5lY3RlZCB0byAxMjcuMC4wLjEg
KDEyNy4wLjAuMSkgcG9ydCA1NTUxCj4gR0VUIC9zbWFydC9yZXBvLmdpdC9pbmZvL3JlZnM/c2Vy
dmljZT1naXQtdXBsb2FkLXBhY2sgSFRUUC8xLjENClVzZXItQWdlbnQ6IGdpdC8xLjYuNS40NS5n
N2Y2NDANCkhvc3Q6IDEyNy4wLjAuMTo1NTUxDQpBY2NlcHQ6ICovKg0KUHJhZ21hOiBuby1jYWNo
ZQ0KDQo8IEhUVFAvMS4xIDIwMCBPSw0KPCBEYXRlOiBNb24sIDA5IE5vdiAyMDA5IDA3OjI5OjA5
IEdNVA0KPCBTZXJ2ZXI6IEFwYWNoZS8yLjIuMyAoQ2VudE9TKQ0KPCBFeHBpcmVzOiBGcmksIDAx
IEphbiAxOTgwIDAwOjAwOjAwIEdNVA0KPCBQcmFnbWE6IG5vLWNhY2hlDQo8IENhY2hlLUNvbnRy
b2w6IG5vLWNhY2hlLCBtYXgtYWdlPTAsIG11c3QtcmV2YWxpZGF0ZQ0KPCBUcmFuc2Zlci1FbmNv
ZGluZzogY2h1bmtlZA0KPCBDb250ZW50LVR5cGU6IGFwcGxpY2F0aW9uL3gtZ2l0LXVwbG9hZC1w
YWNrLWFkdmVydGlzZW1lbnQNCiogQ29ubmVjdGlvbiAjMCB0byBob3N0IDEyNy4wLjAuMSBsZWZ0
IGludGFjdAoqIENvdWxkbid0IGZpbmQgaG9zdCAxMjcuMC4wLjEgaW4gdGhlIC5uZXRyYyBmaWxl
LCB1c2luZyBkZWZhdWx0cwoqIFJlLXVzaW5nIGV4aXN0aW5nIGNvbm5lY3Rpb24hICgjMCkgd2l0
aCBob3N0IDEyNy4wLjAuMQoqIENvbm5lY3RlZCB0byAxMjcuMC4wLjEgKDEyNy4wLjAuMSkgcG9y
dCA1NTUxCj4gUE9TVCAvc21hcnQvcmVwby5naXQvZ2l0LXVwbG9hZC1wYWNrIEhUVFAvMS4xDQpV
c2VyLUFnZW50OiBnaXQvMS42LjUuNDUuZzdmNjQwDQpIb3N0OiAxMjcuMC4wLjE6NTU1MQ0KQWNj
ZXB0OiAqLyoNCkFjY2VwdC1FbmNvZGluZzogZGVmbGF0ZSwgZ3ppcA0KQ29udGVudC1UeXBlOiBh
cHBsaWNhdGlvbi94LWdpdC11cGxvYWQtcGFjay1yZXF1ZXN0DQpBY2NlcHQ6IGFwcGxpY2F0aW9u
L3gtZ2l0LXVwbG9hZC1wYWNrLXJlc3BvbnNlDQpDb250ZW50LUxlbmd0aDogMTI4DQoNCjAwNzN3
YW50IDAxNmE4NzJjZTk3Nzk1ZDk5MWE5YzUwMTRhMGJiYzhhYTRlY2NhMzkgbXVsdGlfYWNrX2Rl
dGFpbGVkIHNpZGUtYmFuZC02NGsgdGhpbi1wYWNrIG5vLXByb2dyZXNzIG9mcy1kZWx0YQowMDAw
MDAwOWRvbmUKPCBIVFRQLzEuMSAyMDAgT0sNCjwgRGF0ZTogTW9uLCAwOSBOb3YgMjAwOSAwNzoy
OTowOSBHTVQNCjwgU2VydmVyOiBBcGFjaGUvMi4yLjMgKENlbnRPUykNCjwgRXhwaXJlczogRnJp
LCAwMSBKYW4gMTk4MCAwMDowMDowMCBHTVQNCjwgUHJhZ21hOiBuby1jYWNoZQ0KPCBDYWNoZS1D
b250cm9sOiBuby1jYWNoZSwgbWF4LWFnZT0wLCBtdXN0LXJldmFsaWRhdGUNCjwgVHJhbnNmZXIt
RW5jb2Rpbmc6IGNodW5rZWQNCjwgQ29udGVudC1UeXBlOiBhcHBsaWNhdGlvbi94LWdpdC11cGxv
YWQtcGFjay1yZXN1bHQNCiogQ29ubmVjdGlvbiAjMCB0byBob3N0IDEyNy4wLjAuMSBsZWZ0IGlu
dGFjdAo=
--00504502aeebebb5ce0477ebb46a--
