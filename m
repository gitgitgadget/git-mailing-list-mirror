From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include log_config module in apache.conf
Date: Wed, 11 Mar 2009 11:58:10 -0700
Message-ID: <7vab7r6g59.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903102320170.19665@iabervon.org>
 <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 19:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhTee-0004wm-8m
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 19:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZCKS6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 14:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbZCKS6T
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 14:58:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZCKS6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 14:58:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4B4DA0039;
	Wed, 11 Mar 2009 14:58:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5CCF4A0033; Wed,
 11 Mar 2009 14:58:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 11 Mar 2009 12:46:23 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94786D2E-0E6E-11DE-AC0A-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112963>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sorry, no:
>
> -- snip --
> apache2: Syntax error on line 7 of 
> /home/schindelin/git/t/lib-httpd/apache.conf: module log_config_module is 
> built-in and can't be loaded
> -- snap --

Sorry and thanks---I'll apply an interdiff and credit it to you.

-- >8 --
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Wed, 11 Mar 2009 12:47:06 +0100 (CET)
Subject: [PATCH] test: do not LoadModule log_config_module unconditionally

LoadModule directive for log_config_module will not work if the module is
built-in.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-httpd/apache.conf |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index a0d4077..f460e40 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -4,7 +4,9 @@ DocumentRoot www
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
 CustomLog access.log common
 ErrorLog error.log
-LoadModule log_config_module modules/mod_log_config.so
+<IfModule !mod_log_config.c>
+	LoadModule log_config_module modules/mod_log_config.so
+</IfModule>
 
 <IfDefine Darwin>
 	LoadModule log_config_module modules/mod_log_config.so
-- 
