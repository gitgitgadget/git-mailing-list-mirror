From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Incremental object transfer
Date: Sat, 13 Nov 2010 10:31:36 -0800 (PST)
Message-ID: <m31v6pf54h.fsf@localhost.localdomain>
References: <20101112103427.GA29057@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Sat Nov 13 19:31:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHKt6-0005Yb-IC
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 19:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab0KMSbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 13:31:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38977 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab0KMSbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 13:31:38 -0500
Received: by eye27 with SMTP id 27so2448888eye.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 10:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=cIovU5WjI/i8Mg86pbAY6UVfLjJZUMQiSC/ehgtRgQ8=;
        b=rP+/houZigmVxQQXDTHhDXjVpiQ6I7UW0JuZ/qdlPIOrYN9MLHqL/HZ1L0nitQDktL
         x7peAZJtMaLUQI8rcrqw/VRKoUHXcPdI0NOg9JGNwsJcKei2tkp2S1M/5KpVpw7Wb1Ci
         Qdp837K6qmw0Yuq8BVRjPFxjpnzjbJQKsRXCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Nhn6V78VQwRjTL020eAsdumUotYUSwNq8aTQiKx5ObB76UX4rTBwKOxvxk1SpgoJPl
         Zh0O3h4rXir2CAqIF3slQRAGw3kk59OWwNTI+hsRO6dsYsYwwnToVCId/Yu/yErzJfsu
         WFQv4iCnmaf8OnguLc0BJdIzjeH4mp/uTLdSg=
Received: by 10.213.98.69 with SMTP id p5mr4289778ebn.23.1289673097121;
        Sat, 13 Nov 2010 10:31:37 -0800 (PST)
Received: from localhost.localdomain (abwe118.neoplus.adsl.tpnet.pl [83.8.228.118])
        by mx.google.com with ESMTPS id v51sm4631351eeh.16.2010.11.13.10.31.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Nov 2010 10:31:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oADIV3B3024061;
	Sat, 13 Nov 2010 19:31:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oADIUdPk024051;
	Sat, 13 Nov 2010 19:30:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101112103427.GA29057@nibiru.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161394>

Enrico Weigelt <weigelt@metux.de> writes:

> As already said some time ago, I'm using git to back up maildirs
> on a machine w/ relatively low ram. The biggest problem for now
> is the initial push (maybe later larger subsequent pushes could
> be also affected too): it takes quite a long time to get everything
> packed, and if the connection breaks (the box is sitting behind
> a dynamic-IP DSL link), everything has to be restarted :(
> 
> So my idea is to incrementally transfer objects in smaller packs,
> disable gc on remote side and update refs when some commit is
> complete.
> 
> Is there any way to do this ?

This would work only for "dumb" transports: "dumb" HTTP transport and
deprecated rsync transport.

"Smart" transport (e.g. git://, SSH, new "smart" HTTP transport) all
create packs to send on the fly.  Those packs would rarely be
byte-for-byte the same, even if both server and client have the same
objects, unless perhaps on single code (unthreaded).

There were discussion about resumable download, by examining what got
downloaded in partial pack; but this is a hard problem.

So I would recommend either creating a bundle (see git-bundle
manpage), which can be resumably downloaded via HTTP, FTP, P2P - it is
an ordinary file.  Or you can try cloning via rsync (but the
repository should be quiescent).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
