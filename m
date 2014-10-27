From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] Documentation: remove Asciidoctor linkgit macro
Date: Mon, 27 Oct 2014 00:13:43 +0000
Message-ID: <1414368823-427216-3-git-send-email-sandals@crustytoothpaste.net>
References: <1414368823-427216-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 01:13:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiXwY-0008Qq-0x
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 01:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbaJ0ANv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 20:13:51 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49586 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745AbaJ0ANt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Oct 2014 20:13:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 966FB28092;
	Mon, 27 Oct 2014 00:13:48 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414368823-427216-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor provides an extension implementing a backend-independent
macro for dealing with manpage links just like the linkgit macro.  As
this is more likely to be up-to-date with future changes in Asciidoctor,
prefer using it over reimplementing in Git.

This reverts commit 773ee47c2b9c691d9758b2bea6cac10e3f0c4e12.
---
 Documentation/extensions.rb | 39 ---------------------------------------
 1 file changed, 39 deletions(-)
 delete mode 100644 Documentation/extensions.rb

diff --git a/Documentation/extensions.rb b/Documentation/extensions.rb
deleted file mode 100644
index c33a50d..0000000
--- a/Documentation/extensions.rb
+++ /dev/null
@@ -1,39 +0,0 @@
-require 'asciidoctor'
-require 'asciidoctor/extensions'
-
-module Git
-  module Documentation
-    class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
-      use_dsl
-
-      named :chrome
-
-      def process(parent, target, attrs)
-        if parent.document.basebackend? 'html'
-          generate_html(parent, target, attrs)
-        elsif parent.document.basebackend? 'docbook'
-          generate_docbook(parent, target, attrs)
-        end
-      end
-
-      private
-
-      def generate_html(parent, target, attrs)
-        section = attrs.has_key?(1) ? "(#{attrs[1]})" : ''
-        prefix = parent.document.attr('git-relative-html-prefix') || ''
-        %(<a href="#{prefix}#{target}.html">#{target}#{section}</a>\n)
-      end
-
-      def generate_docbook(parent, target, attrs)
-        %(<citerefentry>
-<refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
-</citerefentry>
-)
-      end
-    end
-  end
-end
-
-Asciidoctor::Extensions.register do
-  inline_macro Git::Documentation::LinkGitProcessor, :linkgit
-end
-- 
2.1.1
