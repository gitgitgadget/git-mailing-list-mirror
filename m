Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2472E2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbcGHRYn (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:24:43 -0400
Received: from perdizione.investici.org ([94.23.50.208]:36755 "EHLO
	perdizione.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbcGHRYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:24:42 -0400
X-Greylist: delayed 1869 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jul 2016 13:24:42 EDT
Received: from [94.23.50.208] (perdizione [94.23.50.208]) (Authenticated sender: najamelan@autistici.org) by localhost (Postfix) with ESMTPSA id 77BF31200E3
	for <git@vger.kernel.org>; Fri,  8 Jul 2016 16:53:24 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
	s=stigmate; t=1467996805;
	bh=hOPsnT53evEXymJuL/Yed2unJW+2xG9ku+HAIPfGe7o=;
	h=To:From:Subject:Date;
	b=in6upQOSHjp3sEctlyQAXahDXuqh+RcZ3G98OsoaWHw1vuQos2YtATZZT2XW86loB
	 E0sR0X3253dUi+XA2vbzqAJFJIe2XrzxczFDPpYsAph+c4fx3+KUQcQjL5C5IKnOAb
	 luWHNJ0vrA9A6T6+UqwenE8rjkRfOOKoa3OzCacs=
To:	git@vger.kernel.org
From:	Naja Melan <najamelan@autistici.org>
Subject: Git 2.8.1 - bug in patience diff algorithm when used with
 --ignore-space-at-eol?
Message-ID: <3153d359-2b82-d5e2-9e92-7a28bcd8bc48@autistici.org>
Date:	Fri, 08 Jul 2016 16:51:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When diffing with --patience and --ignore-space-at-eol, a change that
adds or removes just one character a the end of a line isn't picked up.

Other diff algorithms don't suffer from this and patience doesn't if I
don't put --ignore-space-at-eol.

See the following output for a proof:


$ git diff --ignore-space-at-eol lib/gitomate/facts/path.rb

diff --git a/lib/gitomate/facts/path.rb b/lib/gitomate/facts/path.rb
index bc99661..a5cd184 100644
--- a/lib/gitomate/facts/path.rb
+++ b/lib/gitomate/facts/path.rb
@@ -77,7 +77,7 @@ def check( update = false )
      options( :exist ) and warn "#{@info[ :path ].inspect} does not exist."
      options( :exist ) or  warn "#{@info[ :path ].inspect} exists but
it shouldn't."

-     @checked = true
+     @checked = trued
      return @checkPassed = false

   end

$ git diff --patience --ignore-space-at-eol lib/gitomate/facts/path.rb
-> no output

$ git diff --patience lib/gitomate/facts/path.rb

diff --git a/lib/gitomate/facts/path.rb b/lib/gitomate/facts/path.rb
index bc99661..a5cd184 100644
--- a/lib/gitomate/facts/path.rb
+++ b/lib/gitomate/facts/path.rb
@@ -77,7 +77,7 @@ def check( update = false )
      options( :exist ) and warn "#{@info[ :path ].inspect} does not exist."
      options( :exist ) or  warn "#{@info[ :path ].inspect} exists but
it shouldn't."

-     @checked = true
+     @checked = trued
      return @checkPassed = false

   end


Naja Melan
