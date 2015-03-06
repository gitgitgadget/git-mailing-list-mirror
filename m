From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] protocol upload-pack-v2
Date: Fri,  6 Mar 2015 15:38:07 -0800
Message-ID: <1425685087-21633-1-git-send-email-sbeller@google.com>
References: <20150302092136.GA30278@lanh>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 07 00:38:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU1ox-0003KA-Gz
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 00:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbbCFXiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 18:38:14 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44490 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbbCFXiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 18:38:12 -0500
Received: by iecar1 with SMTP id ar1so89662579iec.11
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 15:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e/yuW9MbylK4yJGWkVzQA3oULmDitBgiUGCSvz/1g+I=;
        b=YiiGLfdEB1pUUVYfVMCyUbAJ+nLp7qanx383WFhWlNrj9ytjGyv1avxs44SJH3VWf8
         /Q0nySQhcxRFUPYGuS7geDILD4x4HCQjTii0rsS9L3tscFpMZs+crbuRkaYcMZ1NFbeT
         7XgAimdNjG9UpRKcQ2HslZIQp4uv7AlXsmfDQb3FM/qngXMZpS6SXmvlhdcQwlY1t7HB
         Cxn2C5Mbo7tGUGRNKOmtHfSjd9okwU7gdKlHopvLnDSkuR/BDdbgLcBhRoViTEnkdu+H
         aj2OyptwmXNKD6IuNEvv6S/eaVikgcnm0Rr8OFuVHeQ3eMybiHZH0e6SeuYw9fkRGqgD
         7d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e/yuW9MbylK4yJGWkVzQA3oULmDitBgiUGCSvz/1g+I=;
        b=Ph6dQaCW6C0dJ7pNuW2KQZf6ZkyTLaCpl0nBfAxqbBP/2IT92WQukKfhpM4Hxj3DPc
         3uCnAHeWJqv1R0NvOIBEm0xWxlJP8bhupX/CKDrCD2H3qYXgxN3yhcXzFPkgrGuEi0Nx
         4NlOLvF7QnbaRjUosI9Zq/aukZjTsy/I9bzVN9Vb9LPO0v+4SE1gPqyScuiYgEbVgh2p
         tKqqtuKM85ybCzEmjOyLXJgX77MLA3WtFciqWtyX9JHEakCAuwtpfmggnqnO3bnMzxTa
         g0zwkVbybO5V7BtmyAz04Mf+zs8Nhcr1BXPJr/HAGb5CdyFJt/FUt0UP/3f3Oz3JVJbH
         3h0g==
X-Gm-Message-State: ALoCoQn4ANf9HnEbgEn4pHIQywG7k7VloJy0HAsepQk2nnKQnwHeV3deXg0ULf9jbLYN3tD6QdCp
X-Received: by 10.42.88.1 with SMTP id a1mr13241482icm.29.1425685091719;
        Fri, 06 Mar 2015 15:38:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f081:aafb:d9e3:be46])
        by mx.google.com with ESMTPSA id vk4sm1760040igc.11.2015.03.06.15.38.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Mar 2015 15:38:10 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <20150302092136.GA30278@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264972>

From: Duy Nguyen <pclouds@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This is just aimed at untangling capabilities and refs
    advertisement, no new features.
    
    Hence this is missing the proposal from Duy to save one RTT.
    I have the impression that most of you are dreaming about new
    features which would solve the actual problem, but I'd first try
    to change the protocol which enables such game changers without
    adding new features at first. The optimisation to save a round trip
    or the optimisation how to save sending all the refs will come
    in a follow up series.
    
    XXX: this approach wastes one round trip in smart-http because the
    client would speak first. Perhaps we could allow client speculation.
    It can assume what server caps will send and send commands based on that
    assumption. If it turns out true, we save one round trip. E.g. fast
    path:
       C: You are supposed to send caps A, B. I would respond with cap B.
          Then I would send "want-refs refs/heads/foo".
       S: (yes we are sending caps A and B), validate client caps,
          execute "want-refs" and return ref list
    
    and slow path:
    
       C: You are supposed to send caps A, B. I would respond with cap B.
          Then I would send "want-refs refs/heads/foo".
       S: Send caps A, B and C. ignore the rest from client
       C: Want caps A and C. Send "want-refs foo"
       S: return ref foo

 Documentation/technical/pack-protocol.txt         | 122 ++++++++++++++++++++--
 Documentation/technical/protocol-capabilities.txt |  22 ++--
 2 files changed, 121 insertions(+), 23 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 462e206..38bed2c 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -1,11 +1,11 @@
 Packfile transfer protocols
 ===========================
 
