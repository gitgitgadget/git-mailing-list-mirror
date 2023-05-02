Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A43C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 04:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEBELY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 00:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBELU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 00:11:20 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DD2114
        for <git@vger.kernel.org>; Mon,  1 May 2023 21:11:18 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-18b0879e0c8so2759431fac.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 21:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683000677; x=1685592677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYJGzyU0fFVsMvmSTN1q34tJ32Jvn4O4BJHU2C+Tsdk=;
        b=gcRA2aPB9Q+VEMai9YV7iEaj1+iKqSx8F8eH1uvdM7abORwIIvvzR4eAtYL6JnIdPG
         Kly9WWndD6AIQw+yVohr65k/fk1a7CR78x84u+mPawryVTjGpxNgeuLh/PgTSuttSMCm
         iRJsYzdqt5eDHUROLSBrrRHpdP47AuyvlqUAf3/Ig+dg02P3SJ4LnSLL9miSQtJ4vxX6
         9alC4NpkvTqvPDZnLDN/J2bvq5JHdWYPEVj0wPycyKZIOGOvbseYW6du8p3ZNNY/ROan
         lbKBHfAoQl4wWOAfIipyxJ6Trbo8jsroAQFQjOze1TMeO8buf3y6kN6JqQKxxpcIDDHG
         QGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683000677; x=1685592677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYJGzyU0fFVsMvmSTN1q34tJ32Jvn4O4BJHU2C+Tsdk=;
        b=JPpgPfZOkqSp/VDZX9N73hSlsJFLXhrOdGqnIPEZybhdtaA2TYV/Or+0jDOw0WQT6m
         CfrGr4t0BlLKfhgw8MLIDWhmjZDGvwCkxppR6SD5U/oon+/cP4lGl4CHJTuwqHXXnsm+
         goiGy2SuwHzRPXrM7dT+c9HUhdhp/V5V2ntD0clrJI4gG0D0MPTNI2umaVB1Vu1ysuKG
         0xZYDOdxkzHQZJpP0TUWbpkNok+/5Oc6W0chflDt/E/QyhFIh5AONNT6AxGZC7LZvFp3
         L4rHVFvFPi1HiuByF5NimUeBNm5peJtJbKU8aINYCZJTmqi7l3/whOuZ/rv0/QS70LQq
         COjQ==
X-Gm-Message-State: AC+VfDyy/36WvCWI3ren7E6iVVGVMfT4o3BkAPNSUkpSHrhzG9PfTgwL
        JdTyn76FxZvCrmzFGTm6o+rksDhGb1M=
X-Google-Smtp-Source: ACHHUZ6+GRtnCzyJBkjgBlkDNfHYmTQdZbdcObyDbfNgDhU+0xyG+jhhlg4W5aeDZCxF9SKNi7EiVA==
X-Received: by 2002:a05:6870:9444:b0:187:796c:b5cd with SMTP id e4-20020a056870944400b00187796cb5cdmr6324834oal.23.1683000677629;
        Mon, 01 May 2023 21:11:17 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h19-20020a4add93000000b0054c7a08d4casm604130oov.38.2023.05.01.21.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 21:11:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 2/3] test: add basic unit testing framework
Date:   Mon,  1 May 2023 22:11:12 -0600
Message-Id: <20230502041113.103385-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230502041113.103385-1-felipe.contreras@gmail.com>
References: <20230502041113.103385-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Testing full git commands is helpful, but so it is to test specific
functions, which is not easy to do from the shell, which is how the
current testing framework is implemented.

A much more modern way to test specific functions is to write a binding
for a modern language--like Ruby--and then use that binding on a modern
testing framework using the same language.

This makes the testing framework much simpler, and also has the
advantage that writing the Ruby bindings spots libification issues.

Moreover no forks are needed, and crashes are handled nicely due to
Ruby's exception handling.

This is the best of all worlds.

This step doesn't add any actual unit tests, simply prepares the
groundwork for writing them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/Makefile       | 13 +++++++++
 t/ruby/git.c     |  7 +++++
 t/ruby/testox.rb | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/unit-test.t    | 10 +++++++
 4 files changed, 98 insertions(+)
 create mode 100644 t/ruby/git.c
 create mode 100644 t/ruby/testox.rb
 create mode 100644 t/unit-test.t

