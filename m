From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Add example of config file and how to generate projects list to gitweb/INSTALL
Date: Mon, 26 Mar 2007 02:34:41 +0100
Message-ID: <200703260334.42885.jnareb@gmail.com>
References: <etufpl$7en$1@sea.gmane.org> <11747663931269-git-send-email-jnareb@gmail.com> <f329bf540703241918y22830d50jbf20928d402c67fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Mar 26 03:34:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVe6o-0008VP-Pf
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 03:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933354AbXCZBev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 21:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933339AbXCZBev
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 21:34:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:28447 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933387AbXCZBet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 21:34:49 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1465357uga
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 18:34:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g0lNvRI2PfF5yfJoqq3GiHupjFR5thSDnhVTI4/GsLtKt+sBlRfFhvusWg0u4mRQ3wGj7IZrH6mQyIU7abY1ZkLUNd0F8UOYgH/vAmvGO8vGLfw8SdBy428T8VYzRZvbhhBK6TqSAB+nJL0Qv+2AzttFzfLtmxGXNrZL31VsaR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YIkEkrbdU2ORdkhfgIQcsBcCIXG93b15YXRI2/R+GK7V/wW3D13a9HeJaj89PYCmWOXB/PsrR6P/jSzJUyuRVy7tJNAlXyZFnDngnostQPFCBEUTzyCk0/jQ0Umrnw1btxT/fjgcpdYCMjbpZvr/cqczS7jWNhxkdW3R+FWZDQQ=
Received: by 10.66.255.7 with SMTP id c7mr11302128ugi.1174872888187;
        Sun, 25 Mar 2007 18:34:48 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j2sm25996171mue.2007.03.25.18.34.46;
        Sun, 25 Mar 2007 18:34:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <f329bf540703241918y22830d50jbf20928d402c67fe@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43103>

Add simple example of config file (turning on and allowing override of
a few %features). Also example config file and script to generate list
of projects in a format that can be used as GITWEB_LIST / $projects_list.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Han-Wen Nienhuys wrote:
> 2007/3/24, Jakub Narebski <jnareb@gmail.com>:
> > Add some installation and configuration notes for gitweb in
> > gitweb/INSTALL. Make use of filling gitweb configuration by
> > Makefile.
> >
> > It does not cover (yet?) all the configuration variables and
> > options.
> 
> I got it running with the help of the list, but this patch surely
> improves the state of the docs. Just one nit: it should give a small
> example of the desired syntax of the gitweb_conf.perl file

HTH

I'm not sure about example how to get projects list in the format
suitable for gitweb. For example HTTP headers should be stripped
from the projects_index gitweb.cgi output, but I don't remember
proper sed invocation to skip all lines up to emty line/line
containing only "\r".


 gitweb/INSTALL |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 371407d..6328e26 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -103,9 +103,25 @@ for gitweb (in gitweb/README).
 
   See the top of gitweb.perl file for examples of customizable options.
 
+Config file example
+~~~~~~~~~~~~~~~~~~~
 
-Gitweb repositories:
---------------------
+To enable blame, pickaxe search, and snapshot support, while allowing
+individual projects to turn them off, put the following in your
+GITWEB_CONFIG file:
+
+	$feature{'blame'}{'default'} = [1];
+	$feature{'blame'}{'override'} = 1;
+
+	$feature{'pickaxe'}{'default'} = [1];
+	$feature{'pickaxe'}{'override'} = 1;
+
+	$feature{'snapshot'}{'default'} = ['x-gzip', 'gz', 'gzip'];
+	$feature{'snapshot'}{'override'} = 1;
+
+
+Gitweb repositories
+-------------------
 
 - By default all git repositories under projectroot are visible and
   available to gitweb. List of projects is generated by default by
@@ -139,6 +155,31 @@ Gitweb repositories:
   show repository only if this file exists in its object database
   (if directory has the magic file $export_ok).
 
+Generating projects list using gitweb
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+We assume that GITWEB_CONFIG has its default Makefile value, namely
+gitweb_config.perl. Put the following in gitweb_make_index.perl file:
+
+	$GITWEB_CONFIG = "gitweb_config.perl";
+	do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
+
+	$projects_list = $projectroot;
+
+Then create the following script to get list of project in the format
+suitable for GITWEB_LIST build configuration variable (or
+$projects_list variable in gitweb config):
+
+	#!/bin/sh
+
+	export GITWEB_CONFIG="gitweb_make_index.perl"
+	export GATEWAY_INTERFACE="CGI/1.1"
+	export HTTP_ACCEPT="*/*"
+	export REQUEST_METHOD="GET"
+	export QUERY_STRING="a=project_index"
+
+	perl -- /var/www/cgi-bin/gitweb.cgi
+
 
 Requirements
 ------------
-- 
1.5.0.5
