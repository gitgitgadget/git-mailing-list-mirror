From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Thu, 03 Jul 2008 06:10:12 -0700 (PDT)
Message-ID: <m3d4lvf70w.fsf@localhost.localdomain>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
	<1214879914-17866-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:17:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOgx-000707-PZ
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 15:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754AbYGCNKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 09:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757371AbYGCNKq
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 09:10:46 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:2352 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYGCNKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 09:10:45 -0400
Received: by py-out-1112.google.com with SMTP id p76so419890pyb.10
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=RmtK3g5XT/vjaJiGvn3ZJTYtcMTntepIM8iKQdl1tuw=;
        b=HuG0FsQLXOraaicKxZUF2Bvwn9RA7WScT/+v0xEE1d3jT+/XuCkJ+LhTfRZOUtz2J+
         uIqa2w37u7a9H0ltCjJAsYot+xyOjmDLNg5RGUVB/npBGzUgxzsrTCFuTxbfj79vkqfU
         5GiwAASyQhuUaOmQdJcuCyyTl0eNatTpnWb5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=rmqOICvSYX93vuy8KQBq6yLMwep0DKI+0YYsgQUG5X16SnryZS1KTOfm75StEszsY4
         CSGAQo/2+wUhfGcHL51NoNZbSkCnxwXv8OCuUXfwDGahBcx6lZutZAAWih/7N0qezjKc
         vhQ9nc6wzMXspx5vJzM8ueGL4ViJBJ5+JQGkE=
Received: by 10.115.18.2 with SMTP id v2mr263535wai.1.1215090644235;
        Thu, 03 Jul 2008 06:10:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.253.104])
        by mx.google.com with ESMTPS id 12sm250520fks.9.2008.07.03.06.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 06:10:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m63DA9kY007081;
	Thu, 3 Jul 2008 15:10:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m63DA8cP007078;
	Thu, 3 Jul 2008 15:10:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87288>

Stephan Beyer <s-beyer@gmx.net> writes:

> +# Generate message, patch and author script files
> +make_patch () {
> +	parent_sha1=$(git rev-parse --verify "$1"^) ||
> +		die "Cannot get patch for $1^"
> +	git diff-tree -p "$parent_sha1..$1" >"$PATCH"

First, let's not perpetuate _convenience_ calling convention of "A..B"
of git-diff* family, but use "A B" to set _endpoints_.

Second, with "A B" convention you can fairly easy deal with root
commit, changing the code to the fragment below:

+# Generate message, patch and author script files
+make_patch () {
+	parent_sha1=$(git rev-parse --verify "$1"^) ||
+		echo '--root'
+	git diff-tree -p "$parent_sha1" "$1" >"$PATCH"


BTW. what is best way of checking if given revision is parent-less?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
