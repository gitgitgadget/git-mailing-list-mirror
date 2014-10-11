From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Sat, 11 Oct 2014 23:37:32 +0000
Message-ID: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 01:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd6Ea-0004Lp-3B
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 01:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbaJKXhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Oct 2014 19:37:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49218 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751758AbaJKXhq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 19:37:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0A00E2808F
	for <git@vger.kernel.org>; Sat, 11 Oct 2014 23:37:42 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is designed to implement the changes necessary to build Git
using Asciidoctor instead of AsciiDoc.

The first two patches are bug fixes.  Asciidoctor is stricter about
title underline lengths (=C2=B1 1 character instead of 2) and requires
matching delimiter lengths[0].  They're needed regardless of whether th=
e
other two patches are accepted because git-scm.com uses Asciidoctor to
render the documentation, so we might as well render it correctly.

Even with these patches, Asciidoctor warns about everyday.txt and
user-manual.txt.  I'm not sending patches for these right now because
I've seen recent series including those and don't want to cause a
merge conflict.

The second two patches implement some basic support for building with
Asciidoctor.  The first of these moves some items into variables due to
some differences between the AsciiDoc and Asciidoctor command lines.
The user can then override these values when invoking make.

The final patch adds support for the linkgit macro.  Asciidoctor uses
Ruby extensions to implement macro support, unlike AsciiDoc, which uses
a configuration file.

In order to build the documentation successfully, the patches from [1]
are required.  The current version of Asciidoctor uses the wrong
elements in some cases and is lacking elements in others when generatin=
g
manpage (refentry) output in DocBook format.  The need for these patche=
s
is also the reason I didn't implement a configuration macro for
Asciidoctor, as almost nobody will be able to use it at the moment.

With these patches and the ones for Asciidoctor, it's possible to build
the documentation with the following command line:

  make doc ASCIIDOC=3Dasciidoctor ASCIIDOC_DOCBOOK=3Ddocbook45 ASCIIDOC=
_HTML=3Dhtml5 ASCIIDOC_CONF=3D'-I. -rasciidoctor/extensions -rextension=
s'

brian m. carlson (4):
  Documentation: adjust document title underlining
  Documentation: fix mismatched delimiters in git-imap-send
  Documentation: move some AsciiDoc parameters into variables
  Documentation: implement linkgit macro for Asciidoctor

 Documentation/Makefile             | 18 +++++++++++-------
 Documentation/extensions.rb        | 39 ++++++++++++++++++++++++++++++=
++++++++
 Documentation/git-imap-send.txt    |  4 ++--
 Documentation/git-prune-packed.txt |  2 +-
 Documentation/git-quiltimport.txt  |  2 +-
 Documentation/git-stage.txt        |  2 +-
 6 files changed, 55 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/extensions.rb

[0] http://asciidoctor.org/docs/asciidoc-asciidoctor-diffs/
[1] https://github.com/asciidoctor/asciidoctor/pull/1142
--=20
2.1.1
