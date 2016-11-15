Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC492042F
	for <e@80x24.org>; Tue, 15 Nov 2016 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbcKOPv5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 10:51:57 -0500
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:34249 "EHLO
        6.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcKOPv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 10:51:56 -0500
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Nov 2016 10:51:56 EST
Received: from player788.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id AE947BE9E
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:13:23 +0100 (CET)
Received: from RCM-ns322269.ip-176-31-238.eu (LFbn-1-459-240.w86-245.abo.wanadoo.fr [86.245.167.240])
        (Authenticated sender: postmaster@rapsys.eu)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 63799180090
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:13:23 +0100 (CET)
Received: from LFbn-1-459-240.w86-245.abo.wanadoo.fr ([86.245.167.240])
 by mail.ovh.net
 with HTTP (HTTP/1.1 POST); Tue, 15 Nov 2016 16:13:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Nov 2016 16:13:23 +0100
From:   =?UTF-8?Q?Rapha=C3=ABl_Gertz?= <mageia@rapsys.eu>
To:     git@vger.kernel.org
Subject: gitweb html validation
Message-ID: <13c9b4a74d82a1f0ed3f626406a43e92@rapsys.eu>
X-Sender: mageia@rapsys.eu
User-Agent: Roundcube Webmail/1.2.1
X-Originating-IP: 86.245.167.240
X-Webmail-UserID: postmaster@rapsys.eu
X-Ovh-Tracer-Id: 2743536599189384925
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelfedruddvgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

There a small bug in gitweb html validation, you need the following 
patch to pass w3c check with searchbox enabled.

The problem lies in the input directly embed inside a form without a 
wrapper which is not valid.

Best regards

The following patch fix the issue for git-2.10.2 :
--- /usr/share/gitweb/gitweb.cgi.orig   2016-11-15 15:37:21.149805026 
+0100
+++ /usr/share/gitweb/gitweb.cgi        2016-11-15 15:37:48.579240429 
+0100
@@ -5518,6 +5518,7 @@ sub git_project_search_form {

         print "<div class=\"projsearch\">\n";
         print $cgi->start_form(-method => 'get', -action => $my_uri) .
+             '<div>'.
               $cgi->hidden(-name => 'a', -value => 'project_list')  . 
"\n";
         print $cgi->hidden(-name => 'pf', -value => $project_filter). 
"\n"
                 if (defined $project_filter);
@@ -5529,6 +5530,7 @@ sub git_project_search_form {
                              -checked => $search_use_regexp) .
               "</span>\n" .
               $cgi->submit(-name => 'btnS', -value => 'Search') .
+             '</div>'.
               $cgi->end_form() . "\n" .
               $cgi->a({-href => href(project => undef, searchtext => 
undef,
                                      project_filter => 
$project_filter)},
