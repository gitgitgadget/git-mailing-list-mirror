From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 0/5] Re-implement 'git remote update' using 'git fetch'
Date: Mon, 09 Nov 2009 21:08:52 +0100
Message-ID: <4AF876D4.5010207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 21:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7aY6-0007iM-Lj
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbZKIUJC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 15:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbZKIUJB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:09:01 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:65151 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZKIUJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:09:00 -0500
Received: by ewy3 with SMTP id 3so3510617ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ULJAjtsD2mqCLoLr1m+ropuxs/s2/DsrQihL/6Xfb7U=;
        b=BsxG8bWniHFu4reXJiK837BZH3cZ6xm/wvJZ9DGBd5uez4smJvuPpZfmC0Ksn3KOC2
         y8UdczXXRZwR+6MiYg6cRXIp6uHTiZG7bAltUORBf4rsZVdy/ECWR8HAeCwm+gFjuMuD
         Bcpw2HmZ50dKCWdTn+BzSp+JlYuVVPwIDRGUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=TX4Pe+JrdY4DNbb1bbHvBD0glZq/ZPQg7Ex3ny9Bjmu8K851hkKI8i2O1xfu+AGm7Q
         SA0AKh23s3kLwXgLMT+Biqw4sZCby0xIFh44CiDfGY7KAdy3L3Pr4ksAMEqiGBrbqY11
         oTYdz4Rfk9jZYIAY4VQa09L9D0KHHgOANIJYY=
Received: by 10.213.24.22 with SMTP id t22mr3802077ebb.59.1257797335194;
        Mon, 09 Nov 2009 12:08:55 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm68214eyg.25.2009.11.09.12.08.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 12:08:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132513>

Here is the re-roll of my patch series for extending
the capabilities of 'git fetch' so that it can be used
for re-implementing 'git remote update'.

Since Jay Soffian is working on implementing 'git fetch
--prune', I have not attempted to implement it myself.
Therefore, 'git fetch update' in the final patch still
silently ignores the --prune option.

I have made the following changes compared to the previous
version of the series:

* Updated the usage strings in builtin_fetch.c.

* Added test cases for testing the new functionality in
  'git fetch'.

* Updated the documentation.

* Added a new test case for 'git remote update --prune'.
  (Since all tests case succeeded even though 'git
  remote update' didn't handle --prune correctly, there
  was clearly a missing test case.) In the final commit,
  I marked that new test case as a known breakage, so
  that the test suite will still pass.

* Some corrections and improvements of the commit
  messages.


Bj=C3=B6rn Gustavsson (5):
  Teach the --all option to 'git fetch'
  Teach the --multiple option to 'git fetch'
  Add the configuration option skipFetchAll
  Add missing test for 'git remote update --prune'
  Re-implement 'git remote update' using 'git fetch'

 Documentation/config.txt           |    8 ++-
 Documentation/fetch-options.txt    |    9 ++
 Documentation/git-fetch.txt        |   14 +++-
 Documentation/pull-fetch-param.txt |    7 ++
 builtin-fetch.c                    |  160 ++++++++++++++++++++++++++++=
++++----
 builtin-remote.c                   |   86 ++++++-------------
 remote.c                           |    3 +-
 t/t5505-remote.sh                  |   11 +++
 t/t5506-remote-groups.sh           |   21 ++++-
 t/t5514-fetch-multiple.sh          |  154 ++++++++++++++++++++++++++++=
++++++
 10 files changed, 389 insertions(+), 84 deletions(-)
 create mode 100755 t/t5514-fetch-multiple.sh
