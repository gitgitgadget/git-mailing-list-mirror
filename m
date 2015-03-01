From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH 0/5] protocol v2 for upload-pack
Date: Sun, 01 Mar 2015 10:11:30 +0100
Message-ID: <54F2D7C2.4010700@kdbg.org>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com> <1425085318-30537-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 10:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRzuk-0003wb-2l
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 10:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbbCAJLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2015 04:11:40 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:39122 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750956AbbCAJLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 04:11:35 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kvzPH5t9qz5tlD;
	Sun,  1 Mar 2015 10:11:31 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id EF26E51D8;
	Sun,  1 Mar 2015 10:11:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1425085318-30537-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264554>

Am 28.02.2015 um 02:01 schrieb Stefan Beller:
> Heavily inspired by the ideas of Duy, who wrote the first
> patches nearly a year ago.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
>    upload-pack: only accept capabilities on the first "want" line
>    upload-pack: support out of band client capability requests
>
> Stefan Beller (3):
>    connect.c: connect to a remote service with some flags
>    daemon.c: accept extra service arguments
>    WIP/Document the http protocol change
>
>   Documentation/git-upload-pack.txt                 | 10 +++++-
>   Documentation/technical/http-protocol.txt         |  4 +--
>   Documentation/technical/protocol-capabilities.txt |  4 +++
>   builtin/fetch-pack.c                              |  2 +-
>   builtin/send-pack.c                               |  2 +-
>   connect.c                                         | 21 ++++++------
>   connect.h                                         |  2 +-
>   daemon.c                                          | 37 ++++++++++++=
+--------
>   transport.c                                       |  3 +-
>   upload-pack.c                                     | 39 ++++++++++++=
+++++------
>   10 files changed, 86 insertions(+), 38 deletions(-)
>

You may also consider an idea I proposed here:

http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=3D2=
07342

The idea is that the exchange begins as usual, but when the v2 client=20
sees that the server also supports v2, then it begins sending its=20
desired refs. When the server notices that the client spoke while it wa=
s=20
still sending out its megabytes of ref advertisments, it stops the v1=20
advertisements and continues with v2 protocol.

But Shawn pointed out that this would be difficult to implement in a=20
JGit server because there is no way to poll the incoming channel while=20
it is sending out refs.

-- Hannes
