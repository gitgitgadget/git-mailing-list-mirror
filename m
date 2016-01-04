From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 02/17] check-attr, check-ignore, checkout-index: read
 paths with strbuf_getline_crlf()
Date: Mon, 4 Jan 2016 13:25:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041258280.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:25:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Cy-0006Az-7h
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbcADMZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:25:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:53055 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbcADMZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:25:51 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M92ZJ-1aO0ph25Xh-00CQ7m; Mon, 04 Jan 2016 13:25:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-3-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:USEKhQbutn8fk8iLwI7zf28JkAijpXfj0CINkZ3z0uMZP0gQW0z
 4sY1lvkFk/peJ+h+y5DlFr9lJKVNLVWE4smX9H/vZUKE+UwrXPcSlu5xtX3sMEr9+ZeyHt1
 Nf8Mp5YiN1dT+QPQiDNys74dpKW/onQEy9z1qD+6IAE0g2T+QM3QCGEXT//mkRVMHDhvWqw
 ElLusl277/FI+QhKYiXUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EjRBtGZUceM=:Je+01UwlYILioPxvvYjDiC
 DyUpppz9+sutgWl56tvXCw51qmaRDVMXh1S3zGEmmONpYDYFuor+cyd4ZCrMjlt9YzvIzDlRf
 egsr5hu7HCuzlcLCWLDTaNBJIMyX7q5gR+doebu1UOFuLI0W6lzy1jFvRBwYinIHEfM+RoX9X
 xcZydLbba65lzMm1gII6z5C4y36uukNxDIL/axCRthlsGLrYd/jT/dUzOqbqwxAnGzmpCYdhM
 3Xq7gPzqMVX0b0RAqjKrDFGuYDsOnMAEgIJnAspilo2UdIgF/juG1xVhY3Ixtb2w1Ybh2Ms9S
 CHtyrPJwmL410ns5V4/gXif0QdYFpQdbNkfZg+bC13YibvOVFcslOrIELqPZ6xGT8a+avYlUb
 K++ZoS2aIE7nTsNrn87NOnC0dOTVrj0IOLrRm9aPfG6PXNI6vMHSbfWh+y8owjj0pbEpVlAsZ
 s+ybeaA1Y0vrEe5OZ/4uNDz0g6o7aUx07R3XCXVKlYvQJBQnBPQPGfg0M98GwGTophvl5cNvM
 37VIIlHAD3q44PvBXVZnd93wvbLHhjaTXLGp6vUqCQI9cl0xluS+gFuEtsgSC8WOhk5m5EgvP
 neRHbMZaSWwDv4YVub8egyajbWlD523v5NwhGuJx68a/iWOKBam420sdLLN8jvV/lY0bksnjj
 A5XxyZP33c2V+Tn5kIQ6WkAKFH3jXgZT/0I3OacwUHqmb0u6zlfB1817kbbtPBLuIH7h4SjUT
 sbridkLJCMV0CcytwfO/wviNvzcdf1IC/Ufy4a4dvtvj8OkvP/QCR6fCMYVV0UPWGfrqG+3x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283300>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> These commands read list of paths from their standard input under
> the --stdin option (in order to avoid busting limit on the length of
> the command line).
> 
> When they are using text input mode (i.e. line_termination is set to
> '\n'), we should try to be more friendly to our DOSsy friends and
> accept lines with CRLF endings.
> 
> It is tempting to lift this logic to strbuf_getline() and not introduce
> a separate strbuf_getline_crlf(), but that can lead to silent
> misconversion.

This paragraph would make more sense in 01/17.

> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 265c9ba..4c44d8f 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -77,7 +77,9 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
>  
>  	strbuf_init(&buf, 0);
>  	strbuf_init(&nbuf, 0);
> -	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
> +	while ((line_termination
> +		? strbuf_getline_crlf(&buf, stdin)
> +		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
>  		if (line_termination && buf.buf[0] == '"') {
>  			strbuf_reset(&nbuf);
>  			if (unquote_c_style(&nbuf, buf.buf, NULL))

Hrm. With this much context, it is unclear that line_termination can only
ever be '\n' or '\0'. In fact, with the intention of this hunk, the
line_termination variable makes no sense any longer because its value is
not even used any longer. So something like this instead (and likewise in
check-ignore.c)?

-- snipsnap --
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 265c9ba..605bbf9 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -73,12 +73,13 @@ static void check_attr_stdin_paths(const char *prefix,
int cnt,
 	struct git_attr_check *check)
 {
 	struct strbuf buf, nbuf;
-	int line_termination = nul_term_line ? 0 : '\n';
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
-		if (line_termination && buf.buf[0] == '"') {
+	while ((nul_term_line
+			? strbuf_getline(&buf, stdin, '\0')
+			: strbuf_getline_crlf(&buf, stdin)) != EOF) {
+		if (!nul_term_line && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
 				die("line is badly quoted");
