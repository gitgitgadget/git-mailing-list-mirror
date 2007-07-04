From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix t5516 to create test repo without hooks
Date: Wed, 4 Jul 2007 15:11:01 +0200
Message-ID: <81b0412b0707040611q43054ac1uc0ba8d753dea3f95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_94831_22306003.1183554661104"
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 15:11:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64di-0000Wg-J9
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351AbXGDNLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759339AbXGDNLF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:11:05 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:33433 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275AbXGDNLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:11:03 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1631417ika
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 06:11:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=XpbRgl04USVTJfQyzGaQzfB5Nk1+FOylRRI3C6EaHPgKp/SvljPwsOuj8g1D8FGZL+Q3YTksxQ0BT5yCgNpKIA3urLEoFGXYNB9Cyq5XxJ26vfW8l+0VO8cZTJRx/5I0g8fNYVG6YMUNcXoDfDKcdhw0k46cX8YV6ZDFG5McSgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Wolu9Rp7Hze+JrUDLjeai+JJfjYs5qcZBXybgF2U/ysz4U6hNje1PGmoY6TdSpS/GTBYGta0F9uBBVqlNe2BzkV3jjggNxfxc8gcD0aURrIylO8m9tLJcpWDGH6fwS54/s+YgSFzAkxe5QsbI6ZrUkXpMYLuZzZHcHwFUud70jM=
Received: by 10.78.160.4 with SMTP id i4mr4107026hue.1183554661132;
        Wed, 04 Jul 2007 06:11:01 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 4 Jul 2007 06:11:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51607>

------=_Part_94831_22306003.1183554661104
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise the hooks will be executed on cygwin and the test will fail
because of the contributed hooks.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t5516-fetch-push.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

Before someone tries to say something about Cygwin supporting
permissions on NTFS and not on FAT: it is NTFS.

The relevant output was:

* expecting success:

        mk_test heads/frotz tags/frotz &&
        if git push testrepo master:frotz
        then
                echo "Oops, should have failed"
                false
        else
                check_push_result $the_first_commit heads/frotz tags/frotz
        fi


Initialized empty Git repository in .git/
updating 'refs/heads/frotz' using 'b9c09d6cc74d3857142fb7c082dca65b88254c6d'
  from 0000000000000000000000000000000000000000
  to   b9c09d6cc74d3857142fb7c082dca65b88254c6d
Generating pack...
Done counting 3 objects.
Deltifying 3 objects...
 100% (3/3) done
Writing 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects...
 100% (3/3) done
refs/heads/frotz: 0000000000000000000000000000000000000000 ->
b9c09d6cc74d3857142fb7c082dca65b88254c6d
updating 'refs/tags/frotz' using 'b9c09d6cc74d3857142fb7c082dca65b88254c6d'
  from 0000000000000000000000000000000000000000
  to   b9c09d6cc74d3857142fb7c082dca65b88254c6d
Generating pack...
Done counting 0 objects.
Writing 0 objects...
Total 0 (delta 0), reused 0 (delta 0)
Unpacking 0 objects...
*** The un-annotated tag, frotz, is not allowed in this repository
*** Use 'git tag [ -a | -s ]' for tags you want to propagate.
error: hooks/update exited with error code 1
error: hook declined to update refs/tags/frotz
ng refs/tags/frotz hook declined
error: failed to push to 'testrepo'
Oops, push refs/tags/frotz failure
* FAIL 12: push with ambiguity (2)


                mk_test heads/frotz tags/frotz &&
                if git push testrepo master:frotz
                then
                        echo "Oops, should have failed"
                        false
                else
                        check_push_result $the_first_commit
heads/frotz tags/frotz

------=_Part_94831_22306003.1183554661104
Content-Type: text/plain; 
	name=0001-Fix-t5516-to-create-test-repo-without-hooks.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f3ptsvfp
Content-Disposition: attachment; filename="0001-Fix-t5516-to-create-test-repo-without-hooks.txt"

RnJvbSBiZjkzNzAzMDNiYzY3NTJlYTJlNWY4MTVkMjA3YWNhMTUxZDM2MGQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDQgSnVsIDIwMDcgMTQ6MDY6MDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXggdDU1
MTYgdG8gY3JlYXRlIHRlc3QgcmVwbyB3aXRob3V0IGhvb2tzCgpPdGhlcndpc2UgdGhlIGhvb2tz
IHdpbGwgYmUgZXhlY3V0ZWQgb24gY3lnd2luIGFuZCB0aGUgdGVzdCB3aWxsIGZhaWwKYmVjYXVz
ZSBvZiB0aGUgY29udHJpYnV0ZWQgaG9va3MuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8
cmFhLmxrbWxAZ21haWwuY29tPgotLS0KIHQvdDU1MTYtZmV0Y2gtcHVzaC5zaCB8ICAgIDMgKyst
CiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90L3Q1NTE2LWZldGNoLXB1c2guc2ggYi90L3Q1NTE2LWZldGNoLXB1c2guc2gKaW5k
ZXggYzBmYTJiYS4uY2E0NmFhZiAxMDA3NTUKLS0tIGEvdC90NTUxNi1mZXRjaC1wdXNoLnNoCisr
KyBiL3QvdDU1MTYtZmV0Y2gtcHVzaC5zaApAQCAtMTEsNyArMTEsOCBAQCBta19lbXB0eSAoKSB7
CiAJbWtkaXIgdGVzdHJlcG8gJiYKIAkoCiAJCWNkIHRlc3RyZXBvICYmCi0JCWdpdCBpbml0CisJ
CWdpdCBpbml0ICYmCisJCW12IC5naXQvaG9va3MgLmdpdC9ob29rcy1kaXNhYmxlZAogCSkKIH0K
IAotLSAKMS41LjMucmMwLjc1OS5nNmMxMTIKCg==
------=_Part_94831_22306003.1183554661104--
