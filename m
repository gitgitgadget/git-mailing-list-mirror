From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Mon, 2 Mar 2015 16:21:36 +0700
Message-ID: <20150302092136.GA30278@lanh>
References: <CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
 <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
 <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
 <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
 <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
 <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <xmqqioekawmb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:21:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMXL-00043v-QY
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbbCBJVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:21:11 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39198 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbCBJVI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 04:21:08 -0500
Received: by pablf10 with SMTP id lf10so42078716pab.6
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VQbT8ZHY5hoUmJjrgVNhZBo0Mbx8mYIeQ+WgczOIpA4=;
        b=ShL/RyZq7D8dDTmEcin3cqlXxyQSRNlFnSfUwQkeDMUcZbiec1Z1YoGN9gyEP7SDLq
         xfCn5xoBLKrxTkEiv3fuQlVf3oo+Ay2qp/tM5aiQIq24fJubcQ54/OI3YbgT6wThw64W
         lrhUNHGrxU7ATX5yxBfATTruG2NsDbVNercVSPNcc7sSdGUczc1T/EyibD9PjvbHE3tu
         MYBa917ptc0ig7sAuwoiyPwuCnVXGd1NjWACv4KS5UuiWI7c/1RHj68aDmlQUmwV8ZQp
         jPwOpdAzZwdj5LsXTq9QFXzg60fRYiGQ/v9cfE/wAh+oxwiGXnvYr3kLvEHiR2fEMOi2
         xHEw==
X-Received: by 10.66.157.231 with SMTP id wp7mr45676700pab.70.1425288068130;
        Mon, 02 Mar 2015 01:21:08 -0800 (PST)
Received: from lanh ([115.73.224.188])
        by mx.google.com with ESMTPSA id y7sm11245587pdp.92.2015.03.02.01.21.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 01:21:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 02 Mar 2015 16:21:36 +0700
Content-Disposition: inline
In-Reply-To: <xmqqioekawmb.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264578>

On Sun, Mar 01, 2015 at 07:47:40PM -0800, Junio C Hamano wrote:
> It seems, however, that our current thinking is that it is OK to do
> the "allow new v1 clients to notice the availabilty of v2 servers,
> so that they can talk v2 the next time" thing, so my preference is
> to throw this "client first and let server notice" into "maybe
> doable but not our first choice" bin, at least for now.

OK let's see if first choice like this could work. Very draft but it
should give some idea how to make a prototype to test it out. Note
that the server still speaks first in this proposal.

-- 8< --
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 462e206..32a1186 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -1,11 +1,11 @@
 Packfile transfer protocols
 ===========================
 
-Git supports transferring data in packfiles over the ssh://, git:// and
+Git supports transferring data in packfiles over the ssh://, git://, http:// and
 file:// transports.  There exist two sets of protocols, one for pushing
 data from a client to a server and another for fetching data from a
 server to a client.  All three transports (ssh, git, file) use the same
-protocol to transfer data.
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
 
@@ -124,9 +130,58 @@ has, the first can 'fetch' from the second.  This operation determines
 what data the server has that the client does not then streams that
 data down to the client in packfile format.
 
+Capability discovery (v2)
+-------------------------
 
-Reference Discovery
--------------------
+In version 1, capability discovery is part of reference discovery and
+covered in reference discovery section.
+
+In versino 2, when the client initially connects, the server
+immediately sends its capabilities to the client. Then the client must
+send the list of server capabilities it wants to use to the server.
+
+   S: 00XXcapabilities multi_ack thin-pack ofs-delta lang\n
+   C: 00XXcapabilities thin-pack ofs-delta lang=en\n
+
+----
+  cap              =  PKT-LINE("capabilities" SP capability-list LF)
+  capability-list  =  capability *(SP capability)
+  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
+  LC_ALPHA         =  %x61-7A
+----
+
+The client MUST NOT ask for capabilities the server did not say it
+supports.
+
+Server MUST diagnose and abort if capabilities it does not understand
+was sent.  Server MUST NOT ignore capabilities that client requested
+and server advertised.  As a consequence of these rules, server MUST
+NOT advertise capabilities it does not understand.
+
+See protocol-capabilities.txt for a list of allowed server and client
+capabilities and descriptions.
+
+XXX: this approach wastes one round trip in smart-http because the
+client would speak first. Perhaps we could allow client speculation.
+It can assume what server caps will send and send commands based on that
+assumption. If it turns out true, we save one round trip. E.g. fast
+path:
+
+   C: You are supposed to send caps A, B. I would respond with cap B.
+      Then I would send "want-refs refs/heads/foo".
+   S: (yes we are sending caps A and B), validate client caps,
+      execute "want-refs" and return ref list
+
+and slow path:
+
+   C: You are supposed to send caps A, B. I would respond with cap B.
+      Then I would send "want-refs refs/heads/foo".
+   S: Send caps A, B and C. ignore the rest from client
+   C: Want caps A and C. Send "want-refs foo"
+   S: return ref foo
+
+Reference Discovery (v1)
+------------------------
 
 When the client initially connects the server will immediately respond
 with a listing of each reference it has (all branches and tags) along
@@ -178,16 +233,69 @@ MUST peel the ref if it's an annotated tag.
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
-- 8< --
