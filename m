From: Joshua Juran <jjuran@gmail.com>
Subject: strbuf name conflict on Mac OS
Date: Tue, 31 Mar 2009 13:17:11 -0700
Message-ID: <E5D92A5D-B2CC-44CE-B117-0BB88C0E663E@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 22:18:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LokQB-0005Ou-Oz
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbZCaURS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbZCaURR
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:17:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:19509 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbZCaURQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:17:16 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3360608wff.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:mime-version:content-type
         :message-id:content-transfer-encoding:from:subject:date:to:x-mailer;
        bh=+glFFU1lpKfvVmYEW4K81CCknepW84J2NRfGW2WzR/4=;
        b=a5rdxksHYum01CGKdYNkuRE/BMAFrCs1dck+NT2/O0lcxy8cJK4F+PUtZsBL/ZHRK1
         zsthlUxWDz0QbwoYc22hwiui/Wzr3IJy0MyPulM00nbay7YP/4rnCm9WNufBVr4H3OSp
         U9qLvl0Ca9yMufAqhf2ch4FKS35bXQlMkCPxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:content-type:message-id:content-transfer-encoding:from
         :subject:date:to:x-mailer;
        b=k3gOTllbxzhtMeaWFx5BqgdVfh7BQqh3rSCM6iBIvd4KmnPXlJYWBasfCKBxe6xtxU
         3LcQHZxdJNmJ3utxl/HeKd0mdREBuUIzjS8a6JvVtyDRekqEQHXUnLOukIGSWWR8uo+Q
         JTLBDDlxPa1TZ2fsadAV4BRnNu0Nln6ZqA0Qw=
Received: by 10.142.192.1 with SMTP id p1mr2758350wff.295.1238530635304;
        Tue, 31 Mar 2009 13:17:15 -0700 (PDT)
Received: from ?192.168.1.24? (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 30sm11491489wff.27.2009.03.31.13.17.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 13:17:14 -0700 (PDT)
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115308>

Apple's OpenTransport.h from Universal Interfaces 3.4.2 defines its  
own struct strbuf, with which git's collides.

Since OpenTransport.h also defines some POSIX constants (such as  
O_NONBLOCK) as enums, it's necessary to include OpenTransport.h from  
fcntl.h (and other affected headers) so as to control the order in  
which the definitions appear in the translation unit.

This is the minimal patch:


diff --git a/strbuf.h b/strbuf.h
index 89bd36e..b8f380e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -40,6 +40,8 @@

  #include <assert.h>

+#define strbuf git_strbuf
+
  extern char strbuf_slopbuf[];
  struct strbuf {
         size_t alloc;


Josh
