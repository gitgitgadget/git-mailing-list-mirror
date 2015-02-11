From: Junio C Hamano <gitster@pobox.com>
Subject: Re: read() MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Wed, 11 Feb 2015 13:13:10 -0800
Message-ID: <xmqqmw4ktamx.fsf@gitster.dls.corp.google.com>
References: <loom.20150207T174514-727@post.gmane.org>
	<54D64939.4080102@web.de> <loom.20150207T182443-33@post.gmane.org>
	<54D67662.7040504@web.de>
	<CAPc5daUnKcktv0xcz-fGEApckbkQksKuZO53ZL20E1MhtZmn4w@mail.gmail.com>
	<loom.20150207T232422-706@post.gmane.org>
	<CAPc5daXD_7XZD5Vag51BjrSZ0q1r9eMswhLmnpUFqqjrc9oSTw@mail.gmail.com>
	<loom.20150208T125055-287@post.gmane.org>
	<CAPig+cTbLOV-0yFKp8wwVLSr4OJz7LUaLZgVGHUdFhj7xZEzrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:13:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLeb3-0000QC-Is
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 22:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbbBKVNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2015 16:13:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754572AbbBKVNN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 16:13:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 37FD2369CD;
	Wed, 11 Feb 2015 16:13:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lEugjbaqjt2S
	BV01YyDieFEj3sk=; b=JjY7Lab8mPExI7YwRAuFXCMz+c4iv5Upf/9ghhua/yKr
	KxwALVz+44AO6dDCZ8usa/6FQsCNQULwCRlHCi9vZuAZp2gL8AuG6KyTmdp6GCo7
	+9sF82cy95ZHgrh3nND2mSJipCP8FmRdD69jyAghN8UucD2gMXd/NJNbeTDRm60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nh1TQp
	okE9IhWVhAMY0liO+Qle9VuJmK5BK9z+4JqL5HsFzu3o6plcTAaAl4X5QTePsQaf
	QqTenYREN58CNjqyPAsVWcxWBRm9QsCNBHAUGPR1MEtaYjsIsewbnxaeCaAVL/fQ
	TfJdjF1cBaAAs+vH4KWp5HTHzT8kFGKIhWkPc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E788369CC;
	Wed, 11 Feb 2015 16:13:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E697369C9;
	Wed, 11 Feb 2015 16:13:11 -0500 (EST)
In-Reply-To: <CAPig+cTbLOV-0yFKp8wwVLSr4OJz7LUaLZgVGHUdFhj7xZEzrw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 8 Feb 2015 12:09:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C8DBFD7E-B232-11E4-8C70-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263691>

Eric Sunshine <sunshine@sunshineco.com> writes:

> A bit cleaner:
>
> #ifndef(MAX_IO_SIZE)
> # define MAX_IO_SIZE_DEFAULT (8*1024*1024)
> # if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
> #  define MAX_IO_SIZE SSIZE_MAX
> # else
> #  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
> # endif
> #endif

OK, then let's do this.

-- >8 --
Subject: xread/xwrite: clip MAX_IO_SIZE to SSIZE_MAX

Since 0b6806b9 (xread, xwrite: limit size of IO to 8MB, 2013-08-20),
we chomp our calls to read(2) and write(2) into chunks of
MAX_IO_SIZE bytes (8 MiB), because a large IO results in a bad
latency when the program needs to be killed.  This also brought our
IO below SSIZE_MAX, which is a limit POSIX allows read(2) and
write(2) to fail when the IO size exceeds it, for OS X, where a
problem was originally reported.

However, there are other systems that define SSIZE_MAX smaller than
our default X-<.  Make sure we clip our calls to this as well.

Reported-by: Joachim Schmitz <jojo@schmitz-digital.de>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wrapper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 007ec0d..50e6697 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -172,8 +172,21 @@ void *xcalloc(size_t nmemb, size_t size)
  * 64-bit is buggy, returning EINVAL if len >=3D INT_MAX; and even in
  * the absence of bugs, large chunks can result in bad latencies when
  * you decide to kill the process.
+ *
+ * We pick 8 MiB as our default, but if the platform defines SSIZE_MAX
+ * that is smaller than that, clip it to SSIZE_MAX, as a call to
+ * read(2) or write(2) larger than taht is allowed to fail.  As the la=
st
+ * resort, we allow a port to pass via CFLAGS e.g. "-DMAX_IO_SIZE=3Dva=
lue"
+ * to override this, if the definition of SSIZE_MAX platform is broken=
=2E
  */
-#define MAX_IO_SIZE (8*1024*1024)
+#ifndef(MAX_IO_SIZE)
+# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
+# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
+#  define MAX_IO_SIZE SSIZE_MAX
+# else
+#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
+# endif
+#endif
=20
 /*
  * xread() is the same a read(), but it automatically restarts read()
