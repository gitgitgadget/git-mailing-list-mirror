From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 00/11] Support customizable label decorations
Date: Thu,  5 Feb 2009 02:00:07 +0100
Message-ID: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUsdI-0000xt-VC
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbZBEBAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 20:00:08 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756331AbZBEBAF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 20:00:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:5806 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbZBEA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:59:52 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1582fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=YUC8r2MXHPVEb5X4+5QPspik1x1Ycotzv73bzDoTtFI=;
        b=l45+/lLhcB3CtR/tedNBL038v27oSyef6QXRMS0ogTZ1r32UIMVZfphd9oXTFew00C
         wLIPMVYKbrxoO+rGNeaWRonNSGjRjsLYMnA1/g2ZsUhG9I2+B+myC6IQ6mY0w54c3o4K
         BeGC3Wdd7nKp5JsPVz79B658Qgae1VUIZCRSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Bc9ETYg6S9QvXspzaxXx+rLcd134afK/tawEMyDOq5wqORg4yVycTn3t/2PIofN/j1
         PEppCLXLlwD2dc3DPNDPu6o3r5n3PHr3PkkKHnTtLa7oUuu/tS09p+mHxUM/UmkjbmTq
         61yP1Y82e0Cm8edCwAbNAbZfB9dxfeu0/tnAw=
Received: by 10.86.100.19 with SMTP id x19mr1512199fgb.29.1233795590679;
        Wed, 04 Feb 2009 16:59:50 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l12sm19744fgb.41.2009.02.04.16.59.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:49 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 3EDC5468001; Thu,  5 Feb 2009 02:00:18 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108480>

This series adds support for customizable label decorations, which
is usefull for hiding selected decorations, or tweaking the format
of the decoration text.

Decorations are edited using the new Team->Git->Label Decorations
preference page, which is based off similar functionality from the
existing CVS and SVN team providers.

Icons can be enabled and disabled individually, and text can be
customized by reordering and editing the set of mapped variables.
Boolean variables like 'dirty' and 'staged' can be customized by
postfixing the variable name with a colon and a selected string
that should be insert if the variable evaluates to true.

The two general options control traversal of child and parent
elements during decoration. The first, 'Also re-decorate...',
controls whether or not ancestor elements of the current decorated
elment will also be scheduled for re-recoration. The second,=20
'Inspect dirty state...', controls whether decoration of container
elements such as projects and folders should traverse child elements
to decide if the container is dirty.

Disabling these options will improve performance for large trees.

The code should be solid enough for normal use, but I may have
missed situations that the code does not handle -- resuling in
crash and burn. If so, please let me know.

Known issues are:

  - If a project has a repository more than one level above the
    project directory decorations will fail.

  - When a Java resource is dirty, each parent package in the
    package hierarcy will appear dirty, even when the layout is
    set to 'flat'.

I've sprinkled the code with TODOs where I found possible future
improvments. One such improvment is performance, where for example
refactoring to use one shared status cache should help.

Tor Arne

PS: This is my first major patch to EGit, so apologies in advance
if I messed up the steps of the submit process in any way :)


Tor Arne Vestb=C3=B8 (11):
  Add support code to handle plugin property changes
  Use Set instead of array to keep track of change listeners
  Add a specialized team exception for Git
  Add new class ExceptionCollector for grouping exceptions
  Add new class SWTUtils with helper-methods for creating controls
  Implement basic customizable label decorations with preferences
  Add binding for name of the current branch
  Add icon decoration for tracked and untracked resources
  Implement decorations of dirty, staged, and conflicting resources
  Don't decorate every single resource on repository change
  Implement label decorations for folders and projects

 org.spearce.egit.core/META-INF/MANIFEST.MF         |    5 +-
 .../src/org/spearce/egit/core/GitException.java    |  168 +++
 .../core/internal/util/ExceptionCollector.java     |  128 +++
 .../spearce/egit/core/project/GitProjectData.java  |   33 +-
 org.spearce.egit.ui/.options                       |    8 +-
 org.spearce.egit.ui/icons/ovr/assumevalid.gif      |  Bin 64 -> 0 byte=
s
 org.spearce.egit.ui/icons/ovr/conflict.gif         |  Bin 64 -> 164 by=
tes
 org.spearce.egit.ui/icons/ovr/pending_add.gif      |  Bin 64 -> 0 byte=
s
 org.spearce.egit.ui/icons/ovr/pending_remove.gif   |  Bin 111 -> 0 byt=
es
 org.spearce.egit.ui/icons/ovr/shared.gif           |  Bin 106 -> 0 byt=
es
 org.spearce.egit.ui/icons/ovr/staged.gif           |  Bin 0 -> 114 byt=
es
 org.spearce.egit.ui/icons/ovr/staged_added.gif     |  Bin 0 -> 114 byt=
es
 org.spearce.egit.ui/icons/ovr/staged_removed.gif   |  Bin 0 -> 114 byt=
es
 org.spearce.egit.ui/icons/ovr/untracked.gif        |  Bin 0 -> 79 byte=
s
 org.spearce.egit.ui/plugin.properties              |    1 +
 org.spearce.egit.ui/plugin.xml                     |   12 +-
 .../src/org/spearce/egit/ui/Activator.java         |   70 ++-
 .../egit/ui/PluginPreferenceInitializer.java       |   13 +
 .../src/org/spearce/egit/ui/UIIcons.java           |   19 +-
 .../src/org/spearce/egit/ui/UIPreferences.java     |   19 +
 .../src/org/spearce/egit/ui/UIText.java            |   87 ++-
 .../src/org/spearce/egit/ui/internal/SWTUtils.java |  595 +++++++++++
 .../egit/ui/internal/actions/BranchAction.java     |    4 +-
 .../egit/ui/internal/actions/Disconnect.java       |    4 +-
 .../egit/ui/internal/actions/ResetAction.java      |    4 +-
 .../decorators/GitLightweightDecorator.java        | 1062 ++++++++++++=
++++++++
 .../internal/decorators/GitResourceDecorator.java  |  454 ---------
 .../internal/decorators/IDecoratableResource.java  |   93 ++
 .../preferences/GitDecoratorPreferencePage.java    |  911 ++++++++++++=
+++++
 .../src/org/spearce/egit/ui/uitext.properties      |   35 +-
 30 files changed, 3230 insertions(+), 495 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/Git=
Exception.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/int=
ernal/util/ExceptionCollector.java
 delete mode 100644 org.spearce.egit.ui/icons/ovr/assumevalid.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/pending_add.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/pending_remove.gif
 delete mode 100644 org.spearce.egit.ui/icons/ovr/shared.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged_added.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/staged_removed.gif
 create mode 100644 org.spearce.egit.ui/icons/ovr/untracked.gif
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/SWTUtils.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/GitLightweightDecorator.java
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/GitResourceDecorator.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/IDecoratableResource.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/preferences/GitDecoratorPreferencePage.java
