From: "Rolf Bjarne Kvinge" <RKvinge@novell.com>
Subject: git rev-list --pretty=raw strips empty lines
Date: Tue, 06 Oct 2009 14:33:37 +0200
Organization: Novell
Message-ID: <op.u1do6bq5k71drc@linux.lacasa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=----------xu0yrybMEnvK0oPaOtGF17
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 14:55:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv9Zs-0004dc-Nc
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 14:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208AbZJFMxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 08:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757190AbZJFMxe
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 08:53:34 -0400
Received: from vpn.id2.novell.com ([195.33.99.129]:51955 "EHLO
	gwia-smtp.id2.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757186AbZJFMxd (ORCPT
	<rfc822;groupwise-RKvinge@novell.com;0:0>);
	Tue, 6 Oct 2009 08:53:33 -0400
X-Greylist: delayed 1260 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2009 08:53:33 EDT
Received: from linux.lacasa ([::ffff:149.44.117.251])
	by gwia-smtp.id2.novell.com with ESMTP; Tue, 06 Oct 2009 14:17:02 +0100
User-Agent: Opera Mail/10.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129628>

------------xu0yrybMEnvK0oPaOtGF17
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit

Hi,

It seems like the --pretty=raw format strips off empty newlines from the beginning of log messages, while I'd expect the raw format to not do any transformations (just as the documentation says: "The 'raw' format shows the entire commit exactly as stored in the commit object").

I've attached a test script that I can use to reproduce with current master (dbc1b1f71052c0)

The below changes works for me, not sure if I'm right about this though (my first time here ;-)

Rolf

diff --git a/pretty.c b/pretty.c
index f5983f8..1037700 100644
--- a/pretty.c
+++ b/pretty.c
@@ -868,7 +868,7 @@ void pp_remainder(enum cmit_fmt fmt,
                         break;

                 if (is_empty_line(line, &linelen)) {
-                       if (first)
+                       if (first && fmt != CMIT_FMT_RAW)
                                 continue;
                         if (fmt == CMIT_FMT_SHORT)
                                 break;
@@ -952,7 +952,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
         }

         /* Skip excess blank lines at the beginning of body, if any... */
-       msg = skip_empty_lines(msg);
+       if (fmt != CMIT_FMT_RAW)
+               msg = skip_empty_lines(msg);

         /* These formats treat the title line specially. */
         if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)



-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
------------xu0yrybMEnvK0oPaOtGF17
Content-Disposition: attachment; filename=test.sh
Content-Type: application/octet-stream; name=test.sh
Content-Transfer-Encoding: Base64

IyEvYmluL2Jhc2ggLWUKCmNhdCA+IG1zZyA8PCBFT0YKCgoKZmlyc3QgbGluZQoK
RU9GCgojIHRoZSBmb2xsb3dpbmcgZXhwb3J0cyBhcmUganVzdCB0byBtYWtlIHRo
ZSBzaXplIG9mIHRoZSByZXYtbGlzdCBvdXRwdXQgb25seSBkZXBlbmRlbnQgb24g
dGhlIHNpemUgb2YgdGhlIGxvZyBtZXNzYWdlCmV4cG9ydCBHSVRfQ09NTUlUVEVS
X05BTUU9QmFyCmV4cG9ydCBHSVRfQ09NTUlUVEVSX0VNQUlMPSJiYXJAZm9vLmNv
bSIKZXhwb3J0IEdJVF9DT01NSVRURVJfREFURT0iMjAwMC8wMS8wMSAwMDowMCIK
ZXhwb3J0IEdJVF9BVVRIT1JfTkFNRT1Gb28KZXhwb3J0IEdJVF9BVVRIT1JfRU1B
SUw9ImZvb0BiYXIuY29tIgpleHBvcnQgR0lUX0FVVEhPUl9EQVRFPSIyMDAwLzAx
LzAxIDAwOjAwIgoKZ2l0IGFkZCBtc2cKZ2l0IGNvbW1pdCAtRiBtc2cgLS1jbGVh
bnVwPXZlcmJhdGltCmdpdCByZXYtbGlzdCAtLXByZXR0eT1yYXcgLTEgSEVBRCB8
IHRlZSBtc2cudG1wClNJWkU9YGNhdCBtc2cudG1wIHwgd2MgLWNgCiMgY3VycmVu
dCBtYXN0ZXIgZ2l2ZXMgYSBtZXNzYWdlIGxlbmd0aCBvZiAyNDQKZWNobyBFeHBl
Y3RlZCBtZXNzYWdlIGxlbmd0aDogMjU5LCBnb3QgbWVzc2FnZSBsZW5ndGg6ICRT
SVpFCmdpdCByZXNldCBIRUFEXiAtLWhhcmQKCg==

------------xu0yrybMEnvK0oPaOtGF17--
