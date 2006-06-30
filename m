From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 13] autoconf: Append '-include config.mak.autogen' to config.mak if it is not present
Date: Fri, 30 Jun 2006 17:11:39 +0200
Message-ID: <200606301711.39635.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606301441.01327.jnareb@gmail.com> <200606301708.19521.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 30 17:11:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKeo-00089z-Dt
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 17:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWF3PLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 11:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWF3PLc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 11:11:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:26952 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751794AbWF3PLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 11:11:31 -0400
Received: by nf-out-0910.google.com with SMTP id k27so169062nfc
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 08:11:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oQEAoJFELdYl/U50ooLkTOWLsr5u4tcPM7eozX5bObopV59MfODxmSAIqWOcxd+acetUBq/QRWGV0PC8xibQBeodX4HeoR8QsoPrjM8Kku1OGVOuBnv5dZHc8L9c3QOVi30PVaMQ459AOQQw8QCrVnCZt4HzozpYFhUW6I3jjLg=
Received: by 10.49.21.14 with SMTP id y14mr398460nfi;
        Fri, 30 Jun 2006 08:11:29 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id y23sm1689581nfb.2006.06.30.08.11.29;
        Fri, 30 Jun 2006 08:11:29 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606301708.19521.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22992>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Andreas Ericsson wrote:
> Jakub Narebski wrote:
>>
>> The idea was to use ./configure to _generate_ config.mak, which the user can
>> then edit.
>
> This is bad, since it forces users to do one thing first and then do
> what they're used to. Better to have the script add
>
> -include config.mak.autogen
>
> LAST in config.mak, unless it's already in the file and generate
> config.mak.autogen with configure, e.g. with
>
> grep -q autogen config.mak || \
>         echo "-include config.mak.autogen" >> config.mak
>
> Since Make does things bottoms-up (much like swedish students and
> midsummer celebrators), the previous hand-edited defaults in config.mak
> will beat the ones in config.mak.autogen (a good thing).
>
> I wouldn't want my long-standing, functioning config.mak overwritten,
> but I *might* be interested in trying some of the options provided by
> ./configure.

Done, with small changes.

Can anyone tell me if frep use is portable enough?

 configure.ac |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1ead656..2904077 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,3 +54,6 @@ AC_CONFIG_FILES(["${config_file}":"${con
 AC_OUTPUT
 
 rm -f "${config_append}"
+
+grep -q -s -F "-include ${config_file}" config.mak || \
+        echo  "-include ${config_file}" >> config.mak
-- 
1.4.0
