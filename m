From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 02:13:56 +1000
Message-ID: <BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:14:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF7NN-0003cl-Sg
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 18:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152Ab1D0QN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 12:13:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33640 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab1D0QN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 12:13:58 -0400
Received: by eyx24 with SMTP id 24so561973eyx.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=BR6KQ7LR6H3nVMVHqdXS6pw7Oi5eRTRmKmtrmDKpvIg=;
        b=HQp7aHv6zKTz+uv4ylKnlNp2uNwvtxfEoPGwWMu2GyJ6BGkCDNliDaCgVCBWt7/rRK
         qJ01WSrwyyfMxgHgAAdDsuwYrSGZlXIQ6+Yg8xFQBTh/VKwSn74US8M4BZct6H9qqoR8
         pLcp5W3BVSoxp0oBFP8szqW3f4rBTj9dUyl+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=ew2pWYm2RX1hAinh97e7+Ugkt7kV8GeHsS78fZ+Lon3x1sOGQw6lsZ6yNRmSN9WIaO
         RTvh4jFuSAJc4oKZv7tW/+59VZY3xUEC5TVS4X0AGSda6OyaGKMzcBfa3+Le59YOdNZC
         WkAaP5VvJdm05dV1TtLLC3YJQ0WrPRIY4hBMM=
Received: by 10.14.10.130 with SMTP id 2mr1032446eev.181.1303920836379; Wed,
 27 Apr 2011 09:13:56 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 09:13:56 -0700 (PDT)
In-Reply-To: <BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172241>

I think my use of the word package was unfortunate, since it suggests
I am proposing an alternative to tools such as apt-get, brew, rpm etc.

This is not the intention. The intention is to manage _plugins_ to
git, treating git itself as a platform.

Plugins will be delivered via platform-specific package managers
(perhaps sequenced by git-pm), but once they arrive on the OS platform
they will be _activated_ by the plugin manager and this made available
to the git command line.

Platform specific concerns such as building and (most) dependency
management will be delegated to platform specific package managers.

The overriding objective is to allow a git user to install a git
plugin called foobar with 4 words:

     git pm install foobar

given that someone, somwhere, has done the work to create a plugin
descriptor and create an installable package of some kind for whatever
package managers are required in order to successfully install the
plugin on the target platform.

The same command should work whether your git platform is hosted on
MAC OSX, cygwin, Debian, Fedora, AIX or Windows.

Where git can be used as the underlying package manager, it will be
(for extensions which really are just source repos). If more
sophisticated build support is required, then that will be delegated
to a platform specific package manager via one of a small number of
package manager adapters.

Here is an updated README that hopefully makes this clear.