-Git supports transferring data in packfiles over the ssh://, git:// and
+Git supports transferring data in packfiles over the ssh://, git://, http:// and
 file:// transports.  There exist two sets of protocols, one for pushing
 data from a client to a server and another for fetching data from a
-server to a client.  All three transports (ssh, git, file) use the same
-protocol to transfer data.
+server to a client.  The three transports (ssh, git, file) use the same
+protocol to transfer data. http is documented in http-protocol.txt.
 
 The processes invoked in the canonical Git implementation are 'upload-pack'
 on the server side and 'fetch-pack' on the client side for fetching data;
@@ -14,6 +14,12 @@ data.  The protocol functions to have a server tell a client what is
 currently on the server, then for the two to negotiate the smallest amount
 of data to send in order to fully update one or the other.
 
+"upload-pack-2" and "receive-pack-2" are the next generation of
+"upload-pack" and "receive-pack" respectively. The first two are
+referred as "version 2" in this document and pack-capabilities.txt
+while the last two are "version 1". Unless stated otherwise, "version 1"
+is implied.
+
 Transports
 ----------
 There are three transports over which the packfile protocol is
@@ -42,7 +48,8 @@ hostname parameter, terminated by a NUL byte.
 
 --
    git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
-   request-command   = "git-upload-pack" / "git-receive-pack" /
+   request-command   = "git-upload-pack" / "git-upload-pack-2" /
+		       "git-receive-pack" / "git-receive-pack-2" /
 		       "git-upload-archive"   ; case sensitive
    pathname          = *( %x01-ff ) ; exclude NUL
    host-parameter    = "host=" hostname [ ":" port ]
@@ -67,7 +74,6 @@ gracefully with an error message.
   error-line     =  PKT-LINE("ERR" SP explanation-text)
 ----
 
-
 SSH Transport
 -------------
 
@@ -124,9 +130,56 @@ has, the first can 'fetch' from the second.  This operation determines
 what data the server has that the client does not then streams that
 data down to the client in packfile format.
 
+Capability discovery (v2)
+-------------------------
 
-Reference Discovery
--------------------
+In version 1, capability discovery is part of reference discovery and
+covered in reference discovery section.
+
+In version 2, when the client initially connects, the server
+immediately sends its capabilities to the client. Then the client must
+send the list of server capabilities it wants to use to the server.
+
+   S: 00XXcapabilities 4\n
+   S: 00XXcap:lang\n
+   S: 00XXcap:thin-pack\n
+   S: 00XXcap:ofs-delta\n
+   S: 00XXagent:agent=git/2:3.4.5+custom-739-gb850f98\n
+
+   C: 00XXcapabilities 3
+   C: 00XXcap:thin-pack\n
+   C: 00XXcap:ofs-delta\n
+   C: 00XXcap:lang=en\n
+   C: 00XXagent:agent=git/custom_string\n
+
+----
+  cap              =  PKT-LINE("capabilities" SP size LF list)
+  size             =  *DIGIT
+  capability-list  =  *(capability) [agent LF]
+  capability       =  "cap:" keyvaluepair LF
+  agent            =  keyvaluepair LF
+  keyvaluepair     =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
+  LC_ALPHA         =  %x61-7A
+----
+
+The client MUST ignore any data before the pkt-line starting with "capabilities"
+for future easy of extension.
+
+The server MUST advertise "size" as the decimal number of lines following
+the "capabilities" line. This includes lines starting "cap:" and "agent:" for now.
+The client MUST ignore lines which start with an unknown pattern.
+
+The client MUST NOT ask for capabilities the server did not say it
+supports. The server MUST diagnose and abort if capabilities it does
+not understand was requested. The server MUST NOT ignore capabilities
+that client requested and server advertised.  As a consequence of these
+rules, server MUST NOT advertise capabilities it does not understand.
+
+See protocol-capabilities.txt for a list of allowed server and client
+capabilities and descriptions.
+
+Reference Discovery (v1)
+------------------------
 
 When the client initially connects the server will immediately respond
 with a listing of each reference it has (all branches and tags) along
