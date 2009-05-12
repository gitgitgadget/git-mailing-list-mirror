From: Andrew Schein <andrew@andrewschein.com>
Subject: Re: git default behavior seems odd from a Unix command line point of 
	view
Date: Tue, 12 May 2009 12:24:56 -0400
Message-ID: <4e963a650905120924j52d38c0dg577d93e913013e38@mail.gmail.com>
References: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>
	 <7vd4ae8fls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3unB-0002Yt-FW
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbZELQY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZELQY4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:24:56 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61756 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZELQY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:24:56 -0400
Received: by fxm2 with SMTP id 2so76489fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:24:56 -0700 (PDT)
Received: by 10.103.176.20 with SMTP id d20mr5422376mup.27.1242145496224; Tue, 
	12 May 2009 09:24:56 -0700 (PDT)
In-Reply-To: <7vd4ae8fls.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118919>

Hi Junio -

Thanks for your reply giving historical context.  The command line
examples I gave were intended to give examples of the output rather
than my own usage pattern.

Here is my actual usage pattern... from a file called "sync.sh"
(would love feedback on whether this is the gitly? way to solve my use
case):

# environment set up occurs before loop, I pull before "pushing" in an
attempt to prevent
# conflicts from being left on the shared repository.
for dir in ./* ; do
    if [ ! -d $dir ]      ; then continue ; fi #not a directory
    if [ ! -e $dir/.git ] ; then continue ; fi #not a git repo
    dir=`basename $dir`
    echo "syncing: $dir"
    set +e # commit returns an error if there is nothing to commit.
    (cd ./$dir ; git commit -a)
    set -e
    (cd ./$dir ; git pull $UP "$REPO/$dir" master)        #pull
    ssh $HOST "mkdir -p $DEST_CACHE/$LOC/$dir"  # these three lines
handle "push"
    rsync -rl --delete ./$dir/.git -e ssh "$DEST:$DEST_CACHE/$LOC/$dir/.git"
    ssh $DEST "(cd $LOC/$dir ; /tools/bin/git pull
$DEST_CACHE/$LOC/$dir/.git master)"

done
