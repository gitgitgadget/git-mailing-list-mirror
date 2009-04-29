From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git config: error when editing a repo config and not being in one
Date: Thu, 30 Apr 2009 01:49:47 +0300
Message-ID: <1241045387-30181-1-git-send-email-felipe.contreras@gmail.com>
References: <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de>
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 00:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIbT-0005VR-B2
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbZD2Wt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 18:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbZD2Wtz
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:49:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:62787 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbZD2Wty (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:49:54 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1076312fga.17
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FQz+I86U7PnCeHSz9WeRnxP8J+RjGrJNXUe+7O/Pxss=;
        b=CFsUm7EftKLx5eRw73334CnKKqmMVxknxJFb+TOMF88nAJeG2TboKVszP8uuUNx2k6
         YBP88RWgBnsUaoCaSBE7K401Q3QwO0X2G+6ZWs3ZGldX3HCgiDla1OKb2oYu0N7VpPSo
         jrt0QEj04vuBabGo7WWcdUYxcsuaaftDciIJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Otw6fcK+h4iYNaOaPrHQgfN0wfZfNxV0pKrakjB+q1bYzrwS6T/Hs+LJDl+qAiTXpW
         NIBhEyhH1nIAkZgtJDn2lcYpznSFNNT87K6TFnm6Jj1zwMVzmjfMuanmQLpRd6m1DoYq
         qcb5wU7W7zfA2nXFCf35EXHOfr6oPkwcWjwUI=
Received: by 10.86.49.13 with SMTP id w13mr1208872fgw.31.1241045393241;
        Wed, 29 Apr 2009 15:49:53 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id d6sm2519802fga.22.2009.04.29.15.49.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 15:49:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.13.g195b.dirty
In-Reply-To: <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117972>

Let's throw an error on this specific case. If the user specifies the
config file, he must know what he is doing.

Teemu Likonen pointed this out.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index d8da72c..a81bc8b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -390,6 +390,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 	else if (actions == ACTION_EDIT) {
 		check_argc(argc, 0, 0);
+		if (!config_exclusive_filename && nongit)
+			die("not in a git directory");
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
 			      config_exclusive_filename : git_path("config"),
-- 
1.6.3.rc3.13.g195b.dirty
