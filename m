From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Add git-archive [take #2]
Date: Thu, 07 Sep 2006 15:08:19 +0200
Message-ID: <450019C3.4030001@innova-card.com>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>	<44FED12E.7010409@innova-card.com>	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>	<44FFD00E.5040305@innova-card.com> <7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 07 15:08:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLJc6-0006Sj-5q
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 15:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWIGNIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWIGNIK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 09:08:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12841 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751792AbWIGNII (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 09:08:08 -0400
Received: by nf-out-0910.google.com with SMTP id o25so434012nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 06:08:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=MSXAaJ3JArqzn/Nf9e7cqFUcedydXQO/pEcCIH04Qjn48MuGANqS6lV3FOpWLVdtS7LwUepN4N29T+lXIsIyqpcLWropgb0UOLwJSUGhV3S5RtdtQsVNHJRSOcs4VumHAStkpHupi0mf93NEGYMt2WyYGlOefAna4IY1E38XuAM=
Received: by 10.49.8.10 with SMTP id l10mr2476416nfi;
        Thu, 07 Sep 2006 06:08:06 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id l38sm3377840nfc.2006.09.07.06.08.05;
        Thu, 07 Sep 2006 06:08:06 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26633>

I'm sending a new version of the patchset which allows 'git-archive'
and 'git-upload-archive' command. I tried to take into account all
feedbacks made by Junio and Rene, but there are still some open points.

  1/ Allow 'git-upload-archive' command to enable/disable some
     formats. This should be done by 'git-upload-archive'.

  2/ Can I remove 'git-upload-tar' command ? If so, the current
     implementation of 'git-upload-archive' won't work with the old
     'git-tar-tree --remote' command because the protocol needs a
     "argument --format" to be passed to the server. Therefore we can
     either modify 'git-tar-tree' or simply remove it.

  3/ Should I kill 'git-zip-tree' command ? If so should I rename
     builtin-zip-tree.c file into zip-tree.c or something else ?

  4/ Progress indicator support. Junio wants to mimic upload-pack for
     that. But it will lead in a lot of duplicated code if we don't
     try to share code. Can we copy that code anyways and clean up
     later ?

  5/ Should we use "struct tree_desc" based interface for tree parsing
     ? According to Rene it doesn't worth it as soon as you actually
     start to do something to the trees

  6/ Simple subtree matching would be enough, at least for now.

Did I forgot something else ?

Point 1 seems to be important. As soons as we plug git-upload-archive,
we need to control what kind of formats the server deal with.

Point 2 and 3 are easy to achieve, just need a "go wild" authorization.

Point 4, seems to be high in priority since we don't want to deal with
clients and servers interoperate issues.

Points 5 and 6 can be done later. These improvements won't break if
done after releasing.

		Franck
