From: Pascal Obry <pascal@obry.net>
Subject: Re: send an email with logs after push
Date: Fri, 13 Nov 2009 09:55:38 +0100
Message-ID: <a2633edd0911130055y199955a2n93888b03c5f9b985@mail.gmail.com>
References: <1258101999.17624.1345023113@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: michele <michele@mailc.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 09:55:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8rwb-0007Gd-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 09:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbZKMIzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 03:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755358AbZKMIzh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 03:55:37 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:36280 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbZKMIzf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 03:55:35 -0500
Received: by fxm21 with SMTP id 21so190466fxm.21
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 00:55:38 -0800 (PST)
Received: by 10.204.155.80 with SMTP id r16mr801072bkw.133.1258102538639; Fri, 
	13 Nov 2009 00:55:38 -0800 (PST)
In-Reply-To: <1258101999.17624.1345023113@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132824>

Michele,

> Do you have any suggestion to implement this?

I'm doing that. In the post-receive hook I have:

<<
while read oldrev newrev ref; do
    trac_post_receive_record_log "$oldrev" "$newrev" "$ref" gtest

    send_mail_post_receive "$oldrev" "$newrev" "$ref" gtest \
	pascal@obry.net another@here.com
done
>>

the trac_post_receive_record_log is to add log into trac bug tracker.

the send_mail_post_receive is to send a message to the recipients
listed. The 4th parameter is the name of the project.

The send_mail_post_receive function is:

function send_mail_post_receive() {
    oldrev=$1
    newrev=$2
    ref=$3
    MODULE="$4"

    git log -p $oldrev..$newrev > $log
    cat $log | mail -s "[$MODULE] $ref $oldrev..$newrev" $5 $6 $7 $8 $9
    rm -fr $root
}

You'll find a set of hook helper routines there:

   git clone http://repo.or.cz/r/git-scripts.git

Hope this helps!

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
