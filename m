From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Document the HTTP transport protocols
Date: Wed, 21 Aug 2013 20:45:13 +0700
Message-ID: <1377092713-25434-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	rctay89@gmail.com, "Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 15:42:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC8gH-00087l-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 15:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab3HUNmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Aug 2013 09:42:32 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54915 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab3HUNmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 09:42:31 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so472073pde.37
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=jWAuPyxNQ0y2NXWtpPNHOIMV863vgk+gUvrMZcLLamc=;
        b=bgDU5ef9AKL6U2/tLj/ZqOtn6c5m+SSNQS51fYdRvoqrZyIqPievNE77RF5VZ0qhsA
         KxDOecnFoIXY761LaJm78J3iYzGtFPzD+BtpKcX8mM8e7V0kw6bSK58iP09vE7l4wkSm
         wSpTQSNhdEHLA93xUrzTy3FR36cK9ibd8CP2WXu0hCltOAFJZNfhMsPtVe3nKizmf0s/
         FYyv9MvNn4GiFs0+9WezBfp9waaBgAfS04k1eman+ZBQhWgpTPLGFp/kSS0hvZtdqmti
         HfgdWRlY3Q3BoQX4s98yJP1iu7k1w1C8yr1eJ7j1/xlMpm3kWCsla67Cgyv4GShFAC3S
         vzJQ==
X-Received: by 10.66.217.166 with SMTP id oz6mr9828638pac.22.1377092550874;
        Wed, 21 Aug 2013 06:42:30 -0700 (PDT)
Received: from lanh ([115.73.201.19])
        by mx.google.com with ESMTPSA id ib9sm8476808pbc.43.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 06:42:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 21 Aug 2013 20:45:21 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232702>

=46rom: "Shawn O. Pearce" <spearce@spearce.org>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Revised-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is basically the version from Tay Ray Chuan [1] with one more
 proofreading round from me. My changes besides realignments are below.
 There are TODOs remain but I think the document is valuable as it is.

 On the topic, C Git's (maybe) violations on this spec are:
=20
  - The client does not strip trailing slashes from $GIT_URL before
    sending to the server, as described in section "URL Format".
=20
  - The client does not check that HTTP status code is either 200 or
    304 when receiving response in discovering references phase.
=20
  - The client verifies the first 5 bytes against pattern
    "^[0-9a-fA-F]{4}#" instead of "^[0-9a-f]{4}#" as described in
    section "discovering references".

 [1] https://raw.github.com/rctay/git/feature/http-doc/Documentation/te=
chnical/http-protocol.txt

    diff --git b/home/pclouds/t/http-protocol.txt a/Documentation/techn=
ical/http-protocol.txt
    index 0b1c96c..8812bf6 100644
    --- b/home/pclouds/t/http-protocol.txt
    +++ a/Documentation/technical/http-protocol.txt
    @@ -315,7 +315,8 @@ Servers SHOULD support all capabilities defined=
 here.
    =20
     Clients MUST send at least one 'want' command in the request body.
     Clients MUST NOT reference an id in a 'want' command which did not
    -appear in the response obtained through ref discovery.
    +appear in the response obtained through ref discovery unless the
    +server advertises capability "allow-tip-sha1-in-want".
    =20
       compute_request   =3D  want_list
                            have_list
    @@ -330,31 +331,9 @@ appear in the response obtained through ref di=
scovery.
    =20
       have_list         =3D  *PKT-LINE("have" SP id LF)
    =20
    -  command           =3D  create / delete / update
    -  create            =3D  zero-id SP new_id SP name
    -  delete            =3D  old_id SP zero-id SP name
    -  update            =3D  old_id SP new_id SP name
    -
     TODO: Document this further.
     TODO: Don't use uppercase for variable names below.
    =20
    -Capability include-tag
    -~~~~~~~~~~~~~~~~~~~~~~
    -
    -When packing an object that an annotated tag points at, include th=
