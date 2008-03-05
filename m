From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 03:15:23 -0500
Message-ID: <20080305081523.GK8410@spearce.org>
References: <20080304051149.GS8410@spearce.org> <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com> <20080305053612.GA8410@spearce.org> <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWonI-00041m-W8
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbYCEIPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756400AbYCEIPa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:15:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50175 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988AbYCEIP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:15:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWomZ-0007aY-I2; Wed, 05 Mar 2008 03:15:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D982D20FBAE; Wed,  5 Mar 2008 03:15:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76189>

Imran M Yousuf <imyousuf@gmail.com> wrote:
> 1. GIT SCM Plugin for NetBeans (GPLv2 with CPE, same as NetBeans)
> The aim of the plugin is to integrate GIT with NetBeans using JNI so
> that any change in the implementation of GIT does not effect the SCM
> plugins way of work.
> Language: Java
> Goal: Make GIT available from IDE for NetBeans users and use GIT using
> Java Native Interfaces

Interesting, but libgit.a is *not* suitable for embedding inside of
a JVM.  Its no fun when a low level Git function suddenly calls die()
because it was fed invalid user input like a mistyped branch name.
Your whole IDE shutsdown without a chance to save files.

So that leaves you with three possible routes:

  * Use JNI and libgit.a

    Now you have three projects, not one.  You first need to make
    libgit.a embeddable.  *Then* you can work on a JNI wrapper,
    and finally you can build the UI.

  * Use jgit

    Its at least 100% pure Java and doesn't have the libgit.a issues
    I mentioned above.  Its also got some active developers and its
    userbase is growing.  We have been careful to keep jgit such
    that it runs on any J2SE system, and thus does not require an
    Eclipse environment.

  * Use java.lang.Process and pipes

    Ick.  Forking a running JVM, especially one the size of an IDE,
    is not pretty.  At least on Windows you have CreateProcess(),
    but on POSIX systems the JVM still does a fork/exec pair, and
    on Solaris that hurts hard when your address space is large.

Of these only the latter two are really viable for any time to come
(just my opinion, but that's that).  jgit is coming along and may
actually be able to do most of the critical features that an IDE
demands, especially if more people work on it.  The latter option
is obviously available today, but doesn't offer anything near the
performance or integration that jgit does.
 
> 2. distributed versioned web system backup and restoration framework
> (GPLv2 with CPE, same as NetBeans)
> [I am not sure whether this one is even qualifies or not as a GIT
> Community Project]
> Language: Java, NetBeans RCP
> Goal: Develop a framework which can backup and restore data from
> different components of web application. For example, database, ldap,
> log, images, files (PHP, JSP, PY, HTML, JS, CSS etc.). Additionally
> allow edit and propagation of configuration in distributed nature,
> system restart, data restore. Also integrate backup and repo maintain
> to Amazon S3.

Yea, I'm not sure this falls too well under the Git community either.
I don't doubt that we would have sufficient mentor experience here
to support such a project, but the outcome in terms of both code and
a student who is familiar with it would not benefit Git very well,
if at all.
 
-- 
Shawn.
