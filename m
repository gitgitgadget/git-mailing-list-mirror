From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 0/4] Re-implement 'remote update' using 'fetch'
Date: Sun, 08 Nov 2009 16:44:52 +0100
Message-ID: <4AF6E774.80909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 16:45:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N79x5-0001nj-A6
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 16:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbZKHPo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 10:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbZKHPot
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 10:44:49 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50174 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZKHPos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 10:44:48 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so2428901ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=WmVlK4d/bWrwYb5SDG/zdMySPde15N8K43Z1UevQYCY=;
        b=jhd+LUbk/RTT5Nl6ISr40z09KZYOKtdChEry6kNSVuKXNcxeEZbcp9vrtIzxv1+INs
         2JQtI+Yg4FkR3aOgfyDyHhJSH4sglXmpn4woXrVG18c7vfvwG5j5iL0IUtecD0D77MnH
         OZMMt/km8nRevVaNmTHK0ODGVo/wHEDaTcf0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=f2OFNQjI3oKM4/FnKZAei1uZMvyNACsTIJ3JbJ0Nah9jBVlDdJETALbscb3YtlxW3k
         GpDFX75jeVUhAk9D8gCc4jb//bYemSaxovucNrzr98eQysUpNqvQ+oGxaJI4Wh1sHZCq
         xvg7NJbKiuGOV1qdU/E5s/NKMT3U0BcHUOzoU=
Received: by 10.213.0.143 with SMTP id 15mr7776482ebb.54.1257695093788;
        Sun, 08 Nov 2009 07:44:53 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm3820197eyg.30.2009.11.08.07.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 07:44:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132403>

After having done my previous patch to implement 'git fetch --all'
I decided to implement as much functionality in 'git fetch' to
make it possibility to re-implement 'git remote update' in terms of
'git fetch'.

The following things are currently missing from the patch series:

* updated documentation
* test cases for the group functionality in fetch
* support for 'git remote update --prune'

There is also a slight backward incompatibility that I know of (see the=
 commit
message for the last commit). I could fix that, if there are
people depending on it.

I have no idea how much of the group functionality is really used. If s=
omeone
knows that "no-one uses THIS feature and" it would be nice to know.

Bj=C3=B6rn Gustavsson (4):
  Teach the --all option to 'git fetch'
  Teach the --multiple option to 'git fetch'
  Add the configure variable skipFetchAll
  Re-implement 'git remote update' using 'git fetch'

 Documentation/git-fetch.txt |    5 ++
 builtin-fetch.c             |  158 +++++++++++++++++++++++++++++++++++=
+++-----
 builtin-remote.c            |   86 +++++++----------------
 remote.c                    |    3 +-
 t/t5514-fetch-all.sh        |   76 +++++++++++++++++++++
 5 files changed, 249 insertions(+), 79 deletions(-)
 create mode 100755 t/t5514-fetch-all.sh
