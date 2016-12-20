Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0CB1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 19:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937351AbcLTTUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 14:20:33 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34770 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbcLTTUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 14:20:32 -0500
Received: by mail-oi0-f51.google.com with SMTP id 3so5396015oih.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 11:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tento-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YImXS8y/ktBfdvPW6kMziuE/TCNJNx/bnihUSaLb/ys=;
        b=LNd+Pm+3g+RWSZUl3kV3D3aMbnWoTv2YTBrvw2toIp0RNqb/9YUSaJKuSDEBrFC98b
         ZUggBBUa9n9P+L/P+L0fnRRIFmJanJWFsCsz391IDXYVhMsLfwk+BoEw/SsVpzqa9gQM
         TdYOyaNHIYYOYZQfDSG5jFvmJ0sfVO12GVErbQ5ljuuEqpqxVmH95+5VYRVBeO3tkftp
         +Ml4zUmG5P8aJmDjZgcr+FpYH35iSsTSLwikAgUKGLcZRiCrz0Sk1lVTmxVC2vXxxn9l
         WQE2pBTzc4dZbXEqAhDoEq5Orpzi5a6SWByb2dJPk8PSvfDhB+5+Jix+ZGyOFh82+ro2
         8KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YImXS8y/ktBfdvPW6kMziuE/TCNJNx/bnihUSaLb/ys=;
        b=CEoZPqsDChmblb1gkiK6XwHrTS5fpMhx4f46lL+ehh6BYISOLeVzv6Uj0PcsheHq3d
         WVze3b79O/irj01ax0novLAzM5OfaS8b0VqM4CHxT1vZVY+dcCXJzY/tukkjxtKabUWk
         ae61bmkfg7JPI/G4sxqjj2JKuWdRei3jXki8TMrJwYR0PYmpi2MdEsbuTpXw6KLsQ5IS
         XpmToiBeB29Lqn45UPwnmTJ8S1jKPF7phIG1PqWzbybV6I1M2Ha16OsJL1Y6JBq7vW86
         j+yUupcrIJVoimqIu9zBeUOUUjC40O6X26Bjp5ikHnpyMgETUqasRWB1ULreqpWh+BPH
         BxZA==
X-Gm-Message-State: AIkVDXKK3dEd6y2nfDJ7mwP6eBsjbBHbbR3fH3pD5lTTYqQwnwh5hEBlf9vwRJLgySWCCtr8jxTa7379GD9kEn3q
X-Received: by 10.202.82.193 with SMTP id g184mr517512oib.23.1482261631082;
 Tue, 20 Dec 2016 11:20:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.41.69 with HTTP; Tue, 20 Dec 2016 11:20:30 -0800 (PST)
From:   Pete Harlan <pgit@tento.net>
Date:   Tue, 20 Dec 2016 11:20:30 -0800
Message-ID: <CAAB=nN=dVgg1BREfoZhOTcT5PQSbi+wE+Ng7fqjUSenkp9fcKg@mail.gmail.com>
Subject: [GIT GUI/PATCH/RFC] git gui: get current theme in 8.5-backwards-compatible
 way
To:     Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Later Tcl 8.5 versions learned to return the current theme by omitting
the final argument to "[ttk::style theme use]", but this throws an
error on earlier 8.5 versions (e.g., 8.5.7).

InitTheme works around this by catching the error and reading
::ttk::currentTheme instead.

A call to "[ttk::style theme use]" was added to ttext in 30508bc
("Amend tab ordering and text widget border and highlighting.",
2016-10-02).  Break out InitTheme's workaround into its own
get_current_theme proc and use it in both places.

Signed-off-by: Pete Harlan <pgit@tento.net>
---

Note: Applies to the upstream git-gui repo, http://repo.or.cz/git-gui .
To apply to Git itself, apply in the git-gui directory.

Issue entered Git in v2.10.1-537-g3eae30870.

 lib/themed.tcl | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/themed.tcl b/lib/themed.tcl
index 351a712..85c157b 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -28,10 +28,7 @@ proc InitTheme {} {
                }
        }

-       # Handle either current Tk or older versions of 8.5
-       if {[catch {set theme [ttk::style theme use]}]} {
-               set theme  $::ttk::currentTheme
-       }
+       set theme [get_current_theme]

        if {[lsearch -exact {default alt classic clam} $theme] != -1} {
                # Simple override of standard ttk::entry to change the field
@@ -248,7 +245,7 @@ proc tspinbox {w args} {
 proc ttext {w args} {
        global use_ttk
        if {$use_ttk} {
-               switch -- [ttk::style theme use] {
+               switch -- [get_current_theme] {
                        "vista" - "xpnative" {
                                lappend args -highlightthickness 0
-borderwidth 0
                        }
@@ -343,6 +340,16 @@ proc on_choosefont {familyvar sizevar font} {
        set size [dict get $font -size]
 }

+# Get current theme in a backwards-compatible way.
+proc get_current_theme {} {
+       # Handle either current Tk or older versions of 8.5
+       if {[catch {set theme [ttk::style theme use]}]} {
+               set theme $::ttk::currentTheme
+       }
+
+       return $theme
+}
+
 # Local variables:
 # mode: tcl
 # indent-tabs-mode: t
