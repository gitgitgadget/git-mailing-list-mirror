From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 9
Date: Thu, 1 Jul 2010 15:13:10 +0200
Message-ID: <20100701131310.GA28607@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 15:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUJxj-0000Z0-On
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 15:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab0GANhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 09:37:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62607 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0GANhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 09:37:48 -0400
Received: by fxm14 with SMTP id 14so1286668fxm.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=5QLcg46HnWGQ+ub4LmXnrYtHpkLgTmrweeE9PU6HTEw=;
        b=BANq6CBX5wDqo6Z9jLrdByyCpSl3Lrqlr7D8AuZumLzX4aAWphy0edmPJp/LDH5JuG
         OQ6K5+bcZUmmAUHoad9DGsbDF8IlNCQOqKDiuVyvP+g+puSFXC8HPu7glGD6UswzS9Ep
         g0Z7EpmLy7FF2/XN8ExjVOoj8UbWmZN/NsG5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=SFyj+xk5ETPchTTaPDiWP5B91CChI+Ts2H1yQF3zoewmfkf2gl7TyHnyXLB7P4+j4S
         jIGAyeh6PrdH8XG/UBEOT38zQ1ulQ+SEKwgFdO1CbfZILlEOzl6/GXciAKKHw3qtEOuU
         uZVUYaIIDB6VDSsVy6uMQ0rORJBu77b1ZNSiQ=
Received: by 10.223.99.212 with SMTP id v20mr9471839fan.44.1277989890049;
        Thu, 01 Jul 2010 06:11:30 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id p21sm53087746fak.45.2010.07.01.06.11.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 06:11:28 -0700 (PDT)
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>, Sam Vilain <sam@vilain.net>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150035>

Hi,

In terms of code, this week was unproductive. However, there was one
very long and productive discussion about the design of svn-fe. We can
now prove that the design of svn-fe is most efficient, and that any
other dumpfile importer will do worse than svn-fe. I'll put this proof
down in another email, and use this one for just a status update. We
have also determined that some some extensions to git-fast-import will
significantly reduce the complexity of svn-fe. Here are the current
list of tasks along with their status:

1. The svnclient_ra. I have stopped working on a stopgap
   implementation of svnclient_ra that dumps full text/ props; to do
   this, it needs to interrupt a replay and open a new connection- it
   seems that this is quite non-trivial to get right. I've decided to
   complete the delta dump generator instead. Unfortunately, this
   means that I won't have a complete chain to show a remote helper by
   mid-term evaluations: just individual components.
2. Ternary treap fork. This only changes the underlying data
   structure- nothing else should change. David is close to completing
   this.
3. Make svn-fe support deltified dumps. This can only be done after we
   have a Git object store backing. Deferred for the moment.
4. git-fast-import only supports filecopy for trees from the parent
   commit; make it support copies from all commits. Jonathan has
   already sent an RFC patch on the list for this.
5. Zero-tree fork. svn-fe currently maintains trees for all revisions;
   Jonathan suggested that it can lazily fetch tree objects from the
   Git store backing. This change will significantly reduce the
   complexity of svn-fe.
6. git-fast-import needs to be extended to print-marks. Sverre
   suggested this, and Jonathan has sent an RFC patch on the
   list. This is required for the Git object store to communicate back
   commit hashes to the caller (svn-fe in this case).

In other news, we managed to get colabti.org to log the channel where
we have most of our discussions: #git-devel on Freenode IRC. This
information is probably helpful for other GSoC students and developers
who are looking to collaborate on projects.

-- Ram
