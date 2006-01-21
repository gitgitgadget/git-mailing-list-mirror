From: dave morgan <morgad@eclipse.co.uk>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 20:08:52 +0000
Organization: the great unwashed
Message-ID: <ep45t15q8ojs215f39ir9sli98163m4b87@4ax.com>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com> <20060121194826.GK28365@pasky.or.cz>
Reply-To: david morgan <morgad@eclipse.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 21:08:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0P2g-0002Zy-Vp
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWAUUI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWAUUI4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:08:56 -0500
Received: from mra01.ch.as12513.net ([82.153.252.23]:46743 "EHLO
	mra01.ch.as12513.net") by vger.kernel.org with ESMTP
	id S932312AbWAUUI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 15:08:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by mra01.ch.as12513.net (Postfix) with ESMTP id 570E228C54D;
	Sat, 21 Jan 2006 20:08:55 +0000 (GMT)
Received: from mra01.ch.as12513.net ([127.0.0.1])
 by localhost (mra01.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 12136-01-59; Sat, 21 Jan 2006 20:08:54 +0000 (GMT)
Received: from unknown (unknown [82.152.150.47])
	by mra01.ch.as12513.net (Postfix) with SMTP id B888128C76B;
	Sat, 21 Jan 2006 20:08:52 +0000 (GMT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060121194826.GK28365@pasky.or.cz>
X-Mailer: Forte Agent 3.1/32.783
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15015>

On Sat, 21 Jan 2006 20:48:26 +0100, Petr Baudis <pasky@suse.cz> wrote:

>Dear diary, on Sat, Jan 21, 2006 at 03:08:27PM CET, I got a letter
>where dave morgan <morgad@eclipse.co.uk> said that...
>>                 sed -e
>> 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \
>> 
>> s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
>> \
>>                        $file > $file.new; \
>>                 cat $file.new > $file; rm $file.new; \
>>         done
>> sed: -e expression #1, char 145: unterminated address regex
>
>(145 is the total expression length.) Now, I'm at loss - this works here
>and I can see nothing wrong on the regexp - does anyone have any idea?
>
>What is your sed version?

~/cogito$ sed --version
GNU sed version 4.1.2

(from Debian/testing)

>
>> net result - a pile of zero length files in /home/david/bin/   :-(
>> 
>> can I just copy the cg-files from to cogito directory over?
>
>No, you would have to also set $COGITO_LIB and $COGITO_SHARE (or put
>cg-X* scripts to your bin directory as well).


I blundered about for 30 minutes with git-reset, and ended up here -

david@tower2:~/cogito$ cg-log | head
commit a9c75f3b8b1adb01859ff2c9b028f72a247837c6
tree c0c2b743d5dbacc33bced6ace62347724664c817
parent 653b039dbf989696160db56bb196a1584932fdeb
author Petr Baudis <pasky@suse.cz> Sat, 21 Jan 2006 02:28:30 +0100
committer Petr Baudis <xpasky@machine.or.cz> Sat, 21 Jan 2006 02:28:30
+0100

    Add support for cg-update -v

    Makes it call cg-fetch with -v as well, to list all the changes
being
    pulled.

and then make-install worked, and I seem to have a working cogito ...
but 'make test' fails -

*** t9400-clean.sh ***
*   ok 1: initialize repo
*   ok 2: cg-clean -n in top-level dir
*   ok 3: cg-clean -Ddxqn in top-level dir
*   ok 4: cg-clean -n in subdir
* FAIL 5: cg-clean in subdir
        (cd 'repo dir' && cg-clean && check_loss)
*   ok 6: cg-clean -d in subdir
* FAIL 7: cg-clean -x in subdir
        (cd 'repo dir' && cg-clean -x && check_loss)
* FAIL 8: cg-clean in top-level dir
        (cg-clean && check_loss)
* FAIL 9: cg-clean -x in top-level dir
        (cg-clean -x && check_loss)
* FAIL 10: cg-clean -d in top-level dir
        (cg-clean -d && check_loss)
*   ok 11: cg-clean -D in top-level dir
* failed 5 among 11 test(s)
make[1]: *** [all] Error 1
make[1]: Leaving directory `/home/david/cogito/t'
make: *** [test] Error 2

is this expected?

best regards
Dave
