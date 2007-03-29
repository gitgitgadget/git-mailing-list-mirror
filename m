From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-mailinfo munges the patch?
Date: Thu, 29 Mar 2007 14:24:39 -0700
Message-ID: <7vejn73fqg.fsf@assigned-by-dhcp.cox.net>
References: <7v1wj74xck.fsf@assigned-by-dhcp.cox.net>
	<20070329205357.GF11029@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX26u-0007JX-SJ
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 23:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030737AbXC2VYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030748AbXC2VYl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 17:24:41 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59780 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030737AbXC2VYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 17:24:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329212440.KVF792.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 17:24:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id glQf1W00J1kojtg0000000; Thu, 29 Mar 2007 17:24:40 -0400
In-Reply-To: <20070329205357.GF11029@redhat.com> (Don Zickus's message of
	"Thu, 29 Mar 2007 16:53:57 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43475>

--=-=-=

Don Zickus <dzickus@redhat.com> writes:

> On Thu, Mar 29, 2007 at 01:18:51PM -0700, Junio C Hamano wrote:
>> I noticed that the new mailinfo when splitting a message into
>> cover letter and the patch text seems to munge the patch text,
>> applying the same "if content-type is not there then assume
>> latin-1 and recode to utf-8" logic that is applied to the commit
>> log message.  That munging should not be done to the patch text,
>> and it appears the current code botches it.
>
> Ok.  I see what you are saying with the old code.  Sorry about that.  Do
> you have a sample file that I can play with to test my fix?

Attached are two files.

The first one is to be split with git-mailsplit and then
processed with git-mailinfo; I just tried to make sure what I
expect to see as the output is given by 1.5.0 but not with the
current 'master'.

The second one is a bundle of the repository the test data comes
from.  You could use it like this:

	$ mkdir foo && cd foo && git init
        $ git pull ../sample.bdl master

The repository has one branch, 'master', with two commits on
it.  The first one creates an empty file 'a', and the second one
adds a line to the file, which has a Spanish "tilde on top of N"
in it, and the contents of the file is encoded in ISO 8859-1.

The commit message of the second one is plain ascii but it could
be in UTF-8.

The point is that patch can have payload from different files
that are possibly in different encodings, so shoud really be
treated as binary data without mangling.

Thanks.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment;
 filename=0001-Add-a-line-with-ISO-8859-1-contents.txt
Content-Transfer-Encoding: base64
Content-Description: sample input

RnJvbSAxMTlkY2E3ZTlkOTA1YjczY2E5NGExZDYyNWQ3NTIwOWQyNDFlYzU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW5pbyBDIEhhbWFubyA8anVua2lvQGNveC5uZXQ+CkRhdGU6
IFRodSwgMjkgTWFyIDIwMDcgMTQ6MTY6MDEgLTA3MDAKU3ViamVjdDogQWRkIGEgbGluZSB3aXRo
IElTTyA4ODU5LTEgY29udGVudHMKClRoaXMgYWRkcyBhIGxpbmUgd2l0aCB0aWxkZS1vbi10b3At
b2YtTiBjaGFyYWN0ZXIgaW4gSVNPIDg4NTktMS4KVGhpcyBjb21taXQgbG9nIG1lc3NhZ2UgaXRz
ZWxmIGlzIGluIHBsYWluIGFzY2lpIGJ1dCBpdCBjb3VsZCBiZSBpbgpVVEYtOC4nCi0tLQogYSB8
ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYSBiL2EKaW5kZXggZTY5ZGUyOS4uNmNjYmVjNCAxMDA2NDQKLS0tIGEv
YQorKysgYi9hCkBAIC0wLDAgKzEgQEAKK0lTTyA4ODU5IDEg0SAoU3BhbmlzaCBlbiB3aXRoIHRp
bGRlIG9uIHRvcCkKLS0gCjEuNS4xLnJjMy41LmdlOTFlCgo=
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=sample.bdl
Content-Transfer-Encoding: base64
Content-Description: sample repository bundle

IyB2MiBnaXQgYnVuZGxlCjExOWRjYTdlOWQ5MDViNzNjYTk0YTFkNjI1ZDc1MjA5ZDI0MWVjNTkg
cmVmcy9oZWFkcy9tYXN0ZXIKClBBQ0sAAAACAAAABpQYeJyNjrFOxDAQRHt/xXZUPtmJnWwkhEBI
CCig4PiAPXt9MST2KXEEn4/RUUBHM83MG72yMIMzTThgQFZW2cAaLQarOkTP3BttTdN2ilCLEy2c
CqB2xqHTNnQBh8aRVsOgfKCgjXGWtUHsdcuCtjLmBR63FDPcwj3NlDJcvm3pPeZrlz93icsVaN3b
RjVDp0GqXinh8jzHUvi/aNuq9gcVN94DwRQTw0csIzy8PAOiHaQGl1Op/qsQ+zGuQN6vf6YlTp5l
TrLkk8xBPoEbaSH3LRLTr6fd+eCsCVM+wszrSkeGWFaeAtSyAqeJatLqYoTDVmpZkW3ycKjDJF73
dxJ3F+IL+dJ3IpgLeJydy1EKAiEQANB/TzHsf+EMrqsQUfQT3cLVkax0YlGo23eH3v/rGzMYb5M1
5FYfsyfvMEVv/EyIbBmRdF5tpjWoMPpdNriNVgQucA01NIHDY7RnkVOUz75xPwLiMpNG5wh2etFa
Ram19M5/VHVOCUIDru/+hVxeDFOY1A/fNzaNrQF4nDM0MDAzMVFIZMg5/cbnkJr994NOa0+KpEnJ
BixfrA0AmQ4LLbwCeJzzDPZXsLAwtVQwVLiooBFckJiXWZyhkJqnUJ5ZkqFQkpmTkqqQn6dQkl+g
yQUALBIN7q0BeJwzNDAwMzFRSGR4NvfR7E0Xrzl7d2uuK4+6cehJT/BEAK+QDbkweJwDAAAAAAHL
qcltGNolWmCG+4he+bBqEKvRGA==
--=-=-=--