diff --git a/t/Makefile b/t/Makefile
index d85e3e661d..4fdad529ab 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -47,6 +47,9 @@ CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 # scripts not to run the external "chainlint.pl" script themselves
 CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT &&
 
+RUBY_LIBS = $(shell pkg-config --libs ruby-3.0)
+RUBY_CFLAGS = $(shell pkg-config --cflags ruby-3.0)
+
 all: $(DEFAULT_TEST_TARGET)
 
 test: pre-clean check-chainlint $(TEST_LINT)
@@ -65,6 +68,13 @@ prove: pre-clean check-chainlint $(TEST_LINT)
 $(T):
 	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
+ruby/git.o: ruby/git.c
+	$(QUIET_CC)$(COMPILE.c) -o $@ $<
+
+ruby/git.so: CFLAGS := -fPIC $(RUBY_CFLAGS) -Ilib/ $(CFLAGS)
+ruby/git.so: LIBS := $(RUBY_LIBS) -Llib/ -lgit $(LIBS)
+ruby/git.so: ruby/git.o | lib/libgit.so
+
 lib/git.o: lib/git.c
 	$(QUIET_CC)$(COMPILE.c) -o $@ $<
 
@@ -74,6 +84,9 @@ lib/libgit.so: lib/git.o
 %.so::
 	$(QUIET_LINK)$(CC) -shared -o $@ $^ $(LIBS)
 
+test-unit: ruby/git.so
+	@LD_LIBRARY_PATH=lib/ ruby -Iruby unit-test.t
+
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
diff --git a/t/ruby/git.c b/t/ruby/git.c
new file mode 100644
index 0000000000..e75692c582
--- /dev/null
+++ b/t/ruby/git.c
@@ -0,0 +1,7 @@
+#include <ruby.h>
+#include <git.h>
+
+void Init_git(void)
+{
+	VALUE mod = rb_define_module("Git");
+}
diff --git a/t/ruby/testox.rb b/t/ruby/testox.rb
new file mode 100644
index 0000000000..1cc58a3ab3
--- /dev/null
+++ b/t/ruby/testox.rb
@@ -0,0 +1,68 @@
+# Copyright (c) 2023 Felipe Contreras
+
+require 'singleton'
+
+class TestOxException < StandardError
+  attr_reader :actual, :expected
+
+  def initialize(actual, expected)
+    @actual, @expected = actual, expected
+  end
+end
+
+class TestOx
+  include Singleton
+
+  @tests = []
+
+  class << self
+
+    def add(desc, &block)
+      @tests << [ desc, block ]
+    end
+
+    def run
+      success = true
+
+      puts '1..%d' % @tests.length
+
+      @tests.each_with_index do |(desc, block),i|
+        begin
+          instance.instance_exec(&block)
+          puts 'ok %d - %s' % [i + 1, desc]
+        rescue => e
+          success = false
+          puts 'not ok %d - %s' % [i + 1, desc]
+          if e.is_a?(TestOxException)
+            puts '# -%s' % e.expected
+            puts '# +%s' % e.actual
+          else
+            puts '# exception: %s' % e
+          end
+        end
+      end
+
+      return success
+    end
+
+  end
+
+  def assert(string)
+    raise string
+  end
+
+  def ok(bool)
+    raise TestOxException.new(bool.inspect, true) unless bool
+  end
+
+  def is(actual, expected)
+    raise TestOxException.new(actual, expected) unless actual == expected
+  end
+
+end
+
+def test(*args, &block)
+  TestOx.add(*args, &block)
+end
+
+at_exit { exit TestOx.run }
diff --git a/t/unit-test.t b/t/unit-test.t
new file mode 100644
index 0000000000..97d8a14ec3
--- /dev/null
+++ b/t/unit-test.t
@@ -0,0 +1,10 @@
+#!/bin/env ruby
+
+require 'testox'
+require 'git'
+
+test 'basic' do
+  ok(true)
+end
+
+# vim: ft=ruby
-- 
2.40.0+fc1

