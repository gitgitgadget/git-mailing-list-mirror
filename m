Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0A91F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfGIXFz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:05:55 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43951 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:05:55 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so135494pfz.10
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=wTyculBfBH7rjA+cBKMgZTM7i5F2ir8ueapSceISMVI=;
        b=gqeU8/s23FXx/fZLp76zkTyvL7yiwSAOFai6D1HWrHmnUASVrmBvdfKhjvA+6jIV0O
         Mz89S860QyUZLRTXAsTv8JpNFNyLuc8N4T1gtH0cXLOYCZ3lrKuYb5Qn24qR9Lsf71AE
         MEzbty+0yhvJv3in84mSz/llWLaFNjNz7/fgd/sjC74laaCogNOeZbZ8oHGOV4N9bSSO
         q7sylXBJiA3N8zedZo/yJ3UwOgdKBVqF6h3LcIxf2JJaOfaOgDKea30ay1XcAZbZhXTG
         aY3Fv4GzXCxeK7ZR57aaixQmqlQsmhlXjzwi+XcnbRMgRVg+UXgauOH+cphYcLQLs6mz
         q6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=wTyculBfBH7rjA+cBKMgZTM7i5F2ir8ueapSceISMVI=;
        b=Qm0/G+60rS+pC37he9srg/rt9AJVxxQZQ8fJvwtdZrMqk+x49FFR3U/Vk1M3YkZgYN
         WuEB1yaf5zfpps+UXxWaZXVjJ2skMggMOyiJgTYT2DC2Z4jrsmY9/u97GMpIPyD6eUns
         s4Lcn3S7GRLkEFJMtWnLABlZrzvvWERb4WfppPLIqU+hl525a9d3l7jOIGvjYAADBRgm
         BWu1mJWg+EnV0DU7yNmOEZVdGoj6UWZp77pCtRW4h8AQMY3OuPZC2a/aB+NgmCrukz3w
         5wSeX/M7fMVQmWpSWTKkOS07/KPqyjy19pDvERse6eVg9GJfLlRJhIm/SGjQUjtfEubZ
         UZ+A==
X-Gm-Message-State: APjAAAVSybcxWRAnLAd0RCraZeISS5HHkzRXegCb4Yr50MA9RpboWtSz
        KWCiivLCWB1JEcxCeZ51m+cCcVyjdKkj/q9OZ97piPqGPZTAkwLC1qMeY4h2tlyk84JJN75mBNM
        tuOd55nt0esasty7FiG/SnFWOW0MHCMZoAB/1wJ8apCajlXivkr1nlevbwERYUAU=
X-Google-Smtp-Source: APXvYqyJfy3ZGc/ERC9ULHcYjhzpVnVZCr+1aNH0eCia1VvmNCDBdjJz69GB8VCi7T/2wAnCLavPJaHTeEvUKw==
X-Received: by 2002:a65:640d:: with SMTP id a13mr33200469pgv.256.1562713554197;
 Tue, 09 Jul 2019 16:05:54 -0700 (PDT)
Date:   Tue,  9 Jul 2019 16:05:44 -0700
In-Reply-To: <cover.1562712943.git.steadmon@google.com>
Message-Id: <3fa4e9eef84ba00c631c82fb3a2eacb8439df9e5.1562712943.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com> <cover.1562712943.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [RFC PATCH v2 2/3] trace2: add a schema validator for trace2 events
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

trace_schema_validator can be used to verify that trace2 event output
conforms to the expectations set by the API documentation and codified
in event_schema.json (or strict_schema.json). This allows us to build a
regression test to verify that trace2 output does not change
unexpectedly.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/trace_schema_validator/.gitignore           |  1 +
 t/trace_schema_validator/Makefile             | 10 +++
 .../trace_schema_validator.go                 | 78 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 t/trace_schema_validator/.gitignore
 create mode 100644 t/trace_schema_validator/Makefile
 create mode 100644 t/trace_schema_validator/trace_schema_validator.go

diff --git a/t/trace_schema_validator/.gitignore b/t/trace_schema_validator/.gitignore
new file mode 100644
index 0000000000..c3f1e04e9e
--- /dev/null
+++ b/t/trace_schema_validator/.gitignore
@@ -0,0 +1 @@
+trace_schema_validator
diff --git a/t/trace_schema_validator/Makefile b/t/trace_schema_validator/Makefile
new file mode 100644
index 0000000000..ed22675e5d
--- /dev/null
+++ b/t/trace_schema_validator/Makefile
@@ -0,0 +1,10 @@
+.PHONY: fetch_deps clean
+
+trace_schema_validator: fetch_deps trace_schema_validator.go
+	go build
+
+fetch_deps:
+	go get github.com/xeipuuv/gojsonschema
+
+clean:
+	rm -f trace_schema_validator
diff --git a/t/trace_schema_validator/trace_schema_validator.go b/t/trace_schema_validator/trace_schema_validator.go
new file mode 100644
index 0000000000..f779ac5ff5
--- /dev/null
+++ b/t/trace_schema_validator/trace_schema_validator.go
@@ -0,0 +1,78 @@
+// trace_schema_validator validates individual lines of an input file against a
+// provided JSON-Schema for git trace2 event output.
+//
+// Traces can be collected by setting the GIT_TRACE2_EVENT environment variable
+// to an absolute path and running any Git command; traces will be appended to
+// the file.
+//
+// Traces can then be verified like so:
+//   trace_schema_validator \
+//     --trace2_event_file /path/to/trace/output \
+//     --schema_file /path/to/schema
+package main
+
+import (
+	"bufio"
+	"flag"
+	"log"
+	"os"
+	"path/filepath"
+
+	"github.com/xeipuuv/gojsonschema"
+)
+
+// Required flags
+var schemaFile = flag.String("schema_file", "", "JSON-Schema filename")
+var trace2EventFile = flag.String("trace2_event_file", "", "trace2 event filename")
+
+func main() {
+	flag.Parse()
+	if *schemaFile == "" || *trace2EventFile == "" {
+		log.Fatal("Both --schema_file and --trace2_event_file are required.")
+	}
+	schemaURI, err := filepath.Abs(*schemaFile)
+	if err != nil {
+		log.Fatal("Can't get absolute path for schema file: ", err)
+	}
+	schemaURI = "file://" + schemaURI
+
+	schemaLoader := gojsonschema.NewReferenceLoader(schemaURI)
+	schema, err := gojsonschema.NewSchema(schemaLoader)
+	if err != nil {
+		log.Fatal("Problem loading schema: ", err)
+	}
+
+	tracesFile, err := os.Open(*trace2EventFile)
+	if err != nil {
+		log.Fatal("Problem opening trace file: ", err)
+	}
+	defer tracesFile.Close()
+
+	scanner := bufio.NewScanner(tracesFile)
+
+	count := 0
+	for ; scanner.Scan(); count++ {
+		if count%10000 == 0 {
+			// Travis-CI expects regular output or it will time out.
+			log.Print("Validated items: ", count)
+		}
+		event := gojsonschema.NewStringLoader(scanner.Text())
+		result, err := schema.Validate(event)
+		if err != nil {
+			log.Fatal(err)
+		}
+		if !result.Valid() {
+			log.Print("Trace event is invalid: ", scanner.Text())
+			for _, desc := range result.Errors() {
+				log.Print("- ", desc)
+			}
+			os.Exit(1)
+		}
+	}
+
+	if err := scanner.Err(); err != nil {
+		log.Fatal("Scanning error: ", err)
+	}
+
+	log.Print("Validated events: ", count)
+}
-- 
2.22.0.510.g264f2c817a-goog

