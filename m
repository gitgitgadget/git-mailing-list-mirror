From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 2/6] xutils: fix hash with whitespace on
 incomplete line
Date: Sun, 23 Aug 2009 00:51:09 -0700
Message-ID: <7veir3ynma.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-2-git-send-email-git@tbfowler.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Sun Aug 23 09:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf7rR-0006Lo-Ny
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 09:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbZHWHvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 03:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755869AbZHWHvU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 03:51:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbZHWHvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 03:51:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7623715E2D;
	Sun, 23 Aug 2009 03:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fi0oNNi+crXfsBGGMAwECWyeH9Q=; b=ei7kQeYi6N8ATQIMIEJUi/U
	ekMuFOxLYetkABjpbCVatrk8lq0cmsgmpjFaQD4Nn61b4s6/yVMIttRnjbQKoA1u
	JRF2Sl2NmeAg2aYBmSupYu5ZYsD+pUACIn1WaFTenmFuU6/zXm5mWH3ffpONUUbb
	6LDkzkgkbbCzSmohQZbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=d1FiJh68ZIe1FMYqzwrtb/C5LD+bNUDnmpFP1Ze6jAlJ3FBwo
	QRRdzgdk2f4cNYmLsH2CLxPe9kzDsyj9Ik30aoTvGyLehwjo2JrFR9xiPjlUij+9
	+oqHXYh1W5YIy/7BUW8Y6GkHJVymWNfquBBX3tWMoi92PgChHR9pe9qXFQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4872D15E2C;
	Sun, 23 Aug 2009 03:51:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76F9815E2B; Sun, 23 Aug
 2009 03:51:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD2483BC-8FB9-11DE-A56C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126846>

Thell Fowler <git@tbfowler.name> writes:

>   - Make xdl_hash_record_with_whitespace stop hashing before the
>     eof when ignoring space change or space at eol on an incomplete
>     line.
>
>   Resolves issue with a final trailing space being included in the
>   hash on an incomplete line by treating the eof in the same fashion
>   as a newline.

Please study the style of existing commit messages and imitate them.

> Signed-off-by: Thell Fowler <git@tbfowler.name>
> ---
>  xdiff/xutils.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 04ad468..c6512a5 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -248,12 +248,12 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
>  			if (flags & XDF_IGNORE_WHITESPACE)
>  				; /* already handled */
>  			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
> -					&& ptr[1] != '\n') {
> +					&& ptr[1] != '\n' && ptr + 1 < top) {
>  				ha += (ha << 5);
>  				ha ^= (unsigned long) ' ';
>  			}
>  			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
> -					&& ptr[1] != '\n') {
> +					&& ptr[1] != '\n' && ptr + 1 < top) {
>  				while (ptr2 != ptr + 1) {
>  					ha += (ha << 5);
>  					ha ^= (unsigned long) *ptr2;

Thanks.

The issue you identified and tried to fix is a worthy one.  But before the
pre-context of this hunk, I notice these lines:

		if (isspace(*ptr)) {
			const char *ptr2 = ptr;
			while (ptr + 1 < top && isspace(ptr[1])
					&& ptr[1] != '\n')
				ptr++;

If you have trailing whitespaces on an incomplete line, ptr initially
points at the first such whitespace, ptr2 points at the same location, and
then the while() loop advances ptr to point at the last byte on the line,
which in turn will be the last byte of the file.  And the codepath with
your updates still try to access ptr[1] that is beyond that last byte.

I would write it like this patch instead.

The intent is the same as your patch, but it avoids accessing ptr[1] when
that is beyond the end of the buffer, and the logic is easier to follow as
well.

-- >8 --
Subject: xutils: fix hashing an incomplete line with whitespaces at the end

Upon seeing a whitespace, xdl_hash_record_with_whitespace() first skipped
the run of whitespaces (excluding LF) that begins there, ensuring that the
pointer points the last whitespace character in the run, and assumed that
the next character must be LF at the end of the line.  This does not work
when hashing an incomplete line, that lacks the LF at the end.

Introduce "at_eol" variable that is true when either we are at the end of
line (looking at LF) or at the end of an incomplete line, and use that
instead throughout the code.

Noticed by Thell Fowler.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xutils.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04ad468..9411fa9 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -242,18 +242,20 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		if (isspace(*ptr)) {
 			const char *ptr2 = ptr;
+			int at_eol;
 			while (ptr + 1 < top && isspace(ptr[1])
 					&& ptr[1] != '\n')
 				ptr++;
+			at_eol = (top <= ptr + 1 || ptr[1] == '\n');
 			if (flags & XDF_IGNORE_WHITESPACE)
 				; /* already handled */
 			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
-					&& ptr[1] != '\n') {
+				 && !at_eol) {
 				ha += (ha << 5);
 				ha ^= (unsigned long) ' ';
 			}
 			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
-					&& ptr[1] != '\n') {
+				 && !at_eol) {
 				while (ptr2 != ptr + 1) {
 					ha += (ha << 5);
 					ha ^= (unsigned long) *ptr2;
