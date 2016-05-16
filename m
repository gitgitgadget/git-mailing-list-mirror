From: tboegi@web.de
Subject: [PATCH v3 0/1] CRLF-Handling: bug fix around ce_compare_data()
Date: Mon, 16 May 2016 17:51:29 +0200
Message-ID: <1463413889-12490-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 17:47:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Kj7-0000hc-Pu
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbcEPPqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2016 11:46:08 -0400
Received: from mout.web.de ([212.227.15.14]:64584 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbcEPPqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:46:06 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LqDHE-1bX0lW2ln6-00djyA; Mon, 16 May 2016 17:46:02
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:2Ych8DMkLrFYDoi29nlX8LhTyOMnqA2GHIPsMh/3JGh/TLsJoZI
 TdTunWKa2B+PkrijSpgSYH0e090H6mJ+3/HIxtUAy2/2NNGecqB+v7YKvrRJ5kA7kyagn6C
 ByXmTH+DokOA2nEJAJ0bn77sQZ2p1C2atiI42tYB9zBUZQu+Ys96qtFEGxm3L+AzNx33N+Y
 5YeJTZaCrW+JXRHYopDqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UgIjJH8dCyY=:BkuX5gSxBSMjxwKdtaGyGd
 PKqOoffRkx22yQa0w4m29z8FtoDNYbcEr9rOJ1z4HSLty5JUsSJ8/+mkq29GMAdOhJYBOCx2/
 H9wL8qKUPgnpv4C3baB7/9AKCqq3K2mSUanfZfFv2cN7Y2qiVJ8Hq0+gc6rjMa+nqs3SsWFWE
 S0eifrvnrJJ19gvczW8nA2/gIeHj49uLMiEK4o/MCVOfKzDTdTlgMoicoIzS5Kz4mxSr4+PB+
 +6luriOGixK5DpwWdRf6EEafSPryXpSTXN5DIpkJnuUsZX0K6Zo4V2nW35jVZaZm3nkJLDxtB
 OQX1oNqnpdQJOeh+SsWyOs+an0CNWHF61AQx486tDDYhG6mQpU+TsQeKr9j0FjFP/mE3uNT98
 g6QJN2PTdkldyBp2OMzN3BgfUjLawSrKPGQM+YGh/qa31rWQAmkjxzpi7H2zvu196fnawvqrU
 UjkNLW+WIjsxV+UvDPv6yYabW87xe7ySoasXUKY8WIl+qkp3+1g9B0YunOyyC8jr4cTGU1vnC
 8lnKCYJjL4gfrfNuMWPz3a4OLb6QcLd3Zz6nY7xBYnxZkhXiicWNLefdSMNmck0drf9Gc0ilO
 yBqMUnb6JzxewEeR4fLH15KUWZbfSqNVzTgnzA0hQvPyJ59MQlBArtUQiZ7HoWtLH4Xk0oeDz
 x4P3VrxHXD1/u2lIFix/enVTvTHyu+niR0ycW4ig2e0AsBChOztJb6YkCutdOE961fJ6VXEiT
 mA0fVZ2TZLRpYpCwegO+Z9YHkUO4tmgAYwC1Ng/n13CQKW0B7wB/J07SRCrmVKGVb10C/d7P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294745>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Changes since v2:

- Only 1 patch, the t6038 needs to go as a separate "series"

has_cr_in_index() uses either
	data =3D read_sha1_file(sha1, &type, &sz);
or
	data =3D read_blob_data_from_cache(path, &sz);

(I like v2 better, since there is a single code to get a sha object
into memory, which later will be replaced by a streaming object)
But in any case, here is v3

Torsten B=C3=B6gershausen (1):
  convert: ce_compare_data() checks for a sha1 of a path

 cache.h                    |  1 +
 convert.c                  | 35 +++++++++++++++++++++--------------
 convert.h                  | 23 +++++++++++++++++++----
 read-cache.c               |  4 +++-
 sha1_file.c                | 17 +++++++++++++----

--=20
2.0.0.rc1.6318.g0c2c796
