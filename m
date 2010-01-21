From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 15:51:36 +0800
Message-ID: <20100121155136.17b59e8f.rctay89@gmail.com>
References: <20100121004756.GA18213@onerussian.com>
	<20100121050850.GA18896@Knoppix>
	<be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 08:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXrpb-0004bo-2x
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 08:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab0AUHvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 02:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816Ab0AUHvv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 02:51:51 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:64342 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab0AUHvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 02:51:50 -0500
Received: by gxk9 with SMTP id 9so7007186gxk.8
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 23:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0V7VRb4t0MgDE24rexw3r6ZJcY6H2Adoo570Ad8+fmY=;
        b=oTWPPUHc2yaKUS46bjmfnX0649roqutuTJQEyyn+iXoU7n0ACX+vRxo3yaGg8hVN4H
         P47Yhz2XnGx9RWdkJSCLQLg0c4/Ui8H+v9tOaGdpt9BTNAFLwu5uAOqBDKbzyclnprKx
         CsD35fK5GS9KZWy1DpByRySnbuLAqAkyUxtsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=dCytpPD8NqcXzn90dLzXDYti877Zd+wVnxvbMivPHYbzF2JuW6QHRvkPTrFwt77wlX
         rNHo4cf8rwhEEY8Mkg2T0CqaPMDKvmwxe0sdD4xKfz+9CpxQYWzUcxUn9x2bDs7g9Mgx
         8u5bGtNiUyfcK4W13wfD9AVPGsPz7mBbzqriY=
Received: by 10.101.132.22 with SMTP id j22mr1472934ann.6.1264060309475;
        Wed, 20 Jan 2010 23:51:49 -0800 (PST)
Received: from your-cukc5e3z5n (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 16sm483893gxk.3.2010.01.20.23.51.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 23:51:48 -0800 (PST)
In-Reply-To: <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137636>

Hi,

On Thu, 21 Jan 2010 14:47:37 +0800
Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Thu, Jan 21, 2010 at 1:08 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> > Looks like remote-curl (which handles http) issues request for:
> >
> > '.../info/refs?service=git-upload-pack'
> >
> > And expects that if there is no smart HTTP server there for the request to be
> > interpretted as:
> >
> > '.../info/refs'
> >
> > (i.e. webserver would ignore the query). This isn't true for git.debian.org.
> > Requesting the latter works (and the data formatting looks sane), but the
> > former is 404. This causes the fetch to fail.
> 
> afaik, putting a "?var1=val1&var2=...." still makes it a normal GET
> request, even if the url requested is just a plain file and not some
> cgi handler that uses those variables/values.

Yaroslav, sorry for making you run in circles - it really is git's
fault (sorta).

In recent versions of git, we were sending out the GET request for
info/refs with a query string (?serivce=<service name>). I'm not sure
why, but your server is not playing nice when the query string is
appended.

Could you try this patch and see if it solves the issue? I manage to
clone your repo successfully with it.

-- 
Cheers,
Ray Chuan

-->8--
Subject: [PATCH] http/remote-curl: coddle picky servers

When "info/refs" is a static file and not behind a CGI handler, some
servers may not handle a GET request for it with a query string
appended (eg. "?foo=bar") properly.

If such a request fails, retry it sans the query string, and also
discount the possibility of using the "smart" protocol (since no
service is specified with "?service=<service name>").

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 remote-curl.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1361006..a904164 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -102,7 +102,7 @@ static struct discovery* discover_refs(const char *service)
 	struct strbuf buffer = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	char *refs_url;
-	int http_ret, is_http = 0;
+	int http_ret, is_http = 0, proto_git_candidate = 1;
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -121,6 +121,19 @@ static struct discovery* discover_refs(const char *service)
 
 	init_walker();
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+
+	/* try again with "plain" url (no ? or & appended) */
+	if (http_ret != HTTP_OK) {
+		free(refs_url);
+		strbuf_reset(&buffer);
+
+		proto_git_candidate = 0;
+		strbuf_addf(&buffer, "%s/info/refs", url);
+		refs_url = strbuf_detach(&buffer, NULL);
+
+		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+	}
+
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
@@ -137,7 +150,8 @@ static struct discovery* discover_refs(const char *service)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	if (is_http && 5 <= last->len && last->buf[4] == '#') {
+	if (is_http && proto_git_candidate
+		&& 5 <= last->len && last->buf[4] == '#') {
 		/* smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-- 
1.6.6.1.337.g96bc8
