From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH] imap-send: suppress warning about cleartext password
 with CRAM-MD5
Date: Tue, 30 Mar 2010 19:51:24 +0900
Message-ID: <4BB1D7AC.80508@dcl.info.waseda.ac.jp>
References: <1269702019-27063-1-git-send-email-chris@arachsys.com> <7vbpe85s7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 13:09:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwZJm-0005ba-Ur
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 13:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab0C3LI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 07:08:58 -0400
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64845 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223Ab0C3LI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 07:08:57 -0400
X-Greylist: delayed 770 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 07:08:56 EDT
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id A7F481001193;
	Tue, 30 Mar 2010 19:56:03 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQzAT+dJia50; Tue, 30 Mar 2010 19:56:03 +0900 (JST)
Received: from [192.168.10.21] (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 518DD1001190;
	Tue, 30 Mar 2010 19:56:03 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091211 Shredder/3.0
In-Reply-To: <7vbpe85s7n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143562>

On 03/29/10 01:25, Junio C Hamano wrote:
 > Chris Webb<chris@arachsys.com>  writes:
 >
 >> If a CRAM-MD5 challenge-response is used to authenticate to the IMAP 
server,
 >> git imap-send shouldn't warn about the password being sent in the clear.
 >>
 >> Signed-off-by: Chris Webb<chris@arachsys.com>
 >> ---
 >
 > Makes sense.  Thanks.
 >
 >>   imap-send.c |    6 +++---
 >>   1 files changed, 3 insertions(+), 3 deletions(-)
 >>
 >> diff --git a/imap-send.c b/imap-send.c
 >> index aeb2985..7107923 100644
 >> --- a/imap-send.c
 >> +++ b/imap-send.c
 >> @@ -1226,9 +1226,6 @@ static struct store *imap_open_store(struct 
imap_server_conf *srvc)
 >>   			fprintf(stderr, "Skipping account %s@%s, server forbids 
LOGIN\n", srvc->user, srvc->host);
 >>   			goto bail;
 >>   		}
 >> -		if (!imap->buf.sock.ssl)
 >> -			imap_warn("*** IMAP Warning *** Password is being "
 >> -				  "sent in the clear\n");
 >>
 >>   		if (srvc->auth_method) {
 >>   			struct imap_cmd_cb cb;
 >> @@ -1253,6 +1250,9 @@ static struct store *imap_open_store(struct 
imap_server_conf *srvc)
 >>   				goto bail;
 >>   			}
 >>   		} else {
 >> +			if (!imap->buf.sock.ssl)
 >> +				imap_warn("*** IMAP Warning *** Password is being "
 >> +					  "sent in the clear\n");
 >>   			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, 
srvc->pass) != RESP_OK) {
 >>   				fprintf(stderr, "IMAP error: LOGIN failed\n");
 >>   				goto bail;
 >> --
 >> 1.7.0.1
 >

Thanks Chris, this was my mistake.
And thanks for your notify, Junio.

     Hitoshi