[ An easier to read version is here - https://github.com/jonseymour/gpm ]

--------------------

NAME
====
git-pm - a plugin manager for git extensions

DESCRIPTION
===========
The initial deliverable of the project will be a plugin architecture
proposal. The intent of this deliverable is to create specifications
that will allow plugin authors to create descriptors for their plugins
that will be sufficient to enable git-pm to locate an appropriate
package manager and delegate installation of the plugin to that package manager.

In parallel to this deliverable, a plugin manager interface (git-pm)
will be developed. Such an interface will manage git plugins on
behalf of git by delegating to whatever package-managers are available
and installed on the platform.

PRINCIPLES
==========
* define a repository layout specification
* define a plugin descriptor (using the git config syntax)
* package manager agnostic repo and plugin specifications
 * perhaps define a pluggable plugin manager interface
* support for:
 * existing contrib/ directory
 * existing git patterns for finding and using extensions
 * man pages
 * plugin specific configuration help
 * bash completions
 * scripts
* build support:
 * for documentation, archives
* layers
 * repo, plugin descriptors
 * tool interface specifications
 * tool implementations
 * global plugin registry and repository

INTENDED SCENARIOS
==================

Installation and Removal
------------------------
There is completely understandable resistance to YAPM - yet another
package manager. This is not the goal of git-pm. In particular, git-pm
will delegate platform-specific build
and deployment concerns to platform-specific package managers such as
apt-get, rpm, brew and cygwin. That said, there is no good reason why
git-pm shouldn't know how to delegate such concerns to a
platform-specific package manager.

The basic intent is to allow plugin authors to provide simple
instructions to potential consumers of their plugin.

<hr/>
Installing a plugin should be as simple as:

	   git pm install foobar

Such a comamnd should work whether the platform is Linux, cygwin or
Mac OSX. In fact, the only
common denominator should be git itself, and its dependencies (POSIX
shell and perl).
<hr/>
Install a plugin, given a URL that can locate its descriptor:

	   git pm install [ plugin-url | plugin-archive | plugin-name ]

<hr/>
Remove a plugin, given a name that can identify it:

	   git pm remove plugin-name

<hr/>
Update an installed plugin:

	   git pm update plugin-name

<hr/>
Inspect a registry of available available, installed, active or
inactive plugins:

	   git pm list available|installed|active|inactive

<hr/>
Describe the current installation, availability or activation status
of a plugin:

	   git pm status plugin-name

<hr/>

Activation/De-activation
------------------------
Activation is the means by which a locally available plugin can be
made available to the git command line. The idea is to

	   git-pm activate plugin-name
	   git-pm deactivate plugin-name

WHAT GIT-PM IS:
===============
* a native extension manager for the git platform
* an _activator_ for git extensions
* distribution and platform package mamager friendly
* git-aware

WHAT GIT-PM IS NOT:
===================
* a build tool
* a replacement for a package manager
* useful for anything other than git extensions

CONCEPTS
========

plugin
------
An extension to git that exports 1 or more commands to the git command line

package
-------
A platform-specific archive that is installable by a platform-specific
package manager. Packages will _package_ plugins.

plugin-descriptor
-----------------
A package-manager agnostic descriptor that describes a plugin to the
git platform, in particular git-pm.

package-descriptor
------------------
A package-manager specific descriptor that describes a package to a
package manager.

plugin manager
--------------
A command, such as git-pm, that can install, remove, activate or
deactive plugins by delegating platform specific
concerns to a platform-specific package manager.

package-manager
---------------
A platform-specific manager of packages.

plugin author
-------------
An author of git plugins.

package author
--------------
An author of package specifications for a package manager. In
particular, the author of a package specification that allows
a git plugin to be bundled into a package for the purposes of
distribution and management.

package-manager-adapter
-----------------------
A pluggable component of git-pm that exposes a platform-specific
package manager via a uniform interface.

DEPENDENCY MANAGEMENT
=====================
It is unclear yet how important dependency management will be. Where
possible, such concerns will be delegated to
platform-specific package managers. That said, there may still be
value in managing dependencies between git-pm
packages at the git-pm level.

PACKAGE NAME
============
The package name is currently gpm. Howeve, the "General Purpose Mouse"
package has already claimed this name in the apt space, at least.

So, it might be better to use 'git-pm' as the package name, which
isn't so bad since idiomatic use of the package should be 'git pm
blah'.

SUPPORTED PACKAGE MANGERS
=========================
The intent of git-pm is not to duplicate the functionality of existing
package managers. The intent is to provide a package manager for git
as a platform itself. To the extent that a build process is required
to install a git extension, then such concerns will be delegated
to a real package manager that knows how to deal with such concerns.

The intent is that a minimal plugin that depends only on the
availability of a shell, should be installable with something as
simple as:

    git pm install foobar

This should work whether your git install is running on Linux, cywgin,
Windows (MSYSGIT), MAC, AIX or whatever.

If a compilation is required, then delegation to a platform package
manager will be requried.

Linux
-----
* git
* rpm
* apt

Mac
---
* git
* brew

cygwin
---
* git

CONTRACTS
=========
The following contracts will be required between:

<dl>
<dt>the git user and git-pm</dt>
<dd>
This contract will be specified in terms of the git-pm man page. It
will specify the plugin management commands offered by
the git-pm interface to the user.
</dd>
<dt>the git runtime and git-pm</dt>
<dd>
This contract will specify the technique by which git-pm exposes git
extensions to the git command line. It will include
support for exposing:
<ul>
<li>sub-commands</li>
<li>man pages</li>
<li>shell completions</li>
</ul>
</dd>
<dt>git-pm and package-manager adapters</dt>
<dd>
This contract will specify how to add a new package-manager adapter.
The purpose will be to allow git-pm to delegate
its interface to backend package managers that know how to manage
platform specific concerns such as building,
dependency management, package distribution etc.
</dd>
</dd>
<dt>package-manager adapters and package managers</dt>
<dt>extension authors and the git-pm package manager</dt>
</dl>

INFLUENCES
==========
The following programs have influenced the design of git-pm.

npm
---
The node package manager.

Node is an interesting, V8-JavaScript based runtime for implementing
servers. Node comes with a tightly coupled package manager npm. If
node is your platform, npm
is the package manager for that platform. In particular, npm works the
same way irrespective of which platform you have node installed on.

brew
----
A Mac OSX specific package manager.

Brew is a relatively new package manager for the Mac OSX operating
system. It has several nice features, including its formula registry
that allows
authors to specify succinct package management formulae as short ruby
scripts. Brew also uses git as an integral part of its registry and
run-time.

SCEPTICS CHALLENGE
==================
Some people doubt there is value in a 'git plugin mamager'. In
response to this scepticism, I pose the following
challenge.

1. take an arbitrary git extension.
2. specify installation instructions for that extension in 4 words or less.
3. make sure those 4 words work on Linux, Cygwin, MAC OSX and AIX.
4. verify that following installation, the man pages work.

As an example, there is a package called gitwork. It is available
somewhere on the Internet. I think, as a tarball. Or perhaps a zip. I
don't think it has any dependencies, but I am really not sure. Why
don't you suck it and see?

MAILING LIST
============
Until noted otherwise, please use the
[http://dir.gmane.org/gmane.comp.version-control.git](git@vger.kernel.org)
mailing list for discussions about design decisions. gpm: is suggested
a good prefix for such discussions.

REVISIONS
=========
Ordered most recent, to less recent:

* changed 'gpm' to 'git pm' on the assumption that 'git-pm' will be in
the path and that 'General Purpose Mouse' has already nabbed 'gpm'
* changed terminology from 'package' to 'plugin' to help reduce
consfusion about the objectives of the project

AUTHOR
======
Jon Seymour
