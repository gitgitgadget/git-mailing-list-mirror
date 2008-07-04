From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH/RFC] Fix some warnings (on cygwin) to allow -Werror
Date: Fri, 4 Jul 2008 11:46:36 +0200
Message-ID: <E4D3A379-9EB2-49D1-AD42-CFFC453A2B08@zib.de>
References: <486CF5A9.5060104@ramsay1.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:48:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhtf-0000wT-Q2
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbYGDJrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 05:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYGDJrF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 05:47:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:65411 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbYGDJrE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 05:47:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m649kG7b012285;
	Fri, 4 Jul 2008 11:46:22 +0200 (CEST)
Received: from [192.168.178.22] (p5499FDC0.dip.t-dialin.net [84.153.253.192])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m649kB3f018010
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 4 Jul 2008 11:46:12 +0200 (MEST)
In-Reply-To: <486CF5A9.5060104@ramsay1.demon.co.uk>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87382>


On Jul 3, 2008, at 5:52 PM, Ramsay Jones wrote:

>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Despite the subject line, this should be useful on any system for
> which uint32_t is defined to be unsigned long rather than
> unsigned int. (and where the return type of htonl() is similarly
> defined).

For MINGW, we fixed these warnings in the compat layer, see cd800eecc2:

diff --git a/compat/mingw.h b/compat/mingw.h
index a87cc96..6bc049a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -186,6 +186,10 @@ pid_t mingw_spawnvpe(const char *cmd, const char  
**argv, char **env);
  void mingw_execvp(const char *cmd, char *const *argv);
  #define execvp mingw_execvp

+static inline unsigned int git_ntohl(unsigned int x)
+{ return (unsigned int)ntohl(x); }
+#define ntohl git_ntohl
+
  sig_handler_t mingw_signal(int sig, sig_handler_t handler);
  #define signal mingw_signal

	Steffen