@@ -178,16 +231,69 @@ MUST peel the ref if it's an annotated tag.
   shallow          =  PKT-LINE("shallow" SP obj-id)
 
   capability-list  =  capability *(SP capability)
-  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
+  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
   LC_ALPHA         =  %x61-7A
 ----
 
 Server and client MUST use lowercase for obj-id, both MUST treat obj-id
 as case-insensitive.
 
+On the very first line of the initial server response of either
+receive-pack and upload-pack the first reference is followed by
+a NUL byte and then a list of space delimited server capabilities.
+These allow the server to declare what it can and cannot support
+to the client.
+
+Client will then send a space separated list of capabilities it wants
+to be in effect. The client MUST NOT ask for capabilities the server
+did not say it supports.
+
+Server MUST diagnose and abort if capabilities it does not understand
+was sent.  Server MUST NOT ignore capabilities that client requested
+and server advertised.  As a consequence of these rules, server MUST
+NOT advertise capabilities it does not understand.
+
 See protocol-capabilities.txt for a list of allowed server capabilities
 and descriptions.
 
+Reference Discovery (v2)
+------------------------
+
+In version 2, reference discovery is initiated by the client with
+"want-refs" line. The client may skip reference discovery phase
+entirely by not sending "want-refs" (e.g. the client has another way
+to retrieve ref list).
+
+----
+  want-refs  =  PKT-LINE("want-refs" SP mode *argument)
+  mode       =  "all"
+  argument   =  SP arg
+  arg        =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
+----
+
+Mode "all" sends all visible refs to the client like in version 1. No
+arguments are accepted in this mode. More modes may be available based
+on capabilities.
+
+----
+  advertised-refs  =  (no-refs / list-of-refs)
+		      *shallow
+		      flush-pkt
+
+  no-refs          =  PKT-LINE(zero-id LF)
+
+  list-of-refs     =  *other-ref
+  other-ref        =  PKT-LINE(other-tip / other-peeled)
+  other-tip        =  obj-id SP refname LF
+  other-peeled     =  obj-id SP refname "^{}" LF
+
+  shallow          =  PKT-LINE("shallow" SP obj-id)
+
+  capability-list  =  capability *(SP capability)
+  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
+  LC_ALPHA         =  %x61-7A
+----
+
 Packfile Negotiation
 --------------------
 After reference and capabilities discovery, the client can decide to
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 4f8a7bf..ecb0efd 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -3,21 +3,6 @@ Git Protocol Capabilities
 
 Servers SHOULD support all capabilities defined in this document.
 
-On the very first line of the initial server response of either
-receive-pack and upload-pack the first reference is followed by
-a NUL byte and then a list of space delimited server capabilities.
-These allow the server to declare what it can and cannot support
-to the client.
-
-Client will then send a space separated list of capabilities it wants
-to be in effect. The client MUST NOT ask for capabilities the server
-did not say it supports.
-
-Server MUST diagnose and abort if capabilities it does not understand
-was sent.  Server MUST NOT ignore capabilities that client requested
-and server advertised.  As a consequence of these rules, server MUST
-NOT advertise capabilities it does not understand.
-
 The 'atomic', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
 capabilities are sent and recognized by the receive-pack (push to server)
 process.
@@ -268,3 +253,10 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+v2
+--
+
+'git-upload-pack' and 'git-receive-pack' may advertise this capability
+if the server supports 'git-upload-pack-2' and 'git-receive-pack-2'
+respectively.
-- 
2.3.0.81.gc37f363
