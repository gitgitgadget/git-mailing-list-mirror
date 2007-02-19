From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Mon, 19 Feb 2007 02:47:00 +0100
Organization: At home
Message-ID: <eravet$noq$1@sea.gmane.org>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx> <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy98o78i.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702151126300.448@wbgn013.biozentrum.uni-wuerzburg.de> <7vvei3d5n5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 02:45:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIxar-000429-BH
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 02:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbXBSBp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 20:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbXBSBp0
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 20:45:26 -0500
Received: from main.gmane.org ([80.91.229.2]:51126 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbXBSBpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 20:45:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HIxad-0004d2-2c
	for git@vger.kernel.org; Mon, 19 Feb 2007 02:45:15 +0100
Received: from host-81-190-18-81.torun.mm.pl ([81.190.18.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 02:45:15 +0100
Received: from jnareb by host-81-190-18-81.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 02:45:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-81.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Okay for GIT_LOCAL_CONFIG. I do not remember off-hand who wanted it 
>> (Jakub? Pasky?), but it was in the context of gitweb.
>>
>> However, GIT_CONFIG is meant to parse arbitrary config files.
>> ...
>> But this "core.*" stuff is insane. Please no.
> 
> Ok, Eric's example and yours made it clear that GIT_CONFIG is an
> interface meant to reuse (or abuse) git-config to read some file
> that is not at all related to git, and should never be used by
> other plumbing.  As long as that is clear (could we have that in
> the documentation, by the way, please?), I have no problem with
> that.
> 
> In fact, I am very happy that we do not have to do that insane
> "core.*" stuff, which I thought was needed purely because
> somebody was trying to use GIT_CONFIG to prevent plumbing and
> porcelain from reading core configuration variables that are per
> repository in nature.
> 
> As I said in my other message, GIT_LOCAL_CONFIG is parallel to
> GIT_OBJECT_DIRECTORY and GIT_INDEX_FILE, and I am Ok with the
> way it is handled by the current code.
> 
> I mildly disagree with you on having an ability to disable
> /etc/gitconfig.  This is necessary in the real world (in the
> same sense as "adduser" can be told not to copy skeltons by
> creating an empty home directory beforehand), even if we do not
> consider the fact that it would help gaining repeatable results
> from our test scripts (remember, using GIT_CONFIG to make
> plumbing and porcelain read from there would set a bad example,
> even when it is pointing at .git/config).

Hmmm... documentation of GIT_CONFIG and GIT_LOCAL_CONFIG is a bit
behind, I guess:

git-repo-config(1):
ENVIRONMENT
       GIT_CONFIG
              Take  the  configuration from the given file instead of .git/config.
              Using the "--global" option forces this to ~/.gitconfig.

       GIT_CONFIG_LOCAL
              Currently the same as $GIT_CONFIG; when Git will support global con-
              figuration  files, this will cause it to take the configuration from
              the global configuration file in addition to the given file.

In my opionoin the logic should be: first read /etc/gitconfig, or
GIT_SYSTEM_CONFIG, if it exists, then ~/.gitconfig, if it exists, then
$GIT_DIR/config or GIT_LOCAL_CONFIG; if GIT_CONFIG is set, read only this.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