e
    -tag object too.  Clients can request this if they want to fetch
    -tags, but don't know which tags they will need until after they
    -receive the branch data.  By enabling include-tag an extra call
    -to upload-pack can be avoided.
    -
    -Capability thin-pack
    -~~~~~~~~~~~~~~~~~~~~
    -
    -When packing a deltified object the base is not included if the ba=
se
    -is reachable from an object listed in the COMMON set by the client=
=2E
    -This reduces the bandwidth required to transfer, but it does sligh=
tly
    -increase processing time for the client to save the pack to disk.
    -
     The Negotiation Algorithm
     ~~~~~~~~~~~~~~~~~~~~~~~~~
     The computation to select the minimal pack proceeds as follows
    @@ -520,4 +499,5 @@ References
    =20
     link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resourc=
e Locators (URL)]
     link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Trans=
fer Protocol -- HTTP/1.1]
    -
    +link:technical/pack-protocol.txt
    +link:technical/protocol-capabilities.txt

 Documentation/technical/http-protocol.txt (new) | 503 ++++++++++++++++=
++++++++
 1 file changed, 503 insertions(+)
 create mode 100644 Documentation/technical/http-protocol.txt

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/=
technical/http-protocol.txt
new file mode 100644
index 0000000..8812bf6
--- /dev/null
+++ b/Documentation/technical/http-protocol.txt
@@ -0,0 +1,503 @@
+HTTP transfer protocols
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Git supports two HTTP based transfer protocols.  A "dumb" protocol
+which requires only a standard HTTP server on the server end of the
+connection, and a "smart" protocol which requires a Git aware CGI
+(or server module).  This document describes both protocols.
+
+As a design feature smart clients can automatically upgrade "dumb"
+protocol URLs to smart URLs.  This permits all users to have the
+same published URL, and the peers automatically select the most
+efficient transport available to them.
+
+
+URL Format
+----------
+
+URLs for Git repositories accessed by HTTP use the standard HTTP
+URL syntax documented by RFC 1738, so they are of the form:
+
+  http://<host>:<port>/<path>?<searchpart>
+
+Within this documentation the placeholder $GIT_URL will stand for
+the http:// repository URL entered by the end-user.
+
+Servers SHOULD handle all requests to locations matching $GIT_URL, as
+both the "smart" and "dumb" HTTP protocols used by Git operate
+by appending additional path components onto the end of the user
+supplied $GIT_URL string.
+
+An example of a dumb client requesting for a loose object:
+
+  $GIT_URL:     http://example.com:8080/git/repo.git
+  URL request:  http://example.com:8080/git/repo.git/objects/d0/49f6c2=
7a2244e12041955e262a404c7faba355
+
+An example of a smart request to a catch-all gateway:
+
+  $GIT_URL:     http://example.com/daemon.cgi?svc=3Dgit&q=3D
+  URL request:  http://example.com/daemon.cgi?svc=3Dgit&q=3D/info/refs=
&service=3Dgit-receive-pack
+
+An example of a request to a submodule:
+
+  $GIT_URL:     http://example.com/git/repo.git/path/submodule.git
+  URL request:  http://example.com/git/repo.git/path/submodule.git/inf=
o/refs
+
+Clients MUST strip a trailing '/', if present, from the user supplied
+$GIT_URL string to prevent empty path tokens ('//') from appearing
+in any URL sent to a server.  Compatible clients MUST expand
+'$GIT_URL/info/refs' as 'foo/info/refs' and not 'foo//info/refs'.
+
+
+Authentication
+--------------
+
+Standard HTTP authentication is used if authentication is required
+to access a repository, and MAY be configured and enforced by the
+HTTP server software.
+
+Because Git repositories are accessed by standard path components
+server administrators MAY use directory based permissions within
+their HTTP server to control repository access.
+
+Clients SHOULD support Basic authentication as described by RFC 2616.
+Servers SHOULD support Basic authentication by relying upon the
+HTTP server placed in front of the Git server software.
+
+Servers SHOULD NOT require HTTP cookies for the purposes of
+authentication or access control.
+
+Clients and servers MAY support other common forms of HTTP based
+authentication, such as Digest authentication.
+
+
+SSL
+---
+
+Clients and servers SHOULD support SSL, particularly to protect
+passwords when relying on Basic HTTP authentication.
+
+
+Session State
+-------------
+
+The Git over HTTP protocol (much like HTTP itself) is stateless
+from the perspective of the HTTP server side.  All state MUST be
+retained and managed by the client process.  This permits simple
+round-robin load-balancing on the server side, without needing to
+worry about state management.
+
+Clients MUST NOT require state management on the server side in
+order to function correctly.
+
+Servers MUST NOT require HTTP cookies in order to function correctly.
+Clients MAY store and forward HTTP cookies during request processing
+as described by RFC 2616 (HTTP/1.1).  Servers SHOULD ignore any
+cookies sent by a client.
+
+
+General Request Processing
+--------------------------
+
+Except where noted, all standard HTTP behavior SHOULD be assumed
+by both client and server.  This includes (but is not necessarily
+limited to):
+
+If there is no repository at $GIT_URL, or the resource pointed to by a
+location matching $GIT_URL does not exist, the server MUST NOT respond
+with '200 OK' response.  A server SHOULD respond with
+'404 Not Found', '410 Gone', or any other suitable HTTP status code
+which does not imply the resource exists as requested.
+
+If there is a repository at $GIT_URL, but access is not currently
+permitted, the server MUST respond with the '403 Forbidden' HTTP
+status code.
+
+Servers SHOULD support both HTTP 1.0 and HTTP 1.1.
+Servers SHOULD support chunked encoding for both request and response
+bodies.
+
+Clients SHOULD support both HTTP 1.0 and HTTP 1.1.
+Clients SHOULD support chunked encoding for both request and response
+bodies.
+
+Servers MAY return ETag and/or Last-Modified headers.
+
+Clients MAY revalidate cached entities by including If-Modified-Since
+and/or If-None-Match request headers.
+
+Servers MAY return '304 Not Modified' if the relevant headers appear
+in the request and the entity has not changed.  Clients MUST treat
+'304 Not Modified' identical to '200 OK' by reusing the cached entity.
+
+Clients MAY reuse a cached entity without revalidation if the
+Cache-Control and/or Expires header permits caching.  Clients and
+servers MUST follow RFC 2616 for cache controls.
+
+
+Discovering References
+----------------------
+
+All HTTP clients MUST begin either a fetch or a push exchange by
+discovering the references available on the remote repository.
+
+Dumb Clients
+~~~~~~~~~~~~
+
+HTTP clients that only support the "dumb" protocol MUST discover
+references by making a request for the special info/refs file of
+the repository.
+
+Dumb HTTP clients MUST make a GET request to $GIT_URL/info/refs,
+without any search/query parameters.
+
+   C: GET $GIT_URL/info/refs HTTP/1.0
+
+   S: 200 OK
+   S:
+   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
+   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
+   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
+   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+
+The Content-Type of the returned info/refs entity SHOULD be
+"text/plain; charset=3Dutf-8", but MAY be any content type.
+Clients MUST NOT attempt to validate the returned Content-Type.
+Dumb servers MUST NOT return a return type starting with
+"application/x-git-".
+
+Cache-Control headers MAY be returned to disable caching of the
+returned entity.
+
+When examining the response clients SHOULD only examine the HTTP
+status code.  Valid responses are '200 OK', or '304 Not Modified'.
+
+The returned content is a UNIX formatted text file describing
+each ref and its known value.  The file SHOULD be sorted by name
+according to the C locale ordering.  The file SHOULD NOT include
+the default ref named 'HEAD'.
+
+  info_refs   =3D  *( ref_record )
+  ref_record  =3D  any_ref / peeled_ref
+
+  any_ref     =3D  obj-id HTAB refname LF
+  peeled_ref  =3D  obj-id HTAB refname LF
+                 obj-id HTAB refname "^{}" LF
+
+Smart Clients
+~~~~~~~~~~~~~
+
+HTTP clients that support the "smart" protocol (or both the
+"smart" and "dumb" protocols) MUST discover references by making
+a parameterized request for the info/refs file of the repository.
+
+The request MUST contain exactly one query parameter,
+'service=3D$servicename', where $servicename MUST be the service
+name the client wishes to contact to complete the operation.
+The request MUST NOT contain additional query parameters.
+
+   C: GET $GIT_URL/info/refs?service=3Dgit-upload-pack HTTP/1.0
+
+   dumb server reply:
+   S: 200 OK
+   S:
+   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
+   S: d049f6c27a2244e12041955e262a404c7faba355	refs/heads/master
+   S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
+   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
+
+   smart server reply:
+   S: 200 OK
+   S: Content-Type: application/x-git-upload-pack-advertisement
+   S: Cache-Control: no-cache
+   S:
+   S: 001e# service=3Dgit-upload-pack\n
+   S: 004895dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint\0m=
ulti_ack\n
+   S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
+   S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
+   S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
+
+Dumb Server Response
+^^^^^^^^^^^^^^^^^^^^
+Dumb servers MUST respond with the dumb server reply format.
+
+See the prior section under dumb clients for a more detailed
+description of the dumb server response.
+
+Smart Server Response
+^^^^^^^^^^^^^^^^^^^^^
+If the server does not recognize the requested service name, or the
+requested service name has been disabled by the server administrator,
+the server MUST respond with the '403 Forbidden' HTTP status code.
+
+Otherwise, smart servers MUST respond with the smart server reply
+format for the requested service name.
+
+Cache-Control headers SHOULD be used to disable caching of the
+returned entity.
+
+The Content-Type MUST be 'application/x-$servicename-advertisement'.
+Clients SHOULD fall back to the dumb protocol if another content
+type is returned.  When falling back to the dumb protocol clients
+SHOULD NOT make an additional request to $GIT_URL/info/refs, but
+instead SHOULD use the response already in hand.  Clients MUST NOT
+continue if they do not support the dumb protocol.
+
+Clients MUST validate the status code is either '200 OK' or
+'304 Not Modified'.
+
+Clients MUST validate the first five bytes of the response entity
+matches the regex "^[0-9a-f]{4}#".  If this test fails, clients
+MUST NOT continue.
+
+Clients MUST parse the entire response as a sequence of pkt-line
+records.
+
+Clients MUST verify the first pkt-line is "# service=3D$servicename".
+Servers MUST set $servicename to be the request parameter value.
+Servers SHOULD include an LF at the end of this line.
+Clients MUST ignore an LF at the end of the line.
+
+Servers MUST terminate the response with the magic "0000" end
+pkt-line marker.
+
+The returned response is a pkt-line stream describing each ref and
+its known value.  The stream SHOULD be sorted by name according to
+the C locale ordering.  The stream SHOULD include the default ref
+named 'HEAD' as the first ref.  The stream MUST include capability
+declarations behind a NUL on the first ref.
+
+  smart_reply     =3D  PKT-LINE("# service=3D$servicename" LF)
+                     ref_list
+                     "0000"
+  ref_list        =3D  empty_list / non_empty_list
+
+  empty_list      =3D  PKT-LINE(zero-id SP "capabilities^{}" NUL cap-l=
ist LF)
+
+  non_empty_list  =3D  PKT-LINE(obj-id SP name NUL cap_list LF)
+                     *ref_record
+
+  cap-list        =3D  capability *(SP capability)
+  capability      =3D  1*(LC_ALPHA / DIGIT / "-" / "_")
+  LC_ALPHA        =3D  %x61-7A
+
+  ref_record      =3D  any_ref / peeled_ref
+  any_ref         =3D  PKT-LINE(obj-id SP name LF)
+  peeled_ref      =3D  PKT-LINE(obj-id SP name LF)
+                     PKT-LINE(obj-id SP name "^{}" LF
+
+Smart Service git-upload-pack
+------------------------------
+This service reads from the repository pointed to by $GIT_URL.
+
+Clients MUST first perform ref discovery with
+'$GIT_URL/info/refs?service=3Dgit-upload-pack'.
+
+   C: POST $GIT_URL/git-upload-pack HTTP/1.0
+   C: Content-Type: application/x-git-upload-pack-request
+   C:
+   C: 0032want 0a53e9ddeaddad63ad106860237bbf53411d11a7\n
+   C: 0032have 441b40d833fdfa93eb2908e52742248faf0ee993\n
+   C: 0000
+
+   S: 200 OK
+   S: Content-Type: application/x-git-upload-pack-result
+   S: Cache-Control: no-cache
+   S:
+   S: ....ACK %s, continue
+   S: ....NAK
+
+Clients MUST NOT reuse or revalidate a cached reponse.
+Servers MUST include sufficient Cache-Control headers
+to prevent caching of the response.
+
+Servers SHOULD support all capabilities defined here.
+
+Clients MUST send at least one 'want' command in the request body.
+Clients MUST NOT reference an id in a 'want' command which did not
+appear in the response obtained through ref discovery unless the
+server advertises capability "allow-tip-sha1-in-want".
+
+  compute_request   =3D  want_list
+                       have_list
+                       request_end
+  request_end       =3D  "0000" / "done"
+
+  want_list         =3D  PKT-LINE(want NUL cap_list LF)
+                       *(want_pkt)
+  want_pkt          =3D  PKT-LINE(want LF)
+  want              =3D  "want" SP id
+  cap_list          =3D  *(SP capability) SP
+
+  have_list         =3D  *PKT-LINE("have" SP id LF)
+
+TODO: Document this further.
+TODO: Don't use uppercase for variable names below.
+
+The Negotiation Algorithm
+~~~~~~~~~~~~~~~~~~~~~~~~~
+The computation to select the minimal pack proceeds as follows
+(c =3D client, s =3D server):
+
+ init step:
+ (c) Use ref discovery to obtain the advertised refs.
+ (c) Place any object seen into set ADVERTISED.
+
+ (c) Build an empty set, COMMON, to hold the objects that are later
+     determined to be on both ends.
+ (c) Build a set, WANT, of the objects from ADVERTISED the client
+     wants to fetch, based on what it saw during ref discovery.
+
+ (c) Start a queue, C_PENDING, ordered by commit time (popping newest
+     first).  Add all client refs.  When a commit is popped from
+     the queue its parents SHOULD be automatically inserted back.
+     Commits MUST only enter the queue once.
+
+ one compute step:
+ (c) Send one $GIT_URL/git-upload-pack request:
+
+   C: 0032want <WANT #1>...............................
+   C: 0032want <WANT #2>...............................
+   ....
+   C: 0032have <COMMON #1>.............................
+   C: 0032have <COMMON #2>.............................
+   ....
+   C: 0032have <HAVE #1>...............................
+   C: 0032have <HAVE #2>...............................
+   ....
+   C: 0000
+
+     The stream is organized into "commands", with each command
+     appearing by itself in a pkt-line.  Within a command line
+     the text leading up to the first space is the command name,
+     and the remainder of the line to the first LF is the value.
+     Command lines are terminated with an LF as the last byte of
+     the pkt-line value.
+
+     Commands MUST appear in the following order, if they appear
+     at all in the request stream:
+
+       * want
+       * have
+
+     The stream is terminated by a pkt-line flush ("0000").
+
+     A single "want" or "have" command MUST have one hex formatted
+     SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
+     multiple commands.
+
+     The HAVE list is created by popping the first 32 commits
+     from C_PENDING.  Less can be supplied if C_PENDING empties.
+
+     If the client has sent 256 HAVE commits and has not yet
+     received one of those back from S_COMMON, or the client has
+     emptied C_PENDING it SHOULD include a "done" command to let
+     the server know it won't proceed:
+
+   C: 0009done
+
+  (s) Parse the git-upload-pack request:
+
+      Verify all objects in WANT are directly reachable from refs.
+
+      The server MAY walk backwards through history or through
+      the reflog to permit slightly stale requests.
+
+      If no WANT objects are received, send an error:
+
+TODO: Define error if no want lines are requested.
+
+      If any WANT object is not reachable, send an error:
+
+TODO: Define error if an invalid want is requested.
+
+     Create an empty list, S_COMMON.
+
+     If 'have' was sent:
+
+     Loop through the objects in the order supplied by the client.
+     For each object, if the server has the object reachable from
+     a ref, add it to S_COMMON.  If a commit is added to S_COMMON,
+     do not add any ancestors, even if they also appear in HAVE.
+
+  (s) Send the git-upload-pack response:
+
+     If the server has found a closed set of objects to pack or the
+     request ends with "done", it replies with the pack.
+
+TODO: Document the pack based response
+   S: PACK...
+
+     The returned stream is the side-band-64k protocol supported
+     by the git-upload-pack service, and the pack is embedded into
+     stream 1.  Progress messages from the server side MAY appear
+     in stream 2.
+
+     Here a "closed set of objects" is defined to have at least
+     one path from every WANT to at least one COMMON object.
+
+     If the server needs more information, it replies with a
+     status continue response:
+
+TODO: Document the non-pack response
+
+  (c) Parse the upload-pack response:
+
+TODO: Document parsing response
+
+      Do another compute step.
+
+
+Smart Service git-receive-pack
+------------------------------
+This service reads from the repository pointed to by $GIT_URL.
+
+Clients MUST first perform ref discovery with
+'$GIT_URL/info/refs?service=3Dgit-receive-pack'.
+
+   C: POST $GIT_URL/git-receive-pack HTTP/1.0
+   C: Content-Type: application/x-git-receive-pack-request
+   C:
+   C: ....0a53e9ddeaddad63ad106860237bbf53411d11a7 441b40d833fdfa93eb2=
908e52742248faf0ee993 refs/heads/maint\0 report-status
+   C: 0000
+   C: PACK....
+
+   S: 200 OK
+   S: Content-Type: application/x-git-receive-pack-result
+   S: Cache-Control: no-cache
+   S:
+   S: ....
+
+Clients MUST NOT reuse or revalidate a cached reponse.
+Servers MUST include sufficient Cache-Control headers
+to prevent caching of the response.
+
+Servers SHOULD support all capabilities defined here.
+
+Clients MUST send at least one command in the request body.
+Within the command portion of the request body clients SHOULD send
+the id obtained through ref discovery as old_id.
+
+  update_request  =3D  command_list
+                     "PACK" <binary data>
+
+  command_list    =3D  PKT-LINE(command NUL cap_list LF)
+                     *(command_pkt)
+  command_pkt     =3D  PKT-LINE(command LF)
+  cap_list        =3D  *(SP capability) SP
+
+  command         =3D  create / delete / update
+  create          =3D  zero-id SP new_id SP name
+  delete          =3D  old_id SP zero-id SP name
+  update          =3D  old_id SP new_id SP name
+
+TODO: Document this further.
+
+
+References
+----------
+
+link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Lo=
cators (URL)]
+link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer =
Protocol -- HTTP/1.1]
+link:technical/pack-protocol.txt
+link:technical/protocol-capabilities.txt
--=20
1.8.2.83.gc99314b
